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
      break;
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

# -- get_container_memory_consumption --
# $1: docker container name
function get_container_memory_consumption() {
  while true ; do
    local log=$(docker stats --no-stream 2>&1 | grep $1)
    if [ -n "$log" ] ; then
      echo $log | awk '{print $4}'
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

# -- get_file_size --
# $1: file path
function get_file_size() {
    echo $(stat -f%z "$1")
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
  package_jar_build_image_jar_size=$(get_file_size "$3")

  run_command "$4"
  package_jar_build_image_building_time=$run_command_exec_time
  package_jar_build_image_docker_image_size=$(get_docker_size $5)
}
