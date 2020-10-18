#!/usr/bin/env bash

source my-functions.sh

declare -A quarkus_book_api_jvm
declare -A quarkus_book_api_native
declare -A micronaut_book_api_jvm
declare -A micronaut_book_api_native
declare -A springboot_book_api_jvm
declare -A springboot_book_api_native

start_time=$(date)

JAVA_OPTS_XMX='-Xmx128m'
CONTAINER_MAX_MEM=256M

AB_PARAMS_WARM_UP_BOOK_API='-c 5 -n 1000'
AB_PARAMS_BOOK_API='-c 10 -n 2000'

echo
echo "========"
echo "BOOK-API"
echo "========"

cd book-api

echo
echo "=============="
echo "DOCKER-COMPOSE"
echo "=============="

docker-compose up -d
wait_for_container_log "mysql" "port: 33060"

echo
echo "--------------------"
echo "QUARKUS-BOOK-API-JVM"
echo "--------------------"

echo "-- Begin: startup warm-up"
docker run -d --rm --name quarkus-book-api-jvm -p 9085:8080 -e MYSQL_HOST=mysql \
  -e JAVA_OPTIONS=$JAVA_OPTS_XMX -m $CONTAINER_MAX_MEM \
  --network book-api_default \
  docker.mycompany.com/quarkus-book-api-jvm:1.0.0
wait_for_container_log "quarkus-book-api-jvm" "started in"
docker stop quarkus-book-api-jvm
echo "-- End: startup warm-up"

docker run -d --rm --name quarkus-book-api-jvm -p 9085:8080 -e MYSQL_HOST=mysql \
  -e JAVA_OPTIONS=$JAVA_OPTS_XMX -m $CONTAINER_MAX_MEM \
  --network book-api_default \
  docker.mycompany.com/quarkus-book-api-jvm:1.0.0

wait_for_container_log "quarkus-book-api-jvm" "started in"
startup_time_sec=$(extract_startup_time_from_log "$wait_for_container_log_matched_row" "{print substr(\$16,0,length(\$16)-2)}")
quarkus_book_api_jvm[startup_time]="$(convert_seconds_to_millis $startup_time_sec)ms"

quarkus_book_api_jvm[initial_memory_usage]=$(get_container_memory_usage "quarkus-book-api-jvm")

echo "-- Begin: ab test warm-up"
run_command "ab -p test-books.json -T 'application/json' $AB_PARAMS_WARM_UP_BOOK_API http://localhost:9085/api/books"
run_command "ab -p test-books.json -T 'application/json' $AB_PARAMS_WARM_UP_BOOK_API http://localhost:9085/api/books"
echo "-- End: ab test warm-up"

run_command "ab -p test-books.json -T 'application/json' $AB_PARAMS_BOOK_API http://localhost:9085/api/books"
quarkus_book_api_jvm[ab_testing_time]=$run_command_exec_time

quarkus_book_api_jvm[final_memory_usage]=$(get_container_memory_usage "quarkus-book-api-jvm")

run_command "docker stop quarkus-book-api-jvm"
quarkus_book_api_jvm[shutdown_time]=$run_command_exec_time

echo
echo "-----------------------"
echo "QUARKUS-BOOK-API-NATIVE"
echo "-----------------------"

echo "-- Begin: startup warm-up"
docker run -d --rm --name quarkus-book-api-native -p 9086:8080 -e MYSQL_HOST=mysql \
  -e JAVA_OPTIONS=$JAVA_OPTS_XMX -m $CONTAINER_MAX_MEM \
  --network book-api_default \
  docker.mycompany.com/quarkus-book-api-native:1.0.0
wait_for_container_log "quarkus-book-api-native" "started in"
docker stop quarkus-book-api-native
echo "-- End: startup warm-up"

docker run -d --rm --name quarkus-book-api-native -p 9086:8080 -e MYSQL_HOST=mysql \
  -e JAVA_OPTIONS=$JAVA_OPTS_XMX -m $CONTAINER_MAX_MEM \
  --network book-api_default \
  docker.mycompany.com/quarkus-book-api-native:1.0.0

wait_for_container_log "quarkus-book-api-native" "started in"
startup_time_sec=$(extract_startup_time_from_log "$wait_for_container_log_matched_row" "{print substr(\$15,0,length(\$15)-2)}")
quarkus_book_api_native[startup_time]="$(convert_seconds_to_millis $startup_time_sec)ms"

quarkus_book_api_native[initial_memory_usage]=$(get_container_memory_usage "quarkus-book-api-native")

echo "-- Begin: ab test warm-up"
run_command "ab -p test-books.json -T 'application/json' $AB_PARAMS_WARM_UP_BOOK_API http://localhost:9086/api/books"
run_command "ab -p test-books.json -T 'application/json' $AB_PARAMS_WARM_UP_BOOK_API http://localhost:9086/api/books"
echo "-- End: ab test warm-up"

run_command "ab -p test-books.json -T 'application/json' $AB_PARAMS_BOOK_API http://localhost:9086/api/books"
quarkus_book_api_native[ab_testing_time]=$run_command_exec_time

quarkus_book_api_native[final_memory_usage]=$(get_container_memory_usage "quarkus-book-api-native")

run_command "docker stop quarkus-book-api-native"
quarkus_book_api_native[shutdown_time]=$run_command_exec_time

echo
echo "----------------------"
echo "MICRONAUT-BOOK-API-JVM"
echo "----------------------"

echo "-- Begin: startup warm-up"
docker run -d --rm --name micronaut-book-api-jvm -p 9087:8080 -e MYSQL_HOST=mysql \
  -e JAVA_OPTIONS=$JAVA_OPTS_XMX -m $CONTAINER_MAX_MEM \
  --network book-api_default \
  docker.mycompany.com/micronaut-book-api-jvm:1.0.0
wait_for_container_log "micronaut-book-api-jvm" "Startup completed in"
docker stop micronaut-book-api-jvm
echo "-- End: startup warm-up"

docker run -d --rm --name micronaut-book-api-jvm -p 9087:8080 -e MYSQL_HOST=mysql \
  -e JAVA_OPTIONS=$JAVA_OPTS_XMX -m $CONTAINER_MAX_MEM \
  --network book-api_default \
  docker.mycompany.com/micronaut-book-api-jvm:1.0.0

wait_for_container_log "micronaut-book-api-jvm" "Startup completed in"
micronaut_book_api_jvm[startup_time]=$(extract_startup_time_from_log "$wait_for_container_log_matched_row" "{print substr(\$10,0,length(\$10)-1)}")

micronaut_book_api_jvm[initial_memory_usage]=$(get_container_memory_usage "micronaut-book-api-jvm")

echo "-- Begin: ab test warm-up"
run_command "ab -p test-books.json -T 'application/json' $AB_PARAMS_WARM_UP_BOOK_API http://localhost:9087/api/books"
run_command "ab -p test-books.json -T 'application/json' $AB_PARAMS_WARM_UP_BOOK_API http://localhost:9087/api/books"
echo "-- End: ab test warm-up"

run_command "ab -p test-books.json -T 'application/json' $AB_PARAMS_BOOK_API http://localhost:9087/api/books"
micronaut_book_api_jvm[ab_testing_time]=$run_command_exec_time

micronaut_book_api_jvm[final_memory_usage]=$(get_container_memory_usage "micronaut-book-api-jvm")

run_command "docker stop micronaut-book-api-jvm"
micronaut_book_api_jvm[shutdown_time]=$run_command_exec_time

echo
echo "-------------------------"
echo "MICRONAUT-BOOK-API-NATIVE"
echo "-------------------------"

echo "-- Begin: startup warm-up"
docker run -d --rm --name micronaut-book-api-native -p 9088:8080 -e MYSQL_HOST=mysql \
 -e JAVA_OPTIONS=$JAVA_OPTS_XMX -m $CONTAINER_MAX_MEM \
 --network book-api_default \
 docker.mycompany.com/micronaut-book-api-native:1.0.0
wait_for_container_log "micronaut-book-api-native" "Startup completed in"
docker stop micronaut-book-api-native
echo "-- End: startup warm-up"

docker run -d --rm --name micronaut-book-api-native -p 9088:8080 -e MYSQL_HOST=mysql \
 -e JAVA_OPTIONS=$JAVA_OPTS_XMX -m $CONTAINER_MAX_MEM \
 --network book-api_default \
 docker.mycompany.com/micronaut-book-api-native:1.0.0

wait_for_container_log "micronaut-book-api-native" "Startup completed in"
micronaut_book_api_native[startup_time]=$(extract_startup_time_from_log "$wait_for_container_log_matched_row" "{print substr(\$10,0,length(\$10)-1)}")

micronaut_book_api_native[initial_memory_usage]=$(get_container_memory_usage "micronaut-book-api-native")

echo "-- Begin: abtest warm-up"
run_command "ab -p test-books.json -T 'application/json' $AB_PARAMS_WARM_UP_BOOK_API http://localhost:9088/api/books"
run_command "ab -p test-books.json -T 'application/json' $AB_PARAMS_WARM_UP_BOOK_API http://localhost:9088/api/books"
echo "-- End: ab test warm-up"

run_command "ab -p test-books.json -T 'application/json' $AB_PARAMS_BOOK_API http://localhost:9088/api/books"
micronaut_book_api_native[ab_testing_time]=$run_command_exec_time

micronaut_book_api_native[final_memory_usage]=$(get_container_memory_usage "micronaut-book-api-native")

run_command "docker stop micronaut-book-api-native"
micronaut_book_api_native[shutdown_time]=$run_command_exec_time

echo
echo "-----------------------"
echo "SPRINGBOOT-BOOK-API-JVM"
echo "-----------------------"

echo "-- Begin: startup warm-up"
docker run -d --rm --name springboot-book-api-jvm -p 9089:8080 -e MYSQL_HOST=mysql \
  -e JAVA_OPTIONS=$JAVA_OPTS_XMX -m $CONTAINER_MAX_MEM \
  --network book-api_default \
  docker.mycompany.com/springboot-book-api-jvm:1.0.0
wait_for_container_log "springboot-book-api-jvm" "Started"
docker stop springboot-book-api-jvm
echo "-- End: startup warm-up"

docker run -d --rm --name springboot-book-api-jvm -p 9089:8080 -e MYSQL_HOST=mysql \
  -e JAVA_OPTIONS=$JAVA_OPTS_XMX -m $CONTAINER_MAX_MEM \
  --network book-api_default \
  docker.mycompany.com/springboot-book-api-jvm:1.0.0

wait_for_container_log "springboot-book-api-jvm" "Started"
startup_time_sec=$(extract_startup_time_from_log "$wait_for_container_log_matched_row" "{print \$13}")
springboot_book_api_jvm[startup_time]="$(convert_seconds_to_millis $startup_time_sec)ms"

springboot_book_api_jvm[initial_memory_usage]=$(get_container_memory_usage "springboot-book-api-jvm")

echo "-- Begin: ab test warm-up"
run_command "ab -p test-books.json -T 'application/json' $AB_PARAMS_WARM_UP_BOOK_API http://localhost:9089/api/books"
run_command "ab -p test-books.json -T 'application/json' $AB_PARAMS_WARM_UP_BOOK_API http://localhost:9089/api/books"
echo "-- End: ab test warm-up"

run_command "ab -p test-books.json -T 'application/json' $AB_PARAMS_BOOK_API http://localhost:9089/api/books"
springboot_book_api_jvm[ab_testing_time]=$run_command_exec_time

springboot_book_api_jvm[final_memory_usage]=$(get_container_memory_usage "springboot-book-api-jvm")

run_command "docker stop springboot-book-api-jvm"
springboot_book_api_jvm[shutdown_time]=$run_command_exec_time

echo
echo "--------------------------"
echo "SPRINGBOOT-BOOK-API-NATIVE"
echo "--------------------------"

echo "-- Begin: startup warm-up"
docker run -d --rm --name springboot-book-api-native -p 9090:8080 -e MYSQL_HOST=mysql \
  -e JAVA_OPTIONS=$JAVA_OPTS_XMX -m $CONTAINER_MAX_MEM \
  --network book-api_default \
  docker.mycompany.com/springboot-book-api-native:1.0.0
wait_for_container_log "springboot-book-api-native" "Started"
docker stop springboot-book-api-native
echo "-- End: startup warm-up"

docker run -d --rm --name springboot-book-api-native -p 9090:8080 -e MYSQL_HOST=mysql \
  -e JAVA_OPTIONS=$JAVA_OPTS_XMX -m $CONTAINER_MAX_MEM \
  --network book-api_default \
  docker.mycompany.com/springboot-book-api-native:1.0.0

wait_for_container_log "springboot-book-api-native" "Started"
startup_time_sec=$(extract_startup_time_from_log "$wait_for_container_log_matched_row" "{print \$13}")
springboot_book_api_native[startup_time]="$(convert_seconds_to_millis $startup_time_sec)ms"

springboot_book_api_native[initial_memory_usage]=$(get_container_memory_usage "springboot-book-api-native")

echo "-- Begin: ab test warm-up"
run_command "ab -p test-books.json -T 'application/json' $AB_PARAMS_WARM_UP_BOOK_API http://localhost:9090/api/books"
run_command "ab -p test-books.json -T 'application/json' $AB_PARAMS_WARM_UP_BOOK_API http://localhost:9090/api/books"
echo "-- End: ab test warm-up"

run_command "ab -p test-books.json -T 'application/json' $AB_PARAMS_BOOK_API http://localhost:9090/api/books"
springboot_book_api_native[ab_testing_time]=$run_command_exec_time

springboot_book_api_native[final_memory_usage]=$(get_container_memory_usage "springboot-book-api-native")

run_command "docker stop springboot-book-api-native"
springboot_book_api_native[shutdown_time]=$run_command_exec_time

echo
echo "=============="
echo "DOCKER-COMPOSE"
echo "=============="

docker-compose down -v

printf "\n"
printf "%31s | %12s | %24s | %15s | %24s | %13s |\n" "Application" "Startup Time" "Initial Memory Usage" "Ab Testing Time" "Final Memory Usage" "Shutdown Time"
printf "%31s + %12s + %24s + %15s + %24s + %13s |\n" "------------------------------" "------------" "------------------------" "---------------" "------------------------" "-------------"
printf "%31s | %12s | %24s | %15s | %24s | %13s |\n" "quarkus-book-api-jvm" ${quarkus_book_api_jvm[startup_time]} ${quarkus_book_api_jvm[initial_memory_usage]} ${quarkus_book_api_jvm[ab_testing_time]} ${quarkus_book_api_jvm[final_memory_usage]} ${quarkus_book_api_jvm[shutdown_time]}
printf "%31s | %12s | %24s | %15s | %24s | %13s |\n" "micronaut-book-api-jvm" ${micronaut_book_api_jvm[startup_time]} ${micronaut_book_api_jvm[initial_memory_usage]} ${micronaut_book_api_jvm[ab_testing_time]} ${micronaut_book_api_jvm[final_memory_usage]} ${micronaut_book_api_jvm[shutdown_time]}
printf "%31s | %12s | %24s | %15s | %24s | %13s |\n" "springboot-book-api-jvm" ${springboot_book_api_jvm[startup_time]} ${springboot_book_api_jvm[initial_memory_usage]} ${springboot_book_api_jvm[ab_testing_time]} ${springboot_book_api_jvm[final_memory_usage]} ${springboot_book_api_jvm[shutdown_time]}
printf "%31s | %12s | %24s | %15s | %24s | %13s |\n" "quarkus-book-api-native" ${quarkus_book_api_native[startup_time]} ${quarkus_book_api_native[initial_memory_usage]} ${quarkus_book_api_native[ab_testing_time]} ${quarkus_book_api_native[final_memory_usage]} ${quarkus_book_api_native[shutdown_time]}
printf "%31s | %12s | %24s | %15s | %24s | %13s |\n" "micronaut-book-api-native" ${micronaut_book_api_native[startup_time]} ${micronaut_book_api_native[initial_memory_usage]} ${micronaut_book_api_native[ab_testing_time]} ${micronaut_book_api_native[final_memory_usage]} ${micronaut_book_api_native[shutdown_time]}
printf "%31s | %12s | %24s | %15s | %24s | %13s |\n" "springboot-book-api-native" ${springboot_book_api_native[startup_time]} ${springboot_book_api_native[initial_memory_usage]} ${springboot_book_api_native[ab_testing_time]} ${springboot_book_api_native[final_memory_usage]} ${springboot_book_api_native[shutdown_time]}

echo
echo "==>  START AT: ${start_time}"
echo "==> FINISH AT: $(date)"
echo