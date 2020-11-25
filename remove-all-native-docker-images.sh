#!/usr/bin/env bash

docker rmi \
  docker.mycompany.com/quarkus-simple-api-native:1.0.0 \
  docker.mycompany.com/micronaut-simple-api-native:1.0.0 \
  docker.mycompany.com/springboot-simple-api-native:1.0.0 \
  docker.mycompany.com/quarkus-book-api-native:1.0.0 \
  docker.mycompany.com/micronaut-book-api-native:1.0.0 \
  docker.mycompany.com/springboot-book-api-native:1.0.0 \
  docker.mycompany.com/quarkus-producer-api-native:1.0.0 \
  docker.mycompany.com/micronaut-producer-api-native:1.0.0 \
  docker.mycompany.com/quarkus-consumer-api-native:1.0.0 \
  docker.mycompany.com/micronaut-consumer-api-native:1.0.0 \
  docker.mycompany.com/quarkus-elasticsearch-native:1.0.0 \
  docker.mycompany.com/micronaut-elasticsearch-native:1.0.0 \
  docker.mycompany.com/springboot-elasticsearch-native:1.0.0
  