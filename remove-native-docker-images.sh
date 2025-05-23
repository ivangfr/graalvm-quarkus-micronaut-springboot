#!/usr/bin/env bash

source my-functions.sh

check_script_input_parameter $1

QUARKUS_VERSION=latest
MICRONAUT_VERSION=latest
SPRING_BOOT_VERSION=latest

if [ "$1" = "quarkus-simple-api" ] ||
   [ "$1" = "quarkus" ] ||
   [ "$1" = "simple-api" ] ||
   [ "$1" = "all" ];
then

  podman rmi ivanfranchin/quarkus-simple-api-native:$QUARKUS_VERSION

fi

if [ "$1" = "micronaut-simple-api" ] ||
   [ "$1" = "micronaut" ] ||
   [ "$1" = "simple-api" ] ||
   [ "$1" = "all" ];
then

  podman rmi ivanfranchin/micronaut-simple-api-native:$MICRONAUT_VERSION

fi

if [ "$1" = "springboot-simple-api" ] ||
   [ "$1" = "springboot" ] ||
   [ "$1" = "simple-api" ] ||
   [ "$1" = "all" ];
then

  podman rmi ivanfranchin/springboot-simple-api-native:$SPRING_BOOT_VERSION

fi

if [ "$1" = "quarkus-jpa-mysql" ] ||
   [ "$1" = "quarkus" ] ||
   [ "$1" = "jpa-mysql" ] ||
   [ "$1" = "all" ];
then

  podman rmi ivanfranchin/quarkus-jpa-mysql-native:$QUARKUS_VERSION

fi

if [ "$1" = "micronaut-jpa-mysql" ] ||
   [ "$1" = "micronaut" ] ||
   [ "$1" = "jpa-mysql" ] ||
   [ "$1" = "all" ];
then

  podman rmi ivanfranchin/micronaut-jpa-mysql-native:$MICRONAUT_VERSION

fi

if [ "$1" = "springboot-jpa-mysql" ] ||
   [ "$1" = "springboot" ] ||
   [ "$1" = "jpa-mysql" ] ||
   [ "$1" = "all" ];
then

  podman rmi ivanfranchin/springboot-jpa-mysql-native:$SPRING_BOOT_VERSION

fi

if [ "$1" = "quarkus-kafka-producer" ] ||
   [ "$1" = "quarkus-kafka" ] ||
   [ "$1" = "quarkus" ] ||
   [ "$1" = "kafka" ] ||
   [ "$1" = "all" ];
then

  podman rmi ivanfranchin/quarkus-kafka-producer-native:$QUARKUS_VERSION

fi

if [ "$1" = "quarkus-kafka-consumer" ] ||
   [ "$1" = "quarkus-kafka" ] ||
   [ "$1" = "quarkus" ] ||
   [ "$1" = "kafka" ] ||
   [ "$1" = "all" ];
then

  podman rmi ivanfranchin/quarkus-kafka-consumer-native:$QUARKUS_VERSION

fi

if [ "$1" = "micronaut-kafka-producer" ] ||
   [ "$1" = "micronaut-kafka" ] ||
   [ "$1" = "micronaut" ] ||
   [ "$1" = "kafka" ] ||
   [ "$1" = "all" ];
then

  podman rmi ivanfranchin/micronaut-kafka-producer-native:$MICRONAUT_VERSION

fi

if [ "$1" = "micronaut-kafka-consumer" ] ||
   [ "$1" = "micronaut-kafka" ] ||
   [ "$1" = "micronaut" ] ||
   [ "$1" = "kafka" ] ||
   [ "$1" = "all" ];
then

  podman rmi ivanfranchin/micronaut-kafka-consumer-native:$MICRONAUT_VERSION

fi

if [ "$1" = "springboot-kafka-producer" ] ||
   [ "$1" = "springboot-kafka" ] ||
   [ "$1" = "springboot" ] ||
   [ "$1" = "kafka" ] ||
   [ "$1" = "all" ];
then

  podman rmi ivanfranchin/springboot-kafka-producer-native:$SPRING_BOOT_VERSION

fi

if [ "$1" = "springboot-kafka-consumer" ] ||
   [ "$1" = "springboot-kafka" ] ||
   [ "$1" = "springboot" ] ||
   [ "$1" = "kafka" ] ||
   [ "$1" = "all" ];
then

  podman rmi ivanfranchin/springboot-kafka-consumer-native:$SPRING_BOOT_VERSION

fi

if [ "$1" = "quarkus-elasticsearch" ] ||
   [ "$1" = "quarkus" ] ||
   [ "$1" = "elasticsearch" ] ||
   [ "$1" = "all" ];
then

  podman rmi ivanfranchin/quarkus-elasticsearch-native:$QUARKUS_VERSION

fi

if [ "$1" = "micronaut-elasticsearch" ] ||
   [ "$1" = "micronaut" ] ||
   [ "$1" = "elasticsearch" ] ||
   [ "$1" = "all" ];
then

  podman rmi ivanfranchin/micronaut-elasticsearch-native:$MICRONAUT_VERSION

fi

if [ "$1" = "springboot-elasticsearch" ] ||
   [ "$1" = "springboot" ] ||
   [ "$1" = "elasticsearch" ] ||
   [ "$1" = "all" ];
then

  podman rmi ivanfranchin/springboot-elasticsearch-native:$SPRING_BOOT_VERSION

fi