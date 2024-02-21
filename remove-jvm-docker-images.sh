#!/usr/bin/env bash

source my-functions.sh

check_docker_manager_script_input_parameter $1

QUARKUS_VERSION=latest
MICRONAUT_VERSION=latest
SPRING_BOOT_VERSION=latest

if [ "$1" = "quarkus-simple-api" ] ||
   [ "$1" = "quarkus" ] ||
   [ "$1" = "simple-api" ] ||
   [ "$1" = "all" ];
then

  docker rmi ivanfranchin/quarkus-simple-api-jvm:$QUARKUS_VERSION

fi

if [ "$1" = "micronaut-simple-api" ] ||
   [ "$1" = "micronaut" ] ||
   [ "$1" = "simple-api" ] ||
   [ "$1" = "all" ];
then

  docker rmi ivanfranchin/micronaut-simple-api-jvm:$MICRONAUT_VERSION

fi

if [ "$1" = "springboot-simple-api" ] ||
   [ "$1" = "springboot" ] ||
   [ "$1" = "simple-api" ] ||
   [ "$1" = "all" ];
then

  docker rmi ivanfranchin/springboot-simple-api-jvm:$SPRING_BOOT_VERSION

fi

if [ "$1" = "quarkus-jpa-mysql" ] ||
   [ "$1" = "quarkus" ] ||
   [ "$1" = "jpa-mysql" ] ||
   [ "$1" = "all" ];
then

  docker rmi ivanfranchin/quarkus-jpa-mysql-jvm:$QUARKUS_VERSION

fi

if [ "$1" = "micronaut-jpa-mysql" ] ||
   [ "$1" = "micronaut" ] ||
   [ "$1" = "jpa-mysql" ] ||
   [ "$1" = "all" ];
then

  docker rmi ivanfranchin/micronaut-jpa-mysql-jvm:$MICRONAUT_VERSION

fi

if [ "$1" = "springboot-jpa-mysql" ] ||
   [ "$1" = "springboot" ] ||
   [ "$1" = "jpa-mysql" ] ||
   [ "$1" = "all" ];
then

  docker rmi ivanfranchin/springboot-jpa-mysql-jvm:$SPRING_BOOT_VERSION

fi

if [ "$1" = "quarkus-kafka-producer" ] ||
   [ "$1" = "quarkus-kafka" ] ||
   [ "$1" = "quarkus" ] ||
   [ "$1" = "kafka" ] ||
   [ "$1" = "all" ];
then

  docker rmi ivanfranchin/quarkus-kafka-producer-jvm:$QUARKUS_VERSION

fi

if [ "$1" = "quarkus-kafka-consumer" ] ||
   [ "$1" = "quarkus-kafka" ] ||
   [ "$1" = "quarkus" ] ||
   [ "$1" = "kafka" ] ||
   [ "$1" = "all" ];
then

  docker rmi ivanfranchin/quarkus-kafka-consumer-jvm:$QUARKUS_VERSION

fi

if [ "$1" = "micronaut-kafka-producer" ] ||
   [ "$1" = "micronaut-kafka" ] ||
   [ "$1" = "micronaut" ] ||
   [ "$1" = "kafka" ] ||
   [ "$1" = "all" ];
then

  docker rmi ivanfranchin/micronaut-kafka-producer-jvm:$MICRONAUT_VERSION

fi

if [ "$1" = "micronaut-kafka-consumer" ] ||
   [ "$1" = "micronaut-kafka" ] ||
   [ "$1" = "micronaut" ] ||
   [ "$1" = "kafka" ] ||
   [ "$1" = "all" ];
then

  docker rmi ivanfranchin/micronaut-kafka-consumer-jvm:$MICRONAUT_VERSION

fi

if [ "$1" = "springboot-kafka-producer" ] ||
   [ "$1" = "springboot-kafka" ] ||
   [ "$1" = "springboot" ] ||
   [ "$1" = "kafka" ] ||
   [ "$1" = "all" ];
then

  docker rmi ivanfranchin/springboot-kafka-producer-jvm:$SPRING_BOOT_VERSION

fi

if [ "$1" = "springboot-kafka-consumer" ] ||
   [ "$1" = "springboot-kafka" ] ||
   [ "$1" = "springboot" ] ||
   [ "$1" = "kafka" ] ||
   [ "$1" = "all" ];
then

  docker rmi ivanfranchin/springboot-kafka-consumer-jvm:$SPRING_BOOT_VERSION

fi

if [ "$1" = "quarkus-elasticsearch" ] ||
   [ "$1" = "quarkus" ] ||
   [ "$1" = "elasticsearch" ] ||
   [ "$1" = "all" ];
then

  docker rmi ivanfranchin/quarkus-elasticsearch-jvm:$QUARKUS_VERSION

fi

if [ "$1" = "micronaut-elasticsearch" ] ||
   [ "$1" = "micronaut" ] ||
   [ "$1" = "elasticsearch" ] ||
   [ "$1" = "all" ];
then

  docker rmi ivanfranchin/micronaut-elasticsearch-jvm:$MICRONAUT_VERSION

fi

if [ "$1" = "springboot-elasticsearch" ] ||
   [ "$1" = "springboot" ] ||
   [ "$1" = "elasticsearch" ] ||
   [ "$1" = "all" ];
then

  docker rmi ivanfranchin/springboot-elasticsearch-jvm:$SPRING_BOOT_VERSION

fi