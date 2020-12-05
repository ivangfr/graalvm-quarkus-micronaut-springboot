#!/usr/bin/env bash

source my-functions.sh

declare -A quarkus_simple_api_native
declare -A micronaut_simple_api_native
declare -A springboot_simple_api_native

declare -A quarkus_book_api_native
declare -A micronaut_book_api_native
declare -A springboot_book_api_native

declare -A quarkus_producer_api_native
declare -A quarkus_consumer_api_native
declare -A micronaut_producer_api_native
declare -A micronaut_consumer_api_native
declare -A springboot_producer_api_native
declare -A springboot_consumer_api_native

declare -A quarkus_elasticsearch_native
declare -A micronaut_elasticsearch_native
declare -A springboot_elasticsearch_native

start_time=$(date)

echo
echo "=========="
echo "SIMPLE_API"
echo "=========="

echo
echo "-------------------------"
echo "QUARKUS-SIMPLE-API-NATIVE"
echo "-------------------------"

cd simple-api/quarkus-simple-api

package_jar_build_image \
  "./mvnw clean" \
  "./mvnw package -Pnative -Dquarkus.native.container-build=true" \
  "target/quarkus-simple-api-1.0.0-runner" \
  "./docker-build.sh native" \
  "docker.mycompany.com/quarkus-simple-api-native:1.0.0"
quarkus_simple_api_native[packaging_time]=$package_jar_build_image_packaging_time
quarkus_simple_api_native[jar_size]=$package_jar_build_image_jar_size
quarkus_simple_api_native[building_time]=$package_jar_build_image_building_time
quarkus_simple_api_native[docker_image_size]=$package_jar_build_image_docker_image_size

cd ../..

echo
echo "---------------------------"
echo "MICRONAUT-SIMPLE-API-NATIVE"
echo "---------------------------"

cd simple-api/micronaut-simple-api

package_jar_build_image \
  "./mvnw clean" \
  "./mvnw package" \
  "target/micronaut-simple-api-1.0.0.jar" \
  "./docker-build.sh native" \
  "docker.mycompany.com/micronaut-simple-api-native:1.0.0"
micronaut_simple_api_native[packaging_time]=$package_jar_build_image_packaging_time
micronaut_simple_api_native[jar_size]=$package_jar_build_image_jar_size
micronaut_simple_api_native[building_time]=$package_jar_build_image_building_time
micronaut_simple_api_native[docker_image_size]=$package_jar_build_image_docker_image_size

cd ../..

echo
echo "----------------------------"
echo "SPRINGBOOT-SIMPLE-API-NATIVE"
echo "----------------------------"

cd simple-api/springboot-simple-api

package_jar_build_image \
  "./mvnw clean" \
  "./mvnw package" \
  "target/springboot-simple-api-1.0.0.jar" \
  "./docker-build.sh native" \
  "docker.mycompany.com/springboot-simple-api-native:1.0.0"
springboot_simple_api_native[packaging_time]=$package_jar_build_image_packaging_time
springboot_simple_api_native[jar_size]=$package_jar_build_image_jar_size
springboot_simple_api_native[building_time]=$package_jar_build_image_building_time
springboot_simple_api_native[docker_image_size]=$package_jar_build_image_docker_image_size

cd ../..

echo
echo "========"
echo "BOOK-API"
echo "========"

echo
echo "-----------------------"
echo "QUARKUS-BOOK-API-NATIVE"
echo "-----------------------"

cd book-api/quarkus-book-api

package_jar_build_image \
  "./mvnw clean" \
  "./mvnw package -Pnative -Dquarkus.native.container-build=true" \
  "target/quarkus-book-api-1.0.0-runner" \
  "./docker-build.sh native" \
  "docker.mycompany.com/quarkus-book-api-native:1.0.0"
quarkus_book_api_native[packaging_time]=$package_jar_build_image_packaging_time
quarkus_book_api_native[jar_size]=$package_jar_build_image_jar_size
quarkus_book_api_native[building_time]=$package_jar_build_image_building_time
quarkus_book_api_native[docker_image_size]=$package_jar_build_image_docker_image_size

cd ../..

echo
echo "-------------------------"
echo "MICRONAUT-BOOK-API-NATIVE"
echo "-------------------------"

cd book-api/micronaut-book-api

package_jar_build_image \
  "./mvnw clean" \
  "./mvnw package" \
  "target/micronaut-book-api-1.0.0.jar" \
  "./docker-build.sh native" \
  "docker.mycompany.com/micronaut-book-api-native:1.0.0"
micronaut_book_api_native[packaging_time]=$package_jar_build_image_packaging_time
micronaut_book_api_native[jar_size]=$package_jar_build_image_jar_size
micronaut_book_api_native[building_time]=$package_jar_build_image_building_time
micronaut_book_api_native[docker_image_size]=$package_jar_build_image_docker_image_size

cd ../..

echo
echo "--------------------------"
echo "SPRINGBOOT-BOOK-API-NATIVE"
echo "--------------------------"

cd book-api/springboot-book-api

package_jar_build_image \
  "./mvnw clean" \
  "./mvnw package" \
  "target/springboot-book-api-1.0.0.jar" \
  "./docker-build.sh native" \
  "docker.mycompany.com/springboot-book-api-native:1.0.0"
springboot_book_api_native[packaging_time]=$package_jar_build_image_packaging_time
springboot_book_api_native[jar_size]=$package_jar_build_image_jar_size
springboot_book_api_native[building_time]=$package_jar_build_image_building_time
springboot_book_api_native[docker_image_size]=$package_jar_build_image_docker_image_size

cd ../..

echo
echo "================="
echo "PRODUCER-CONSUMER"
echo "================="

echo
echo "-----------------------------------------------"
echo "QUARKUS-PRODUCER-CONSUMER / PRODUCER-API-NATIVE"
echo "-----------------------------------------------"

cd producer-consumer/quarkus-producer-consumer

package_jar_build_image \
  "./mvnw clean --projects producer-api" \
  "./mvnw package -Pnative -Dquarkus.native.container-build=true --projects producer-api" \
  "producer-api/target/producer-api-1.0.0-runner" \
  "cd producer-api && ./docker-build.sh native && cd .." \
  "docker.mycompany.com/quarkus-producer-api-native:1.0.0"
quarkus_producer_api_native[packaging_time]=$package_jar_build_image_packaging_time
quarkus_producer_api_native[jar_size]=$package_jar_build_image_jar_size
quarkus_producer_api_native[building_time]=$package_jar_build_image_building_time
quarkus_producer_api_native[docker_image_size]=$package_jar_build_image_docker_image_size

echo
echo "-----------------------------------------------"
echo "QUARKUS-PRODUCER-CONSUMER / CONSUMER-API-NATIVE"
echo "-----------------------------------------------"

package_jar_build_image \
  "./mvnw clean --projects consumer-api" \
  "./mvnw package -Pnative -Dquarkus.native.container-build=true --projects consumer-api" \
  "consumer-api/target/consumer-api-1.0.0-runner" \
  "cd consumer-api && ./docker-build.sh native && cd .." \
  "docker.mycompany.com/quarkus-consumer-api-native:1.0.0"
quarkus_consumer_api_native[packaging_time]=$package_jar_build_image_packaging_time
quarkus_consumer_api_native[jar_size]=$package_jar_build_image_jar_size
quarkus_consumer_api_native[building_time]=$package_jar_build_image_building_time
quarkus_consumer_api_native[docker_image_size]=$package_jar_build_image_docker_image_size

cd ../..

echo
echo "-------------------------------------------------"
echo "MICRONAUT-PRODUCER-CONSUMER / PRODUCER-API-NATIVE"
echo "-------------------------------------------------"

cd producer-consumer/micronaut-producer-consumer

package_jar_build_image \
  "./mvnw clean --projects producer-api" \
  "./mvnw package --projects producer-api" \
  "producer-api/target/producer-api-1.0.0.jar" \
  "cd producer-api && ./docker-build.sh native && cd .." \
  "docker.mycompany.com/micronaut-producer-api-native:1.0.0"
micronaut_producer_api_native[packaging_time]=$package_jar_build_image_packaging_time
micronaut_producer_api_native[jar_size]=$package_jar_build_image_jar_size
micronaut_producer_api_native[building_time]=$package_jar_build_image_building_time
micronaut_producer_api_native[docker_image_size]=$package_jar_build_image_docker_image_size

echo
echo "-------------------------------------------------"
echo "MICRONAUT-PRODUCER-CONSUMER / CONSUMER-API-NATIVE"
echo "-------------------------------------------------"

package_jar_build_image \
  "./mvnw clean --projects consumer-api" \
  "./mvnw package --projects consumer-api" \
  "consumer-api/target/consumer-api-1.0.0.jar" \
  "cd consumer-api && ./docker-build.sh native && cd .." \
  "docker.mycompany.com/micronaut-consumer-api-native:1.0.0"
micronaut_consumer_api_native[packaging_time]=$package_jar_build_image_packaging_time
micronaut_consumer_api_native[jar_size]=$package_jar_build_image_jar_size
micronaut_consumer_api_native[building_time]=$package_jar_build_image_building_time
micronaut_consumer_api_native[docker_image_size]=$package_jar_build_image_docker_image_size

cd ../..

echo
echo "--------------------------------------------------"
echo "SPRINGBOOT-PRODUCER-CONSUMER / PRODUCER-API-NATIVE"
echo "--------------------------------------------------"

cd producer-consumer/springboot-producer-consumer

package_jar_build_image \
  "./mvnw clean --projects producer-api" \
  "./mvnw package --projects producer-api" \
  "producer-api/target/producer-api-1.0.0.jar" \
  "cd producer-api && ./docker-build.sh native && cd .." \
  "docker.mycompany.com/springboot-producer-api-native:1.0.0"
springboot_producer_api_native[packaging_time]=$package_jar_build_image_packaging_time
springboot_producer_api_native[jar_size]=$package_jar_build_image_jar_size
springboot_producer_api_native[building_time]=$package_jar_build_image_building_time
springboot_producer_api_native[docker_image_size]=$package_jar_build_image_docker_image_size

echo
echo "--------------------------------------------------"
echo "SPRINGBOOT-PRODUCER-CONSUMER / CONSUMER-API-NATIVE"
echo "--------------------------------------------------"

package_jar_build_image \
  "./mvnw clean --projects consumer-api" \
  "./mvnw package --projects consumer-api" \
  "consumer-api/target/consumer-api-1.0.0.jar" \
  "cd consumer-api && ./docker-build.sh native && cd .." \
  "docker.mycompany.com/springboot-consumer-api-native:1.0.0"
springboot_consumer_api_native[packaging_time]=$package_jar_build_image_packaging_time
springboot_consumer_api_native[jar_size]=$package_jar_build_image_jar_size
springboot_consumer_api_native[building_time]=$package_jar_build_image_building_time
springboot_consumer_api_native[docker_image_size]=$package_jar_build_image_docker_image_size

cd ../..

echo
echo "============="
echo "ELASTICSEARCH"
echo "============="

echo
echo "----------------------------"
echo "QUARKUS-ELASTICSEARCH-NATIVE"
echo "----------------------------"

cd elasticsearch/quarkus-elasticsearch

package_jar_build_image \
  "./mvnw clean" \
  "./mvnw package -Pnative -Dquarkus.native.container-build=true" \
  "target/quarkus-elasticsearch-1.0.0-runner" \
  "./docker-build.sh native" \
  "docker.mycompany.com/quarkus-elasticsearch-native:1.0.0"
quarkus_elasticsearch_native[packaging_time]=$package_jar_build_image_packaging_time
quarkus_elasticsearch_native[jar_size]=$package_jar_build_image_jar_size
quarkus_elasticsearch_native[building_time]=$package_jar_build_image_building_time
quarkus_elasticsearch_native[docker_image_size]=$package_jar_build_image_docker_image_size

cd ../..

echo
echo "------------------------------"
echo "MICRONAUT-ELASTICSEARCH-NATIVE"
echo "------------------------------"

cd elasticsearch/micronaut-elasticsearch

package_jar_build_image \
  "./mvnw clean" \
  "./mvnw package" \
  "target/micronaut-elasticsearch-1.0.0.jar" \
  "./docker-build.sh native" \
  "docker.mycompany.com/micronaut-elasticsearch-native:1.0.0"
micronaut_elasticsearch_native[packaging_time]=$package_jar_build_image_packaging_time
micronaut_elasticsearch_native[jar_size]=$package_jar_build_image_jar_size
micronaut_elasticsearch_native[building_time]=$package_jar_build_image_building_time
micronaut_elasticsearch_native[docker_image_size]=$package_jar_build_image_docker_image_size

cd ../..

echo
echo "-------------------------------"
echo "SPRINGBOOT-ELASTICSEARCH-NATIVE"
echo "-------------------------------"

cd elasticsearch/springboot-elasticsearch

package_jar_build_image \
  "./mvnw clean" \
  "./mvnw package" \
  "target/springboot-elasticsearch-1.0.0.jar" \
  "./docker-build.sh native" \
  "docker.mycompany.com/springboot-elasticsearch-native:1.0.0"
springboot_elasticsearch_native[packaging_time]=$package_jar_build_image_packaging_time
springboot_elasticsearch_native[jar_size]=$package_jar_build_image_jar_size
springboot_elasticsearch_native[building_time]=$package_jar_build_image_building_time
springboot_elasticsearch_native[docker_image_size]=$package_jar_build_image_docker_image_size

printf "\n"
printf "%31s | %14s | %16s | %17s | %17s |\n" "Application" "Packaging Time" "Jar Size (bytes)" "Docker Build Time" "Docker Image Size"
printf "%31s + %14s + %16s + %17s + %17s |\n" "-------------------------------" "--------------" "----------------" "-----------------" "-----------------"
printf "%31s | %14s | %16s | %17s | %17s |\n" "quarkus-simple-api-native" ${quarkus_simple_api_native[packaging_time]} ${quarkus_simple_api_native[jar_size]} ${quarkus_simple_api_native[building_time]} ${quarkus_simple_api_native[docker_image_size]}
printf "%31s | %14s | %16s | %17s | %17s |\n" "micronaut-simple-api-native" ${micronaut_simple_api_native[packaging_time]} ${micronaut_simple_api_native[jar_size]} ${micronaut_simple_api_native[building_time]} ${micronaut_simple_api_native[docker_image_size]}
printf "%31s | %14s | %16s | %17s | %17s |\n" "springboot-simple-api-native" ${springboot_simple_api_native[packaging_time]} ${springboot_simple_api_native[jar_size]} ${springboot_simple_api_native[building_time]} ${springboot_simple_api_native[docker_image_size]}
printf "%31s + %14s + %16s + %17s + %17s |\n" "..............................." ".............." "................" "................." "................."
printf "%31s | %14s | %16s | %17s | %17s |\n" "quarkus-book-api-native" ${quarkus_book_api_native[packaging_time]} ${quarkus_book_api_native[jar_size]} ${quarkus_book_api_native[building_time]} ${quarkus_book_api_native[docker_image_size]}
printf "%31s | %14s | %16s | %17s | %17s |\n" "micronaut-book-api-native" ${micronaut_book_api_native[packaging_time]} ${micronaut_book_api_native[jar_size]} ${micronaut_book_api_native[building_time]} ${micronaut_book_api_native[docker_image_size]}
printf "%31s | %14s | %16s | %17s | %17s |\n" "springboot-book-api-native" ${springboot_book_api_native[packaging_time]} ${springboot_book_api_native[jar_size]} ${springboot_book_api_native[building_time]} ${springboot_book_api_native[docker_image_size]}
printf "%31s + %14s + %16s + %17s + %17s |\n" "..............................." ".............." "................" "................." "................."
printf "%31s | %14s | %16s | %17s | %17s |\n" "quarkus-producer-api-native" ${quarkus_producer_api_native[packaging_time]} ${quarkus_producer_api_native[jar_size]} ${quarkus_producer_api_native[building_time]} ${quarkus_producer_api_native[docker_image_size]}
printf "%31s | %14s | %16s | %17s | %17s |\n" "micronaut-producer-api-native" ${micronaut_producer_api_native[packaging_time]} ${micronaut_producer_api_native[jar_size]} ${micronaut_producer_api_native[building_time]} ${micronaut_producer_api_native[docker_image_size]}
printf "%31s | %14s | %16s | %17s | %17s |\n" "springboot-producer-api-native" ${springboot_producer_api_native[packaging_time]} ${springboot_producer_api_native[jar_size]} ${springboot_producer_api_native[building_time]} ${springboot_producer_api_native[docker_image_size]}
printf "%31s + %14s + %16s + %17s + %17s |\n" "..............................." ".............." "................" "................." "................."
printf "%31s | %14s | %16s | %17s | %17s |\n" "quarkus-consumer-api-native" ${quarkus_consumer_api_native[packaging_time]} ${quarkus_consumer_api_native[jar_size]} ${quarkus_consumer_api_native[building_time]} ${quarkus_consumer_api_native[docker_image_size]}
printf "%31s | %14s | %16s | %17s | %17s |\n" "micronaut-consumer-api-native" ${micronaut_consumer_api_native[packaging_time]} ${micronaut_consumer_api_native[jar_size]} ${micronaut_consumer_api_native[building_time]} ${micronaut_consumer_api_native[docker_image_size]}
printf "%31s | %14s | %16s | %17s | %17s |\n" "springboot-consumer-api-native" ${springboot_consumer_api_native[packaging_time]} ${springboot_consumer_api_native[jar_size]} ${springboot_consumer_api_native[building_time]} ${springboot_consumer_api_native[docker_image_size]}
printf "%31s + %14s + %16s + %17s + %17s |\n" "..............................." ".............." "................" "................." "................."
printf "%31s | %14s | %16s | %17s | %17s |\n" "quarkus-elasticsearch-native" ${quarkus_elasticsearch_native[packaging_time]} ${quarkus_elasticsearch_native[jar_size]} ${quarkus_elasticsearch_native[building_time]} ${quarkus_elasticsearch_native[docker_image_size]}
printf "%31s | %14s | %16s | %17s | %17s |\n" "micronaut-elasticsearch-native" ${micronaut_elasticsearch_native[packaging_time]} ${micronaut_elasticsearch_native[jar_size]} ${micronaut_elasticsearch_native[building_time]} ${micronaut_elasticsearch_native[docker_image_size]}
printf "%31s | %14s | %16s | %17s | %17s |\n" "springboot-elasticsearch-native" ${springboot_elasticsearch_native[packaging_time]} ${springboot_elasticsearch_native[jar_size]} ${springboot_elasticsearch_native[building_time]} ${springboot_elasticsearch_native[docker_image_size]}

echo
echo "==>  START AT: ${start_time}"
echo "==> FINISH AT: $(date)"
echo
