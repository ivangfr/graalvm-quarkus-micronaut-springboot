#!/usr/bin/env bash

source my-functions.sh

check_script_input_parameter $1

declare -A quarkus_simple_api_native
declare -A micronaut_simple_api_native
declare -A springboot_simple_api_native

declare -A quarkus_jpa_mysql_native
declare -A micronaut_jpa_mysql_native
declare -A springboot_jpa_mysql_native

declare -A quarkus_kafka_producer_native
declare -A quarkus_kafka_consumer_native
declare -A micronaut_kafka_producer_native
declare -A micronaut_kafka_consumer_native
declare -A springboot_kafka_producer_native
declare -A springboot_kafka_consumer_native

declare -A quarkus_elasticsearch_native
declare -A micronaut_elasticsearch_native
declare -A springboot_elasticsearch_native

start_time=$(date)

if [ "$1" = "quarkus-simple-api" ] ||
   [ "$1" = "quarkus" ] ||
   [ "$1" = "simple-api" ] ||
   [ "$1" = "all" ];
then

  echo
  echo "-------------------------"
  echo "QUARKUS-SIMPLE-API-NATIVE"
  echo "-------------------------"

  cd simple-api/quarkus-simple-api

  package_jar_build_image \
    "./mvnw clean" \
    "./mvnw package -Pnative -Dquarkus.native.container-build=true" \
    "target/quarkus-simple-api-1.0.0-runner" \
    "./build-docker-images.sh native" \
    "ivanfranchin/quarkus-simple-api-native:latest"
  quarkus_simple_api_native[packaging_time]=$package_jar_build_image_packaging_time
  quarkus_simple_api_native[jar_size]=$package_jar_build_image_jar_size
  quarkus_simple_api_native[building_time]=$package_jar_build_image_building_time
  quarkus_simple_api_native[docker_image_size]=$package_jar_build_image_docker_image_size

  cd ../..

fi

if [ "$1" = "micronaut-simple-api" ] ||
   [ "$1" = "micronaut" ] ||
   [ "$1" = "simple-api" ] ||
   [ "$1" = "all" ];
then

  echo
  echo "---------------------------"
  echo "MICRONAUT-SIMPLE-API-NATIVE"
  echo "---------------------------"

  cd simple-api/micronaut-simple-api

  package_jar_build_image \
    "./mvnw clean" \
    "./mvnw package" \
    "target/micronaut-simple-api-1.0.0.jar" \
    "./build-docker-images.sh native" \
    "ivanfranchin/micronaut-simple-api-native:latest"
  micronaut_simple_api_native[packaging_time]=$package_jar_build_image_packaging_time
  micronaut_simple_api_native[jar_size]=$package_jar_build_image_jar_size
  micronaut_simple_api_native[building_time]=$package_jar_build_image_building_time
  micronaut_simple_api_native[docker_image_size]=$package_jar_build_image_docker_image_size

  cd ../..

fi

if [ "$1" = "springboot-simple-api" ] ||
   [ "$1" = "springboot" ] ||
   [ "$1" = "simple-api" ] ||
   [ "$1" = "all" ];
then

  echo
  echo "----------------------------"
  echo "SPRINGBOOT-SIMPLE-API-NATIVE"
  echo "----------------------------"

  cd simple-api/springboot-simple-api

  package_jar_build_image \
    "./mvnw clean" \
    "./mvnw package" \
    "target/springboot-simple-api-1.0.0.jar" \
    "./build-docker-images.sh native" \
    "ivanfranchin/springboot-simple-api-native:latest"
  springboot_simple_api_native[packaging_time]=$package_jar_build_image_packaging_time
  springboot_simple_api_native[jar_size]=$package_jar_build_image_jar_size
  springboot_simple_api_native[building_time]=$package_jar_build_image_building_time
  springboot_simple_api_native[docker_image_size]=$package_jar_build_image_docker_image_size

  cd ../..

fi

if [ "$1" = "quarkus-jpa-mysql" ] ||
   [ "$1" = "quarkus" ] ||
   [ "$1" = "jpa-mysql" ] ||
   [ "$1" = "all" ];
then

  echo
  echo "------------------------"
  echo "QUARKUS-JPA-MYSQL-NATIVE"
  echo "------------------------"

  cd jpa-mysql/quarkus-jpa-mysql

  package_jar_build_image \
    "./mvnw clean" \
    "./mvnw package -Pnative -Dquarkus.native.container-build=true" \
    "target/quarkus-jpa-mysql-1.0.0-runner" \
    "./build-docker-images.sh native" \
    "ivanfranchin/quarkus-jpa-mysql-native:latest"
  quarkus_jpa_mysql_native[packaging_time]=$package_jar_build_image_packaging_time
  quarkus_jpa_mysql_native[jar_size]=$package_jar_build_image_jar_size
  quarkus_jpa_mysql_native[building_time]=$package_jar_build_image_building_time
  quarkus_jpa_mysql_native[docker_image_size]=$package_jar_build_image_docker_image_size

  cd ../..

fi

if [ "$1" = "micronaut-jpa-mysql" ] ||
   [ "$1" = "micronaut" ] ||
   [ "$1" = "jpa-mysql" ] ||
   [ "$1" = "all" ];
then

  echo
  echo "--------------------------"
  echo "MICRONAUT-JPA-MYSQL-NATIVE"
  echo "--------------------------"

  cd jpa-mysql/micronaut-jpa-mysql

  package_jar_build_image \
    "./mvnw clean" \
    "./mvnw package" \
    "target/micronaut-jpa-mysql-1.0.0.jar" \
    "./build-docker-images.sh native" \
    "ivanfranchin/micronaut-jpa-mysql-native:latest"
  micronaut_jpa_mysql_native[packaging_time]=$package_jar_build_image_packaging_time
  micronaut_jpa_mysql_native[jar_size]=$package_jar_build_image_jar_size
  micronaut_jpa_mysql_native[building_time]=$package_jar_build_image_building_time
  micronaut_jpa_mysql_native[docker_image_size]=$package_jar_build_image_docker_image_size

  cd ../..

fi

if [ "$1" = "springboot-jpa-mysql" ] ||
   [ "$1" = "springboot" ] ||
   [ "$1" = "jpa-mysql" ] ||
   [ "$1" = "all" ];
then

  echo
  echo "---------------------------"
  echo "SPRINGBOOT-JPA-MYSQL-NATIVE"
  echo "---------------------------"

  cd jpa-mysql/springboot-jpa-mysql

  package_jar_build_image \
    "./mvnw clean" \
    "./mvnw package" \
    "target/springboot-jpa-mysql-1.0.0.jar" \
    "./build-docker-images.sh native" \
    "ivanfranchin/springboot-jpa-mysql-native:latest"
  springboot_jpa_mysql_native[packaging_time]=$package_jar_build_image_packaging_time
  springboot_jpa_mysql_native[jar_size]=$package_jar_build_image_jar_size
  springboot_jpa_mysql_native[building_time]=$package_jar_build_image_building_time
  springboot_jpa_mysql_native[docker_image_size]=$package_jar_build_image_docker_image_size

  cd ../..

fi

if [ "$1" = "quarkus-kafka-producer" ] ||
   [ "$1" = "quarkus-kafka" ] ||
   [ "$1" = "quarkus" ] ||
   [ "$1" = "kafka" ] ||
   [ "$1" = "all" ];
then

  echo
  echo "-------------------------------------"
  echo "QUARKUS-KAFKA / KAFKA-PRODUCER-NATIVE"
  echo "-------------------------------------"

  cd kafka/quarkus-kafka

  package_jar_build_image \
    "./mvnw clean --projects kafka-producer" \
    "./mvnw package -Pnative -Dquarkus.native.container-build=true --projects kafka-producer" \
    "kafka-producer/target/kafka-producer-1.0.0-runner" \
    "cd kafka-producer && ./build-docker-images.sh native && cd .." \
    "ivanfranchin/quarkus-kafka-producer-native:latest"
  quarkus_kafka_producer_native[packaging_time]=$package_jar_build_image_packaging_time
  quarkus_kafka_producer_native[jar_size]=$package_jar_build_image_jar_size
  quarkus_kafka_producer_native[building_time]=$package_jar_build_image_building_time
  quarkus_kafka_producer_native[docker_image_size]=$package_jar_build_image_docker_image_size

  cd ../..

fi

if [ "$1" = "quarkus-kafka-consumer" ] ||
   [ "$1" = "quarkus-kafka" ] ||
   [ "$1" = "quarkus" ] ||
   [ "$1" = "kafka" ] ||
   [ "$1" = "all" ];
then

  echo
  echo "-------------------------------------"
  echo "QUARKUS-KAFKA / KAFKA-CONSUMER-NATIVE"
  echo "-------------------------------------"

  cd kafka/quarkus-kafka

  package_jar_build_image \
    "./mvnw clean --projects kafka-consumer" \
    "./mvnw package -Pnative -Dquarkus.native.container-build=true --projects kafka-consumer" \
    "kafka-consumer/target/kafka-consumer-1.0.0-runner" \
    "cd kafka-consumer && ./build-docker-images.sh native && cd .." \
    "ivanfranchin/quarkus-kafka-consumer-native:latest"
  quarkus_kafka_consumer_native[packaging_time]=$package_jar_build_image_packaging_time
  quarkus_kafka_consumer_native[jar_size]=$package_jar_build_image_jar_size
  quarkus_kafka_consumer_native[building_time]=$package_jar_build_image_building_time
  quarkus_kafka_consumer_native[docker_image_size]=$package_jar_build_image_docker_image_size

  cd ../..

fi

if [ "$1" = "micronaut-kafka-producer" ] ||
   [ "$1" = "micronaut-kafka" ] ||
   [ "$1" = "micronaut" ] ||
   [ "$1" = "kafka" ] ||
   [ "$1" = "all" ];
then

  echo
  echo "---------------------------------------"
  echo "MICRONAUT-KAFKA / KAFKA-PRODUCER-NATIVE"
  echo "---------------------------------------"

  cd kafka/micronaut-kafka

  package_jar_build_image \
    "./mvnw clean --projects kafka-producer" \
    "./mvnw package --projects kafka-producer" \
    "kafka-producer/target/kafka-producer-1.0.0.jar" \
    "cd kafka-producer && ./build-docker-images.sh native && cd .." \
    "ivanfranchin/micronaut-kafka-producer-native:latest"
  micronaut_kafka_producer_native[packaging_time]=$package_jar_build_image_packaging_time
  micronaut_kafka_producer_native[jar_size]=$package_jar_build_image_jar_size
  micronaut_kafka_producer_native[building_time]=$package_jar_build_image_building_time
  micronaut_kafka_producer_native[docker_image_size]=$package_jar_build_image_docker_image_size

  cd ../..

fi

if [ "$1" = "micronaut-kafka-consumer" ] ||
   [ "$1" = "micronaut-kafka" ] ||
   [ "$1" = "micronaut" ] ||
   [ "$1" = "kafka" ] ||
   [ "$1" = "all" ];
then

  echo
  echo "---------------------------------------"
  echo "MICRONAUT-KAFKA / KAFKA-CONSUMER-NATIVE"
  echo "---------------------------------------"

  cd kafka/micronaut-kafka

  package_jar_build_image \
    "./mvnw clean --projects kafka-consumer" \
    "./mvnw package --projects kafka-consumer" \
    "kafka-consumer/target/kafka-consumer-1.0.0.jar" \
    "cd kafka-consumer && ./build-docker-images.sh native && cd .." \
    "ivanfranchin/micronaut-kafka-consumer-native:latest"
  micronaut_kafka_consumer_native[packaging_time]=$package_jar_build_image_packaging_time
  micronaut_kafka_consumer_native[jar_size]=$package_jar_build_image_jar_size
  micronaut_kafka_consumer_native[building_time]=$package_jar_build_image_building_time
  micronaut_kafka_consumer_native[docker_image_size]=$package_jar_build_image_docker_image_size

  cd ../..

fi

if [ "$1" = "springboot-kafka-producer" ] ||
   [ "$1" = "springboot-kafka" ] ||
   [ "$1" = "springboot" ] ||
   [ "$1" = "kafka" ] ||
   [ "$1" = "all" ];
then

  echo
  echo "----------------------------------------"
  echo "SPRINGBOOT-KAFKA / KAFKA-PRODUCER-NATIVE"
  echo "----------------------------------------"

  cd kafka/springboot-kafka

  package_jar_build_image \
    "./mvnw clean --projects kafka-producer" \
    "./mvnw package --projects kafka-producer" \
    "kafka-producer/target/kafka-producer-1.0.0.jar" \
    "cd kafka-producer && ./build-docker-images.sh native && cd .." \
    "ivanfranchin/springboot-kafka-producer-native:latest"
  springboot_kafka_producer_native[packaging_time]=$package_jar_build_image_packaging_time
  springboot_kafka_producer_native[jar_size]=$package_jar_build_image_jar_size
  springboot_kafka_producer_native[building_time]=$package_jar_build_image_building_time
  springboot_kafka_producer_native[docker_image_size]=$package_jar_build_image_docker_image_size

  cd ../..

fi

if [ "$1" = "springboot-kafka-consumer" ] ||
   [ "$1" = "springboot-kafka" ] ||
   [ "$1" = "springboot" ] ||
   [ "$1" = "kafka" ] ||
   [ "$1" = "all" ];
then

  echo
  echo "----------------------------------------"
  echo "SPRINGBOOT-KAFKA / KAFKA-CONSUMER-NATIVE"
  echo "----------------------------------------"

  cd kafka/springboot-kafka

  package_jar_build_image \
    "./mvnw clean --projects kafka-consumer" \
    "./mvnw package --projects kafka-consumer" \
    "kafka-consumer/target/kafka-consumer-1.0.0.jar" \
    "cd kafka-consumer && ./build-docker-images.sh native && cd .." \
    "ivanfranchin/springboot-kafka-consumer-native:latest"
  springboot_kafka_consumer_native[packaging_time]=$package_jar_build_image_packaging_time
  springboot_kafka_consumer_native[jar_size]=$package_jar_build_image_jar_size
  springboot_kafka_consumer_native[building_time]=$package_jar_build_image_building_time
  springboot_kafka_consumer_native[docker_image_size]=$package_jar_build_image_docker_image_size

  cd ../..

fi

if [ "$1" = "quarkus-elasticsearch" ] ||
   [ "$1" = "quarkus" ] ||
   [ "$1" = "elasticsearch" ] ||
   [ "$1" = "all" ];
then

  echo
  echo "----------------------------"
  echo "QUARKUS-ELASTICSEARCH-NATIVE"
  echo "----------------------------"

  cd elasticsearch/quarkus-elasticsearch

  package_jar_build_image \
    "./mvnw clean" \
    "./mvnw package -Pnative -Dquarkus.native.container-build=true" \
    "target/quarkus-elasticsearch-1.0.0-runner" \
    "./build-docker-images.sh native" \
    "ivanfranchin/quarkus-elasticsearch-native:latest"
  quarkus_elasticsearch_native[packaging_time]=$package_jar_build_image_packaging_time
  quarkus_elasticsearch_native[jar_size]=$package_jar_build_image_jar_size
  quarkus_elasticsearch_native[building_time]=$package_jar_build_image_building_time
  quarkus_elasticsearch_native[docker_image_size]=$package_jar_build_image_docker_image_size

  cd ../..

fi

if [ "$1" = "micronaut-elasticsearch" ] ||
   [ "$1" = "micronaut" ] ||
   [ "$1" = "elasticsearch" ] ||
   [ "$1" = "all" ];
then

  echo
  echo "------------------------------"
  echo "MICRONAUT-ELASTICSEARCH-NATIVE"
  echo "------------------------------"

  cd elasticsearch/micronaut-elasticsearch

  package_jar_build_image \
    "./mvnw clean" \
    "./mvnw package" \
    "target/micronaut-elasticsearch-1.0.0.jar" \
    "./build-docker-images.sh native" \
    "ivanfranchin/micronaut-elasticsearch-native:latest"
  micronaut_elasticsearch_native[packaging_time]=$package_jar_build_image_packaging_time
  micronaut_elasticsearch_native[jar_size]=$package_jar_build_image_jar_size
  micronaut_elasticsearch_native[building_time]=$package_jar_build_image_building_time
  micronaut_elasticsearch_native[docker_image_size]=$package_jar_build_image_docker_image_size

  cd ../..

fi

if [ "$1" = "springboot-elasticsearch" ] ||
   [ "$1" = "springboot" ] ||
   [ "$1" = "elasticsearch" ] ||
   [ "$1" = "all" ];
then

  echo
  echo "-------------------------------"
  echo "SPRINGBOOT-ELASTICSEARCH-NATIVE"
  echo "-------------------------------"

  cd elasticsearch/springboot-elasticsearch

  package_jar_build_image \
    "./mvnw clean" \
    "./mvnw package" \
    "target/springboot-elasticsearch-1.0.0.jar" \
    "./build-docker-images.sh native" \
    "ivanfranchin/springboot-elasticsearch-native:latest"
  springboot_elasticsearch_native[packaging_time]=$package_jar_build_image_packaging_time
  springboot_elasticsearch_native[jar_size]=$package_jar_build_image_jar_size
  springboot_elasticsearch_native[building_time]=$package_jar_build_image_building_time
  springboot_elasticsearch_native[docker_image_size]=$package_jar_build_image_docker_image_size

  cd ../..

fi

printf "\n"
printf "%32s | %14s | %14s | %16s | %10s |\n" "Application" "Packaging Time" "Packaging Size" "Image Build Time" "Image Size"
printf "%32s + %14s + %14s + %16s + %10s |\n" "--------------------------------" "--------------" "--------------" "----------------" "----------"
printf "%32s | %14s | %14s | %16s | %10s |\n" "quarkus-simple-api-native" ${quarkus_simple_api_native[packaging_time]} ${quarkus_simple_api_native[jar_size]} ${quarkus_simple_api_native[building_time]} ${quarkus_simple_api_native[docker_image_size]}
printf "%32s | %14s | %14s | %16s | %10s |\n" "micronaut-simple-api-native" ${micronaut_simple_api_native[packaging_time]} ${micronaut_simple_api_native[jar_size]} ${micronaut_simple_api_native[building_time]} ${micronaut_simple_api_native[docker_image_size]}
printf "%32s | %14s | %14s | %16s | %10s |\n" "springboot-simple-api-native" ${springboot_simple_api_native[packaging_time]} ${springboot_simple_api_native[jar_size]} ${springboot_simple_api_native[building_time]} ${springboot_simple_api_native[docker_image_size]}
printf "%32s + %14s + %14s + %16s + %10s |\n" "................................" ".............." ".............." "................" ".........."
printf "%32s | %14s | %14s | %16s | %10s |\n" "quarkus-jpa-mysql-native" ${quarkus_jpa_mysql_native[packaging_time]} ${quarkus_jpa_mysql_native[jar_size]} ${quarkus_jpa_mysql_native[building_time]} ${quarkus_jpa_mysql_native[docker_image_size]}
printf "%32s | %14s | %14s | %16s | %10s |\n" "micronaut-jpa-mysql-native" ${micronaut_jpa_mysql_native[packaging_time]} ${micronaut_jpa_mysql_native[jar_size]} ${micronaut_jpa_mysql_native[building_time]} ${micronaut_jpa_mysql_native[docker_image_size]}
printf "%32s | %14s | %14s | %16s | %10s |\n" "springboot-jpa-mysql-native" ${springboot_jpa_mysql_native[packaging_time]} ${springboot_jpa_mysql_native[jar_size]} ${springboot_jpa_mysql_native[building_time]} ${springboot_jpa_mysql_native[docker_image_size]}
printf "%32s + %14s + %14s + %16s + %10s |\n" "................................" ".............." ".............." "................" ".........."
printf "%32s | %14s | %14s | %16s | %10s |\n" "quarkus-kafka-producer-native" ${quarkus_kafka_producer_native[packaging_time]} ${quarkus_kafka_producer_native[jar_size]} ${quarkus_kafka_producer_native[building_time]} ${quarkus_kafka_producer_native[docker_image_size]}
printf "%32s | %14s | %14s | %16s | %10s |\n" "micronaut-kafka-producer-native" ${micronaut_kafka_producer_native[packaging_time]} ${micronaut_kafka_producer_native[jar_size]} ${micronaut_kafka_producer_native[building_time]} ${micronaut_kafka_producer_native[docker_image_size]}
printf "%32s | %14s | %14s | %16s | %10s |\n" "springboot-kafka-producer-native" ${springboot_kafka_producer_native[packaging_time]} ${springboot_kafka_producer_native[jar_size]} ${springboot_kafka_producer_native[building_time]} ${springboot_kafka_producer_native[docker_image_size]}
printf "%32s + %14s + %14s + %16s + %10s |\n" "................................" ".............." ".............." "................." ".........."
printf "%32s | %14s | %14s | %16s | %10s |\n" "quarkus-kafka-consumer-native" ${quarkus_kafka_consumer_native[packaging_time]} ${quarkus_kafka_consumer_native[jar_size]} ${quarkus_kafka_consumer_native[building_time]} ${quarkus_kafka_consumer_native[docker_image_size]}
printf "%32s | %14s | %14s | %16s | %10s |\n" "micronaut-kafka-consumer-native" ${micronaut_kafka_consumer_native[packaging_time]} ${micronaut_kafka_consumer_native[jar_size]} ${micronaut_kafka_consumer_native[building_time]} ${micronaut_kafka_consumer_native[docker_image_size]}
printf "%32s | %14s | %14s | %16s | %10s |\n" "springboot-kafka-consumer-native" ${springboot_kafka_consumer_native[packaging_time]} ${springboot_kafka_consumer_native[jar_size]} ${springboot_kafka_consumer_native[building_time]} ${springboot_kafka_consumer_native[docker_image_size]}
printf "%32s + %14s + %14s + %16s + %10s |\n" "................................" ".............." ".............." "................" ".........."
printf "%32s | %14s | %14s | %16s | %10s |\n" "quarkus-elasticsearch-native" ${quarkus_elasticsearch_native[packaging_time]} ${quarkus_elasticsearch_native[jar_size]} ${quarkus_elasticsearch_native[building_time]} ${quarkus_elasticsearch_native[docker_image_size]}
printf "%32s | %14s | %14s | %16s | %10s |\n" "micronaut-elasticsearch-native" ${micronaut_elasticsearch_native[packaging_time]} ${micronaut_elasticsearch_native[jar_size]} ${micronaut_elasticsearch_native[building_time]} ${micronaut_elasticsearch_native[docker_image_size]}
printf "%32s | %14s | %14s | %16s | %10s |\n" "springboot-elasticsearch-native" ${springboot_elasticsearch_native[packaging_time]} ${springboot_elasticsearch_native[jar_size]} ${springboot_elasticsearch_native[building_time]} ${springboot_elasticsearch_native[docker_image_size]}

echo
echo "==>  START AT: ${start_time}"
echo "==> FINISH AT: $(date)"
echo
