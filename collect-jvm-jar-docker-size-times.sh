#!/usr/bin/env bash

source my-functions.sh

check_docker_manager_script_input_parameter $1

declare -A quarkus_simple_api_jvm
declare -A micronaut_simple_api_jvm
declare -A springboot_simple_api_jvm

declare -A quarkus_jpa_mysql_jvm
declare -A micronaut_jpa_mysql_jvm
declare -A springboot_jpa_mysql_jvm

declare -A quarkus_kafka_producer_jvm
declare -A quarkus_kafka_consumer_jvm
declare -A micronaut_kafka_producer_jvm
declare -A micronaut_kafka_consumer_jvm
declare -A springboot_kafka_producer_jvm
declare -A springboot_kafka_consumer_jvm

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
    "ivanfranchin/quarkus-simple-api-jvm:1.0.0"
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
    "ivanfranchin/micronaut-simple-api-jvm:1.0.0"
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
    "ivanfranchin/springboot-simple-api-jvm:1.0.0"
  springboot_simple_api_jvm[packaging_time]=$package_jar_build_image_packaging_time
  springboot_simple_api_jvm[jar_size]=$package_jar_build_image_jar_size
  springboot_simple_api_jvm[building_time]=$package_jar_build_image_building_time
  springboot_simple_api_jvm[docker_image_size]=$package_jar_build_image_docker_image_size

  cd ../..

fi

if [ "$1" = "quarkus-jpa-mysql" ] ||
   [ "$1" = "quarkus" ] ||
   [ "$1" = "jpa-mysql" ] ||
   [ "$1" = "all" ];
then

  echo
  echo "---------------------"
  echo "QUARKUS-JPA-MYSQL-JVM"
  echo "---------------------"

  cd jpa-mysql/quarkus-jpa-mysql

  package_jar_build_image \
    "./mvnw clean" \
    "./mvnw package" \
    "target/quarkus-app" \
    "./docker-build.sh" \
    "ivanfranchin/quarkus-jpa-mysql-jvm:1.0.0"
  quarkus_jpa_mysql_jvm[packaging_time]=$package_jar_build_image_packaging_time
  quarkus_jpa_mysql_jvm[jar_size]=$package_jar_build_image_jar_size
  quarkus_jpa_mysql_jvm[building_time]=$package_jar_build_image_building_time
  quarkus_jpa_mysql_jvm[docker_image_size]=$package_jar_build_image_docker_image_size

  cd ../..

fi

if [ "$1" = "micronaut-jpa-mysql" ] ||
   [ "$1" = "micronaut" ] ||
   [ "$1" = "jpa-mysql" ] ||
   [ "$1" = "all" ];
then

  echo
  echo "-----------------------"
  echo "MICRONAUT-JPA-MYSQL-JVM"
  echo "-----------------------"

  cd jpa-mysql/micronaut-jpa-mysql

  package_jar_build_image \
    "./mvnw clean" \
    "./mvnw package" \
    "target/micronaut-jpa-mysql-1.0.0.jar" \
    "./docker-build.sh" \
    "ivanfranchin/micronaut-jpa-mysql-jvm:1.0.0"
  micronaut_jpa_mysql_jvm[packaging_time]=$package_jar_build_image_packaging_time
  micronaut_jpa_mysql_jvm[jar_size]=$package_jar_build_image_jar_size
  micronaut_jpa_mysql_jvm[building_time]=$package_jar_build_image_building_time
  micronaut_jpa_mysql_jvm[docker_image_size]=$package_jar_build_image_docker_image_size

  cd ../..

fi

if [ "$1" = "springboot-jpa-mysql" ] ||
   [ "$1" = "springboot" ] ||
   [ "$1" = "jpa-mysql" ] ||
   [ "$1" = "all" ];
then

  echo
  echo "------------------------"
  echo "SPRINGBOOT-JPA-MYSQL-JVM"
  echo "------------------------"

  cd jpa-mysql/springboot-jpa-mysql

  package_jar_build_image \
    "./mvnw clean" \
    "./mvnw package" \
    "target/springboot-jpa-mysql-1.0.0.jar" \
    "./docker-build.sh" \
    "ivanfranchin/springboot-jpa-mysql-jvm:1.0.0"
  springboot_jpa_mysql_jvm[packaging_time]=$package_jar_build_image_packaging_time
  springboot_jpa_mysql_jvm[jar_size]=$package_jar_build_image_jar_size
  springboot_jpa_mysql_jvm[building_time]=$package_jar_build_image_building_time
  springboot_jpa_mysql_jvm[docker_image_size]=$package_jar_build_image_docker_image_size

  cd ../..

fi

if [ "$1" = "quarkus-kafka-producer" ] ||
   [ "$1" = "quarkus-kafka" ] ||
   [ "$1" = "quarkus" ] ||
   [ "$1" = "kafka" ] ||
   [ "$1" = "all" ];
then

  echo
  echo "----------------------------------"
  echo "QUARKUS-KAFKA / KAFKA-PRODUCER-JVM"
  echo "----------------------------------"

  cd kafka/quarkus-kafka

  package_jar_build_image \
    "./mvnw clean --projects kafka-producer" \
    "./mvnw package --projects kafka-producer" \
    "kafka-producer/target/quarkus-app" \
    "cd kafka-producer && ./docker-build.sh && cd .." \
    "ivanfranchin/quarkus-kafka-producer-jvm:1.0.0"
  quarkus_kafka_producer_jvm[packaging_time]=$package_jar_build_image_packaging_time
  quarkus_kafka_producer_jvm[jar_size]=$package_jar_build_image_jar_size
  quarkus_kafka_producer_jvm[building_time]=$package_jar_build_image_building_time
  quarkus_kafka_producer_jvm[docker_image_size]=$package_jar_build_image_docker_image_size

  cd ../..

fi

if [ "$1" = "quarkus-kafka-consumer" ] ||
   [ "$1" = "quarkus-kafka" ] ||
   [ "$1" = "quarkus" ] ||
   [ "$1" = "kafka" ] ||
   [ "$1" = "all" ];
then

  echo
  echo "----------------------------------"
  echo "QUARKUS-KAFKA / KAFKA-CONSUMER-JVM"
  echo "----------------------------------"

  cd kafka/quarkus-kafka

  package_jar_build_image \
    "./mvnw clean --projects kafka-consumer" \
    "./mvnw package --projects kafka-consumer" \
    "kafka-consumer/target/quarkus-app" \
    "cd kafka-consumer && ./docker-build.sh && cd .." \
    "ivanfranchin/quarkus-kafka-consumer-jvm:1.0.0"
  quarkus_kafka_consumer_jvm[packaging_time]=$package_jar_build_image_packaging_time
  quarkus_kafka_consumer_jvm[jar_size]=$package_jar_build_image_jar_size
  quarkus_kafka_consumer_jvm[building_time]=$package_jar_build_image_building_time
  quarkus_kafka_consumer_jvm[docker_image_size]=$package_jar_build_image_docker_image_size

  cd ../..

fi

if [ "$1" = "micronaut-kafka-producer" ] ||
   [ "$1" = "micronaut-kafka" ] ||
   [ "$1" = "micronaut" ] ||
   [ "$1" = "kafka" ] ||
   [ "$1" = "all" ];
then

  echo
  echo "------------------------------------"
  echo "MICRONAUT-KAFKA / KAFKA-PRODUCER-JVM"
  echo "------------------------------------"

  cd kafka/micronaut-kafka

  package_jar_build_image \
    "./mvnw clean --projects kafka-producer" \
    "./mvnw package --projects kafka-producer" \
    "kafka-producer/target/kafka-producer-1.0.0.jar" \
    "cd kafka-producer && ./docker-build.sh && cd .." \
    "ivanfranchin/micronaut-kafka-producer-jvm:1.0.0"
  micronaut_kafka_producer_jvm[packaging_time]=$package_jar_build_image_packaging_time
  micronaut_kafka_producer_jvm[jar_size]=$package_jar_build_image_jar_size
  micronaut_kafka_producer_jvm[building_time]=$package_jar_build_image_building_time
  micronaut_kafka_producer_jvm[docker_image_size]=$package_jar_build_image_docker_image_size

  cd ../..

fi

if [ "$1" = "micronaut-kafka-consumer" ] ||
   [ "$1" = "micronaut-kafka" ] ||
   [ "$1" = "micronaut" ] ||
   [ "$1" = "kafka" ] ||
   [ "$1" = "all" ];
then

  echo
  echo "------------------------------------"
  echo "MICRONAUT-KAFKA / KAFKA-CONSUMER-JVM"
  echo "------------------------------------"

  cd kafka/micronaut-kafka

  package_jar_build_image \
    "./mvnw clean --projects kafka-consumer" \
    "./mvnw package --projects kafka-consumer" \
    "kafka-consumer/target/kafka-consumer-1.0.0.jar" \
    "cd kafka-consumer && ./docker-build.sh && cd .." \
    "ivanfranchin/micronaut-kafka-consumer-jvm:1.0.0"
  micronaut_kafka_consumer_jvm[packaging_time]=$package_jar_build_image_packaging_time
  micronaut_kafka_consumer_jvm[jar_size]=$package_jar_build_image_jar_size
  micronaut_kafka_consumer_jvm[building_time]=$package_jar_build_image_building_time
  micronaut_kafka_consumer_jvm[docker_image_size]=$package_jar_build_image_docker_image_size

  cd ../..

fi

if [ "$1" = "springboot-kafka-producer" ] ||
   [ "$1" = "springboot-kafka" ] ||
   [ "$1" = "springboot" ] ||
   [ "$1" = "kafka" ] ||
   [ "$1" = "all" ];
then

  echo
  echo "-------------------------------------"
  echo "SPRINGBOOT-KAFKA / KAFKA-PRODUCER-JVM"
  echo "-------------------------------------"

  cd kafka/springboot-kafka

  package_jar_build_image \
    "./mvnw clean --projects kafka-producer" \
    "./mvnw package --projects kafka-producer" \
    "kafka-producer/target/kafka-producer-1.0.0.jar" \
    "cd kafka-producer && ./docker-build.sh && cd .." \
    "ivanfranchin/springboot-kafka-producer-jvm:1.0.0"
  springboot_kafka_producer_jvm[packaging_time]=$package_jar_build_image_packaging_time
  springboot_kafka_producer_jvm[jar_size]=$package_jar_build_image_jar_size
  springboot_kafka_producer_jvm[building_time]=$package_jar_build_image_building_time
  springboot_kafka_producer_jvm[docker_image_size]=$package_jar_build_image_docker_image_size

  cd ../..

fi

if [ "$1" = "springboot-kafka-consumer" ] ||
   [ "$1" = "springboot-kafka" ] ||
   [ "$1" = "springboot" ] ||
   [ "$1" = "kafka" ] ||
   [ "$1" = "all" ];
then

  echo
  echo "-------------------------------------"
  echo "SPRINGBOOT-KAFKA / KAFKA-CONSUMER-JVM"
  echo "-------------------------------------"

  cd kafka/springboot-kafka

  package_jar_build_image \
    "./mvnw clean --projects kafka-consumer" \
    "./mvnw package --projects kafka-consumer" \
    "kafka-consumer/target/kafka-consumer-1.0.0.jar" \
    "cd kafka-consumer && ./docker-build.sh && cd .." \
    "ivanfranchin/springboot-kafka-consumer-jvm:1.0.0"
  springboot_kafka_consumer_jvm[packaging_time]=$package_jar_build_image_packaging_time
  springboot_kafka_consumer_jvm[jar_size]=$package_jar_build_image_jar_size
  springboot_kafka_consumer_jvm[building_time]=$package_jar_build_image_building_time
  springboot_kafka_consumer_jvm[docker_image_size]=$package_jar_build_image_docker_image_size

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
    "ivanfranchin/quarkus-elasticsearch-jvm:1.0.0"
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
    "ivanfranchin/micronaut-elasticsearch-jvm:1.0.0"
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
    "ivanfranchin/springboot-elasticsearch-jvm:1.0.0"
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
printf "%30s | %14s | %14s | %17s | %17s |\n" "quarkus-jpa-mysql-jvm" ${quarkus_jpa_mysql_jvm[packaging_time]} ${quarkus_jpa_mysql_jvm[jar_size]} ${quarkus_jpa_mysql_jvm[building_time]} ${quarkus_jpa_mysql_jvm[docker_image_size]}
printf "%30s | %14s | %14s | %17s | %17s |\n" "micronaut-jpa-mysql-jvm" ${micronaut_jpa_mysql_jvm[packaging_time]} ${micronaut_jpa_mysql_jvm[jar_size]} ${micronaut_jpa_mysql_jvm[building_time]} ${micronaut_jpa_mysql_jvm[docker_image_size]}
printf "%30s | %14s | %14s | %17s | %17s |\n" "springboot-jpa-mysql-jvm" ${springboot_jpa_mysql_jvm[packaging_time]} ${springboot_jpa_mysql_jvm[jar_size]} ${springboot_jpa_mysql_jvm[building_time]} ${springboot_jpa_mysql_jvm[docker_image_size]}
printf "%30s + %14s + %14s + %17s + %17s |\n" ".............................." ".............." ".............." "................." "................."
printf "%30s | %14s | %14s | %17s | %17s |\n" "quarkus-kafka-producer-jvm" ${quarkus_kafka_producer_jvm[packaging_time]} ${quarkus_kafka_producer_jvm[jar_size]} ${quarkus_kafka_producer_jvm[building_time]} ${quarkus_kafka_producer_jvm[docker_image_size]}
printf "%30s | %14s | %14s | %17s | %17s |\n" "micronaut-kafka-producer-jvm" ${micronaut_kafka_producer_jvm[packaging_time]} ${micronaut_kafka_producer_jvm[jar_size]} ${micronaut_kafka_producer_jvm[building_time]} ${micronaut_kafka_producer_jvm[docker_image_size]}
printf "%30s | %14s | %14s | %17s | %17s |\n" "springboot-kafka-producer-jvm" ${springboot_kafka_producer_jvm[packaging_time]} ${springboot_kafka_producer_jvm[jar_size]} ${springboot_kafka_producer_jvm[building_time]} ${springboot_kafka_producer_jvm[docker_image_size]}
printf "%30s + %14s + %14s + %17s + %17s |\n" ".............................." ".............." ".............." "................." "................."
printf "%30s | %14s | %14s | %17s | %17s |\n" "quarkus-kafka-consumer-jvm" ${quarkus_kafka_consumer_jvm[packaging_time]} ${quarkus_kafka_consumer_jvm[jar_size]} ${quarkus_kafka_consumer_jvm[building_time]} ${quarkus_kafka_consumer_jvm[docker_image_size]}
printf "%30s | %14s | %14s | %17s | %17s |\n" "micronaut-kafka-consumer-jvm" ${micronaut_kafka_consumer_jvm[packaging_time]} ${micronaut_kafka_consumer_jvm[jar_size]} ${micronaut_kafka_consumer_jvm[building_time]} ${micronaut_kafka_consumer_jvm[docker_image_size]}
printf "%30s | %14s | %14s | %17s | %17s |\n" "springboot-kafka-consumer-jvm" ${springboot_kafka_consumer_jvm[packaging_time]} ${springboot_kafka_consumer_jvm[jar_size]} ${springboot_kafka_consumer_jvm[building_time]} ${springboot_kafka_consumer_jvm[docker_image_size]}
printf "%30s + %14s + %14s + %17s + %17s |\n" ".............................." ".............." ".............." "................." "................."
printf "%30s | %14s | %14s | %17s | %17s |\n" "quarkus-elasticsearch-jvm" ${quarkus_elasticsearch_jvm[packaging_time]} ${quarkus_elasticsearch_jvm[jar_size]} ${quarkus_elasticsearch_jvm[building_time]} ${quarkus_elasticsearch_jvm[docker_image_size]}
printf "%30s | %14s | %14s | %17s | %17s |\n" "micronaut-elasticsearch-jvm" ${micronaut_elasticsearch_jvm[packaging_time]} ${micronaut_elasticsearch_jvm[jar_size]} ${micronaut_elasticsearch_jvm[building_time]} ${micronaut_elasticsearch_jvm[docker_image_size]}
printf "%30s | %14s | %14s | %17s | %17s |\n" "springboot-elasticsearch-jvm" ${springboot_elasticsearch_jvm[packaging_time]} ${springboot_elasticsearch_jvm[jar_size]} ${springboot_elasticsearch_jvm[building_time]} ${springboot_elasticsearch_jvm[docker_image_size]}

echo
echo "==>  START AT: ${start_time}"
echo "==> FINISH AT: $(date)"
echo
