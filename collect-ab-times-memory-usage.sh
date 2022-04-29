#!/usr/bin/env bash

source my-functions.sh

check_runner_script_input_parameter $1

declare -A quarkus_simple_api_jvm
declare -A quarkus_simple_api_native
declare -A micronaut_simple_api_jvm
declare -A micronaut_simple_api_native
declare -A springboot_simple_api_jvm
declare -A springboot_simple_api_native

declare -A quarkus_jpa_mysql_jvm
declare -A quarkus_jpa_mysql_native
declare -A micronaut_jpa_mysql_jvm
declare -A micronaut_jpa_mysql_native
declare -A springboot_jpa_mysql_jvm
declare -A springboot_jpa_mysql_native

declare -A quarkus_producer_api_jvm
declare -A quarkus_consumer_api_jvm
declare -A quarkus_producer_api_native
declare -A quarkus_consumer_api_native
declare -A micronaut_producer_api_jvm
declare -A micronaut_consumer_api_jvm
declare -A micronaut_producer_api_native
declare -A micronaut_consumer_api_native
declare -A springboot_producer_api_jvm
declare -A springboot_consumer_api_jvm
declare -A springboot_producer_api_native
declare -A springboot_consumer_api_native

declare -A quarkus_elasticsearch_jvm
declare -A quarkus_elasticsearch_native
declare -A micronaut_elasticsearch_jvm
declare -A micronaut_elasticsearch_native
declare -A springboot_elasticsearch_jvm
declare -A springboot_elasticsearch_native

start_time=$(date)

JAVA_OPTS_XMX='-Xmx256m'
CONTAINER_MAX_MEM=512M

AB_PARAMS_SIMPLE_API='-c 10 -n 4000'
AB_PARAMS_JPA_MYSQL='-c 10 -n 2000'
AB_PARAMS_PRODUCER_CONSUMER='-c 10 -n 5000'
AB_PARAMS_ELASTICSEARCH='-c 10 -n 2000'

WARM_UP_TIMES=5

AB_PARAMS_WARM_UP_SIMPLE_API='-c 5 -n 1000'
AB_PARAMS_WARM_UP_JPA_MYSQL='-c 5 -n 500'
AB_PARAMS_WARM_UP_PRODUCER_CONSUMER='-c 5 -n 1000'
AB_PARAMS_WARM_UP_ELASTICSEARCH='-c 5 -n 500'

if [ "$1" = "quarkus-simple-api-jvm" ] ||
   [ "$1" = "quarkus-simple-api" ] ||
   [ "$1" = "quarkus-jvm" ] ||
   [ "$1" = "quarkus" ] ||
   [ "$1" = "simple-api-jvm" ] ||
   [ "$1" = "simple-api" ] ||
   [ "$1" = "jvm" ] ||
   [ "$1" = "all" ];
then

  echo
  echo "----------------------"
  echo "QUARKUS-SIMPLE-API-JVM"
  echo "----------------------"

  docker run -d --rm --name quarkus-simple-api-jvm \
    -p 9080:8080 \
    -e JAVA_OPTIONS=$JAVA_OPTS_XMX -m $CONTAINER_MAX_MEM \
    ivanfranchin/quarkus-simple-api-jvm:1.0.0

  wait_for_container_log "quarkus-simple-api-jvm" "started in"
  startup_time_sec=$(extract_startup_time_from_log "$wait_for_container_log_matched_row" "{print substr(\$16,0,length(\$16)-2)}")
  quarkus_simple_api_jvm[startup_time]="$(convert_seconds_to_millis $startup_time_sec)ms"

  quarkus_simple_api_jvm[initial_memory_usage]=$(get_container_memory_usage "quarkus-simple-api-jvm")

  run_command "ab $AB_PARAMS_SIMPLE_API http://localhost:9080/api/greeting?name=Ivan"
  quarkus_simple_api_jvm[ab_testing_time]=$run_command_exec_time

  warm_up $WARM_UP_TIMES "ab $AB_PARAMS_WARM_UP_SIMPLE_API http://localhost:9080/api/greeting?name=Ivan"

  run_command "ab $AB_PARAMS_SIMPLE_API http://localhost:9080/api/greeting?name=Ivan"
  quarkus_simple_api_jvm[ab_testing_time_2]=$run_command_exec_time

  quarkus_simple_api_jvm[final_memory_usage]=$(get_container_memory_usage "quarkus-simple-api-jvm")

  run_command "docker stop quarkus-simple-api-jvm"
  quarkus_simple_api_jvm[shutdown_time]=$run_command_exec_time

fi

if [ "$1" = "quarkus-simple-api-native" ] ||
   [ "$1" = "quarkus-simple-api" ] ||
   [ "$1" = "quarkus-native" ] ||
   [ "$1" = "quarkus" ] ||
   [ "$1" = "simple-api-native" ] ||
   [ "$1" = "simple-api" ] ||
   [ "$1" = "native" ] ||
   [ "$1" = "all" ];
then

  echo
  echo "-------------------------"
  echo "QUARKUS-SIMPLE-API-NATIVE"
  echo "-------------------------"

  docker run -d --rm --name quarkus-simple-api-native \
    -p 9081:8080 \
    -e JAVA_OPTIONS=$JAVA_OPTS_XMX -m $CONTAINER_MAX_MEM \
    ivanfranchin/quarkus-simple-api-native:1.0.0

  wait_for_container_log "quarkus-simple-api-native" "started in"
  startup_time_sec=$(extract_startup_time_from_log "$wait_for_container_log_matched_row" "{print substr(\$15,0,length(\$15)-2)}")
  quarkus_simple_api_native[startup_time]="$(convert_seconds_to_millis $startup_time_sec)ms"

  quarkus_simple_api_native[initial_memory_usage]=$(get_container_memory_usage "quarkus-simple-api-native")

  run_command "ab $AB_PARAMS_SIMPLE_API http://localhost:9081/api/greeting?name=Ivan"
  quarkus_simple_api_native[ab_testing_time]=$run_command_exec_time

  warm_up $WARM_UP_TIMES "ab $AB_PARAMS_WARM_UP_SIMPLE_API http://localhost:9081/api/greeting?name=Ivan"

  run_command "ab $AB_PARAMS_SIMPLE_API http://localhost:9081/api/greeting?name=Ivan"
  quarkus_simple_api_native[ab_testing_time_2]=$run_command_exec_time

  quarkus_simple_api_native[final_memory_usage]=$(get_container_memory_usage "quarkus-simple-api-native")

  run_command "docker stop quarkus-simple-api-native"
  quarkus_simple_api_native[shutdown_time]=$run_command_exec_time

fi

if [ "$1" = "micronaut-simple-api-jvm" ] ||
   [ "$1" = "micronaut-simple-api" ] ||
   [ "$1" = "micronaut-jvm" ] ||
   [ "$1" = "micronaut" ] ||
   [ "$1" = "simple-api-jvm" ] ||
   [ "$1" = "simple-api" ] ||
   [ "$1" = "jvm" ] ||
   [ "$1" = "all" ];
then

  echo
  echo "------------------------"
  echo "MICRONAUT-SIMPLE-API-JVM"
  echo "------------------------"

  docker run -d --rm --name micronaut-simple-api-jvm \
    -p 9082:8080 \
    -e JAVA_OPTIONS=$JAVA_OPTS_XMX -m $CONTAINER_MAX_MEM \
    ivanfranchin/micronaut-simple-api-jvm:1.0.0

  wait_for_container_log "micronaut-simple-api-jvm" "Startup completed in"
  micronaut_simple_api_jvm[startup_time]=$(extract_startup_time_from_log "$wait_for_container_log_matched_row" "{print substr(\$10,0,length(\$10)-1)}")

  micronaut_simple_api_jvm[initial_memory_usage]=$(get_container_memory_usage "micronaut-simple-api-jvm")

  run_command "ab $AB_PARAMS_SIMPLE_API http://localhost:9082/api/greeting?name=Ivan"
  micronaut_simple_api_jvm[ab_testing_time]=$run_command_exec_time

  warm_up $WARM_UP_TIMES "ab $AB_PARAMS_WARM_UP_SIMPLE_API http://localhost:9082/api/greeting?name=Ivan"

  run_command "ab $AB_PARAMS_SIMPLE_API http://localhost:9082/api/greeting?name=Ivan"
  micronaut_simple_api_jvm[ab_testing_time_2]=$run_command_exec_time

  micronaut_simple_api_jvm[final_memory_usage]=$(get_container_memory_usage "micronaut-simple-api-jvm")

  run_command "docker stop micronaut-simple-api-jvm"
  micronaut_simple_api_jvm[shutdown_time]=$run_command_exec_time

fi

if [ "$1" = "micronaut-simple-api-native" ] ||
   [ "$1" = "micronaut-simple-api" ] ||
   [ "$1" = "micronaut-native" ] ||
   [ "$1" = "micronaut" ] ||
   [ "$1" = "simple-api-native" ] ||
   [ "$1" = "simple-api" ] ||
   [ "$1" = "native" ] ||
   [ "$1" = "all" ];
then

  echo
  echo "---------------------------"
  echo "MICRONAUT-SIMPLE-API-NATIVE"
  echo "---------------------------"

  docker run -d --rm --name micronaut-simple-api-native \
    -p 9083:8080 \
    -e JAVA_OPTIONS=$JAVA_OPTS_XMX -m $CONTAINER_MAX_MEM \
    ivanfranchin/micronaut-simple-api-native:1.0.0

  wait_for_container_log "micronaut-simple-api-native" "Startup completed in"
  micronaut_simple_api_native[startup_time]=$(extract_startup_time_from_log "$wait_for_container_log_matched_row" "{print substr(\$10,0,length(\$10)-1)}")

  micronaut_simple_api_native[initial_memory_usage]=$(get_container_memory_usage "micronaut-simple-api-native")

  run_command "ab $AB_PARAMS_SIMPLE_API http://localhost:9083/api/greeting?name=Ivan"
  micronaut_simple_api_native[ab_testing_time]=$run_command_exec_time

  warm_up $WARM_UP_TIMES "ab $AB_PARAMS_WARM_UP_SIMPLE_API http://localhost:9083/api/greeting?name=Ivan"

  run_command "ab $AB_PARAMS_SIMPLE_API http://localhost:9083/api/greeting?name=Ivan"
  micronaut_simple_api_native[ab_testing_time_2]=$run_command_exec_time

  micronaut_simple_api_native[final_memory_usage]=$(get_container_memory_usage "micronaut-simple-api-native")

  run_command "docker stop micronaut-simple-api-native"
  micronaut_simple_api_native[shutdown_time]=$run_command_exec_time

fi

if [ "$1" = "springboot-simple-api-jvm" ] ||
   [ "$1" = "springboot-simple-api" ] ||
   [ "$1" = "springboot-jvm" ] ||
   [ "$1" = "springboot" ] ||
   [ "$1" = "simple-api-jvm" ] ||
   [ "$1" = "simple-api" ] ||
   [ "$1" = "jvm" ] ||
   [ "$1" = "all" ];
then

  echo
  echo "-------------------------"
  echo "SPRINGBOOT-SIMPLE-API-JVM"
  echo "-------------------------"

  docker run -d --rm --name springboot-simple-api-jvm \
    -p 9084:8080 \
    -e JAVA_OPTIONS=$JAVA_OPTS_XMX -m $CONTAINER_MAX_MEM \
    ivanfranchin/springboot-simple-api-jvm:1.0.0

  wait_for_container_log "springboot-simple-api-jvm" "Started"
  startup_time_sec=$(extract_startup_time_from_log "$wait_for_container_log_matched_row" "{print \$13}")
  springboot_simple_api_jvm[startup_time]="$(convert_seconds_to_millis $startup_time_sec)ms"

  springboot_simple_api_jvm[initial_memory_usage]=$(get_container_memory_usage "springboot-simple-api-jvm")

  run_command "ab $AB_PARAMS_SIMPLE_API http://localhost:9084/api/greeting?name=Ivan"
  springboot_simple_api_jvm[ab_testing_time]=$run_command_exec_time

  warm_up $WARM_UP_TIMES "ab $AB_PARAMS_WARM_UP_SIMPLE_API http://localhost:9084/api/greeting?name=Ivan"

  run_command "ab $AB_PARAMS_SIMPLE_API http://localhost:9084/api/greeting?name=Ivan"
  springboot_simple_api_jvm[ab_testing_time_2]=$run_command_exec_time

  springboot_simple_api_jvm[final_memory_usage]=$(get_container_memory_usage "springboot-simple-api-jvm")

  run_command "docker stop springboot-simple-api-jvm"
  springboot_simple_api_jvm[shutdown_time]=$run_command_exec_time

fi

if [ "$1" = "springboot-simple-api-native" ] ||
   [ "$1" = "springboot-simple-api" ] ||
   [ "$1" = "springboot-native" ] ||
   [ "$1" = "springboot" ] ||
   [ "$1" = "simple-api-native" ] ||
   [ "$1" = "simple-api" ] ||
   [ "$1" = "native" ] ||
   [ "$1" = "all" ];
then

  echo
  echo "----------------------------"
  echo "SPRINGBOOT-SIMPLE-API-NATIVE"
  echo "----------------------------"

  docker run -d --rm --name springboot-simple-api-native \
    -p 9085:8080 \
    -e JAVA_OPTIONS=$JAVA_OPTS_XMX -m $CONTAINER_MAX_MEM \
    ivanfranchin/springboot-simple-api-native:1.0.0

  wait_for_container_log "springboot-simple-api-native" "Started"
  startup_time_sec=$(extract_startup_time_from_log "$wait_for_container_log_matched_row" "{print \$13}")
  springboot_simple_api_native[startup_time]="$(convert_seconds_to_millis $startup_time_sec)ms"

  springboot_simple_api_native[initial_memory_usage]=$(get_container_memory_usage "springboot-simple-api-native")

  run_command "ab $AB_PARAMS_SIMPLE_API http://localhost:9085/api/greeting?name=Ivan"
  springboot_simple_api_native[ab_testing_time]=$run_command_exec_time

  warm_up $WARM_UP_TIMES "ab $AB_PARAMS_WARM_UP_SIMPLE_API http://localhost:9085/api/greeting?name=Ivan"

  run_command "ab $AB_PARAMS_SIMPLE_API http://localhost:9085/api/greeting?name=Ivan"
  springboot_simple_api_native[ab_testing_time_2]=$run_command_exec_time

  springboot_simple_api_native[final_memory_usage]=$(get_container_memory_usage "springboot-simple-api-native")

  run_command "docker stop springboot-simple-api-native"
  springboot_simple_api_native[shutdown_time]=$run_command_exec_time

fi

if [ "$1" = "quarkus-jpa-mysql-jvm" ] || [ "$1" = "quarkus-jpa-mysql-native" ] ||
   [ "$1" = "micronaut-jpa-mysql-jvm" ] || [ "$1" = "micronaut-jpa-mysql-native" ] ||
   [ "$1" = "springboot-jpa-mysql-jvm" ] || [ "$1" = "springboot-jpa-mysql-native" ] ||
   [ "$1" = "quarkus-jpa-mysql" ] || [ "$1" = "micronaut-jpa-mysql" ] || [ "$1" = "springboot-jpa-mysql" ] ||
   [ "$1" = "quarkus-jvm" ] || [ "$1" = "micronaut-jvm" ] || [ "$1" = "springboot-jvm" ] ||
   [ "$1" = "quarkus-native" ] || [ "$1" = "micronaut-native" ] || [ "$1" = "springboot-native" ] ||
   [ "$1" = "quarkus" ] || [ "$1" = "micronaut" ] || [ "$1" = "springboot" ] ||
   [ "$1" = "jpa-mysql-jvm" ] || [ "$1" = "jpa-mysql-native" ] ||
   [ "$1" = "jpa-mysql" ] ||
   [ "$1" = "jvm" ] || [ "$1" = "native" ] ||
   [ "$1" = "all" ];
then

  cd jpa-mysql

  echo
  echo "=============="
  echo "DOCKER-COMPOSE"
  echo "=============="

  docker-compose up -d
  wait_for_container_log "mysql" "port: 3306"

  if [ "$1" = "quarkus-jpa-mysql-jvm" ] ||
     [ "$1" = "quarkus-jpa-mysql" ] ||
     [ "$1" = "quarkus-jvm" ] ||
     [ "$1" = "quarkus" ] ||
     [ "$1" = "jpa-mysql-jvm" ] ||
     [ "$1" = "jpa-mysql" ] ||
     [ "$1" = "jvm" ] ||
     [ "$1" = "all" ];
  then

    echo
    echo "---------------------"
    echo "QUARKUS-JPA-MYSQL-JVM"
    echo "---------------------"

    docker run -d --rm --name quarkus-jpa-mysql-jvm \
      -p 9086:8080 -e MYSQL_HOST=mysql \
      -e JAVA_OPTIONS=$JAVA_OPTS_XMX -m $CONTAINER_MAX_MEM \
      --network jpa-mysql_default \
      ivanfranchin/quarkus-jpa-mysql-jvm:1.0.0

    wait_for_container_log "quarkus-jpa-mysql-jvm" "started in"
    startup_time_sec=$(extract_startup_time_from_log "$wait_for_container_log_matched_row" "{print substr(\$16,0,length(\$16)-2)}")
    quarkus_jpa_mysql_jvm[startup_time]="$(convert_seconds_to_millis $startup_time_sec)ms"

    quarkus_jpa_mysql_jvm[initial_memory_usage]=$(get_container_memory_usage "quarkus-jpa-mysql-jvm")

    run_command "ab -p test-book.json -T 'application/json' $AB_PARAMS_JPA_MYSQL http://localhost:9086/api/books"
    quarkus_jpa_mysql_jvm[ab_testing_time]=$run_command_exec_time

    warm_up $WARM_UP_TIMES "ab -p test-book.json -T 'application/json' $AB_PARAMS_WARM_UP_JPA_MYSQL http://localhost:9086/api/books"

    run_command "ab -p test-book.json -T 'application/json' $AB_PARAMS_JPA_MYSQL http://localhost:9086/api/books"
    quarkus_jpa_mysql_jvm[ab_testing_time_2]=$run_command_exec_time

    quarkus_jpa_mysql_jvm[final_memory_usage]=$(get_container_memory_usage "quarkus-jpa-mysql-jvm")

    run_command "docker stop quarkus-jpa-mysql-jvm"
    quarkus_jpa_mysql_jvm[shutdown_time]=$run_command_exec_time

  fi

  if [ "$1" = "quarkus-jpa-mysql-native" ] ||
     [ "$1" = "quarkus-jpa-mysql" ] ||
     [ "$1" = "quarkus-native" ] ||
     [ "$1" = "quarkus" ] ||
     [ "$1" = "jpa-mysql-native" ] ||
     [ "$1" = "jpa-mysql" ] ||
     [ "$1" = "native" ] ||
     [ "$1" = "all" ];
  then

    echo
    echo "------------------------"
    echo "QUARKUS-JPA-MYSQL-NATIVE"
    echo "------------------------"

    docker run -d --rm --name quarkus-jpa-mysql-native \
      -p 9087:8080 -e QUARKUS_PROFILE=native -e MYSQL_HOST=mysql \
      -e JAVA_OPTIONS=$JAVA_OPTS_XMX -m $CONTAINER_MAX_MEM \
      --network jpa-mysql_default \
      ivanfranchin/quarkus-jpa-mysql-native:1.0.0

    wait_for_container_log "quarkus-jpa-mysql-native" "started in"
    startup_time_sec=$(extract_startup_time_from_log "$wait_for_container_log_matched_row" "{print substr(\$15,0,length(\$15)-2)}")
    quarkus_jpa_mysql_native[startup_time]="$(convert_seconds_to_millis $startup_time_sec)ms"

    quarkus_jpa_mysql_native[initial_memory_usage]=$(get_container_memory_usage "quarkus-jpa-mysql-native")

    run_command "ab -p test-book.json -T 'application/json' $AB_PARAMS_JPA_MYSQL http://localhost:9087/api/books"
    quarkus_jpa_mysql_native[ab_testing_time]=$run_command_exec_time

    warm_up $WARM_UP_TIMES "ab -p test-book.json -T 'application/json' $AB_PARAMS_WARM_UP_JPA_MYSQL http://localhost:9087/api/books"

    run_command "ab -p test-book.json -T 'application/json' $AB_PARAMS_JPA_MYSQL http://localhost:9087/api/books"
    quarkus_jpa_mysql_native[ab_testing_time_2]=$run_command_exec_time

    quarkus_jpa_mysql_native[final_memory_usage]=$(get_container_memory_usage "quarkus-jpa-mysql-native")

    run_command "docker stop quarkus-jpa-mysql-native"
    quarkus_jpa_mysql_native[shutdown_time]=$run_command_exec_time

  fi

  if [ "$1" = "micronaut-jpa-mysql-jvm" ] ||
     [ "$1" = "micronaut-jpa-mysql" ] ||
     [ "$1" = "micronaut-jvm" ] ||
     [ "$1" = "micronaut" ] ||
     [ "$1" = "jpa-mysql-jvm" ] ||
     [ "$1" = "jpa-mysql" ] ||
     [ "$1" = "jvm" ] ||
     [ "$1" = "all" ];
  then

    echo
    echo "-----------------------"
    echo "MICRONAUT-JPA-MYSQL-JVM"
    echo "-----------------------"

    docker run -d --rm --name micronaut-jpa-mysql-jvm \
      -p 9088:8080 -e MYSQL_HOST=mysql \
      -e JAVA_OPTIONS=$JAVA_OPTS_XMX -m $CONTAINER_MAX_MEM \
      --network jpa-mysql_default \
      ivanfranchin/micronaut-jpa-mysql-jvm:1.0.0

    wait_for_container_log "micronaut-jpa-mysql-jvm" "Startup completed in"
    micronaut_jpa_mysql_jvm[startup_time]=$(extract_startup_time_from_log "$wait_for_container_log_matched_row" "{print substr(\$10,0,length(\$10)-1)}")

    micronaut_jpa_mysql_jvm[initial_memory_usage]=$(get_container_memory_usage "micronaut-jpa-mysql-jvm")

    run_command "ab -p test-book.json -T 'application/json' $AB_PARAMS_JPA_MYSQL http://localhost:9088/api/books"
    micronaut_jpa_mysql_jvm[ab_testing_time]=$run_command_exec_time

    warm_up $WARM_UP_TIMES "ab -p test-book.json -T 'application/json' $AB_PARAMS_WARM_UP_JPA_MYSQL http://localhost:9088/api/books"

    run_command "ab -p test-book.json -T 'application/json' $AB_PARAMS_JPA_MYSQL http://localhost:9088/api/books"
    micronaut_jpa_mysql_jvm[ab_testing_time_2]=$run_command_exec_time

    micronaut_jpa_mysql_jvm[final_memory_usage]=$(get_container_memory_usage "micronaut-jpa-mysql-jvm")

    run_command "docker stop micronaut-jpa-mysql-jvm"
    micronaut_jpa_mysql_jvm[shutdown_time]=$run_command_exec_time

  fi

  if [ "$1" = "micronaut-jpa-mysql-native" ] ||
     [ "$1" = "micronaut-jpa-mysql" ] ||
     [ "$1" = "micronaut-native" ] ||
     [ "$1" = "micronaut" ] ||
     [ "$1" = "jpa-mysql-native" ] ||
     [ "$1" = "jpa-mysql" ] ||
     [ "$1" = "native" ] ||
     [ "$1" = "all" ];
  then

    echo
    echo "--------------------------"
    echo "MICRONAUT-JPA-MYSQL-NATIVE"
    echo "--------------------------"

    docker run -d --rm --name micronaut-jpa-mysql-native \
      -p 9089:8080 -e MICRONAUT_ENVIRONMENTS=native -e MYSQL_HOST=mysql \
      -e JAVA_OPTIONS=$JAVA_OPTS_XMX -m $CONTAINER_MAX_MEM \
      --network jpa-mysql_default \
      ivanfranchin/micronaut-jpa-mysql-native:1.0.0

    wait_for_container_log "micronaut-jpa-mysql-native" "Startup completed in"
    micronaut_jpa_mysql_native[startup_time]=$(extract_startup_time_from_log "$wait_for_container_log_matched_row" "{print substr(\$10,0,length(\$10)-1)}")

    micronaut_jpa_mysql_native[initial_memory_usage]=$(get_container_memory_usage "micronaut-jpa-mysql-native")

    run_command "ab -p test-book.json -T 'application/json' $AB_PARAMS_JPA_MYSQL http://localhost:9089/api/books"
    micronaut_jpa_mysql_native[ab_testing_time]=$run_command_exec_time

    warm_up $WARM_UP_TIMES "ab -p test-book.json -T 'application/json' $AB_PARAMS_WARM_UP_JPA_MYSQL http://localhost:9089/api/books"

    run_command "ab -p test-book.json -T 'application/json' $AB_PARAMS_JPA_MYSQL http://localhost:9089/api/books"
    micronaut_jpa_mysql_native[ab_testing_time_2]=$run_command_exec_time

    micronaut_jpa_mysql_native[final_memory_usage]=$(get_container_memory_usage "micronaut-jpa-mysql-native")

    run_command "docker stop micronaut-jpa-mysql-native"
    micronaut_jpa_mysql_native[shutdown_time]=$run_command_exec_time

  fi

  if [ "$1" = "springboot-jpa-mysql-jvm" ] ||
     [ "$1" = "springboot-jpa-mysql" ] ||
     [ "$1" = "springboot-jvm" ] ||
     [ "$1" = "springboot" ] ||
     [ "$1" = "jpa-mysql-jvm" ] ||
     [ "$1" = "jpa-mysql" ] ||
     [ "$1" = "jvm" ] ||
     [ "$1" = "all" ];
  then

    echo
    echo "------------------------"
    echo "SPRINGBOOT-JPA-MYSQL-JVM"
    echo "------------------------"

    docker run -d --rm --name springboot-jpa-mysql-jvm \
      -p 9090:8080 -e MYSQL_HOST=mysql \
      -e JAVA_OPTIONS=$JAVA_OPTS_XMX -m $CONTAINER_MAX_MEM \
      --network jpa-mysql_default \
      ivanfranchin/springboot-jpa-mysql-jvm:1.0.0

    wait_for_container_log "springboot-jpa-mysql-jvm" "Started"
    startup_time_sec=$(extract_startup_time_from_log "$wait_for_container_log_matched_row" "{print \$13}")
    springboot_jpa_mysql_jvm[startup_time]="$(convert_seconds_to_millis $startup_time_sec)ms"

    springboot_jpa_mysql_jvm[initial_memory_usage]=$(get_container_memory_usage "springboot-jpa-mysql-jvm")

    run_command "ab -p test-book.json -T 'application/json' $AB_PARAMS_JPA_MYSQL http://localhost:9090/api/books"
    springboot_jpa_mysql_jvm[ab_testing_time]=$run_command_exec_time

    warm_up $WARM_UP_TIMES "ab -p test-book.json -T 'application/json' $AB_PARAMS_WARM_UP_JPA_MYSQL http://localhost:9090/api/books"

    run_command "ab -p test-book.json -T 'application/json' $AB_PARAMS_JPA_MYSQL http://localhost:9090/api/books"
    springboot_jpa_mysql_jvm[ab_testing_time_2]=$run_command_exec_time

    springboot_jpa_mysql_jvm[final_memory_usage]=$(get_container_memory_usage "springboot-jpa-mysql-jvm")

    run_command "docker stop springboot-jpa-mysql-jvm"
    springboot_jpa_mysql_jvm[shutdown_time]=$run_command_exec_time

  fi

  if [ "$1" = "springboot-jpa-mysql-native" ] ||
     [ "$1" = "springboot-jpa-mysql" ] ||
     [ "$1" = "springboot-native" ] ||
     [ "$1" = "springboot" ] ||
     [ "$1" = "jpa-mysql-native" ] ||
     [ "$1" = "jpa-mysql" ] ||
     [ "$1" = "native" ] ||
     [ "$1" = "all" ];
  then

    echo
    echo "---------------------------"
    echo "SPRINGBOOT-JPA-MYSQL-NATIVE"
    echo "---------------------------"

    docker run -d --rm --name springboot-jpa-mysql-native \
      -p 9091:8080 -e SPRING_PROFILES_ACTIVE=native -e MYSQL_HOST=mysql \
      -e JAVA_OPTIONS=$JAVA_OPTS_XMX -m $CONTAINER_MAX_MEM \
      --network jpa-mysql_default \
      ivanfranchin/springboot-jpa-mysql-native:1.0.0

    wait_for_container_log "springboot-jpa-mysql-native" "Started"
    startup_time_sec=$(extract_startup_time_from_log "$wait_for_container_log_matched_row" "{print \$13}")
    springboot_jpa_mysql_native[startup_time]="$(convert_seconds_to_millis $startup_time_sec)ms"

    springboot_jpa_mysql_native[initial_memory_usage]=$(get_container_memory_usage "springboot-jpa-mysql-native")

    run_command "ab -p test-book.json -T 'application/json' $AB_PARAMS_JPA_MYSQL http://localhost:9091/api/books"
    springboot_jpa_mysql_native[ab_testing_time]=$run_command_exec_time

    warm_up $WARM_UP_TIMES "ab -p test-book.json -T 'application/json' $AB_PARAMS_WARM_UP_JPA_MYSQL http://localhost:9091/api/books"

    run_command "ab -p test-book.json -T 'application/json' $AB_PARAMS_JPA_MYSQL http://localhost:9091/api/books"
    springboot_jpa_mysql_native[ab_testing_time_2]=$run_command_exec_time

    springboot_jpa_mysql_native[final_memory_usage]=$(get_container_memory_usage "springboot-jpa-mysql-native")

    run_command "docker stop springboot-jpa-mysql-native"
    springboot_jpa_mysql_native[shutdown_time]=$run_command_exec_time

  fi

  echo
  echo "=============="
  echo "DOCKER-COMPOSE"
  echo "=============="

  docker-compose down -v

  cd ..

fi

if [ "$1" = "quarkus-producer-consumer-jvm" ] || [ "$1" = "quarkus-producer-consumer-native" ] ||
   [ "$1" = "micronaut-producer-consumer-jvm" ] || [ "$1" = "micronaut-producer-consumer-native" ] ||
   [ "$1" = "springboot-producer-consumer-jvm" ] || [ "$1" = "springboot-producer-consumer-native" ] ||
   [ "$1" = "quarkus-producer-consumer" ] || [ "$1" = "micronaut-producer-consumer" ] || [ "$1" = "springboot-producer-consumer" ] ||
   [ "$1" = "quarkus-jvm" ] || [ "$1" = "micronaut-jvm" ] || [ "$1" = "springboot-jvm" ] ||
   [ "$1" = "quarkus-native" ] || [ "$1" = "micronaut-native" ] || [ "$1" = "springboot-native" ] ||
   [ "$1" = "quarkus" ] || [ "$1" = "micronaut" ] || [ "$1" = "springboot" ] ||
   [ "$1" = "producer-consumer-jvm" ] || [ "$1" = "producer-consumer-native" ] ||
   [ "$1" = "producer-consumer" ] ||
   [ "$1" = "jvm" ] || [ "$1" = "native" ] ||
   [ "$1" = "all" ];
then

  cd producer-consumer

  echo
  echo "=============="
  echo "DOCKER-COMPOSE"
  echo "=============="

  docker-compose up -d zookeeper kafka
  wait_for_container_status_healthy "9092"

  if [ "$1" = "quarkus-producer-consumer-jvm" ] ||
     [ "$1" = "quarkus-producer-consumer" ] ||
     [ "$1" = "quarkus-jvm" ] ||
     [ "$1" = "quarkus" ] ||
     [ "$1" = "producer-consumer-jvm" ] ||
     [ "$1" = "producer-consumer" ] ||
     [ "$1" = "jvm" ] ||
     [ "$1" = "all" ];
  then

    echo
    echo "--------------------------------------------"
    echo "QUARKUS-PRODUCER-CONSUMER / PRODUCER-API-JVM"
    echo "--------------------------------------------"

    docker run -d --rm --name quarkus-producer-api-jvm \
      -p 9100:8080 -e KAFKA_HOST=kafka -e KAFKA_PORT=9092 \
      -e JAVA_OPTIONS=$JAVA_OPTS_XMX -m $CONTAINER_MAX_MEM \
      --network producer-consumer_default \
      ivanfranchin/quarkus-producer-api-jvm:1.0.0

    wait_for_container_log "quarkus-producer-api-jvm" "started in"
    startup_time_sec=$(extract_startup_time_from_log "$wait_for_container_log_matched_row" "{print substr(\$16,0,length(\$16)-2)}")
    quarkus_producer_api_jvm[startup_time]="$(convert_seconds_to_millis $startup_time_sec)ms"

    quarkus_producer_api_jvm[initial_memory_usage]=$(get_container_memory_usage "quarkus-producer-api-jvm")

    run_command "ab -p test-news.json -T 'application/json' $AB_PARAMS_PRODUCER_CONSUMER http://localhost:9100/api/news"
    quarkus_producer_api_jvm[ab_testing_time]=$run_command_exec_time

    warm_up $WARM_UP_TIMES "ab -p test-news.json -T 'application/json' $AB_PARAMS_WARM_UP_PRODUCER_CONSUMER http://localhost:9100/api/news"

    run_command "ab -p test-news.json -T 'application/json' $AB_PARAMS_PRODUCER_CONSUMER http://localhost:9100/api/news"
    quarkus_producer_api_jvm[ab_testing_time_2]=$run_command_exec_time

    quarkus_producer_api_jvm[final_memory_usage]=$(get_container_memory_usage "quarkus-producer-api-jvm")

    echo
    echo "--------------------------------------------"
    echo "QUARKUS-PRODUCER-CONSUMER / CONSUMER-API-JVM"
    echo "--------------------------------------------"

    docker run -d --rm --name quarkus-consumer-api-jvm \
      -p 9106:8080 -e KAFKA_HOST=kafka -e KAFKA_PORT=9092 \
      -e JAVA_OPTIONS=$JAVA_OPTS_XMX -m $CONTAINER_MAX_MEM \
      --network producer-consumer_default \
      ivanfranchin/quarkus-consumer-api-jvm:1.0.0

    wait_for_container_log "quarkus-consumer-api-jvm" "started in"
    startup_time_sec=$(extract_startup_time_from_log "$wait_for_container_log_matched_row" "{print substr(\$16,0,length(\$16)-2)}")
    quarkus_consumer_api_jvm[startup_time]="$(convert_seconds_to_millis $startup_time_sec)ms"

    quarkus_consumer_api_jvm[initial_memory_usage]=$(get_container_memory_usage "quarkus-consumer-api-jvm")

    wait_for_container_log "quarkus-consumer-api-jvm" "OFFSET: 14999"
    quarkus_consumer_api_jvm[ab_testing_time]=$wait_for_container_log_exec_time

    quarkus_consumer_api_jvm[final_memory_usage]=$(get_container_memory_usage "quarkus-consumer-api-jvm")

    echo "== Stopping producer-consuner docker containers"

    run_command "docker stop quarkus-producer-api-jvm"
    quarkus_producer_api_jvm[shutdown_time]=$run_command_exec_time

    run_command "docker stop quarkus-consumer-api-jvm"
    quarkus_consumer_api_jvm[shutdown_time]=$run_command_exec_time

  fi

  if [ "$1" = "quarkus-producer-consumer-native" ] ||
     [ "$1" = "quarkus-producer-consumer" ] ||
     [ "$1" = "quarkus-native" ] ||
     [ "$1" = "quarkus" ] ||
     [ "$1" = "producer-consumer-native" ] ||
     [ "$1" = "producer-consumer" ] ||
     [ "$1" = "native" ] ||
     [ "$1" = "all" ];
  then

    echo
    echo "-----------------------------------------------"
    echo "QUARKUS-PRODUCER-CONSUMER / PRODUCER-API-NATIVE"
    echo "-----------------------------------------------"

    docker run -d --rm --name quarkus-producer-api-native \
      -p 9101:8080 -e QUARKUS_PROFILE=native -e KAFKA_HOST=kafka -e KAFKA_PORT=9092 \
      -e JAVA_OPTIONS=$JAVA_OPTS_XMX -m $CONTAINER_MAX_MEM \
      --network producer-consumer_default \
      ivanfranchin/quarkus-producer-api-native:1.0.0

    wait_for_container_log "quarkus-producer-api-native" "started in"
    startup_time_sec=$(extract_startup_time_from_log "$wait_for_container_log_matched_row" "{print substr(\$15,0,length(\$15)-2)}")
    quarkus_producer_api_native[startup_time]="$(convert_seconds_to_millis $startup_time_sec)ms"

    quarkus_producer_api_native[initial_memory_usage]=$(get_container_memory_usage "quarkus-producer-api-native")

    run_command "ab -p test-news.json -T 'application/json' $AB_PARAMS_PRODUCER_CONSUMER http://localhost:9101/api/news"
    quarkus_producer_api_native[ab_testing_time]=$run_command_exec_time

    warm_up $WARM_UP_TIMES "ab -p test-news.json -T 'application/json' $AB_PARAMS_WARM_UP_PRODUCER_CONSUMER http://localhost:9101/api/news"

    run_command "ab -p test-news.json -T 'application/json' $AB_PARAMS_PRODUCER_CONSUMER http://localhost:9101/api/news"
    quarkus_producer_api_native[ab_testing_time_2]=$run_command_exec_time

    quarkus_producer_api_native[final_memory_usage]=$(get_container_memory_usage "quarkus-producer-api-native")

    echo
    echo "-----------------------------------------------"
    echo "QUARKUS-PRODUCER-CONSUMER / CONSUMER-API-NATIVE"
    echo "-----------------------------------------------"

    docker run -d --rm --name quarkus-consumer-api-native \
      -p 9107:8080 -e QUARKUS_PROFILE=native -e KAFKA_HOST=kafka -e KAFKA_PORT=9092 \
      -e JAVA_OPTIONS=$JAVA_OPTS_XMX -m $CONTAINER_MAX_MEM \
      --network producer-consumer_default \
      ivanfranchin/quarkus-consumer-api-native:1.0.0

    wait_for_container_log "quarkus-consumer-api-native" "started in"
    startup_time_sec=$(extract_startup_time_from_log "$wait_for_container_log_matched_row" "{print substr(\$15,0,length(\$15)-2)}")
    quarkus_consumer_api_native[startup_time]="$(convert_seconds_to_millis $startup_time_sec)ms"

    quarkus_consumer_api_native[initial_memory_usage]=$(get_container_memory_usage "quarkus-consumer-api-native")

    wait_for_container_log "quarkus-consumer-api-native" "OFFSET: 14999"
    quarkus_consumer_api_native[ab_testing_time]=$wait_for_container_log_exec_time

    quarkus_consumer_api_native[final_memory_usage]=$(get_container_memory_usage "quarkus-consumer-api-native")

    echo "== Stopping producer-consuner docker containers"

    run_command "docker stop quarkus-producer-api-native"
    quarkus_producer_api_native[shutdown_time]=$run_command_exec_time

    run_command "docker stop quarkus-consumer-api-native"
    quarkus_consumer_api_native[shutdown_time]=$run_command_exec_time

  fi

  if [ "$1" = "micronaut-producer-consumer-jvm" ] ||
     [ "$1" = "micronaut-producer-consumer" ] ||
     [ "$1" = "micronaut-jvm" ] ||
     [ "$1" = "micronaut" ] ||
     [ "$1" = "producer-consumer-jvm" ] ||
     [ "$1" = "producer-consumer" ] ||
     [ "$1" = "jvm" ] ||
     [ "$1" = "all" ];
  then

    echo
    echo "----------------------------------------------"
    echo "MICRONAUT-PRODUCER-CONSUMER / PRODUCER-API-JVM"
    echo "----------------------------------------------"

    docker run -d --rm --name micronaut-producer-api-jvm \
      -p 9102:8080 -e KAFKA_HOST=kafka -e KAFKA_PORT=9092 \
      -e JAVA_OPTIONS=$JAVA_OPTS_XMX -m $CONTAINER_MAX_MEM \
      --network producer-consumer_default \
      ivanfranchin/micronaut-producer-api-jvm:1.0.0

    wait_for_container_log "micronaut-producer-api-jvm" "Startup completed in"
    micronaut_producer_api_jvm[startup_time]=$(extract_startup_time_from_log "$wait_for_container_log_matched_row" "{print substr(\$10,0,length(\$10)-1)}")

    micronaut_producer_api_jvm[initial_memory_usage]=$(get_container_memory_usage "micronaut-producer-api-jvm")

    run_command "ab -p test-news.json -T 'application/json' $AB_PARAMS_PRODUCER_CONSUMER http://localhost:9102/api/news"
    micronaut_producer_api_jvm[ab_testing_time]=$run_command_exec_time

    warm_up $WARM_UP_TIMES "ab -p test-news.json -T 'application/json' $AB_PARAMS_WARM_UP_PRODUCER_CONSUMER http://localhost:9102/api/news"

    run_command "ab -p test-news.json -T 'application/json' $AB_PARAMS_PRODUCER_CONSUMER http://localhost:9102/api/news"
    micronaut_producer_api_jvm[ab_testing_time_2]=$run_command_exec_time

    micronaut_producer_api_jvm[final_memory_usage]=$(get_container_memory_usage "micronaut-producer-api-jvm")

    echo
    echo "----------------------------------------------"
    echo "MICRONAUT-PRODUCER-CONSUMER / CONSUMER-API-JVM"
    echo "----------------------------------------------"

    docker run -d --rm --name micronaut-consumer-api-jvm \
      -p 9108:8080 -e KAFKA_HOST=kafka -e KAFKA_PORT=9092 \
      -e JAVA_OPTIONS=$JAVA_OPTS_XMX -m $CONTAINER_MAX_MEM \
      --network producer-consumer_default \
      ivanfranchin/micronaut-consumer-api-jvm:1.0.0

    wait_for_container_log "micronaut-consumer-api-jvm" "Startup completed in"
    micronaut_consumer_api_jvm[startup_time]=$(extract_startup_time_from_log "$wait_for_container_log_matched_row" "{print substr(\$10,0,length(\$10)-1)}")

    micronaut_consumer_api_jvm[initial_memory_usage]=$(get_container_memory_usage "micronaut-consumer-api-jvm")

    wait_for_container_log "micronaut-consumer-api-jvm" "OFFSET: 14999"
    micronaut_consumer_api_jvm[ab_testing_time]=$wait_for_container_log_exec_time

    micronaut_consumer_api_jvm[final_memory_usage]=$(get_container_memory_usage "micronaut-consumer-api-jvm")

    echo "== Stopping producer-consuner docker containers"

    run_command "docker stop micronaut-producer-api-jvm"
    micronaut_producer_api_jvm[shutdown_time]=$run_command_exec_time

    run_command "docker stop micronaut-consumer-api-jvm"
    micronaut_consumer_api_jvm[shutdown_time]=$run_command_exec_time

  fi

  if [ "$1" = "micronaut-producer-consumer-native" ] ||
     [ "$1" = "micronaut-producer-consumer" ] ||
     [ "$1" = "micronaut-native" ] ||
     [ "$1" = "micronaut" ] ||
     [ "$1" = "producer-consumer-native" ] ||
     [ "$1" = "producer-consumer" ] ||
     [ "$1" = "native" ] ||
     [ "$1" = "all" ];
  then

    echo
    echo "-------------------------------------------------"
    echo "MICRONAUT-PRODUCER-CONSUMER / PRODUCER-API-NATIVE"
    echo "-------------------------------------------------"

    docker run -d --rm --name micronaut-producer-api-native \
      -p 9103:8080 -e MICRONAUT_ENVIRONMENTS=native -e KAFKA_HOST=kafka -e KAFKA_PORT=9092 \
      -e JAVA_OPTIONS=$JAVA_OPTS_XMX -m $CONTAINER_MAX_MEM \
      --network producer-consumer_default \
      ivanfranchin/micronaut-producer-api-native:1.0.0

    wait_for_container_log "micronaut-producer-api-native" "Startup completed in"
    micronaut_producer_api_native[startup_time]=$(extract_startup_time_from_log "$wait_for_container_log_matched_row" "{print substr(\$10,0,length(\$10)-1)}")

    micronaut_producer_api_native[initial_memory_usage]=$(get_container_memory_usage "micronaut-producer-api-native")

    run_command "ab -p test-news.json -T 'application/json' $AB_PARAMS_PRODUCER_CONSUMER http://localhost:9103/api/news"
    micronaut_producer_api_native[ab_testing_time]=$run_command_exec_time

    warm_up $WARM_UP_TIMES "ab -p test-news.json -T 'application/json' $AB_PARAMS_WARM_UP_PRODUCER_CONSUMER http://localhost:9103/api/news"

    run_command "ab -p test-news.json -T 'application/json' $AB_PARAMS_PRODUCER_CONSUMER http://localhost:9103/api/news"
    micronaut_producer_api_native[ab_testing_time_2]=$run_command_exec_time

    micronaut_producer_api_native[final_memory_usage]=$(get_container_memory_usage "micronaut-producer-api-native")

    echo
    echo "-------------------------------------------------"
    echo "MICRONAUT-PRODUCER-CONSUMER / CONSUMER-API-NATIVE"
    echo "-------------------------------------------------"

    docker run -d --rm --name micronaut-consumer-api-native \
      -p 9109:8080 -e MICRONAUT_ENVIRONMENTS=native -e KAFKA_HOST=kafka -e KAFKA_PORT=9092 \
      -e JAVA_OPTIONS=$JAVA_OPTS_XMX -m $CONTAINER_MAX_MEM \
      --network producer-consumer_default \
      ivanfranchin/micronaut-consumer-api-native:1.0.0

    wait_for_container_log "micronaut-consumer-api-native" "Startup completed in"
    micronaut_consumer_api_native[startup_time]=$(extract_startup_time_from_log "$wait_for_container_log_matched_row" "{print substr(\$10,0,length(\$10)-1)}")

    micronaut_consumer_api_native[initial_memory_usage]=$(get_container_memory_usage "micronaut-consumer-api-native")

    wait_for_container_log "micronaut-consumer-api-native" "OFFSET: 14999"
    micronaut_consumer_api_native[ab_testing_time]=$wait_for_container_log_exec_time

    micronaut_consumer_api_native[final_memory_usage]=$(get_container_memory_usage "micronaut-consumer-api-native")

    echo "== Stopping producer-consuner docker containers"

    run_command "docker stop micronaut-producer-api-native"
    micronaut_producer_api_native[shutdown_time]=$run_command_exec_time

    run_command "docker stop micronaut-consumer-api-native"
    micronaut_consumer_api_native[shutdown_time]=$run_command_exec_time

  fi

  if [ "$1" = "springboot-producer-consumer-jvm" ] ||
     [ "$1" = "springboot-producer-consumer" ] ||
     [ "$1" = "springboot-jvm" ] ||
     [ "$1" = "springboot" ] ||
     [ "$1" = "producer-consumer-jvm" ] ||
     [ "$1" = "producer-consumer" ] ||
     [ "$1" = "jvm" ] ||
     [ "$1" = "all" ];
  then

    echo
    echo "-----------------------------------------------"
    echo "SPRINGBOOT-PRODUCER-CONSUMER / PRODUCER-API-JVM"
    echo "-----------------------------------------------"

    docker run -d --rm --name springboot-producer-api-jvm \
      -p 9104:8080 -e KAFKA_HOST=kafka -e KAFKA_PORT=9092 \
      -e JAVA_OPTIONS=$JAVA_OPTS_XMX -m $CONTAINER_MAX_MEM \
      --network producer-consumer_default \
      ivanfranchin/springboot-producer-api-jvm:1.0.0

    wait_for_container_log "springboot-producer-api-jvm" "Started"
    startup_time_sec=$(extract_startup_time_from_log "$wait_for_container_log_matched_row" "{print \$13}")
    springboot_producer_api_jvm[startup_time]="$(convert_seconds_to_millis $startup_time_sec)ms"

    springboot_producer_api_jvm[initial_memory_usage]=$(get_container_memory_usage "springboot-producer-api-jvm")

    run_command "ab -p test-news.json -T 'application/json' $AB_PARAMS_PRODUCER_CONSUMER http://localhost:9104/api/news"
    springboot_producer_api_jvm[ab_testing_time]=$run_command_exec_time

    warm_up $WARM_UP_TIMES "ab -p test-news.json -T 'application/json' $AB_PARAMS_WARM_UP_PRODUCER_CONSUMER http://localhost:9104/api/news"

    run_command "ab -p test-news.json -T 'application/json' $AB_PARAMS_PRODUCER_CONSUMER http://localhost:9104/api/news"
    springboot_producer_api_jvm[ab_testing_time_2]=$run_command_exec_time

    springboot_producer_api_jvm[final_memory_usage]=$(get_container_memory_usage "springboot-producer-api-jvm")

    echo
    echo "-----------------------------------------------"
    echo "SPRINGBOOT-PRODUCER-CONSUMER / CONSUMER-API-JVM"
    echo "-----------------------------------------------"

    docker run -d --rm --name springboot-consumer-api-jvm \
      -p 9110:8080 -e KAFKA_HOST=kafka -e KAFKA_PORT=9092 \
      -e JAVA_OPTIONS=$JAVA_OPTS_XMX -m $CONTAINER_MAX_MEM \
      --network producer-consumer_default \
      ivanfranchin/springboot-consumer-api-jvm:1.0.0

    wait_for_container_log "springboot-consumer-api-jvm" "Started"
    startup_time_sec=$(extract_startup_time_from_log "$wait_for_container_log_matched_row" "{print \$13}")
    springboot_consumer_api_jvm[startup_time]="$(convert_seconds_to_millis $startup_time_sec)ms"

    springboot_consumer_api_jvm[initial_memory_usage]=$(get_container_memory_usage "springboot-consumer-api-jvm")

    wait_for_container_log "springboot-consumer-api-jvm" "OFFSET: 14999"
    springboot_consumer_api_jvm[ab_testing_time]=$wait_for_container_log_exec_time

    springboot_consumer_api_jvm[final_memory_usage]=$(get_container_memory_usage "springboot-consumer-api-jvm")

    echo "== Stopping producer-consuner docker containers"

    run_command "docker stop springboot-producer-api-jvm"
    springboot_producer_api_jvm[shutdown_time]=$run_command_exec_time

    run_command "docker stop springboot-consumer-api-jvm"
    springboot_consumer_api_jvm[shutdown_time]=$run_command_exec_time

  fi

  if [ "$1" = "springboot-producer-consumer-native" ] ||
     [ "$1" = "springboot-producer-consumer" ] ||
     [ "$1" = "springboot-native" ] ||
     [ "$1" = "springboot" ] ||
     [ "$1" = "producer-consumer-native" ] ||
     [ "$1" = "producer-consumer" ] ||
     [ "$1" = "native" ] ||
     [ "$1" = "all" ];
  then

    echo
    echo "--------------------------------------------------"
    echo "SPRINGBOOT-PRODUCER-CONSUMER / PRODUCER-API-NATIVE"
    echo "--------------------------------------------------"

    docker run -d --rm --name springboot-producer-api-native \
      -p 9105:8080 -e SPRING_PROFILES_ACTIVE=native -e KAFKA_HOST=kafka -e KAFKA_PORT=9092 \
      -e JAVA_OPTIONS=$JAVA_OPTS_XMX -m $CONTAINER_MAX_MEM \
      --network producer-consumer_default \
      ivanfranchin/springboot-producer-api-native:1.0.0

    wait_for_container_log "springboot-producer-api-native" "Started"
    startup_time_sec=$(extract_startup_time_from_log "$wait_for_container_log_matched_row" "{print \$13}")
    springboot_producer_api_native[startup_time]="$(convert_seconds_to_millis $startup_time_sec)ms"

    springboot_producer_api_native[initial_memory_usage]=$(get_container_memory_usage "springboot-producer-api-native")

    run_command "ab -p test-news.json -T 'application/json' $AB_PARAMS_PRODUCER_CONSUMER http://localhost:9105/api/news"
    springboot_producer_api_native[ab_testing_time]=$run_command_exec_time

    warm_up $WARM_UP_TIMES "ab -p test-news.json -T 'application/json' $AB_PARAMS_WARM_UP_PRODUCER_CONSUMER http://localhost:9105/api/news"

    run_command "ab -p test-news.json -T 'application/json' $AB_PARAMS_PRODUCER_CONSUMER http://localhost:9105/api/news"
    springboot_producer_api_native[ab_testing_time_2]=$run_command_exec_time

    springboot_producer_api_native[final_memory_usage]=$(get_container_memory_usage "springboot-producer-api-native")

    echo
    echo "--------------------------------------------------"
    echo "SPRINGBOOT-PRODUCER-CONSUMER / CONSUMER-API-NATIVE"
    echo "--------------------------------------------------"

    docker run -d --rm --name springboot-consumer-api-native \
      -p 9111:8080 -e SPRING_PROFILES_ACTIVE=native -e KAFKA_HOST=kafka -e KAFKA_PORT=9092 \
      -e JAVA_OPTIONS=$JAVA_OPTS_XMX -m $CONTAINER_MAX_MEM \
      --network producer-consumer_default \
      ivanfranchin/springboot-consumer-api-native:1.0.0

    wait_for_container_log "springboot-consumer-api-native" "Started"
    startup_time_sec=$(extract_startup_time_from_log "$wait_for_container_log_matched_row" "{print \$13}")
    springboot_consumer_api_native[startup_time]="$(convert_seconds_to_millis $startup_time_sec)ms"

    springboot_consumer_api_native[initial_memory_usage]=$(get_container_memory_usage "springboot-consumer-api-native")

    wait_for_container_log "springboot-consumer-api-native" "OFFSET: 14999"
    springboot_consumer_api_native[ab_testing_time]=$wait_for_container_log_exec_time

    springboot_consumer_api_native[final_memory_usage]=$(get_container_memory_usage "springboot-consumer-api-native")

    echo "== Stopping producer-consuner docker containers"

    run_command "docker stop springboot-producer-api-native"
    springboot_producer_api_native[shutdown_time]=$run_command_exec_time

    run_command "docker stop springboot-consumer-api-native"
    springboot_consumer_api_native[shutdown_time]=$run_command_exec_time

  fi

  echo
  echo "=============="
  echo "DOCKER-COMPOSE"
  echo "=============="

  docker-compose down -v

  cd ..

fi

if [ "$1" = "quarkus-elasticsearch-jvm" ] || [ "$1" = "quarkus-elasticsearch-native" ] ||
   [ "$1" = "micronaut-elasticsearch-jvm" ] || [ "$1" = "micronaut-elasticsearch-native" ] ||
   [ "$1" = "springboot-elasticsearch-jvm" ] || [ "$1" = "springboot-elasticsearch-native" ] ||
   [ "$1" = "quarkus-elasticsearch" ] || [ "$1" = "micronaut-elasticsearch" ] || [ "$1" = "springboot-elasticsearch" ] ||
   [ "$1" = "quarkus-jvm" ] || [ "$1" = "micronaut-jvm" ] || [ "$1" = "springboot-jvm" ] ||
   [ "$1" = "quarkus-native" ] || [ "$1" = "micronaut-native" ] || [ "$1" = "springboot-native" ] ||
   [ "$1" = "quarkus" ] || [ "$1" = "micronaut" ] || [ "$1" = "springboot" ] ||
   [ "$1" = "elasticsearch-jvm" ] || [ "$1" = "elasticsearch-native" ] ||
   [ "$1" = "elasticsearch" ] ||
   [ "$1" = "jvm" ] || [ "$1" = "native" ] ||
   [ "$1" = "all" ];
then

  cd elasticsearch

  echo
  echo "=============="
  echo "DOCKER-COMPOSE"
  echo "=============="

  docker-compose up -d
  wait_for_container_status_healthy "9200"

  ./init-es-indexes.sh
  echo

  if [ "$1" = "quarkus-elasticsearch-jvm" ] ||
     [ "$1" = "quarkus-elasticsearch" ] ||
     [ "$1" = "quarkus-jvm" ] ||
     [ "$1" = "quarkus" ] ||
     [ "$1" = "elasticsearch-jvm" ] ||
     [ "$1" = "elasticsearch" ] ||
     [ "$1" = "jvm" ] ||
     [ "$1" = "all" ];
  then

    echo
    echo "-------------------------"
    echo "QUARKUS-ELASTICSEARCH-JVM"
    echo "-------------------------"

    docker run -d --rm --name quarkus-elasticsearch-jvm \
      -p 9112:8080 -e ELASTICSEARCH_HOST=elasticsearch \
      -e JAVA_OPTIONS=$JAVA_OPTS_XMX -m $CONTAINER_MAX_MEM \
      --network elasticsearch_default \
      ivanfranchin/quarkus-elasticsearch-jvm:1.0.0

    wait_for_container_log "quarkus-elasticsearch-jvm" "started in"
    startup_time_sec=$(extract_startup_time_from_log "$wait_for_container_log_matched_row" "{print substr(\$16,0,length(\$16)-2)}")
    quarkus_elasticsearch_jvm[startup_time]="$(convert_seconds_to_millis $startup_time_sec)ms"

    quarkus_elasticsearch_jvm[initial_memory_usage]=$(get_container_memory_usage "quarkus-elasticsearch-jvm")

    run_command "ab -p test-movies.json -T 'application/json' $AB_PARAMS_ELASTICSEARCH http://localhost:9112/api/movies"
    quarkus_elasticsearch_jvm[ab_testing_time]=$run_command_exec_time

    warm_up $WARM_UP_TIMES "ab -p test-movies.json -T 'application/json' $AB_PARAMS_WARM_UP_ELASTICSEARCH http://localhost:9112/api/movies"

    run_command "ab -p test-movies.json -T 'application/json' $AB_PARAMS_ELASTICSEARCH http://localhost:9112/api/movies"
    quarkus_elasticsearch_jvm[ab_testing_time_2]=$run_command_exec_time

    quarkus_elasticsearch_jvm[final_memory_usage]=$(get_container_memory_usage "quarkus-elasticsearch-jvm")

    run_command "docker stop quarkus-elasticsearch-jvm"
    quarkus_elasticsearch_jvm[shutdown_time]=$run_command_exec_time

  fi

  if [ "$1" = "quarkus-elasticsearch-native" ] ||
     [ "$1" = "quarkus-elasticsearch" ] ||
     [ "$1" = "quarkus-native" ] ||
     [ "$1" = "quarkus" ] ||
     [ "$1" = "elasticsearch-native" ] ||
     [ "$1" = "elasticsearch" ] ||
     [ "$1" = "native" ] ||
     [ "$1" = "all" ];
  then

    echo
    echo "----------------------------"
    echo "QUARKUS-ELASTICSEARCH-NATIVE"
    echo "----------------------------"

    docker run -d --rm --name quarkus-elasticsearch-native \
      -p 9113:8080 -e QUARKUS_PROFILE=native -e ELASTICSEARCH_HOST=elasticsearch \
      -e JAVA_OPTIONS=$JAVA_OPTS_XMX -m $CONTAINER_MAX_MEM \
      --network elasticsearch_default \
      ivanfranchin/quarkus-elasticsearch-native:1.0.0

    wait_for_container_log "quarkus-elasticsearch-native" "started in"
    startup_time_sec=$(extract_startup_time_from_log "$wait_for_container_log_matched_row" "{print substr(\$15,0,length(\$15)-2)}")
    quarkus_elasticsearch_native[startup_time]="$(convert_seconds_to_millis $startup_time_sec)ms"

    quarkus_elasticsearch_native[initial_memory_usage]=$(get_container_memory_usage "quarkus-elasticsearch-native")

    run_command "ab -p test-movies.json -T 'application/json' $AB_PARAMS_ELASTICSEARCH http://localhost:9113/api/movies"
    quarkus_elasticsearch_native[ab_testing_time]=$run_command_exec_time

    warm_up $WARM_UP_TIMES "ab -p test-movies.json -T 'application/json' $AB_PARAMS_WARM_UP_ELASTICSEARCH http://localhost:9113/api/movies"

    run_command "ab -p test-movies.json -T 'application/json' $AB_PARAMS_ELASTICSEARCH http://localhost:9113/api/movies"
    quarkus_elasticsearch_native[ab_testing_time_2]=$run_command_exec_time

    quarkus_elasticsearch_native[final_memory_usage]=$(get_container_memory_usage "quarkus-elasticsearch-native")

    run_command "docker stop quarkus-elasticsearch-native"
    quarkus_elasticsearch_native[shutdown_time]=$run_command_exec_time

  fi

  if [ "$1" = "micronaut-elasticsearch-jvm" ] ||
     [ "$1" = "micronaut-elasticsearch" ] ||
     [ "$1" = "micronaut-jvm" ] ||
     [ "$1" = "micronaut" ] ||
     [ "$1" = "elasticsearch-jvm" ] ||
     [ "$1" = "elasticsearch" ] ||
     [ "$1" = "jvm" ] ||
     [ "$1" = "all" ];
  then

    echo
    echo "---------------------------"
    echo "MICRONAUT-ELASTICSEARCH-JVM"
    echo "---------------------------"

    docker run -d --rm --name micronaut-elasticsearch-jvm \
      -p 9114:8080 -e ELASTICSEARCH_HOST=elasticsearch \
      -e JAVA_OPTIONS=$JAVA_OPTS_XMX -m $CONTAINER_MAX_MEM \
      --network elasticsearch_default \
      ivanfranchin/micronaut-elasticsearch-jvm:1.0.0

    wait_for_container_log "micronaut-elasticsearch-jvm" "Startup completed in"
    micronaut_elasticsearch_jvm[startup_time]=$(extract_startup_time_from_log "$wait_for_container_log_matched_row" "{print substr(\$10,0,length(\$10)-1)}")

    micronaut_elasticsearch_jvm[initial_memory_usage]=$(get_container_memory_usage "micronaut-elasticsearch-jvm")

    run_command "ab -p test-movies.json -T 'application/json' $AB_PARAMS_ELASTICSEARCH http://localhost:9114/api/movies"
    micronaut_elasticsearch_jvm[ab_testing_time]=$run_command_exec_time

    warm_up $WARM_UP_TIMES "ab -p test-movies.json -T 'application/json' $AB_PARAMS_WARM_UP_ELASTICSEARCH http://localhost:9114/api/movies"

    run_command "ab -p test-movies.json -T 'application/json' $AB_PARAMS_ELASTICSEARCH http://localhost:9114/api/movies"
    micronaut_elasticsearch_jvm[ab_testing_time_2]=$run_command_exec_time

    micronaut_elasticsearch_jvm[final_memory_usage]=$(get_container_memory_usage "micronaut-elasticsearch-jvm")

    run_command "docker stop micronaut-elasticsearch-jvm"
    micronaut_elasticsearch_jvm[shutdown_time]=$run_command_exec_time

  fi

  if [ "$1" = "micronaut-elasticsearch-native" ] ||
     [ "$1" = "micronaut-elasticsearch" ] ||
     [ "$1" = "micronaut-native" ] ||
     [ "$1" = "micronaut" ] ||
     [ "$1" = "elasticsearch-native" ] ||
     [ "$1" = "elasticsearch" ] ||
     [ "$1" = "native" ] ||
     [ "$1" = "all" ];
  then

    echo
    echo "------------------------------"
    echo "MICRONAUT-ELASTICSEARCH-NATIVE"
    echo "------------------------------"

    docker run -d --rm --name micronaut-elasticsearch-native \
      -p 9115:8080 -e MICRONAUT_ENVIRONMENTS=native -e ELASTICSEARCH_HOST=elasticsearch \
      -e JAVA_OPTIONS=$JAVA_OPTS_XMX -m $CONTAINER_MAX_MEM \
      --network elasticsearch_default \
      ivanfranchin/micronaut-elasticsearch-native:1.0.0

    wait_for_container_log "micronaut-elasticsearch-native" "Startup completed in"
    micronaut_elasticsearch_native[startup_time]=$(extract_startup_time_from_log "$wait_for_container_log_matched_row" "{print substr(\$10,0,length(\$10)-1)}")

    micronaut_elasticsearch_native[initial_memory_usage]=$(get_container_memory_usage "micronaut-elasticsearch-native")

    run_command "ab -p test-movies.json -T 'application/json' $AB_PARAMS_ELASTICSEARCH http://localhost:9115/api/movies"
    micronaut_elasticsearch_native[ab_testing_time]=$run_command_exec_time

    warm_up $WARM_UP_TIMES "ab -p test-movies.json -T 'application/json' $AB_PARAMS_WARM_UP_ELASTICSEARCH http://localhost:9115/api/movies"

    run_command "ab -p test-movies.json -T 'application/json' $AB_PARAMS_ELASTICSEARCH http://localhost:9115/api/movies"
    micronaut_elasticsearch_native[ab_testing_time_2]=$run_command_exec_time

    micronaut_elasticsearch_native[final_memory_usage]=$(get_container_memory_usage "micronaut-elasticsearch-native")

    run_command "docker stop micronaut-elasticsearch-native"
    micronaut_elasticsearch_native[shutdown_time]=$run_command_exec_time

  fi

  if [ "$1" = "springboot-elasticsearch-jvm" ] ||
     [ "$1" = "springboot-elasticsearch" ] ||
     [ "$1" = "springboot-jvm" ] ||
     [ "$1" = "springboot" ] ||
     [ "$1" = "elasticsearch-jvm" ] ||
     [ "$1" = "elasticsearch" ] ||
     [ "$1" = "jvm" ] ||
     [ "$1" = "all" ];
  then

    echo
    echo "----------------------------"
    echo "SPRINGBOOT-ELASTICSEARCH-JVM"
    echo "----------------------------"

    docker run -d --rm --name springboot-elasticsearch-jvm \
      -p 9116:8080 -e ELASTICSEARCH_HOST=elasticsearch \
      -e JAVA_OPTIONS=$JAVA_OPTS_XMX -m $CONTAINER_MAX_MEM \
      --network elasticsearch_default \
      ivanfranchin/springboot-elasticsearch-jvm:1.0.0

    wait_for_container_log "springboot-elasticsearch-jvm" "Started"
    startup_time_sec=$(extract_startup_time_from_log "$wait_for_container_log_matched_row" "{print \$13}")
    springboot_elasticsearch_jvm[startup_time]="$(convert_seconds_to_millis $startup_time_sec)ms"

    springboot_elasticsearch_jvm[initial_memory_usage]=$(get_container_memory_usage "springboot-elasticsearch-jvm")

    run_command "ab -p test-movies.json -T 'application/json' $AB_PARAMS_ELASTICSEARCH http://localhost:9116/api/movies"
    springboot_elasticsearch_jvm[ab_testing_time]=$run_command_exec_time

    warm_up $WARM_UP_TIMES "ab -p test-movies.json -T 'application/json' $AB_PARAMS_WARM_UP_ELASTICSEARCH http://localhost:9116/api/movies"

    run_command "ab -p test-movies.json -T 'application/json' $AB_PARAMS_ELASTICSEARCH http://localhost:9116/api/movies"
    springboot_elasticsearch_jvm[ab_testing_time_2]=$run_command_exec_time

    springboot_elasticsearch_jvm[final_memory_usage]=$(get_container_memory_usage "springboot-elasticsearch-jvm")

    run_command "docker stop springboot-elasticsearch-jvm"
    springboot_elasticsearch_jvm[shutdown_time]=$run_command_exec_time

  fi

  if [ "$1" = "springboot-elasticsearch-native" ] ||
     [ "$1" = "springboot-elasticsearch" ] ||
     [ "$1" = "springboot-native" ] ||
     [ "$1" = "springboot" ] ||
     [ "$1" = "elasticsearch-native" ] ||
     [ "$1" = "elasticsearch" ] ||
     [ "$1" = "native" ] ||
     [ "$1" = "all" ];
  then

    echo
    echo "-------------------------------"
    echo "SPRINGBOOT-ELASTICSEARCH-NATIVE"
    echo "-------------------------------"

    docker run -d --rm --name springboot-elasticsearch-native \
      -p 9117:8080 -e SPRING_PROFILES_ACTIVE=native -e ELASTICSEARCH_HOST=elasticsearch \
      -e JAVA_OPTIONS=$JAVA_OPTS_XMX -m $CONTAINER_MAX_MEM \
      --network elasticsearch_default \
      ivanfranchin/springboot-elasticsearch-native:1.0.0

    wait_for_container_log "springboot-elasticsearch-native" "Started"
    startup_time_sec=$(extract_startup_time_from_log "$wait_for_container_log_matched_row" "{print \$13}")
    springboot_elasticsearch_native[startup_time]="$(convert_seconds_to_millis $startup_time_sec)ms"

    springboot_elasticsearch_native[initial_memory_usage]=$(get_container_memory_usage "springboot-elasticsearch-native")

    run_command "ab -p test-movies.json -T 'application/json' $AB_PARAMS_ELASTICSEARCH http://localhost:9117/api/movies"
    springboot_elasticsearch_native[ab_testing_time]=$run_command_exec_time

    warm_up $WARM_UP_TIMES "ab -p test-movies.json -T 'application/json' $AB_PARAMS_WARM_UP_ELASTICSEARCH http://localhost:9117/api/movies"

    run_command "ab -p test-movies.json -T 'application/json' $AB_PARAMS_ELASTICSEARCH http://localhost:9117/api/movies"
    springboot_elasticsearch_native[ab_testing_time_2]=$run_command_exec_time

    springboot_elasticsearch_native[final_memory_usage]=$(get_container_memory_usage "springboot-elasticsearch-native")

    run_command "docker stop springboot-elasticsearch-native"
    springboot_elasticsearch_native[shutdown_time]=$run_command_exec_time

  fi

  echo
  echo "=============="
  echo "DOCKER-COMPOSE"
  echo "=============="

  docker-compose down -v

  cd ..

fi

printf "\n"
printf "%31s | %12s | %24s | %15s | %17s | %24s | %13s |\n" "Application" "Startup Time" "Initial Memory Usage" "Ab Testing Time" "Ab Testing Time 2" "Final Memory Usage" "Shutdown Time"
printf "%31s + %12s + %24s + %15s + %17s + %24s + %13s |\n" "-------------------------------" "------------" "------------------------" "---------------" "-----------------" "------------------------" "-------------"
printf "%31s | %12s | %24s | %15s | %17s | %24s | %13s |\n" "quarkus-simple-api-jvm" ${quarkus_simple_api_jvm[startup_time]} ${quarkus_simple_api_jvm[initial_memory_usage]} ${quarkus_simple_api_jvm[ab_testing_time]} ${quarkus_simple_api_jvm[ab_testing_time_2]} ${quarkus_simple_api_jvm[final_memory_usage]} ${quarkus_simple_api_jvm[shutdown_time]}
printf "%31s | %12s | %24s | %15s | %17s | %24s | %13s |\n" "micronaut-simple-api-jvm" ${micronaut_simple_api_jvm[startup_time]} ${micronaut_simple_api_jvm[initial_memory_usage]} ${micronaut_simple_api_jvm[ab_testing_time]} ${micronaut_simple_api_jvm[ab_testing_time_2]} ${micronaut_simple_api_jvm[final_memory_usage]} ${micronaut_simple_api_jvm[shutdown_time]}
printf "%31s | %12s | %24s | %15s | %17s | %24s | %13s |\n" "springboot-simple-api-jvm" ${springboot_simple_api_jvm[startup_time]} ${springboot_simple_api_jvm[initial_memory_usage]} ${springboot_simple_api_jvm[ab_testing_time]} ${springboot_simple_api_jvm[ab_testing_time_2]} ${springboot_simple_api_jvm[final_memory_usage]} ${springboot_simple_api_jvm[shutdown_time]}
printf "%31s | %12s | %24s | %15s | %17s | %24s | %13s |\n" "quarkus-simple-api-native" ${quarkus_simple_api_native[startup_time]} ${quarkus_simple_api_native[initial_memory_usage]} ${quarkus_simple_api_native[ab_testing_time]} ${quarkus_simple_api_native[ab_testing_time_2]} ${quarkus_simple_api_native[final_memory_usage]} ${quarkus_simple_api_native[shutdown_time]}
printf "%31s | %12s | %24s | %15s | %17s | %24s | %13s |\n" "micronaut-simple-api-native" ${micronaut_simple_api_native[startup_time]} ${micronaut_simple_api_native[initial_memory_usage]} ${micronaut_simple_api_native[ab_testing_time]} ${micronaut_simple_api_native[ab_testing_time_2]} ${micronaut_simple_api_native[final_memory_usage]} ${micronaut_simple_api_native[shutdown_time]}
printf "%31s | %12s | %24s | %15s | %17s | %24s | %13s |\n" "springboot-simple-api-native" ${springboot_simple_api_native[startup_time]} ${springboot_simple_api_native[initial_memory_usage]} ${springboot_simple_api_native[ab_testing_time]} ${springboot_simple_api_native[ab_testing_time_2]} ${springboot_simple_api_native[final_memory_usage]} ${springboot_simple_api_native[shutdown_time]}
printf "%31s + %12s + %24s + %15s + %17s + %24s + %13s |\n" "..............................." "............" "........................" "..............." "................." "........................" "............."
printf "%31s | %12s | %24s | %15s | %17s | %24s | %13s |\n" "quarkus-jpa-mysql-jvm" ${quarkus_jpa_mysql_jvm[startup_time]} ${quarkus_jpa_mysql_jvm[initial_memory_usage]} ${quarkus_jpa_mysql_jvm[ab_testing_time]} ${quarkus_jpa_mysql_jvm[ab_testing_time_2]} ${quarkus_jpa_mysql_jvm[final_memory_usage]} ${quarkus_jpa_mysql_jvm[shutdown_time]}
printf "%31s | %12s | %24s | %15s | %17s | %24s | %13s |\n" "micronaut-jpa-mysql-jvm" ${micronaut_jpa_mysql_jvm[startup_time]} ${micronaut_jpa_mysql_jvm[initial_memory_usage]} ${micronaut_jpa_mysql_jvm[ab_testing_time]} ${micronaut_jpa_mysql_jvm[ab_testing_time_2]} ${micronaut_jpa_mysql_jvm[final_memory_usage]} ${micronaut_jpa_mysql_jvm[shutdown_time]}
printf "%31s | %12s | %24s | %15s | %17s | %24s | %13s |\n" "springboot-jpa-mysql-jvm" ${springboot_jpa_mysql_jvm[startup_time]} ${springboot_jpa_mysql_jvm[initial_memory_usage]} ${springboot_jpa_mysql_jvm[ab_testing_time]} ${springboot_jpa_mysql_jvm[ab_testing_time_2]} ${springboot_jpa_mysql_jvm[final_memory_usage]} ${springboot_jpa_mysql_jvm[shutdown_time]}
printf "%31s | %12s | %24s | %15s | %17s | %24s | %13s |\n" "quarkus-jpa-mysql-native" ${quarkus_jpa_mysql_native[startup_time]} ${quarkus_jpa_mysql_native[initial_memory_usage]} ${quarkus_jpa_mysql_native[ab_testing_time]} ${quarkus_jpa_mysql_native[ab_testing_time_2]} ${quarkus_jpa_mysql_native[final_memory_usage]} ${quarkus_jpa_mysql_native[shutdown_time]}
printf "%31s | %12s | %24s | %15s | %17s | %24s | %13s |\n" "micronaut-jpa-mysql-native" ${micronaut_jpa_mysql_native[startup_time]} ${micronaut_jpa_mysql_native[initial_memory_usage]} ${micronaut_jpa_mysql_native[ab_testing_time]} ${micronaut_jpa_mysql_native[ab_testing_time_2]} ${micronaut_jpa_mysql_native[final_memory_usage]} ${micronaut_jpa_mysql_native[shutdown_time]}
printf "%31s | %12s | %24s | %15s | %17s | %24s | %13s |\n" "springboot-jpa-mysql-native" ${springboot_jpa_mysql_native[startup_time]} ${springboot_jpa_mysql_native[initial_memory_usage]} ${springboot_jpa_mysql_native[ab_testing_time]} ${springboot_jpa_mysql_native[ab_testing_time_2]} ${springboot_jpa_mysql_native[final_memory_usage]} ${springboot_jpa_mysql_native[shutdown_time]}
printf "%31s + %12s + %24s + %15s + %17s + %24s + %13s |\n" "..............................." "............" "........................" "..............." "................." "........................" "............."
printf "%31s | %12s | %24s | %15s | %17s | %24s | %13s |\n" "quarkus-producer-api-jvm" ${quarkus_producer_api_jvm[startup_time]} ${quarkus_producer_api_jvm[initial_memory_usage]} ${quarkus_producer_api_jvm[ab_testing_time]} ${quarkus_producer_api_jvm[ab_testing_time_2]} ${quarkus_producer_api_jvm[final_memory_usage]} ${quarkus_producer_api_jvm[shutdown_time]}
printf "%31s | %12s | %24s | %15s | %17s | %24s | %13s |\n" "micronaut-producer-api-jvm" ${micronaut_producer_api_jvm[startup_time]} ${micronaut_producer_api_jvm[initial_memory_usage]} ${micronaut_producer_api_jvm[ab_testing_time]} ${micronaut_producer_api_jvm[ab_testing_time_2]} ${micronaut_producer_api_jvm[final_memory_usage]} ${micronaut_producer_api_jvm[shutdown_time]}
printf "%31s | %12s | %24s | %15s | %17s | %24s | %13s |\n" "springboot-producer-api-jvm" ${springboot_producer_api_jvm[startup_time]} ${springboot_producer_api_jvm[initial_memory_usage]} ${springboot_producer_api_jvm[ab_testing_time]} ${springboot_producer_api_jvm[ab_testing_time_2]} ${springboot_producer_api_jvm[final_memory_usage]} ${springboot_producer_api_jvm[shutdown_time]}
printf "%31s | %12s | %24s | %15s | %17s | %24s | %13s |\n" "quarkus-producer-api-native" ${quarkus_producer_api_native[startup_time]} ${quarkus_producer_api_native[initial_memory_usage]} ${quarkus_producer_api_native[ab_testing_time]} ${quarkus_producer_api_native[ab_testing_time_2]} ${quarkus_producer_api_native[final_memory_usage]} ${quarkus_producer_api_native[shutdown_time]}
printf "%31s | %12s | %24s | %15s | %17s | %24s | %13s |\n" "micronaut-producer-api-native" ${micronaut_producer_api_native[startup_time]} ${micronaut_producer_api_native[initial_memory_usage]} ${micronaut_producer_api_native[ab_testing_time]} ${micronaut_producer_api_native[ab_testing_time_2]} ${micronaut_producer_api_native[final_memory_usage]} ${micronaut_producer_api_native[shutdown_time]}
printf "%31s | %12s | %24s | %15s | %17s | %24s | %13s |\n" "springboot-producer-api-native" ${springboot_producer_api_native[startup_time]} ${springboot_producer_api_native[initial_memory_usage]} ${springboot_producer_api_native[ab_testing_time]} ${springboot_producer_api_native[ab_testing_time_2]} ${springboot_producer_api_native[final_memory_usage]} ${springboot_producer_api_native[shutdown_time]}
printf "%31s + %12s + %24s + %15s + %17s + %24s + %13s |\n" "..............................." "............" "........................" "..............." "................." "........................" "............."
printf "%31s | %12s | %24s | %15s   %17s | %24s | %13s |\n" "quarkus-consumer-api-jvm" ${quarkus_consumer_api_jvm[startup_time]} ${quarkus_consumer_api_jvm[initial_memory_usage]} " " ${quarkus_consumer_api_jvm[ab_testing_time]} ${quarkus_consumer_api_jvm[final_memory_usage]} ${quarkus_consumer_api_jvm[shutdown_time]}
printf "%31s | %12s | %24s | %15s   %17s | %24s | %13s |\n" "micronaut-consumer-api-jvm" ${micronaut_consumer_api_jvm[startup_time]} ${micronaut_consumer_api_jvm[initial_memory_usage]} " " ${micronaut_consumer_api_jvm[ab_testing_time]} ${micronaut_consumer_api_jvm[final_memory_usage]} ${micronaut_consumer_api_jvm[shutdown_time]}
printf "%31s | %12s | %24s | %15s   %17s | %24s | %13s |\n" "springboot-consumer-api-jvm" ${springboot_consumer_api_jvm[startup_time]} ${springboot_consumer_api_jvm[initial_memory_usage]} " " ${springboot_consumer_api_jvm[ab_testing_time]} ${springboot_consumer_api_jvm[final_memory_usage]} ${springboot_consumer_api_jvm[shutdown_time]}
printf "%31s | %12s | %24s | %15s   %17s | %24s | %13s |\n" "quarkus-consumer-api-native" ${quarkus_consumer_api_native[startup_time]} ${quarkus_consumer_api_native[initial_memory_usage]} " " ${quarkus_consumer_api_native[ab_testing_time]} ${quarkus_consumer_api_native[final_memory_usage]} ${quarkus_consumer_api_native[shutdown_time]}
printf "%31s | %12s | %24s | %15s   %17s | %24s | %13s |\n" "micronaut-consumer-api-native" ${micronaut_consumer_api_native[startup_time]} ${micronaut_consumer_api_native[initial_memory_usage]} " " ${micronaut_consumer_api_native[ab_testing_time]} ${micronaut_consumer_api_native[final_memory_usage]} ${micronaut_consumer_api_native[shutdown_time]}
printf "%31s | %12s | %24s | %15s   %17s | %24s | %13s |\n" "springboot-consumer-api-native" ${springboot_consumer_api_native[startup_time]} ${springboot_consumer_api_native[initial_memory_usage]} " " ${springboot_consumer_api_native[ab_testing_time]} ${springboot_consumer_api_native[final_memory_usage]} ${springboot_consumer_api_native[shutdown_time]}
printf "%31s + %12s + %24s + %15s + %17s + %24s + %13s |\n" "..............................." "............" "........................" "..............." "................." "........................" "............."
printf "%31s | %12s | %24s | %15s | %17s | %24s | %13s |\n" "quarkus-elasticsearch-jvm" ${quarkus_elasticsearch_jvm[startup_time]} ${quarkus_elasticsearch_jvm[initial_memory_usage]} ${quarkus_elasticsearch_jvm[ab_testing_time]} ${quarkus_elasticsearch_jvm[ab_testing_time_2]} ${quarkus_elasticsearch_jvm[final_memory_usage]} ${quarkus_elasticsearch_jvm[shutdown_time]}
printf "%31s | %12s | %24s | %15s | %17s | %24s | %13s |\n" "micronaut-elasticsearch-jvm" ${micronaut_elasticsearch_jvm[startup_time]} ${micronaut_elasticsearch_jvm[initial_memory_usage]} ${micronaut_elasticsearch_jvm[ab_testing_time]} ${micronaut_elasticsearch_jvm[ab_testing_time_2]} ${micronaut_elasticsearch_jvm[final_memory_usage]} ${micronaut_elasticsearch_jvm[shutdown_time]}
printf "%31s | %12s | %24s | %15s | %17s | %24s | %13s |\n" "springboot-elasticsearch-jvm" ${springboot_elasticsearch_jvm[startup_time]} ${springboot_elasticsearch_jvm[initial_memory_usage]} ${springboot_elasticsearch_jvm[ab_testing_time]} ${springboot_elasticsearch_jvm[ab_testing_time_2]} ${springboot_elasticsearch_jvm[final_memory_usage]} ${springboot_elasticsearch_jvm[shutdown_time]}
printf "%31s | %12s | %24s | %15s | %17s | %24s | %13s |\n" "quarkus-elasticsearch-native" ${quarkus_elasticsearch_native[startup_time]} ${quarkus_elasticsearch_native[initial_memory_usage]} ${quarkus_elasticsearch_native[ab_testing_time]} ${quarkus_elasticsearch_native[ab_testing_time_2]} ${quarkus_elasticsearch_native[final_memory_usage]} ${quarkus_elasticsearch_native[shutdown_time]}
printf "%31s | %12s | %24s | %15s | %17s | %24s | %13s |\n" "micronaut-elasticsearch-native" ${micronaut_elasticsearch_native[startup_time]} ${micronaut_elasticsearch_native[initial_memory_usage]} ${micronaut_elasticsearch_native[ab_testing_time]} ${micronaut_elasticsearch_native[ab_testing_time_2]} ${micronaut_elasticsearch_native[final_memory_usage]} ${micronaut_elasticsearch_native[shutdown_time]}
printf "%31s | %12s | %24s | %15s | %17s | %24s | %13s |\n" "springboot-elasticsearch-native" ${springboot_elasticsearch_native[startup_time]} ${springboot_elasticsearch_native[initial_memory_usage]} ${springboot_elasticsearch_native[ab_testing_time]} ${springboot_elasticsearch_native[ab_testing_time_2]} ${springboot_elasticsearch_native[final_memory_usage]} ${springboot_elasticsearch_native[shutdown_time]}

echo
echo "==>  START AT: ${start_time}"
echo "==> FINISH AT: $(date)"
echo