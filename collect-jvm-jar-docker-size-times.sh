#!/usr/bin/env bash

source my-functions.sh

docker rmi \
  docker.mycompany.com/quarkus-simple-api-jvm:1.0.0 \
  docker.mycompany.com/micronaut-simple-api-jvm:1.0.0 \
  docker.mycompany.com/springboot-simple-api-jvm:1.0.0 \
  docker.mycompany.com/quarkus-book-api-jvm:1.0.0 \
  docker.mycompany.com/micronaut-book-api-jvm:1.0.0 \
  docker.mycompany.com/springboot-book-api-jvm:1.0.0 \
  docker.mycompany.com/quarkus-producer-api-jvm:1.0.0 \
  docker.mycompany.com/micronaut-producer-api-jvm:1.0.0 \
  docker.mycompany.com/quarkus-consumer-api-jvm:1.0.0 \
  docker.mycompany.com/micronaut-consumer-api-jvm:1.0.0 \
  docker.mycompany.com/springboot-producer-api-jvm:1.0.0 \
  docker.mycompany.com/springboot-consumer-api-jvm:1.0.0 \
  docker.mycompany.com/quarkus-elasticsearch-jvm:1.0.0 \
  docker.mycompany.com/micronaut-elasticsearch-jvm:1.0.0 \
  docker.mycompany.com/springboot-elasticsearch-jvm:1.0.0

declare -A quarkus_simple_api_jvm
declare -A micronaut_simple_api_jvm
declare -A springboot_simple_api_jvm

declare -A quarkus_book_api_jvm
declare -A micronaut_book_api_jvm
declare -A springboot_book_api_jvm

declare -A quarkus_producer_api_jvm
declare -A quarkus_consumer_api_jvm
declare -A micronaut_producer_api_jvm
declare -A micronaut_consumer_api_jvm
declare -A springboot_producer_api_jvm
declare -A springboot_consumer_api_jvm

declare -A quarkus_elasticsearch_jvm
declare -A micronaut_elasticsearch_jvm
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

cd simple-api/quarkus-simple-api

package_jar_build_image \
  "./mvnw clean" \
  "./mvnw package" \
  "target/quarkus-simple-api-1.0.0-runner.jar" \
  "./docker-build.sh" \
  "docker.mycompany.com/quarkus-simple-api-jvm:1.0.0"
quarkus_simple_api_jvm[packaging_time]=$package_jar_build_image_packaging_time
quarkus_simple_api_jvm[jar_size]=$package_jar_build_image_jar_size
quarkus_simple_api_jvm[building_time]=$package_jar_build_image_building_time
quarkus_simple_api_jvm[docker_image_size]=$package_jar_build_image_docker_image_size

echo
echo "------------------------"
echo "MICRONAUT-SIMPLE-API-JVM"
echo "------------------------"

cd ../micronaut-simple-api

package_jar_build_image \
  "./gradlew clean" \
  "./gradlew assemble" \
  "build/libs/micronaut-simple-api-1.0.0-all.jar" \
  "./docker-build.sh" \
  "docker.mycompany.com/micronaut-simple-api-jvm:1.0.0"
micronaut_simple_api_jvm[packaging_time]=$package_jar_build_image_packaging_time
micronaut_simple_api_jvm[jar_size]=$package_jar_build_image_jar_size
micronaut_simple_api_jvm[building_time]=$package_jar_build_image_building_time
micronaut_simple_api_jvm[docker_image_size]=$package_jar_build_image_docker_image_size

echo
echo "---------------------"
echo "SPRINGBOOT-SIMPLE-API"
echo "---------------------"

cd ../springboot-simple-api

package_jar_build_image \
  "./gradlew clean" \
  "./gradlew assemble" \
  "build/libs/springboot-simple-api-1.0.0.jar" \
  "./docker-build.sh" \
  "docker.mycompany.com/springboot-simple-api-jvm:1.0.0"
springboot_simple_api_jvm[packaging_time]=$package_jar_build_image_packaging_time
springboot_simple_api_jvm[jar_size]=$package_jar_build_image_jar_size
springboot_simple_api_jvm[building_time]=$package_jar_build_image_building_time
springboot_simple_api_jvm[docker_image_size]=$package_jar_build_image_docker_image_size

echo
echo "========"
echo "BOOK-API"
echo "========"

echo
echo "--------------------"
echo "QUARKUS-BOOK-API-JVM"
echo "--------------------"

cd ../../book-api/quarkus-book-api

package_jar_build_image \
  "./mvnw clean" \
  "./mvnw package" \
  "target/quarkus-book-api-1.0.0-runner.jar" \
  "./docker-build.sh" \
  "docker.mycompany.com/quarkus-book-api-jvm:1.0.0"
quarkus_book_api_jvm[packaging_time]=$package_jar_build_image_packaging_time
quarkus_book_api_jvm[jar_size]=$package_jar_build_image_jar_size
quarkus_book_api_jvm[building_time]=$package_jar_build_image_building_time
quarkus_book_api_jvm[docker_image_size]=$package_jar_build_image_docker_image_size

echo
echo "----------------------"
echo "MICRONAUT-BOOK-API-JVM"
echo "----------------------"

cd ../micronaut-book-api

package_jar_build_image \
  "./gradlew clean" \
  "./gradlew assemble" \
  "build/libs/micronaut-book-api-1.0.0-all.jar" \
  "./docker-build.sh" \
  "docker.mycompany.com/micronaut-book-api-jvm:1.0.0"
micronaut_book_api_jvm[packaging_time]=$package_jar_build_image_packaging_time
micronaut_book_api_jvm[jar_size]=$package_jar_build_image_jar_size
micronaut_book_api_jvm[building_time]=$package_jar_build_image_building_time
micronaut_book_api_jvm[docker_image_size]=$package_jar_build_image_docker_image_size

echo
echo "-------------------"
echo "SPRINGBOOT-BOOK-API"
echo "-------------------"

cd ../springboot-book-api

package_jar_build_image \
  "./gradlew clean" \
  "./gradlew assemble" \
  "build/libs/springboot-book-api-1.0.0.jar" \
  "./docker-build.sh" \
  "docker.mycompany.com/springboot-book-api-jvm:1.0.0"
springboot_book_api_jvm[packaging_time]=$package_jar_build_image_packaging_time
springboot_book_api_jvm[jar_size]=$package_jar_build_image_jar_size
springboot_book_api_jvm[building_time]=$package_jar_build_image_building_time
springboot_book_api_jvm[docker_image_size]=$package_jar_build_image_docker_image_size

echo
echo "================="
echo "PRODUCER-CONSUMER"
echo "================="

echo
echo "--------------------------------------------"
echo "QUARKUS-PRODUCER-CONSUMER / PRODUCER-API-JVM"
echo "--------------------------------------------"

cd ../../producer-consumer/quarkus-producer-consumer

package_jar_build_image \
  "./mvnw clean --projects producer-api" \
  "./mvnw package --projects producer-api" \
  "producer-api/target/producer-api-1.0.0-runner.jar" \
  "cd producer-api && ./docker-build.sh && cd .." \
  "docker.mycompany.com/quarkus-producer-api-jvm:1.0.0"
quarkus_producer_api_jvm[packaging_time]=$package_jar_build_image_packaging_time
quarkus_producer_api_jvm[jar_size]=$package_jar_build_image_jar_size
quarkus_producer_api_jvm[building_time]=$package_jar_build_image_building_time
quarkus_producer_api_jvm[docker_image_size]=$package_jar_build_image_docker_image_size

echo
echo "--------------------------------------------"
echo "QUARKUS-PRODUCER-CONSUMER / CONSUMER-API-JVM"
echo "--------------------------------------------"

package_jar_build_image \
  "./mvnw clean --projects consumer-api" \
  "./mvnw package --projects consumer-api" \
  "consumer-api/target/consumer-api-1.0.0-runner.jar" \
  "cd consumer-api && ./docker-build.sh && cd .." \
  "docker.mycompany.com/quarkus-consumer-api-jvm:1.0.0"
quarkus_consumer_api_jvm[packaging_time]=$package_jar_build_image_packaging_time
quarkus_consumer_api_jvm[jar_size]=$package_jar_build_image_jar_size
quarkus_consumer_api_jvm[building_time]=$package_jar_build_image_building_time
quarkus_consumer_api_jvm[docker_image_size]=$package_jar_build_image_docker_image_size

echo
echo "----------------------------------------------"
echo "MICRONAUT-PRODUCER-CONSUMER / PRODUCER-API-JVM"
echo "----------------------------------------------"

cd ../micronaut-producer-consumer

package_jar_build_image \
  "./gradlew producer-api:clean" \
  "./gradlew producer-api:assemble" \
  "producer-api/build/libs/producer-api-1.0.0-all.jar" \
  "cd producer-api && ./docker-build.sh && cd .." \
  "docker.mycompany.com/micronaut-producer-api-jvm:1.0.0"
micronaut_producer_api_jvm[packaging_time]=$package_jar_build_image_packaging_time
micronaut_producer_api_jvm[jar_size]=$package_jar_build_image_jar_size
micronaut_producer_api_jvm[building_time]=$package_jar_build_image_building_time
micronaut_producer_api_jvm[docker_image_size]=$package_jar_build_image_docker_image_size

echo
echo "----------------------------------------------"
echo "MICRONAUT-PRODUCER-CONSUMER / CONSUMER-API-JVM"
echo "----------------------------------------------"

package_jar_build_image \
  "./gradlew consumer-api:clean" \
  "./gradlew consumer-api:assemble" \
  "consumer-api/build/libs/consumer-api-1.0.0-all.jar" \
  "cd consumer-api && ./docker-build.sh && cd .." \
  "docker.mycompany.com/micronaut-consumer-api-jvm:1.0.0"
micronaut_consumer_api_jvm[packaging_time]=$package_jar_build_image_packaging_time
micronaut_consumer_api_jvm[jar_size]=$package_jar_build_image_jar_size
micronaut_consumer_api_jvm[building_time]=$package_jar_build_image_building_time
micronaut_consumer_api_jvm[docker_image_size]=$package_jar_build_image_docker_image_size

echo
echo "-----------------------------------------------"
echo "SPRINGBOOT-PRODUCER-CONSUMER / PRODUCER-API-JVM"
echo "-----------------------------------------------"

cd ../springboot-producer-consumer

package_jar_build_image \
  "./mvnw clean --projects producer-api" \
  "./mvnw package --projects producer-api" \
  "producer-api/target/producer-api-1.0.0.jar" \
  "cd producer-api && ./docker-build.sh && cd .." \
  "docker.mycompany.com/springboot-producer-api-jvm:1.0.0"
springboot_producer_api_jvm[packaging_time]=$package_jar_build_image_packaging_time
springboot_producer_api_jvm[jar_size]=$package_jar_build_image_jar_size
springboot_producer_api_jvm[building_time]=$package_jar_build_image_building_time
springboot_producer_api_jvm[docker_image_size]=$package_jar_build_image_docker_image_size

echo
echo "-----------------------------------------------"
echo "SPRINGBOOT-PRODUCER-CONSUMER / CONSUMER-API-JVM"
echo "-----------------------------------------------"

package_jar_build_image \
  "./mvnw clean --projects consumer-api" \
  "./mvnw package --projects consumer-api" \
  "consumer-api/target/consumer-api-1.0.0.jar" \
  "cd consumer-api && ./docker-build.sh && cd .." \
  "docker.mycompany.com/springboot-consumer-api-jvm:1.0.0"
springboot_consumer_api_jvm[packaging_time]=$package_jar_build_image_packaging_time
springboot_consumer_api_jvm[jar_size]=$package_jar_build_image_jar_size
springboot_consumer_api_jvm[building_time]=$package_jar_build_image_building_time
springboot_consumer_api_jvm[docker_image_size]=$package_jar_build_image_docker_image_size

echo
echo "============="
echo "ELASTICSEARCH"
echo "============="

echo
echo "-------------------------"
echo "QUARKUS-ELASTICSEARCH-JVM"
echo "-------------------------"

cd ../../elasticsearch/quarkus-elasticsearch

package_jar_build_image \
  "./mvnw clean" \
  "./mvnw package" \
  "target/quarkus-elasticsearch-1.0.0-runner.jar" \
  "./docker-build.sh" \
  "docker.mycompany.com/quarkus-elasticsearch-jvm:1.0.0"
quarkus_elasticsearch_jvm[packaging_time]=$package_jar_build_image_packaging_time
quarkus_elasticsearch_jvm[jar_size]=$package_jar_build_image_jar_size
quarkus_elasticsearch_jvm[building_time]=$package_jar_build_image_building_time
quarkus_elasticsearch_jvm[docker_image_size]=$package_jar_build_image_docker_image_size

echo
echo "---------------------------"
echo "MICRONAUT-ELASTICSEARCH-JVM"
echo "---------------------------"

cd ../micronaut-elasticsearch

package_jar_build_image \
  "./gradlew clean" \
  "./gradlew assemble" \
  "build/libs/micronaut-elasticsearch-1.0.0-all.jar" \
  "./docker-build.sh" \
  "docker.mycompany.com/micronaut-elasticsearch-jvm:1.0.0"
micronaut_elasticsearch_jvm[packaging_time]=$package_jar_build_image_packaging_time
micronaut_elasticsearch_jvm[jar_size]=$package_jar_build_image_jar_size
micronaut_elasticsearch_jvm[building_time]=$package_jar_build_image_building_time
micronaut_elasticsearch_jvm[docker_image_size]=$package_jar_build_image_docker_image_size

echo
echo "------------------------"
echo "SPRINGBOOT-ELASTICSEARCH"
echo "------------------------"

cd ../springboot-elasticsearch

package_jar_build_image \
  "./mvnw clean" \
  "./mvnw package" \
  "target/springboot-elasticsearch-1.0.0.jar" \
  "./docker-build.sh" \
  "docker.mycompany.com/springboot-elasticsearch-jvm:1.0.0"
springboot_elasticsearch_jvm[packaging_time]=$package_jar_build_image_packaging_time
springboot_elasticsearch_jvm[jar_size]=$package_jar_build_image_jar_size
springboot_elasticsearch_jvm[building_time]=$package_jar_build_image_building_time
springboot_elasticsearch_jvm[docker_image_size]=$package_jar_build_image_docker_image_size

printf "\n"
printf "%30s | %14s | %16s | %17s | %17s |\n" "Application" "Packaging Time" "Jar Size (bytes)" "Docker Build Time" "Docker Image Size"
printf "%30s + %14s + %16s + %17s + %17s |\n" "------------------------------" "--------------" "----------------" "-----------------" "-----------------"
printf "%30s | %14s | %16s | %17s | %17s |\n" "quarkus-simple-api-jvm" ${quarkus_simple_api_jvm[packaging_time]} ${quarkus_simple_api_jvm[jar_size]} ${quarkus_simple_api_jvm[building_time]} ${quarkus_simple_api_jvm[docker_image_size]}
printf "%30s | %14s | %16s | %17s | %17s |\n" "micronaut-simple-api-jvm" ${micronaut_simple_api_jvm[packaging_time]} ${micronaut_simple_api_jvm[jar_size]} ${micronaut_simple_api_jvm[building_time]} ${micronaut_simple_api_jvm[docker_image_size]}
printf "%30s | %14s | %16s | %17s | %17s |\n" "springboot-simple-api-jvm" ${springboot_simple_api_jvm[packaging_time]} ${springboot_simple_api_jvm[jar_size]} ${springboot_simple_api_jvm[building_time]} ${springboot_simple_api_jvm[docker_image_size]}
printf "%30s + %14s + %16s + %17s + %17s |\n" ".............................." ".............." "................" "................." "................."
printf "%30s | %14s | %16s | %17s | %17s |\n" "quarkus-book-api-jvm" ${quarkus_book_api_jvm[packaging_time]} ${quarkus_book_api_jvm[jar_size]} ${quarkus_book_api_jvm[building_time]} ${quarkus_book_api_jvm[docker_image_size]}
printf "%30s | %14s | %16s | %17s | %17s |\n" "micronaut-book-api-jvm" ${micronaut_book_api_jvm[packaging_time]} ${micronaut_book_api_jvm[jar_size]} ${micronaut_book_api_jvm[building_time]} ${micronaut_book_api_jvm[docker_image_size]}
printf "%30s | %14s | %16s | %17s | %17s |\n" "springboot-book-api-jvm" ${springboot_book_api_jvm[packaging_time]} ${springboot_book_api_jvm[jar_size]} ${springboot_book_api_jvm[building_time]} ${springboot_book_api_jvm[docker_image_size]}
printf "%30s + %14s + %16s + %17s + %17s |\n" ".............................." ".............." "................" "................." "................."
printf "%30s | %14s | %16s | %17s | %17s |\n" "quarkus-producer-api-jvm" ${quarkus_producer_api_jvm[packaging_time]} ${quarkus_producer_api_jvm[jar_size]} ${quarkus_producer_api_jvm[building_time]} ${quarkus_producer_api_jvm[docker_image_size]}
printf "%30s | %14s | %16s | %17s | %17s |\n" "micronaut-producer-api-jvm" ${micronaut_producer_api_jvm[packaging_time]} ${micronaut_producer_api_jvm[jar_size]} ${micronaut_producer_api_jvm[building_time]} ${micronaut_producer_api_jvm[docker_image_size]}
printf "%30s | %14s | %16s | %17s | %17s |\n" "springboot-producer-api-jvm" ${springboot_producer_api_jvm[packaging_time]} ${springboot_producer_api_jvm[jar_size]} ${springboot_producer_api_jvm[building_time]} ${springboot_producer_api_jvm[docker_image_size]}
printf "%30s + %14s + %16s + %17s + %17s |\n" ".............................." ".............." "................" "................." "................."
printf "%30s | %14s | %16s | %17s | %17s |\n" "quarkus-consumer-api-jvm" ${quarkus_consumer_api_jvm[packaging_time]} ${quarkus_consumer_api_jvm[jar_size]} ${quarkus_consumer_api_jvm[building_time]} ${quarkus_consumer_api_jvm[docker_image_size]}
printf "%30s | %14s | %16s | %17s | %17s |\n" "micronaut-consumer-api-jvm" ${micronaut_consumer_api_jvm[packaging_time]} ${micronaut_consumer_api_jvm[jar_size]} ${micronaut_consumer_api_jvm[building_time]} ${micronaut_consumer_api_jvm[docker_image_size]}
printf "%30s | %14s | %16s | %17s | %17s |\n" "springboot-consumer-api-jvm" ${springboot_consumer_api_jvm[packaging_time]} ${springboot_consumer_api_jvm[jar_size]} ${springboot_consumer_api_jvm[building_time]} ${springboot_consumer_api_jvm[docker_image_size]}
printf "%30s + %14s + %16s + %17s + %17s |\n" ".............................." ".............." "................" "................." "................."
printf "%30s | %14s | %16s | %17s | %17s |\n" "quarkus-elasticsearch-jvm" ${quarkus_elasticsearch_jvm[packaging_time]} ${quarkus_elasticsearch_jvm[jar_size]} ${quarkus_elasticsearch_jvm[building_time]} ${quarkus_elasticsearch_jvm[docker_image_size]}
printf "%30s | %14s | %16s | %17s | %17s |\n" "micronaut-elasticsearch-jvm" ${micronaut_elasticsearch_jvm[packaging_time]} ${micronaut_elasticsearch_jvm[jar_size]} ${micronaut_elasticsearch_jvm[building_time]} ${micronaut_elasticsearch_jvm[docker_image_size]}
printf "%30s | %14s | %16s | %17s | %17s |\n" "springboot-elasticsearch-jvm" ${springboot_elasticsearch_jvm[packaging_time]} ${springboot_elasticsearch_jvm[jar_size]} ${springboot_elasticsearch_jvm[building_time]} ${springboot_elasticsearch_jvm[docker_image_size]}

echo
echo "==>  START AT: ${start_time}"
echo "==> FINISH AT: $(date)"
echo
