#!/usr/bin/env bash

source my-functions.sh

check_docker_manager_script_input_parameter $1

if [ "$1" = "quarkus-simple-api" ] ||
   [ "$1" = "quarkus" ] ||
   [ "$1" = "simple-api" ] ||
   [ "$1" = "all" ];
then

  docker rmi ivanfranchin/quarkus-simple-api-jvm:1.0.0

fi

if [ "$1" = "micronaut-simple-api" ] ||
   [ "$1" = "micronaut" ] ||
   [ "$1" = "simple-api" ] ||
   [ "$1" = "all" ];
then

  docker rmi ivanfranchin/micronaut-simple-api-jvm:1.0.0

fi

if [ "$1" = "springboot-simple-api" ] ||
   [ "$1" = "springboot" ] ||
   [ "$1" = "simple-api" ] ||
   [ "$1" = "all" ];
then

  docker rmi ivanfranchin/springboot-simple-api-jvm:1.0.0

fi

if [ "$1" = "quarkus-jpa-mysql" ] ||
   [ "$1" = "quarkus" ] ||
   [ "$1" = "jpa-mysql" ] ||
   [ "$1" = "all" ];
then

  docker rmi ivanfranchin/quarkus-jpa-mysql-jvm:1.0.0

fi

if [ "$1" = "micronaut-jpa-mysql" ] ||
   [ "$1" = "micronaut" ] ||
   [ "$1" = "jpa-mysql" ] ||
   [ "$1" = "all" ];
then

  docker rmi ivanfranchin/micronaut-jpa-mysql-jvm:1.0.0

fi

if [ "$1" = "springboot-jpa-mysql" ] ||
   [ "$1" = "springboot" ] ||
   [ "$1" = "jpa-mysql" ] ||
   [ "$1" = "all" ];
then

  docker rmi ivanfranchin/springboot-jpa-mysql-jvm:1.0.0

fi

if [ "$1" = "quarkus-producer-consumer_producer-api" ] ||
   [ "$1" = "quarkus-producer-consumer" ] ||
   [ "$1" = "quarkus" ] ||
   [ "$1" = "producer-consumer" ] ||
   [ "$1" = "all" ];
then

  docker rmi ivanfranchin/quarkus-producer-api-jvm:1.0.0

fi

if [ "$1" = "quarkus-producer-consumer_consumer-api" ] ||
   [ "$1" = "quarkus-producer-consumer" ] ||
   [ "$1" = "quarkus" ] ||
   [ "$1" = "producer-consumer" ] ||
   [ "$1" = "all" ];
then

  docker rmi ivanfranchin/quarkus-consumer-api-jvm:1.0.0

fi

if [ "$1" = "micronaut-producer-consumer_producer-api" ] ||
   [ "$1" = "micronaut-producer-consumer" ] ||
   [ "$1" = "micronaut" ] ||
   [ "$1" = "producer-consumer" ] ||
   [ "$1" = "all" ];
then

  docker rmi ivanfranchin/micronaut-producer-api-jvm:1.0.0

fi

if [ "$1" = "micronaut-producer-consumer_consumer-api" ] ||
   [ "$1" = "micronaut-producer-consumer" ] ||
   [ "$1" = "micronaut" ] ||
   [ "$1" = "producer-consumer" ] ||
   [ "$1" = "all" ];
then

  docker rmi ivanfranchin/micronaut-consumer-api-jvm:1.0.0

fi

if [ "$1" = "springboot-producer-consumer_producer-api" ] ||
   [ "$1" = "springboot-producer-consumer" ] ||
   [ "$1" = "springboot" ] ||
   [ "$1" = "producer-consumer" ] ||
   [ "$1" = "all" ];
then

  docker rmi ivanfranchin/springboot-producer-api-jvm:1.0.0

fi

if [ "$1" = "springboot-producer-consumer_consumer-api" ] ||
   [ "$1" = "springboot-producer-consumer" ] ||
   [ "$1" = "springboot" ] ||
   [ "$1" = "producer-consumer" ] ||
   [ "$1" = "all" ];
then

  docker rmi ivanfranchin/springboot-consumer-api-jvm:1.0.0

fi

if [ "$1" = "quarkus-elasticsearch" ] ||
   [ "$1" = "quarkus" ] ||
   [ "$1" = "elasticsearch" ] ||
   [ "$1" = "all" ];
then

  docker rmi ivanfranchin/quarkus-elasticsearch-jvm:1.0.0

fi

if [ "$1" = "micronaut-elasticsearch" ] ||
   [ "$1" = "micronaut" ] ||
   [ "$1" = "elasticsearch" ] ||
   [ "$1" = "all" ];
then

  docker rmi ivanfranchin/micronaut-elasticsearch-jvm:1.0.0

fi

if [ "$1" = "springboot-elasticsearch" ] ||
   [ "$1" = "springboot" ] ||
   [ "$1" = "elasticsearch" ] ||
   [ "$1" = "all" ];
then

  docker rmi ivanfranchin/springboot-elasticsearch-jvm:1.0.0

fi