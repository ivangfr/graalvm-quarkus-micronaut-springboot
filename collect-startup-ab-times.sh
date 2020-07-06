#!/usr/bin/env bash

source my-functions.sh

declare -A quarkus_simple_api_jvm
declare -A quarkus_simple_api_native
declare -A micronaut_simple_api_jvm
declare -A micronaut_simple_api_native
declare -A springboot_simple_api_jvm

declare -A quarkus_book_api_jvm
declare -A quarkus_book_api_native
declare -A micronaut_book_api_jvm
declare -A micronaut_book_api_native
declare -A springboot_book_api_jvm

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

declare -A quarkus_elasticsearch_jvm
declare -A quarkus_elasticsearch_native
declare -A micronaut_elasticsearch_jvm
declare -A micronaut_elasticsearch_native
declare -A springboot_elasticsearch_jvm

start_time=$(date)

echo
echo "=========="
echo "SIMPLE_API"
echo "=========="

echo
echo "----------------------"
echo "QUARKUS-SIMPLE-API-JVM"
echo "----------------------"

docker run -d --rm --name quarkus-simple-api-jvm -p 9080:8080 docker.mycompany.com/quarkus-simple-api-jvm:1.0.0

wait_for_container_log "quarkus-simple-api-jvm" "started in"
startup_time_sec=$(extract_startup_time_from_log "$wait_for_container_log_matched_row" "{print substr(\$16,0,length(\$16)-2)}")
quarkus_simple_api_jvm[startup_time]="$(convert_seconds_to_millis $startup_time_sec)ms"

quarkus_simple_api_jvm[initial_memory_consumption]=$(get_container_memory_consumption "quarkus-simple-api-jvm")

run_command "ab -c 10 -n 7500 http://localhost:9080/api/greeting?name=Ivan"
quarkus_simple_api_jvm[ab_testing_time]=$run_command_exec_time

quarkus_simple_api_jvm[final_memory_consumption]=$(get_container_memory_consumption "quarkus-simple-api-jvm")

docker stop quarkus-simple-api-jvm

echo
echo "-------------------------"
echo "QUARKUS-SIMPLE-API-NATIVE"
echo "-------------------------"

docker run -d --rm --name quarkus-simple-api-native -p 9081:8080 docker.mycompany.com/quarkus-simple-api-native:1.0.0

wait_for_container_log "quarkus-simple-api-native" "started in"
startup_time_sec=$(extract_startup_time_from_log "$wait_for_container_log_matched_row" "{print substr(\$15,0,length(\$15)-2)}")
quarkus_simple_api_native[startup_time]="$(convert_seconds_to_millis $startup_time_sec)ms"

quarkus_simple_api_native[initial_memory_consumption]=$(get_container_memory_consumption "quarkus-simple-api-native")

run_command "ab -c 10 -n 7500 http://localhost:9081/api/greeting?name=Ivan"
quarkus_simple_api_native[ab_testing_time]=$run_command_exec_time

quarkus_simple_api_native[final_memory_consumption]=$(get_container_memory_consumption "quarkus-simple-api-native")

docker stop quarkus-simple-api-native

echo
echo "------------------------"
echo "MICRONAUT-SIMPLE-API-JVM"
echo "------------------------"

docker run -d --rm --name micronaut-simple-api-jvm -p 9082:8080 docker.mycompany.com/micronaut-simple-api-jvm:1.0.0

wait_for_container_log "micronaut-simple-api-jvm" "Startup completed in"
micronaut_simple_api_jvm[startup_time]=$(extract_startup_time_from_log "$wait_for_container_log_matched_row" "{print substr(\$10,0,length(\$10)-1)}")

micronaut_simple_api_jvm[initial_memory_consumption]=$(get_container_memory_consumption "micronaut-simple-api-jvm")

run_command "ab -c 10 -n 7500 http://localhost:9082/api/greeting?name=Ivan"
micronaut_simple_api_jvm[ab_testing_time]=$run_command_exec_time

micronaut_simple_api_jvm[final_memory_consumption]=$(get_container_memory_consumption "micronaut-simple-api-jvm")

docker stop micronaut-simple-api-jvm

echo
echo "---------------------------"
echo "MICRONAUT-SIMPLE-API-NATIVE"
echo "---------------------------"

docker run -d --rm --name micronaut-simple-api-native -p 9083:8080 docker.mycompany.com/micronaut-simple-api-native:1.0.0

wait_for_container_log "micronaut-simple-api-native" "Startup completed in"
micronaut_simple_api_native[startup_time]=$(extract_startup_time_from_log "$wait_for_container_log_matched_row" "{print substr(\$10,0,length(\$10)-1)}")

micronaut_simple_api_native[initial_memory_consumption]=$(get_container_memory_consumption "micronaut-simple-api-native")

run_command "ab -c 10 -n 7500 http://localhost:9083/api/greeting?name=Ivan"
micronaut_simple_api_native[ab_testing_time]=$run_command_exec_time

micronaut_simple_api_native[final_memory_consumption]=$(get_container_memory_consumption "micronaut-simple-api-native")

docker stop micronaut-simple-api-native

echo
echo "---------------------"
echo "SPRINGBOOT-SIMPLE-API"
echo "---------------------"

docker run -d --rm --name springboot-simple-api-jvm -p 9084:8080 docker.mycompany.com/springboot-simple-api-jvm:1.0.0

wait_for_container_log "springboot-simple-api-jvm" "Started"
startup_time_sec=$(extract_startup_time_from_log "$wait_for_container_log_matched_row" "{print \$13}")
springboot_simple_api_jvm[startup_time]="$(convert_seconds_to_millis $startup_time_sec)ms"

springboot_simple_api_jvm[initial_memory_consumption]=$(get_container_memory_consumption "springboot-simple-api-jvm")

run_command "ab -c 10 -n 7500 http://localhost:9084/api/greeting?name=Ivan"
springboot_simple_api_jvm[ab_testing_time]=$run_command_exec_time

springboot_simple_api_jvm[final_memory_consumption]=$(get_container_memory_consumption "springboot-simple-api-jvm")

docker stop springboot-simple-api-jvm

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

./init-db.sh

echo
echo "--------------------"
echo "QUARKUS-BOOK-API-JVM"
echo "--------------------"

docker run -d --rm --name quarkus-book-api-jvm -p 9085:8080 -e MYSQL_HOST=mysql --network book-api_default \
  docker.mycompany.com/quarkus-book-api-jvm:1.0.0

wait_for_container_log "quarkus-book-api-jvm" "started in"
startup_time_sec=$(extract_startup_time_from_log "$wait_for_container_log_matched_row" "{print substr(\$16,0,length(\$16)-2)}")
quarkus_book_api_jvm[startup_time]="$(convert_seconds_to_millis $startup_time_sec)ms"

quarkus_book_api_jvm[initial_memory_consumption]=$(get_container_memory_consumption "quarkus-book-api-jvm")

run_command "ab -p test-books.json -T 'application/json' -c 5 -n 2500 http://localhost:9085/api/books"
quarkus_book_api_jvm[ab_testing_time]=$run_command_exec_time

quarkus_book_api_jvm[final_memory_consumption]=$(get_container_memory_consumption "quarkus-book-api-jvm")

docker stop quarkus-book-api-jvm

echo
echo "-----------------------"
echo "QUARKUS-BOOK-API-NATIVE"
echo "-----------------------"

docker run -d --rm --name quarkus-book-api-native -p 9086:8080 -e MYSQL_HOST=mysql --network book-api_default \
  docker.mycompany.com/quarkus-book-api-native:1.0.0

wait_for_container_log "quarkus-book-api-native" "started in"
startup_time_sec=$(extract_startup_time_from_log "$wait_for_container_log_matched_row" "{print substr(\$15,0,length(\$15)-2)}")
quarkus_book_api_native[startup_time]="$(convert_seconds_to_millis $startup_time_sec)ms"

quarkus_book_api_native[initial_memory_consumption]=$(get_container_memory_consumption "quarkus-book-api-native")

run_command "ab -p test-books.json -T 'application/json' -c 5 -n 2500 http://localhost:9086/api/books"
quarkus_book_api_native[ab_testing_time]=$run_command_exec_time

quarkus_book_api_native[final_memory_consumption]=$(get_container_memory_consumption "quarkus-book-api-native")

docker stop quarkus-book-api-native

echo
echo "----------------------"
echo "MICRONAUT-BOOK-API-JVM"
echo "----------------------"

docker run -d --rm --name micronaut-book-api-jvm -p 9087:8080 -e MYSQL_HOST=mysql --network book-api_default \
  docker.mycompany.com/micronaut-book-api-jvm:1.0.0

wait_for_container_log "micronaut-book-api-jvm" "Startup completed in"
micronaut_book_api_jvm[startup_time]=$(extract_startup_time_from_log "$wait_for_container_log_matched_row" "{print substr(\$10,0,length(\$10)-1)}")

micronaut_book_api_jvm[initial_memory_consumption]=$(get_container_memory_consumption "micronaut-book-api-jvm")

run_command "ab -p test-books.json -T 'application/json' -c 5 -n 2500 http://localhost:9087/api/books"
micronaut_book_api_jvm[ab_testing_time]=$run_command_exec_time

micronaut_book_api_jvm[final_memory_consumption]=$(get_container_memory_consumption "micronaut-book-api-jvm")

docker stop micronaut-book-api-jvm

echo
echo "-------------------------"
echo "MICRONAUT-BOOK-API-NATIVE (DISABLED)"
echo "-------------------------"

#docker run -d --rm --name micronaut-book-api-native -p 9088:8080 -e MYSQL_HOST=mysql --network book-api_default \
#  docker.mycompany.com/micronaut-book-api-native:1.0.0
#
#wait_for_container_log "micronaut-book-api-native" "Startup completed in"
#micronaut_book_api_native[startup_time]=$(extract_startup_time_from_log "$wait_for_container_log_matched_row" "{print substr(\$10,0,length(\$10)-1)}")
#
#micronaut_book_api_native[initial_memory_consumption]=$(get_container_memory_consumption "micronaut-book-api-native")
#
#run_command "ab -p test-books.json -T 'application/json' -c 5 -n 2500 http://localhost:9088/api/books"
#micronaut_book_api_native[ab_testing_time]=$run_command_exec_time
#
#micronaut_book_api_native[final_memory_consumption]=$(get_container_memory_consumption "micronaut-book-api-native")
#
#docker stop micronaut-book-api-native
micronaut_book_api_native[startup_time]="-"
micronaut_book_api_native[initial_memory_consumption]="-"
micronaut_book_api_native[ab_testing_time]="-"
micronaut_book_api_native[final_memory_consumption]="-"

echo
echo "-------------------"
echo "SPRINGBOOT-BOOK-API"
echo "-------------------"

docker run -d --rm --name springboot-book-api-jvm -p 9089:8080 -e MYSQL_HOST=mysql --network book-api_default \
  docker.mycompany.com/springboot-book-api-jvm:1.0.0

wait_for_container_log "springboot-book-api-jvm" "Started"
startup_time_sec=$(extract_startup_time_from_log "$wait_for_container_log_matched_row" "{print \$13}")
springboot_book_api_jvm[startup_time]="$(convert_seconds_to_millis $startup_time_sec)ms"

springboot_book_api_jvm[initial_memory_consumption]=$(get_container_memory_consumption "springboot-book-api-jvm")

run_command "ab -p test-books.json -T 'application/json' -c 5 -n 2500 http://localhost:9089/api/books"
springboot_book_api_jvm[ab_testing_time]=$run_command_exec_time

springboot_book_api_jvm[final_memory_consumption]=$(get_container_memory_consumption "springboot-book-api-jvm")

docker stop springboot-book-api-jvm

echo
echo "=============="
echo "DOCKER-COMPOSE"
echo "=============="

docker-compose down -v

echo
echo "================="
echo "PRODUCER-CONSUMER"
echo "================="

cd ../producer-consumer

echo
echo "=============="
echo "DOCKER-COMPOSE"
echo "=============="

docker-compose up -d
wait_for_container_status_healthy "9092"

echo
echo "--------------------------------------------"
echo "QUARKUS-PRODUCER-CONSUMER / PRODUCER-API-JVM"
echo "--------------------------------------------"

docker run -d --rm --name quarkus-producer-api-jvm -p 9100:8080 --network producer-consumer_default \
  docker.mycompany.com/quarkus-producer-api-jvm:1.0.0

wait_for_container_log "quarkus-producer-api-jvm" "started in"
startup_time_sec=$(extract_startup_time_from_log "$wait_for_container_log_matched_row" "{print substr(\$16,0,length(\$16)-2)}")
quarkus_producer_api_jvm[startup_time]="$(convert_seconds_to_millis $startup_time_sec)ms"

quarkus_producer_api_jvm[initial_memory_consumption]=$(get_container_memory_consumption "quarkus-producer-api-jvm")

run_command "ab -p test-news.json -T 'application/json' -c 5 -n 5000 http://localhost:9100/api/news"
quarkus_producer_api_jvm[ab_testing_time]=$run_command_exec_time

quarkus_producer_api_jvm[final_memory_consumption]=$(get_container_memory_consumption "quarkus-producer-api-jvm")

echo
echo "--------------------------------------------"
echo "QUARKUS-PRODUCER-CONSUMER / CONSUMER-API-JVM"
echo "--------------------------------------------"

docker run -d --rm --name quarkus-consumer-api-jvm -p 9105:8080 --network producer-consumer_default \
  docker.mycompany.com/quarkus-consumer-api-jvm:1.0.0

wait_for_container_log "quarkus-consumer-api-jvm" "started in"
startup_time_sec=$(extract_startup_time_from_log "$wait_for_container_log_matched_row" "{print substr(\$16,0,length(\$16)-2)}")
quarkus_consumer_api_jvm[startup_time]="$(convert_seconds_to_millis $startup_time_sec)ms"

quarkus_consumer_api_jvm[initial_memory_consumption]=$(get_container_memory_consumption "quarkus-consumer-api-jvm")

wait_for_container_log "quarkus-consumer-api-jvm" "OFFSET: 4999"
quarkus_consumer_api_jvm[ab_testing_time]=$wait_for_container_log_exec_time

quarkus_consumer_api_jvm[final_memory_consumption]=$(get_container_memory_consumption "quarkus-consumer-api-jvm")

echo "== Stopping producer-consuner docker containers"
docker stop quarkus-producer-api-jvm
docker stop quarkus-consumer-api-jvm

echo
echo "-----------------------------------------------"
echo "QUARKUS-PRODUCER-CONSUMER / PRODUCER-API-NATIVE"
echo "-----------------------------------------------"

docker run -d --rm --name quarkus-producer-api-native -p 9101:8080 --network producer-consumer_default \
  docker.mycompany.com/quarkus-producer-api-native:1.0.0

wait_for_container_log "quarkus-producer-api-native" "started in"
startup_time_sec=$(extract_startup_time_from_log "$wait_for_container_log_matched_row" "{print substr(\$15,0,length(\$15)-2)}")
quarkus_producer_api_native[startup_time]="$(convert_seconds_to_millis $startup_time_sec)ms"

quarkus_producer_api_native[initial_memory_consumption]=$(get_container_memory_consumption "quarkus-producer-api-native")

run_command "ab -p test-news.json -T 'application/json' -c 5 -n 5000 http://localhost:9101/api/news"
quarkus_producer_api_native[ab_testing_time]=$run_command_exec_time

quarkus_producer_api_native[final_memory_consumption]=$(get_container_memory_consumption "quarkus-producer-api-native")

echo
echo "-----------------------------------------------"
echo "QUARKUS-PRODUCER-CONSUMER / CONSUMER-API-NATIVE"
echo "-----------------------------------------------"

docker run -d --rm --name quarkus-consumer-api-native -p 9106:8080 --network producer-consumer_default \
  docker.mycompany.com/quarkus-consumer-api-native:1.0.0

wait_for_container_log "quarkus-consumer-api-native" "started in"
startup_time_sec=$(extract_startup_time_from_log "$wait_for_container_log_matched_row" "{print substr(\$15,0,length(\$15)-2)}")
quarkus_consumer_api_native[startup_time]="$(convert_seconds_to_millis $startup_time_sec)ms"

quarkus_consumer_api_native[initial_memory_consumption]=$(get_container_memory_consumption "quarkus-consumer-api-native")

wait_for_container_log "quarkus-consumer-api-native" "OFFSET: 9999"
quarkus_consumer_api_native[ab_testing_time]=$wait_for_container_log_exec_time

quarkus_consumer_api_native[final_memory_consumption]=$(get_container_memory_consumption "quarkus-consumer-api-native")

echo "== Stopping producer-consuner docker containers"
docker stop quarkus-producer-api-native
docker stop quarkus-consumer-api-native

echo
echo "----------------------------------------------"
echo "MICRONAUT-PRODUCER-CONSUMER / PRODUCER-API-JVM"
echo "----------------------------------------------"

docker run -d --rm --name micronaut-producer-api-jvm \
  -p 9102:8080 -e KAFKA_HOST=kafka -e ZIPKIN_HOST=zipkin --network producer-consumer_default \
  docker.mycompany.com/micronaut-producer-api-jvm:1.0.0

wait_for_container_log "micronaut-producer-api-jvm" "Startup completed in"
micronaut_producer_api_jvm[startup_time]=$(extract_startup_time_from_log "$wait_for_container_log_matched_row" "{print substr(\$10,0,length(\$10)-1)}")

micronaut_producer_api_jvm[initial_memory_consumption]=$(get_container_memory_consumption "micronaut-producer-api-jvm")

run_command "ab -p test-news.json -T 'application/json' -c 5 -n 5000 http://localhost:9102/api/news"
micronaut_producer_api_jvm[ab_testing_time]=$run_command_exec_time

micronaut_producer_api_jvm[final_memory_consumption]=$(get_container_memory_consumption "micronaut-producer-api-jvm")

echo
echo "----------------------------------------------"
echo "MICRONAUT-PRODUCER-CONSUMER / CONSUMER-API-JVM"
echo "----------------------------------------------"

docker run -d --rm --name micronaut-consumer-api-jvm \
  -p 9107:8080 -e KAFKA_HOST=kafka -e ZIPKIN_HOST=zipkin --network producer-consumer_default \
  docker.mycompany.com/micronaut-consumer-api-jvm:1.0.0

wait_for_container_log "micronaut-consumer-api-jvm" "Startup completed in"
micronaut_consumer_api_jvm[startup_time]=$(extract_startup_time_from_log "$wait_for_container_log_matched_row" "{print substr(\$10,0,length(\$10)-1)}")

micronaut_consumer_api_jvm[initial_memory_consumption]=$(get_container_memory_consumption "micronaut-consumer-api-jvm")

wait_for_container_log "micronaut-consumer-api-jvm" "OFFSET: 4999"
micronaut_consumer_api_jvm[ab_testing_time]=$wait_for_container_log_exec_time

micronaut_consumer_api_jvm[final_memory_consumption]=$(get_container_memory_consumption "micronaut-consumer-api-jvm")

echo "== Stopping producer-consuner docker containers"
docker stop micronaut-producer-api-jvm
docker stop micronaut-consumer-api-jvm

echo
echo "-------------------------------------------------"
echo "MICRONAUT-PRODUCER-CONSUMER / PRODUCER-API-NATIVE"
echo "-------------------------------------------------"

docker run -d --rm --name micronaut-producer-api-native \
  -p 9102:8080 -e KAFKA_HOST=kafka -e ZIPKIN_HOST=zipkin --network producer-consumer_default \
  docker.mycompany.com/micronaut-producer-api-native:1.0.0

wait_for_container_log "micronaut-producer-api-native" "Startup completed in"
micronaut_producer_api_native[startup_time]=$(extract_startup_time_from_log "$wait_for_container_log_matched_row" "{print substr(\$10,0,length(\$10)-1)}")

micronaut_producer_api_native[initial_memory_consumption]=$(get_container_memory_consumption "micronaut-producer-api-native")

run_command "ab -p test-news.json -T 'application/json' -c 5 -n 5000 http://localhost:9102/api/news"
micronaut_producer_api_native[ab_testing_time]=$run_command_exec_time

micronaut_producer_api_native[final_memory_consumption]=$(get_container_memory_consumption "micronaut-producer-api-native")

echo
echo "-------------------------------------------------"
echo "MICRONAUT-PRODUCER-CONSUMER / CONSUMER-API-NATIVE"
echo "-------------------------------------------------"

docker run -d --rm --name micronaut-consumer-api-native \
  -p 9107:8080 -e KAFKA_HOST=kafka -e ZIPKIN_HOST=zipkin --network producer-consumer_default \
  docker.mycompany.com/micronaut-consumer-api-native:1.0.0

wait_for_container_log "micronaut-consumer-api-native" "Startup completed in"
micronaut_consumer_api_native[startup_time]=$(extract_startup_time_from_log "$wait_for_container_log_matched_row" "{print substr(\$10,0,length(\$10)-1)}")

micronaut_consumer_api_native[initial_memory_consumption]=$(get_container_memory_consumption "micronaut-consumer-api-native")

wait_for_container_log "micronaut-consumer-api-native" "OFFSET: 9999"
micronaut_consumer_api_native[ab_testing_time]=$wait_for_container_log_exec_time

micronaut_consumer_api_native[final_memory_consumption]=$(get_container_memory_consumption "micronaut-consumer-api-native")

echo "== Stopping producer-consuner docker containers"
docker stop micronaut-producer-api-native
docker stop micronaut-consumer-api-native

echo
echo "-----------------------------------------------"
echo "SPRINGBOOT-PRODUCER-CONSUMER / PRODUCER-API-JVM"
echo "-----------------------------------------------"

docker run -d --rm --name springboot-producer-api-jvm -p 9104:8080 -e KAFKA_HOST=kafka --network producer-consumer_default \
  docker.mycompany.com/springboot-producer-api-jvm:1.0.0

wait_for_container_log "springboot-producer-api-jvm" "Started"
startup_time_sec=$(extract_startup_time_from_log "$wait_for_container_log_matched_row" "{print \$13}")
springboot_producer_api_jvm[startup_time]="$(convert_seconds_to_millis $startup_time_sec)ms"

springboot_producer_api_jvm[initial_memory_consumption]=$(get_container_memory_consumption "springboot-producer-api-jvm")

run_command "ab -p test-news.json -T 'application/json' -c 5 -n 5000 http://localhost:9104/api/news"
springboot_producer_api_jvm[ab_testing_time]=$run_command_exec_time

springboot_producer_api_jvm[final_memory_consumption]=$(get_container_memory_consumption "springboot-producer-api-jvm")

echo
echo "-----------------------------------------------"
echo "SPRINGBOOT-PRODUCER-CONSUMER / CONSUMER-API-JVM"
echo "-----------------------------------------------"

docker run -d --rm --name springboot-consumer-api-jvm -p 9109:8080 -e KAFKA_HOST=kafka --network producer-consumer_default \
  docker.mycompany.com/springboot-consumer-api-jvm:1.0.0

wait_for_container_log "springboot-consumer-api-jvm" "Started"
startup_time_sec=$(extract_startup_time_from_log "$wait_for_container_log_matched_row" "{print \$13}")
springboot_consumer_api_jvm[startup_time]="$(convert_seconds_to_millis $startup_time_sec)ms"

springboot_consumer_api_jvm[initial_memory_consumption]=$(get_container_memory_consumption "springboot-consumer-api-jvm")

wait_for_container_log "springboot-consumer-api-jvm" "OFFSET: 4999"
springboot_consumer_api_jvm[ab_testing_time]=$wait_for_container_log_exec_time

springboot_consumer_api_jvm[final_memory_consumption]=$(get_container_memory_consumption "springboot-consumer-api-jvm")

echo "== Stopping producer-consuner docker containers"
docker stop springboot-producer-api-jvm
docker stop springboot-consumer-api-jvm

echo
echo "=============="
echo "DOCKER-COMPOSE"
echo "=============="

docker-compose down -v

echo
echo "============="
echo "ELASTICSEARCH"
echo "============="

cd ../elasticsearch

echo
echo "=============="
echo "DOCKER-COMPOSE"
echo "=============="

docker-compose up -d
wait_for_container_status_healthy "9200"

./init-es-indexes.sh

echo
echo
echo "-------------------------"
echo "QUARKUS-ELASTICSEARCH-JVM"
echo "-------------------------"

docker run -d --rm --name quarkus-elasticsearch-jvm -p 9105:8080 -e ELASTICSEARCH_HOST=elasticsearch --network elasticsearch_default \
  docker.mycompany.com/quarkus-elasticsearch-jvm:1.0.0

wait_for_container_log "quarkus-elasticsearch-jvm" "started in"
startup_time_sec=$(extract_startup_time_from_log "$wait_for_container_log_matched_row" "{print substr(\$16,0,length(\$16)-2)}")
quarkus_elasticsearch_jvm[startup_time]="$(convert_seconds_to_millis $startup_time_sec)ms"

quarkus_elasticsearch_jvm[initial_memory_consumption]=$(get_container_memory_consumption "quarkus-elasticsearch-jvm")

run_command "ab -p test-movies.json -T 'application/json' -c 5 -n 2500 http://localhost:9105/api/movies"
quarkus_elasticsearch_jvm[ab_testing_time]=$run_command_exec_time

quarkus_elasticsearch_jvm[final_memory_consumption]=$(get_container_memory_consumption "quarkus-elasticsearch-jvm")

docker stop quarkus-elasticsearch-jvm

echo
echo "----------------------------"
echo "QUARKUS-ELASTICSEARCH-NATIVE"
echo "----------------------------"

quarkus_elasticsearch_native[startup_time]="-"
quarkus_elasticsearch_native[initial_memory_consumption]="-"
quarkus_elasticsearch_native[ab_testing_time]="-"
quarkus_elasticsearch_native[final_memory_consumption]="-"

echo
echo "---------------------------"
echo "MICRONAUT-ELASTICSEARCH-JVM"
echo "---------------------------"

docker run -d --rm --name micronaut-elasticsearch-jvm -p 9107:8080 -e ELASTICSEARCH_HOST=elasticsearch --network elasticsearch_default \
  docker.mycompany.com/micronaut-elasticsearch-jvm:1.0.0

wait_for_container_log "micronaut-elasticsearch-jvm" "Startup completed in"
micronaut_elasticsearch_jvm[startup_time]=$(extract_startup_time_from_log "$wait_for_container_log_matched_row" "{print substr(\$10,0,length(\$10)-1)}")

micronaut_elasticsearch_jvm[initial_memory_consumption]=$(get_container_memory_consumption "micronaut-elasticsearch-jvm")

run_command "ab -p test-movies.json -T 'application/json' -c 5 -n 2500 http://localhost:9107/api/movies"
micronaut_elasticsearch_jvm[ab_testing_time]=$run_command_exec_time

micronaut_elasticsearch_jvm[final_memory_consumption]=$(get_container_memory_consumption "micronaut-elasticsearch-jvm")

docker stop micronaut-elasticsearch-jvm

echo
echo "------------------------------"
echo "MICRONAUT-ELASTICSEARCH-NATIVE"
echo "------------------------------"

docker run -d --rm --name micronaut-elasticsearch-native -p 9108:8080 -e ELASTICSEARCH_HOST=elasticsearch --network elasticsearch_default \
  docker.mycompany.com/micronaut-elasticsearch-native:1.0.0

wait_for_container_log "micronaut-elasticsearch-native" "Startup completed in"
micronaut_elasticsearch_native[startup_time]=$(extract_startup_time_from_log "$wait_for_container_log_matched_row" "{print substr(\$10,0,length(\$10)-1)}")

micronaut_elasticsearch_native[initial_memory_consumption]=$(get_container_memory_consumption "micronaut-elasticsearch-native")

run_command "ab -p test-movies.json -T 'application/json' -c 5 -n 2500 http://localhost:9108/api/movies"
micronaut_elasticsearch_native[ab_testing_time]=$run_command_exec_time

micronaut_elasticsearch_native[final_memory_consumption]=$(get_container_memory_consumption "micronaut-elasticsearch-native")

docker stop micronaut-elasticsearch-native

echo
echo "------------------------"
echo "SPRINGBOOT-ELASTICSEARCH"
echo "------------------------"

docker run -d --rm --name springboot-elasticsearch-jvm -p 9109:8080 -e ELASTICSEARCH_HOST=elasticsearch --network elasticsearch_default \
  docker.mycompany.com/springboot-elasticsearch-jvm:1.0.0

wait_for_container_log "springboot-elasticsearch-jvm" "Started"
startup_time_sec=$(extract_startup_time_from_log "$wait_for_container_log_matched_row" "{print \$13}")
springboot_elasticsearch_jvm[startup_time]="$(convert_seconds_to_millis $startup_time_sec)ms"

springboot_elasticsearch_jvm[initial_memory_consumption]=$(get_container_memory_consumption "springboot-elasticsearch-jvm")

run_command "ab -p test-movies.json -T 'application/json' -c 5 -n 2500 http://localhost:9109/api/movies"
springboot_elasticsearch_jvm[ab_testing_time]=$run_command_exec_time

springboot_elasticsearch_jvm[final_memory_consumption]=$(get_container_memory_consumption "springboot-elasticsearch-jvm")

docker stop springboot-elasticsearch-jvm

echo
echo "=============="
echo "DOCKER-COMPOSE"
echo "=============="

docker-compose down -v

printf "\n"
printf "%30s | %12s | %26s | %15s | %24s |\n" "Application" "Startup Time" "Initial Memory Consumption" "Ab Testing Time" "Final Memory Consumption"
printf "%30s + %12s + %26s + %15s + %24s |\n" "------------------------------" "------------" "--------------------------" "---------------" "------------------------"
printf "%30s | %12s | %26s | %15s | %24s |\n" "quarkus-simple-api-jvm" ${quarkus_simple_api_jvm[startup_time]} ${quarkus_simple_api_jvm[initial_memory_consumption]} ${quarkus_simple_api_jvm[ab_testing_time]} ${quarkus_simple_api_jvm[final_memory_consumption]}
printf "%30s | %12s | %26s | %15s | %24s |\n" "micronaut-simple-api-jvm" ${micronaut_simple_api_jvm[startup_time]} ${micronaut_simple_api_jvm[initial_memory_consumption]} ${micronaut_simple_api_jvm[ab_testing_time]} ${micronaut_simple_api_jvm[final_memory_consumption]}
printf "%30s | %12s | %26s | %15s | %24s |\n" "springboot-simple-api-jvm" ${springboot_simple_api_jvm[startup_time]} ${springboot_simple_api_jvm[initial_memory_consumption]} ${springboot_simple_api_jvm[ab_testing_time]} ${springboot_simple_api_jvm[final_memory_consumption]}
printf "%30s | %12s | %26s | %15s | %24s |\n" "quarkus-simple-api-native" ${quarkus_simple_api_native[startup_time]} ${quarkus_simple_api_native[initial_memory_consumption]} ${quarkus_simple_api_native[ab_testing_time]} ${quarkus_simple_api_native[final_memory_consumption]}
printf "%30s | %12s | %26s | %15s | %24s |\n" "micronaut-simple-api-native" ${micronaut_simple_api_native[startup_time]} ${micronaut_simple_api_native[initial_memory_consumption]} ${micronaut_simple_api_native[ab_testing_time]} ${micronaut_simple_api_native[final_memory_consumption]}
printf "%30s + %12s + %26s + %15s + %24s |\n" ".............................." "..........." ".........................." "..............." "........................"
printf "%30s | %12s | %26s | %15s | %24s |\n" "quarkus-book-api-jvm" ${quarkus_book_api_jvm[startup_time]} ${quarkus_book_api_jvm[initial_memory_consumption]} ${quarkus_book_api_jvm[ab_testing_time]} ${quarkus_book_api_jvm[final_memory_consumption]}
printf "%30s | %12s | %26s | %15s | %24s |\n" "micronaut-book-api-jvm" ${micronaut_book_api_jvm[startup_time]} ${micronaut_book_api_jvm[initial_memory_consumption]} ${micronaut_book_api_jvm[ab_testing_time]} ${micronaut_book_api_jvm[final_memory_consumption]}
printf "%30s | %12s | %26s | %15s | %24s |\n" "springboot-book-api-jvm" ${springboot_book_api_jvm[startup_time]} ${springboot_book_api_jvm[initial_memory_consumption]} ${springboot_book_api_jvm[ab_testing_time]} ${springboot_book_api_jvm[final_memory_consumption]}
printf "%30s | %12s | %26s | %15s | %24s |\n" "quarkus-book-api-native" ${quarkus_book_api_native[startup_time]} ${quarkus_book_api_native[initial_memory_consumption]} ${quarkus_book_api_native[ab_testing_time]} ${quarkus_book_api_native[final_memory_consumption]}
printf "%30s | %12s | %26s | %15s | %24s |\n" "micronaut-book-api-native" ${micronaut_book_api_native[startup_time]} ${micronaut_book_api_native[initial_memory_consumption]} ${micronaut_book_api_native[ab_testing_time]} ${micronaut_book_api_native[final_memory_consumption]}
printf "%30s + %12s + %26s + %15s + %24s |\n" ".............................." "..........." ".........................." "..............." "........................"
printf "%30s | %12s | %26s | %15s | %24s |\n" "quarkus-producer-api-jvm" ${quarkus_producer_api_jvm[startup_time]} ${quarkus_producer_api_jvm[initial_memory_consumption]} ${quarkus_producer_api_jvm[ab_testing_time]} ${quarkus_producer_api_jvm[final_memory_consumption]}
printf "%30s | %12s | %26s | %15s | %24s |\n" "micronaut-producer-api-jvm" ${micronaut_producer_api_jvm[startup_time]} ${micronaut_producer_api_jvm[initial_memory_consumption]} ${micronaut_producer_api_jvm[ab_testing_time]} ${micronaut_producer_api_jvm[final_memory_consumption]}
printf "%30s | %12s | %26s | %15s | %24s |\n" "springboot-producer-api-jvm" ${springboot_producer_api_jvm[startup_time]} ${springboot_producer_api_jvm[initial_memory_consumption]} ${springboot_producer_api_jvm[ab_testing_time]} ${springboot_producer_api_jvm[final_memory_consumption]}
printf "%30s | %12s | %26s | %15s | %24s |\n" "quarkus-producer-api-native" ${quarkus_producer_api_native[startup_time]} ${quarkus_producer_api_native[initial_memory_consumption]} ${quarkus_producer_api_native[ab_testing_time]} ${quarkus_producer_api_native[final_memory_consumption]}
printf "%30s | %12s | %26s | %15s | %24s |\n" "micronaut-producer-api-native" ${micronaut_producer_api_native[startup_time]} ${micronaut_producer_api_native[initial_memory_consumption]} ${micronaut_producer_api_native[ab_testing_time]} ${micronaut_producer_api_native[final_memory_consumption]}
printf "%30s + %12s + %26s + %15s + %24s |\n" ".............................." "..........." ".........................." "..............." "........................"
printf "%30s | %12s | %26s | %15s | %24s |\n" "quarkus-consumer-api-jvm" ${quarkus_consumer_api_jvm[startup_time]} ${quarkus_consumer_api_jvm[initial_memory_consumption]} ${quarkus_consumer_api_jvm[ab_testing_time]} ${quarkus_consumer_api_jvm[final_memory_consumption]}
printf "%30s | %12s | %26s | %15s | %24s |\n" "micronaut-consumer-api-jvm" ${micronaut_consumer_api_jvm[startup_time]} ${micronaut_consumer_api_jvm[initial_memory_consumption]} ${micronaut_consumer_api_jvm[ab_testing_time]} ${micronaut_consumer_api_jvm[final_memory_consumption]}
printf "%30s | %12s | %26s | %15s | %24s |\n" "springboot-consumer-api-jvm" ${springboot_consumer_api_jvm[startup_time]} ${springboot_consumer_api_jvm[initial_memory_consumption]} ${springboot_consumer_api_jvm[ab_testing_time]} ${springboot_consumer_api_jvm[final_memory_consumption]}
printf "%30s | %12s | %26s | %15s | %24s |\n" "quarkus-consumer-api-native" ${quarkus_consumer_api_native[startup_time]} ${quarkus_consumer_api_native[initial_memory_consumption]} ${quarkus_consumer_api_native[ab_testing_time]} ${quarkus_consumer_api_native[final_memory_consumption]}
printf "%30s | %12s | %26s | %15s | %24s |\n" "micronaut-consumer-api-native" ${micronaut_consumer_api_native[startup_time]} ${micronaut_consumer_api_native[initial_memory_consumption]} ${micronaut_consumer_api_native[ab_testing_time]} ${micronaut_consumer_api_native[final_memory_consumption]}
printf "%30s + %12s + %26s + %15s + %24s |\n" ".............................." "..........." ".........................." "..............." "........................"
printf "%30s | %12s | %26s | %15s | %24s |\n" "quarkus-elasticsearch-jvm" ${quarkus_elasticsearch_jvm[startup_time]} ${quarkus_elasticsearch_jvm[initial_memory_consumption]} ${quarkus_elasticsearch_jvm[ab_testing_time]} ${quarkus_elasticsearch_jvm[final_memory_consumption]}
printf "%30s | %12s | %26s | %15s | %24s |\n" "micronaut-elasticsearch-jvm" ${micronaut_elasticsearch_jvm[startup_time]} ${micronaut_elasticsearch_jvm[initial_memory_consumption]} ${micronaut_elasticsearch_jvm[ab_testing_time]} ${micronaut_elasticsearch_jvm[final_memory_consumption]}
printf "%30s | %12s | %26s | %15s | %24s |\n" "springboot-elasticsearch-jvm" ${springboot_elasticsearch_jvm[startup_time]} ${springboot_elasticsearch_jvm[initial_memory_consumption]} ${springboot_elasticsearch_jvm[ab_testing_time]} ${springboot_elasticsearch_jvm[final_memory_consumption]}
printf "%30s | %12s | %26s | %15s | %24s |\n" "quarkus-elasticsearch-native" ${quarkus_elasticsearch_native[startup_time]} ${quarkus_elasticsearch_native[initial_memory_consumption]} ${quarkus_elasticsearch_native[ab_testing_time]} ${quarkus_elasticsearch_native[final_memory_consumption]}
printf "%30s | %12s | %26s | %15s | %24s |\n" "micronaut-elasticsearch-native" ${micronaut_elasticsearch_native[startup_time]} ${micronaut_elasticsearch_native[initial_memory_consumption]} ${micronaut_elasticsearch_native[ab_testing_time]} ${micronaut_elasticsearch_native[final_memory_consumption]}

echo
echo "==>  START AT: ${start_time}"
echo "==> FINISH AT: $(date)"
echo