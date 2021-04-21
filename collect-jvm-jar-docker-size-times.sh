#!/usr/bin/env bash

source my-functions.sh

check_builder_script_input_parameter $1

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

if [ "$1" = "quarkus-simple-api" ] ||
   [ "$1" = "quarkus" ] ||
   [ "$1" = "simple-api" ] ||
   [ "$1" = "all" ];
then

  echo
  echo "----------------------"
  echo "QUARKUS-SIMPLE-API-JVM"
  echo "----------------------"

  cd simple-api/quarkus-simple-api

  package_jar_build_image \
    "./mvnw clean" \
    "./mvnw package" \
    "target/quarkus-app" \
    "./docker-build.sh" \
    "docker.mycompany.com/quarkus-simple-api-jvm:1.0.0"
  quarkus_simple_api_jvm[packaging_time]=$package_jar_build_image_packaging_time
  quarkus_simple_api_jvm[jar_size]=$package_jar_build_image_jar_size
  quarkus_simple_api_jvm[building_time]=$package_jar_build_image_building_time
  quarkus_simple_api_jvm[docker_image_size]=$package_jar_build_image_docker_image_size

  cd ../..

fi

if [ "$1" = "micronaut-simple-api" ] ||
   [ "$1" = "micronaut" ] ||
   [ "$1" = "simple-api" ] ||
   [ "$1" = "all" ];
then

  echo
  echo "------------------------"
  echo "MICRONAUT-SIMPLE-API-JVM"
  echo "------------------------"

  cd simple-api/micronaut-simple-api

  package_jar_build_image \
    "./mvnw clean" \
    "./mvnw package" \
    "target/micronaut-simple-api-1.0.0.jar" \
    "./docker-build.sh" \
    "docker.mycompany.com/micronaut-simple-api-jvm:1.0.0"
  micronaut_simple_api_jvm[packaging_time]=$package_jar_build_image_packaging_time
  micronaut_simple_api_jvm[jar_size]=$package_jar_build_image_jar_size
  micronaut_simple_api_jvm[building_time]=$package_jar_build_image_building_time
  micronaut_simple_api_jvm[docker_image_size]=$package_jar_build_image_docker_image_size

  cd ../..

fi

if [ "$1" = "springboot-simple-api" ] ||
   [ "$1" = "springboot" ] ||
   [ "$1" = "simple-api" ] ||
   [ "$1" = "all" ];
then

  echo
  echo "-------------------------"
  echo "SPRINGBOOT-SIMPLE-API-JVM"
  echo "-------------------------"

  cd simple-api/springboot-simple-api

  package_jar_build_image \
    "./mvnw clean" \
    "./mvnw package" \
    "target/springboot-simple-api-1.0.0.jar" \
    "./docker-build.sh" \
    "docker.mycompany.com/springboot-simple-api-jvm:1.0.0"
  springboot_simple_api_jvm[packaging_time]=$package_jar_build_image_packaging_time
  springboot_simple_api_jvm[jar_size]=$package_jar_build_image_jar_size
  springboot_simple_api_jvm[building_time]=$package_jar_build_image_building_time
  springboot_simple_api_jvm[docker_image_size]=$package_jar_build_image_docker_image_size

  cd ../..

fi

if [ "$1" = "quarkus-book-api" ] ||
   [ "$1" = "quarkus" ] ||
   [ "$1" = "book-api" ] ||
   [ "$1" = "all" ];
then

  echo
  echo "--------------------"
  echo "QUARKUS-BOOK-API-JVM"
  echo "--------------------"

  cd book-api/quarkus-book-api

  package_jar_build_image \
    "./mvnw clean" \
    "./mvnw package" \
    "target/quarkus-app" \
    "./docker-build.sh" \
    "docker.mycompany.com/quarkus-book-api-jvm:1.0.0"
  quarkus_book_api_jvm[packaging_time]=$package_jar_build_image_packaging_time
  quarkus_book_api_jvm[jar_size]=$package_jar_build_image_jar_size
  quarkus_book_api_jvm[building_time]=$package_jar_build_image_building_time
  quarkus_book_api_jvm[docker_image_size]=$package_jar_build_image_docker_image_size

  cd ../..

fi

if [ "$1" = "micronaut-book-api" ] ||
   [ "$1" = "micronaut" ] ||
   [ "$1" = "book-api" ] ||
   [ "$1" = "all" ];
then

  echo
  echo "----------------------"
  echo "MICRONAUT-BOOK-API-JVM"
  echo "----------------------"

  cd book-api/micronaut-book-api

  package_jar_build_image \
    "./mvnw clean" \
    "./mvnw package" \
    "target/micronaut-book-api-1.0.0.jar" \
    "./docker-build.sh" \
    "docker.mycompany.com/micronaut-book-api-jvm:1.0.0"
  micronaut_book_api_jvm[packaging_time]=$package_jar_build_image_packaging_time
  micronaut_book_api_jvm[jar_size]=$package_jar_build_image_jar_size
  micronaut_book_api_jvm[building_time]=$package_jar_build_image_building_time
  micronaut_book_api_jvm[docker_image_size]=$package_jar_build_image_docker_image_size

  cd ../..

fi

if [ "$1" = "springboot-book-api" ] ||
   [ "$1" = "springboot" ] ||
   [ "$1" = "book-api" ] ||
   [ "$1" = "all" ];
then

  echo
  echo "-----------------------"
  echo "SPRINGBOOT-BOOK-API-JVM"
  echo "-----------------------"

  cd book-api/springboot-book-api

  package_jar_build_image \
    "./mvnw clean" \
    "./mvnw package" \
    "target/springboot-book-api-1.0.0.jar" \
    "./docker-build.sh" \
    "docker.mycompany.com/springboot-book-api-jvm:1.0.0"
  springboot_book_api_jvm[packaging_time]=$package_jar_build_image_packaging_time
  springboot_book_api_jvm[jar_size]=$package_jar_build_image_jar_size
  springboot_book_api_jvm[building_time]=$package_jar_build_image_building_time
  springboot_book_api_jvm[docker_image_size]=$package_jar_build_image_docker_image_size

  cd ../..

fi

if [ "$1" = "quarkus-producer-consumer_producer-api" ] ||
   [ "$1" = "quarkus-producer-consumer" ] ||
   [ "$1" = "quarkus" ] ||
   [ "$1" = "producer-consumer" ] ||
   [ "$1" = "all" ];
then

  echo
  echo "--------------------------------------------"
  echo "QUARKUS-PRODUCER-CONSUMER / PRODUCER-API-JVM"
  echo "--------------------------------------------"

  cd producer-consumer/quarkus-producer-consumer

  package_jar_build_image \
    "./mvnw clean --projects producer-api" \
    "./mvnw package --projects producer-api" \
    "producer-api/target/quarkus-app" \
    "cd producer-api && ./docker-build.sh && cd .." \
    "docker.mycompany.com/quarkus-producer-api-jvm:1.0.0"
  quarkus_producer_api_jvm[packaging_time]=$package_jar_build_image_packaging_time
  quarkus_producer_api_jvm[jar_size]=$package_jar_build_image_jar_size
  quarkus_producer_api_jvm[building_time]=$package_jar_build_image_building_time
  quarkus_producer_api_jvm[docker_image_size]=$package_jar_build_image_docker_image_size

  cd ../..

fi

if [ "$1" = "quarkus-producer-consumer_consumer-api" ] ||
   [ "$1" = "quarkus-producer-consumer" ] ||
   [ "$1" = "quarkus" ] ||
   [ "$1" = "producer-consumer" ] ||
   [ "$1" = "all" ];
then

  echo
  echo "--------------------------------------------"
  echo "QUARKUS-PRODUCER-CONSUMER / CONSUMER-API-JVM"
  echo "--------------------------------------------"

  cd producer-consumer/quarkus-producer-consumer

  package_jar_build_image \
    "./mvnw clean --projects consumer-api" \
    "./mvnw package --projects consumer-api" \
    "consumer-api/target/quarkus-app" \
    "cd consumer-api && ./docker-build.sh && cd .." \
    "docker.mycompany.com/quarkus-consumer-api-jvm:1.0.0"
  quarkus_consumer_api_jvm[packaging_time]=$package_jar_build_image_packaging_time
  quarkus_consumer_api_jvm[jar_size]=$package_jar_build_image_jar_size
  quarkus_consumer_api_jvm[building_time]=$package_jar_build_image_building_time
  quarkus_consumer_api_jvm[docker_image_size]=$package_jar_build_image_docker_image_size

  cd ../..

fi

if [ "$1" = "micronaut-producer-consumer_producer-api" ] ||
   [ "$1" = "micronaut-producer-consumer" ] ||
   [ "$1" = "micronaut" ] ||
   [ "$1" = "producer-consumer" ] ||
   [ "$1" = "all" ];
then

  echo
  echo "----------------------------------------------"
  echo "MICRONAUT-PRODUCER-CONSUMER / PRODUCER-API-JVM"
  echo "----------------------------------------------"

  cd producer-consumer/micronaut-producer-consumer

  package_jar_build_image \
    "./mvnw clean --projects producer-api" \
    "./mvnw package --projects producer-api" \
    "producer-api/target/producer-api-1.0.0.jar" \
    "cd producer-api && ./docker-build.sh && cd .." \
    "docker.mycompany.com/micronaut-producer-api-jvm:1.0.0"
  micronaut_producer_api_jvm[packaging_time]=$package_jar_build_image_packaging_time
  micronaut_producer_api_jvm[jar_size]=$package_jar_build_image_jar_size
  micronaut_producer_api_jvm[building_time]=$package_jar_build_image_building_time
  micronaut_producer_api_jvm[docker_image_size]=$package_jar_build_image_docker_image_size

  cd ../..

fi

if [ "$1" = "micronaut-producer-consumer_consumer-api" ] ||
   [ "$1" = "micronaut-producer-consumer" ] ||
   [ "$1" = "micronaut" ] ||
   [ "$1" = "producer-consumer" ] ||
   [ "$1" = "all" ];
then

  echo
  echo "----------------------------------------------"
  echo "MICRONAUT-PRODUCER-CONSUMER / CONSUMER-API-JVM"
  echo "----------------------------------------------"

  cd producer-consumer/micronaut-producer-consumer

  package_jar_build_image \
    "./mvnw clean --projects consumer-api" \
    "./mvnw package --projects consumer-api" \
    "consumer-api/target/consumer-api-1.0.0.jar" \
    "cd consumer-api && ./docker-build.sh && cd .." \
    "docker.mycompany.com/micronaut-consumer-api-jvm:1.0.0"
  micronaut_consumer_api_jvm[packaging_time]=$package_jar_build_image_packaging_time
  micronaut_consumer_api_jvm[jar_size]=$package_jar_build_image_jar_size
  micronaut_consumer_api_jvm[building_time]=$package_jar_build_image_building_time
  micronaut_consumer_api_jvm[docker_image_size]=$package_jar_build_image_docker_image_size

  cd ../..

fi

if [ "$1" = "springboot-producer-consumer_producer-api" ] ||
   [ "$1" = "springboot-producer-consumer" ] ||
   [ "$1" = "springboot" ] ||
   [ "$1" = "producer-consumer" ] ||
   [ "$1" = "all" ];
then

  echo
  echo "-----------------------------------------------"
  echo "SPRINGBOOT-PRODUCER-CONSUMER / PRODUCER-API-JVM"
  echo "-----------------------------------------------"

  cd producer-consumer/springboot-producer-consumer

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

  cd ../..

fi

if [ "$1" = "springboot-producer-consumer_consumer-api" ] ||
   [ "$1" = "springboot-producer-consumer" ] ||
   [ "$1" = "springboot" ] ||
   [ "$1" = "producer-consumer" ] ||
   [ "$1" = "all" ];
then

  echo
  echo "-----------------------------------------------"
  echo "SPRINGBOOT-PRODUCER-CONSUMER / CONSUMER-API-JVM"
  echo "-----------------------------------------------"

  cd producer-consumer/springboot-producer-consumer

  # package_jar_build_image \
  #   "./mvnw clean --projects consumer-api" \
  #   "./mvnw package --projects consumer-api" \
  #   "consumer-api/target/consumer-api-1.0.0.jar" \
  #   "cd consumer-api && ./docker-build.sh && cd .." \
  #   "docker.mycompany.com/springboot-consumer-api-jvm:1.0.0"
  # springboot_consumer_api_jvm[packaging_time]=$package_jar_build_image_packaging_time
  # springboot_consumer_api_jvm[jar_size]=$package_jar_build_image_jar_size
  # springboot_consumer_api_jvm[building_time]=$package_jar_build_image_building_time
  # springboot_consumer_api_jvm[docker_image_size]=$package_jar_build_image_docker_image_size

  cd ../..

fi

if [ "$1" = "quarkus-elasticsearch" ] ||
   [ "$1" = "quarkus" ] ||
   [ "$1" = "elasticsearch" ] ||
   [ "$1" = "all" ];
then

  echo
  echo "-------------------------"
  echo "QUARKUS-ELASTICSEARCH-JVM"
  echo "-------------------------"

  cd elasticsearch/quarkus-elasticsearch

  package_jar_build_image \
    "./mvnw clean" \
    "./mvnw package" \
    "target/quarkus-app" \
    "./docker-build.sh" \
    "docker.mycompany.com/quarkus-elasticsearch-jvm:1.0.0"
  quarkus_elasticsearch_jvm[packaging_time]=$package_jar_build_image_packaging_time
  quarkus_elasticsearch_jvm[jar_size]=$package_jar_build_image_jar_size
  quarkus_elasticsearch_jvm[building_time]=$package_jar_build_image_building_time
  quarkus_elasticsearch_jvm[docker_image_size]=$package_jar_build_image_docker_image_size

  cd ../..

fi

if [ "$1" = "micronaut-elasticsearch" ] ||
   [ "$1" = "micronaut" ] ||
   [ "$1" = "elasticsearch" ] ||
   [ "$1" = "all" ];
then

  echo
  echo "---------------------------"
  echo "MICRONAUT-ELASTICSEARCH-JVM"
  echo "---------------------------"

  cd elasticsearch/micronaut-elasticsearch

  package_jar_build_image \
    "./mvnw clean" \
    "./mvnw package" \
    "target/micronaut-elasticsearch-1.0.0.jar" \
    "./docker-build.sh" \
    "docker.mycompany.com/micronaut-elasticsearch-jvm:1.0.0"
  micronaut_elasticsearch_jvm[packaging_time]=$package_jar_build_image_packaging_time
  micronaut_elasticsearch_jvm[jar_size]=$package_jar_build_image_jar_size
  micronaut_elasticsearch_jvm[building_time]=$package_jar_build_image_building_time
  micronaut_elasticsearch_jvm[docker_image_size]=$package_jar_build_image_docker_image_size

  cd ../..

fi

if [ "$1" = "springboot-elasticsearch" ] ||
   [ "$1" = "springboot" ] ||
   [ "$1" = "elasticsearch" ] ||
   [ "$1" = "all" ];
then

  echo
  echo "----------------------------"
  echo "SPRINGBOOT-ELASTICSEARCH-JVM"
  echo "----------------------------"

  cd elasticsearch/springboot-elasticsearch

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

  cd ../..

fi

printf "\n"
printf "%30s | %14s | %14s | %17s | %17s |\n" "Application" "Packaging Time" "Packaging Size" "Docker Build Time" "Docker Image Size"
printf "%30s + %14s + %14s + %17s + %17s |\n" "------------------------------" "--------------" "--------------" "-----------------" "-----------------"
printf "%30s | %14s | %14s | %17s | %17s |\n" "quarkus-simple-api-jvm" ${quarkus_simple_api_jvm[packaging_time]} ${quarkus_simple_api_jvm[jar_size]} ${quarkus_simple_api_jvm[building_time]} ${quarkus_simple_api_jvm[docker_image_size]}
printf "%30s | %14s | %14s | %17s | %17s |\n" "micronaut-simple-api-jvm" ${micronaut_simple_api_jvm[packaging_time]} ${micronaut_simple_api_jvm[jar_size]} ${micronaut_simple_api_jvm[building_time]} ${micronaut_simple_api_jvm[docker_image_size]}
printf "%30s | %14s | %14s | %17s | %17s |\n" "springboot-simple-api-jvm" ${springboot_simple_api_jvm[packaging_time]} ${springboot_simple_api_jvm[jar_size]} ${springboot_simple_api_jvm[building_time]} ${springboot_simple_api_jvm[docker_image_size]}
printf "%30s + %14s + %14s + %17s + %17s |\n" ".............................." ".............." ".............." "................." "................."
printf "%30s | %14s | %14s | %17s | %17s |\n" "quarkus-book-api-jvm" ${quarkus_book_api_jvm[packaging_time]} ${quarkus_book_api_jvm[jar_size]} ${quarkus_book_api_jvm[building_time]} ${quarkus_book_api_jvm[docker_image_size]}
printf "%30s | %14s | %14s | %17s | %17s |\n" "micronaut-book-api-jvm" ${micronaut_book_api_jvm[packaging_time]} ${micronaut_book_api_jvm[jar_size]} ${micronaut_book_api_jvm[building_time]} ${micronaut_book_api_jvm[docker_image_size]}
printf "%30s | %14s | %14s | %17s | %17s |\n" "springboot-book-api-jvm" ${springboot_book_api_jvm[packaging_time]} ${springboot_book_api_jvm[jar_size]} ${springboot_book_api_jvm[building_time]} ${springboot_book_api_jvm[docker_image_size]}
printf "%30s + %14s + %14s + %17s + %17s |\n" ".............................." ".............." ".............." "................." "................."
printf "%30s | %14s | %14s | %17s | %17s |\n" "quarkus-producer-api-jvm" ${quarkus_producer_api_jvm[packaging_time]} ${quarkus_producer_api_jvm[jar_size]} ${quarkus_producer_api_jvm[building_time]} ${quarkus_producer_api_jvm[docker_image_size]}
printf "%30s | %14s | %14s | %17s | %17s |\n" "micronaut-producer-api-jvm" ${micronaut_producer_api_jvm[packaging_time]} ${micronaut_producer_api_jvm[jar_size]} ${micronaut_producer_api_jvm[building_time]} ${micronaut_producer_api_jvm[docker_image_size]}
printf "%30s | %14s | %14s | %17s | %17s |\n" "springboot-producer-api-jvm" ${springboot_producer_api_jvm[packaging_time]} ${springboot_producer_api_jvm[jar_size]} ${springboot_producer_api_jvm[building_time]} ${springboot_producer_api_jvm[docker_image_size]}
printf "%30s + %14s + %14s + %17s + %17s |\n" ".............................." ".............." ".............." "................." "................."
printf "%30s | %14s | %14s | %17s | %17s |\n" "quarkus-consumer-api-jvm" ${quarkus_consumer_api_jvm[packaging_time]} ${quarkus_consumer_api_jvm[jar_size]} ${quarkus_consumer_api_jvm[building_time]} ${quarkus_consumer_api_jvm[docker_image_size]}
printf "%30s | %14s | %14s | %17s | %17s |\n" "micronaut-consumer-api-jvm" ${micronaut_consumer_api_jvm[packaging_time]} ${micronaut_consumer_api_jvm[jar_size]} ${micronaut_consumer_api_jvm[building_time]} ${micronaut_consumer_api_jvm[docker_image_size]}
printf "%30s | %14s | %14s | %17s | %17s |\n" "springboot-consumer-api-jvm" ${springboot_consumer_api_jvm[packaging_time]} ${springboot_consumer_api_jvm[jar_size]} ${springboot_consumer_api_jvm[building_time]} ${springboot_consumer_api_jvm[docker_image_size]}
printf "%30s + %14s + %14s + %17s + %17s |\n" ".............................." ".............." ".............." "................." "................."
printf "%30s | %14s | %14s | %17s | %17s |\n" "quarkus-elasticsearch-jvm" ${quarkus_elasticsearch_jvm[packaging_time]} ${quarkus_elasticsearch_jvm[jar_size]} ${quarkus_elasticsearch_jvm[building_time]} ${quarkus_elasticsearch_jvm[docker_image_size]}
printf "%30s | %14s | %14s | %17s | %17s |\n" "micronaut-elasticsearch-jvm" ${micronaut_elasticsearch_jvm[packaging_time]} ${micronaut_elasticsearch_jvm[jar_size]} ${micronaut_elasticsearch_jvm[building_time]} ${micronaut_elasticsearch_jvm[docker_image_size]}
printf "%30s | %14s | %14s | %17s | %17s |\n" "springboot-elasticsearch-jvm" ${springboot_elasticsearch_jvm[packaging_time]} ${springboot_elasticsearch_jvm[jar_size]} ${springboot_elasticsearch_jvm[building_time]} ${springboot_elasticsearch_jvm[docker_image_size]}

echo
echo "==>  START AT: ${start_time}"
echo "==> FINISH AT: $(date)"
echo
