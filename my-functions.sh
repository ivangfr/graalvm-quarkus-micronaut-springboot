#!/usr/bin/env bash

TIMEOUT=120

# -- wait_for_container_log --
# $1: docker container name
# S2: spring value to wait to appear in container logs
# wait_for_container_log_exec_time: global variable that contains the execution time needed to wait for the string to appear
# wait_for_container_log_matched_row: global variable that contains the log row matched
function wait_for_container_log() {
  local log_waiting="Waiting for string '$2' in the $1 logs ..."
  echo "${log_waiting} It will timeout in ${TIMEOUT}s"
  SECONDS=0

  while true ; do
    local log=$(docker logs $1 2>&1 | grep "$2")
    if [ -n "$log" ] ; then
      echo $log
      wait_for_container_log_exec_time="${SECONDS}s"
      wait_for_container_log_matched_row=$log
      break
    fi

    if [ $SECONDS -ge $TIMEOUT ] ; then
      echo "${log_waiting} TIMEOUT"
      wait_for_container_log_exec_time="999999"
      wait_for_container_log_matched_row=""
      break
    fi
    sleep 1
  done
}

# -- extract_startup_time_from_log --
# $1: log row
# $2: awk command to parse the log and extract the time
function extract_startup_time_from_log() {
  echo "$1" | awk "$2"
}

# -- get_container_memory_usage --
# $1: docker container name
function get_container_memory_usage() {
  while true ; do
    local log=$(docker stats --no-stream 2>&1 | grep $1)
    if [ -n "$log" ] ; then
      echo $log | awk '{print $4"/"$6"("$7")"}'
      break
    fi
    sleep 1
  done
}

# -- wait_for_container_status_healthy --
# $1: docker container port
function wait_for_container_status_healthy() {
  echo "Waiting for container with port $1 to be 'healthy' ..."
  while true ; do
    local log=$(docker ps | grep -E "healthy.*$1")
    if [ -n "$log" ] ; then
      echo $log
      break
    fi
    sleep 1
  done
}

# -- run_command --
# $1: command to run
# $run_command_exec_time: global variable that contains the last execution time of the function
function run_command() {
  SECONDS=0 ; eval $1 ; run_command_exec_time="${SECONDS}s"
}

# -- convert_seconds_to_millis --
# $1: value number in seconds without any suffix
function convert_seconds_to_millis() {
  echo "scale=0 ; ($1 * 1000)/1" | bc -l
}

# -- get_docker_size --
# $1: docker container name
function get_docker_size() {
    echo $(docker images $1 --format='{{println .Size}}')
}

# -- get_folder_file_size --
# $1: file path
function get_folder_file_size() {
    echo $(du -hs "$1" | awk '{ print $1 }')
}

# -- package_jar_build_image --
# $1: jar clean command
# $2: jar package/assemble command
# $3: output jar file path
# $4: docker command
# $5: docker image
function package_jar_build_image() {
  eval "$1"

  run_command "$2"
  package_jar_build_image_packaging_time=$run_command_exec_time
  package_jar_build_image_jar_size=$(get_folder_file_size "$3")

  run_command "$4"
  package_jar_build_image_building_time=$run_command_exec_time
  package_jar_build_image_docker_image_size=$(get_docker_size $5)
}

# -- warm_up --
# $1: number of times
# $2: command to run
function warm_up() {
  echo
  echo "-- Begin: ab test warm-up"
  x=$1 
  while [ $x -gt 0 ]; do 
    eval $2
    x=$(($x-1))
  done
  echo "-- End: ab test warm-up"
  echo
}

# -- check_docker_manager_script_input_parameter --
# $1: input parameter
function check_docker_manager_script_input_parameter() {
  if [ "$1" != "all" ] &&
     [ "$1" != "quarkus" ] &&
     [ "$1" != "micronaut" ] &&
     [ "$1" != "springboot" ] &&
     [ "$1" != "simple-api" ] &&
     [ "$1" != "jpa-mysql" ] &&
     [ "$1" != "kafka" ] &&
     [ "$1" != "elasticsearch" ] &&
     [ "$1" != "quarkus-simple-api" ] &&
     [ "$1" != "micronaut-simple-api" ] &&
     [ "$1" != "springboot-simple-api" ] &&
     [ "$1" != "quarkus-jpa-mysql" ] &&
     [ "$1" != "micronaut-jpa-mysql" ] &&
     [ "$1" != "springboot-jpa-mysql" ] &&
     [ "$1" != "quarkus-kafka" ] &&
     [ "$1" != "micronaut-kafka" ] &&
     [ "$1" != "springboot-kafka" ] &&
     [ "$1" != "quarkus-kafka-producer" ] &&
     [ "$1" != "quarkus-kafka-consumer" ] &&
     [ "$1" != "micronaut-kafka-producer" ] &&
     [ "$1" != "micronaut-kafka-consumer" ] &&
     [ "$1" != "springboot-kafka-producer" ] &&
     [ "$1" != "springboot-kafka-consumer" ] &&
     [ "$1" != "quarkus-elasticsearch" ] &&
     [ "$1" != "micronaut-elasticsearch" ] &&
     [ "$1" != "springboot-elasticsearch" ];
  then
    printf "Invalid Java Framework, application name or type provided!"
    printf "\nValid Parameters:"

    printf "\n\tall"
    printf "\n\tsimple-api\tjpa-mysql\tkafka\telasticsearch"
    
    printf "\n\tquarkus"
    printf "\n\t\tquarkus-simple-api"
    printf "\n\t\tquarkus-jpa-mysql"
    printf "\n\t\tquarkus-kafka"
    printf "\n\t\t\tquarkus-kafka-producer"
    printf "\n\t\t\tquarkus-kafka-consumer"
    printf "\n\t\tquarkus-elasticsearch"

    printf "\n\tmicronaut"
    printf "\n\t\tmicronaut-simple-api"
    printf "\n\t\tmicronaut-jpa-mysql"
    printf "\n\t\tmicronaut-kafka"
    printf "\n\t\t\tmicronaut-kafka-producer"
    printf "\n\t\t\tmicronaut-kafka-consumer"
    printf "\n\t\tmicronaut-elasticsearch"

    printf "\n\tspringboot"
    printf "\n\t\tspringboot-simple-api"
    printf "\n\t\tspringboot-jpa-mysql"
    printf "\n\t\tspringboot-kafka"
    printf "\n\t\t\tspringboot-kafka-producer"
    printf "\n\t\t\tspringboot-kafka-consumer"
    printf "\n\t\tspringboot-elasticsearch"

    printf "\n"
    exit 1
  fi
}

# -- check_runner_script_input_parameter --
# $1: input parameter
function check_runner_script_input_parameter() {
  if [ "$1" != "all" ] &&
     [ "$1" != "jvm" ] &&
     [ "$1" != "native" ] &&
     [ "$1" != "quarkus" ] &&
     [ "$1" != "micronaut" ] &&
     [ "$1" != "springboot" ] &&
     [ "$1" != "quarkus-jvm" ] &&
     [ "$1" != "micronaut-jvm" ] &&
     [ "$1" != "springboot-jvm" ] &&
     [ "$1" != "quarkus-native" ] &&
     [ "$1" != "micronaut-native" ] &&
     [ "$1" != "springboot-native" ] &&
     [ "$1" != "simple-api" ] &&
     [ "$1" != "jpa-mysql" ] &&
     [ "$1" != "kafka" ] &&
     [ "$1" != "elasticsearch" ] &&
     [ "$1" != "simple-api-jvm" ] &&
     [ "$1" != "jpa-mysql-jvm" ] &&
     [ "$1" != "kafka-jvm" ] &&
     [ "$1" != "elasticsearch-jvm" ] &&
     [ "$1" != "simple-api-native" ] &&
     [ "$1" != "jpa-mysql-native" ] &&
     [ "$1" != "kafka-native" ] &&
     [ "$1" != "elasticsearch-native" ] &&
     [ "$1" != "quarkus-simple-api" ] && 
     [ "$1" != "micronaut-simple-api" ] &&
     [ "$1" != "springboot-simple-api" ] &&
     [ "$1" != "quarkus-jpa-mysql" ] &&
     [ "$1" != "micronaut-jpa-mysql" ] &&
     [ "$1" != "springboot-jpa-mysql" ] &&
     [ "$1" != "quarkus-kafka" ] &&
     [ "$1" != "micronaut-kafka" ] &&
     [ "$1" != "springboot-kafka" ] &&
     [ "$1" != "quarkus-elasticsearch" ] &&
     [ "$1" != "micronaut-elasticsearch" ] &&
     [ "$1" != "springboot-elasticsearch" ] &&
     [ "$1" != "quarkus-simple-api-jvm" ] && [ "$1" != "quarkus-simple-api-native" ] &&
     [ "$1" != "micronaut-simple-api-jvm" ] && [ "$1" != "micronaut-simple-api-native" ] &&
     [ "$1" != "springboot-simple-api-jvm" ] && [ "$1" != "springboot-simple-api-native" ] &&
     [ "$1" != "quarkus-jpa-mysql-jvm" ] && [ "$1" != "quarkus-jpa-mysql-native" ] &&
     [ "$1" != "micronaut-jpa-mysql-jvm" ] && [ "$1" != "micronaut-jpa-mysql-native" ] &&
     [ "$1" != "springboot-jpa-mysql-jvm" ] && [ "$1" != "springboot-jpa-mysql-native" ] &&
     [ "$1" != "quarkus-kafka-jvm" ] && [ "$1" != "quarkus-kafka-native" ] &&
     [ "$1" != "micronaut-kafka-jvm" ] && [ "$1" != "micronaut-kafka-native" ] &&
     [ "$1" != "springboot-kafka-jvm" ] && [ "$1" != "springboot-kafka-native" ] &&
     [ "$1" != "quarkus-elasticsearch-jvm" ] && [ "$1" != "quarkus-elasticsearch-native" ] &&
     [ "$1" != "micronaut-elasticsearch-jvm" ] && [ "$1" != "micronaut-elasticsearch-native" ] &&
     [ "$1" != "springboot-elasticsearch-jvm" ] && [ "$1" != "springboot-elasticsearch-native" ];
  then
    printf "Invalid Java Framework, application name or type provided!"
    printf "\nValid Parameters:"

    printf "\n\tall"
    printf "\n\tjvm\tnative"
    printf "\n\tsimple-api\tjpa-mysql\tkafka\telasticsearch"
    
    printf "\n\tsimple-api-jvm\tjpa-mysql-jvm\tkafka-jvm\telasticsearch-jvm"
    printf "\n\tsimple-api-native\tjpa-mysql-native\tkafka-native\telasticsearch-native"
    
    printf "\n\tquarkus"
    printf "\n\t\tquarkus-jvm"
    printf "\n\t\tquarkus-native"
    printf "\n\t\t\tquarkus-simple-api"
    printf "\n\t\t\t\tquarkus-simple-api-jvm"
    printf "\n\t\t\t\tquarkus-simple-api-native"
    printf "\n\t\t\tquarkus-jpa-mysql"
    printf "\n\t\t\t\tquarkus-jpa-mysql-jvm"
    printf "\n\t\t\t\tquarkus-jpa-mysql-native"
    printf "\n\t\t\tquarkus-kafka"
    printf "\n\t\t\t\tquarkus-kafka-jvm"
    printf "\n\t\t\t\tquarkus-kafka-native"
    printf "\n\t\t\tquarkus-elasticsearch"
    printf "\n\t\t\t\tquarkus-elasticsearch-jvm"
    printf "\n\t\t\t\tquarkus-elasticsearch-native"
    
    printf "\n\tmicronaut"
    printf "\n\t\tmicronaut-jvm"
    printf "\n\t\tmicronaut-native"
    printf "\n\t\t\tmicronaut-simple-api"
    printf "\n\t\t\t\tmicronaut-simple-api-jvm"
    printf "\n\t\t\t\tmicronaut-simple-api-native"
    printf "\n\t\t\tmicronaut-jpa-mysql"
    printf "\n\t\t\t\tmicronaut-jpa-mysql-jvm"
    printf "\n\t\t\t\tmicronaut-jpa-mysql-native"
    printf "\n\t\t\tmicronaut-kafka"
    printf "\n\t\t\t\tmicronaut-kafka-jvm"
    printf "\n\t\t\t\tmicronaut-kafka-native"
    printf "\n\t\t\tmicronaut-elasticsearch"
    printf "\n\t\t\t\tmicronaut-elasticsearch-jvm"
    printf "\n\t\t\t\tmicronaut-elasticsearch-native"

    printf "\n\tspringboot"
    printf "\n\t\tspringboot-jvm"
    printf "\n\t\tspringboot-native"
    printf "\n\t\t\tspringboot-simple-api"
    printf "\n\t\t\t\tspringboot-simple-api-jvm"
    printf "\n\t\t\t\tspringboot-simple-api-native"
    printf "\n\t\t\tspringboot-jpa-mysql"
    printf "\n\t\t\t\tspringboot-jpa-mysql-jvm"
    printf "\n\t\t\t\tspringboot-jpa-mysql-native"
    printf "\n\t\t\tspringboot-kafka"
    printf "\n\t\t\t\tspringboot-kafka-jvm"
    printf "\n\t\t\t\tspringboot-kafka-native"
    printf "\n\t\t\tspringboot-elasticsearch"
    printf "\n\t\t\t\tspringboot-elasticsearch-jvm"
    printf "\n\t\t\t\tspringboot-elasticsearch-native"

    printf "\n"
    exit 1
  fi
}