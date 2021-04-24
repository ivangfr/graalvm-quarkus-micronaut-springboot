#!/usr/bin/env bash

docker rmi \
  docker.mycompany.com/quarkus-simple-api-jvm:1.0.0 \
  docker.mycompany.com/micronaut-simple-api-jvm:1.0.0 \
  docker.mycompany.com/springboot-simple-api-jvm:1.0.0 \
  docker.mycompany.com/quarkus-jpa-mysql-jvm:1.0.0 \
  docker.mycompany.com/micronaut-jpa-mysql-jvm:1.0.0 \
  docker.mycompany.com/springboot-jpa-mysql-jvm:1.0.0 \
  docker.mycompany.com/quarkus-producer-api-jvm:1.0.0 \
  docker.mycompany.com/micronaut-producer-api-jvm:1.0.0 \
  docker.mycompany.com/quarkus-consumer-api-jvm:1.0.0 \
  docker.mycompany.com/micronaut-consumer-api-jvm:1.0.0 \
  docker.mycompany.com/springboot-producer-api-jvm:1.0.0 \
  docker.mycompany.com/springboot-consumer-api-jvm:1.0.0 \
  docker.mycompany.com/quarkus-elasticsearch-jvm:1.0.0 \
  docker.mycompany.com/micronaut-elasticsearch-jvm:1.0.0 \
  docker.mycompany.com/springboot-elasticsearch-jvm:1.0.0