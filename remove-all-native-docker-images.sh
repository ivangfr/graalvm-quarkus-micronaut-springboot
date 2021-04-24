#!/usr/bin/env bash

docker rmi \
  docker.mycompany.com/quarkus-simple-api-native:1.0.0 \
  docker.mycompany.com/micronaut-simple-api-native:1.0.0 \
  docker.mycompany.com/springboot-simple-api-native:1.0.0 \
  docker.mycompany.com/quarkus-jpa-mysql-native:1.0.0 \
  docker.mycompany.com/micronaut-jpa-mysql-native:1.0.0 \
  docker.mycompany.com/springboot-jpa-mysql-native:1.0.0 \
  docker.mycompany.com/quarkus-producer-api-native:1.0.0 \
  docker.mycompany.com/micronaut-producer-api-native:1.0.0 \
  docker.mycompany.com/springboot-producer-api-native:1.0.0 \
  docker.mycompany.com/quarkus-consumer-api-native:1.0.0 \
  docker.mycompany.com/micronaut-consumer-api-native:1.0.0 \
  docker.mycompany.com/springboot-consumer-api-native:1.0.0 \
  docker.mycompany.com/quarkus-elasticsearch-native:1.0.0 \
  docker.mycompany.com/micronaut-elasticsearch-native:1.0.0 \
  docker.mycompany.com/springboot-elasticsearch-native:1.0.0
  