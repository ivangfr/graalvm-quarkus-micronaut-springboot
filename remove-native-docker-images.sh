#!/usr/bin/env bash

source my-functions.sh

check_docker_manager_script_input_parameter $1

if [ "$1" = "quarkus-simple-api" ] ||
   [ "$1" = "quarkus" ] ||
   [ "$1" = "simple-api" ] ||
   [ "$1" = "all" ];
then

  docker rmi docker.mycompany.com/quarkus-simple-api-native:1.0.0

fi

if [ "$1" = "micronaut-simple-api" ] ||
   [ "$1" = "micronaut" ] ||
   [ "$1" = "simple-api" ] ||
   [ "$1" = "all" ];
then

  docker rmi docker.mycompany.com/micronaut-simple-api-native:1.0.0

fi

if [ "$1" = "springboot-simple-api" ] ||
   [ "$1" = "springboot" ] ||
   [ "$1" = "simple-api" ] ||
   [ "$1" = "all" ];
then

  docker rmi docker.mycompany.com/springboot-simple-api-native:1.0.0

fi

if [ "$1" = "quarkus-jpa-mysql" ] ||
   [ "$1" = "quarkus" ] ||
   [ "$1" = "jpa-mysql" ] ||
   [ "$1" = "all" ];
then

  docker rmi docker.mycompany.com/quarkus-jpa-mysql-native:1.0.0

fi

if [ "$1" = "micronaut-jpa-mysql" ] ||
   [ "$1" = "micronaut" ] ||
   [ "$1" = "jpa-mysql" ] ||
   [ "$1" = "all" ];
then

  docker rmi docker.mycompany.com/micronaut-jpa-mysql-native:1.0.0

fi

if [ "$1" = "springboot-jpa-mysql" ] ||
   [ "$1" = "springboot" ] ||
   [ "$1" = "jpa-mysql" ] ||
   [ "$1" = "all" ];
then

  docker rmi docker.mycompany.com/springboot-jpa-mysql-native:1.0.0

fi

if [ "$1" = "quarkus-producer-consumer_producer-api" ] ||
   [ "$1" = "quarkus-producer-consumer" ] ||
   [ "$1" = "quarkus" ] ||
   [ "$1" = "producer-consumer" ] ||
   [ "$1" = "all" ];
then

  docker rmi docker.mycompany.com/quarkus-producer-api-native:1.0.0

fi

if [ "$1" = "quarkus-producer-consumer_consumer-api" ] ||
   [ "$1" = "quarkus-producer-consumer" ] ||
   [ "$1" = "quarkus" ] ||
   [ "$1" = "producer-consumer" ] ||
   [ "$1" = "all" ];
then

  docker rmi docker.mycompany.com/quarkus-consumer-api-native:1.0.0

fi

if [ "$1" = "micronaut-producer-consumer_producer-api" ] ||
   [ "$1" = "micronaut-producer-consumer" ] ||
   [ "$1" = "micronaut" ] ||
   [ "$1" = "producer-consumer" ] ||
   [ "$1" = "all" ];
then

  docker rmi docker.mycompany.com/micronaut-producer-api-native:1.0.0

fi

if [ "$1" = "micronaut-producer-consumer_consumer-api" ] ||
   [ "$1" = "micronaut-producer-consumer" ] ||
   [ "$1" = "micronaut" ] ||
   [ "$1" = "producer-consumer" ] ||
   [ "$1" = "all" ];
then

  docker rmi docker.mycompany.com/micronaut-consumer-api-native:1.0.0

fi

if [ "$1" = "springboot-producer-consumer_producer-api" ] ||
   [ "$1" = "springboot-producer-consumer" ] ||
   [ "$1" = "springboot" ] ||
   [ "$1" = "producer-consumer" ] ||
   [ "$1" = "all" ];
then

  docker rmi docker.mycompany.com/springboot-producer-api-native:1.0.0

fi

if [ "$1" = "springboot-producer-consumer_consumer-api" ] ||
   [ "$1" = "springboot-producer-consumer" ] ||
   [ "$1" = "springboot" ] ||
   [ "$1" = "producer-consumer" ] ||
   [ "$1" = "all" ];
then

  docker rmi docker.mycompany.com/springboot-consumer-api-native:1.0.0

fi

if [ "$1" = "quarkus-elasticsearch" ] ||
   [ "$1" = "quarkus" ] ||
   [ "$1" = "elasticsearch" ] ||
   [ "$1" = "all" ];
then

  docker rmi docker.mycompany.com/quarkus-elasticsearch-native:1.0.0

fi

if [ "$1" = "micronaut-elasticsearch" ] ||
   [ "$1" = "micronaut" ] ||
   [ "$1" = "elasticsearch" ] ||
   [ "$1" = "all" ];
then

  docker rmi docker.mycompany.com/micronaut-elasticsearch-native:1.0.0

fi

if [ "$1" = "springboot-elasticsearch" ] ||
   [ "$1" = "springboot" ] ||
   [ "$1" = "elasticsearch" ] ||
   [ "$1" = "all" ];
then

  docker rmi docker.mycompany.com/springboot-elasticsearch-native:1.0.0

fi