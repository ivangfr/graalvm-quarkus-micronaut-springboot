#!/usr/bin/env bash

QUARKUS_VERSION=3.21.0-17
MICRONAUT_VERSION=4.7.6-17
SPRING_BOOT_VERSION=3.4.4-17

podman push ivanfranchin/quarkus-simple-api-jvm:$QUARKUS_VERSION
podman push ivanfranchin/quarkus-simple-api-native:$QUARKUS_VERSION
podman push ivanfranchin/quarkus-jpa-mysql-jvm:$QUARKUS_VERSION
podman push ivanfranchin/quarkus-jpa-mysql-native:$QUARKUS_VERSION
podman push ivanfranchin/quarkus-kafka-consumer-jvm:$QUARKUS_VERSION
podman push ivanfranchin/quarkus-kafka-producer-jvm:$QUARKUS_VERSION
podman push ivanfranchin/quarkus-kafka-consumer-native:$QUARKUS_VERSION
podman push ivanfranchin/quarkus-kafka-producer-native:$QUARKUS_VERSION
podman push ivanfranchin/quarkus-elasticsearch-jvm:$QUARKUS_VERSION
podman push ivanfranchin/quarkus-elasticsearch-native:$QUARKUS_VERSION

podman push ivanfranchin/micronaut-simple-api-jvm:$MICRONAUT_VERSION
podman push ivanfranchin/micronaut-simple-api-native:$MICRONAUT_VERSION
podman push ivanfranchin/micronaut-jpa-mysql-jvm:$MICRONAUT_VERSION
podman push ivanfranchin/micronaut-jpa-mysql-native:$MICRONAUT_VERSION
podman push ivanfranchin/micronaut-kafka-producer-jvm:$MICRONAUT_VERSION
podman push ivanfranchin/micronaut-kafka-consumer-jvm:$MICRONAUT_VERSION
podman push ivanfranchin/micronaut-kafka-consumer-native:$MICRONAUT_VERSION
podman push ivanfranchin/micronaut-kafka-producer-native:$MICRONAUT_VERSION
podman push ivanfranchin/micronaut-elasticsearch-jvm:$MICRONAUT_VERSION
podman push ivanfranchin/micronaut-elasticsearch-native:$MICRONAUT_VERSION

podman push ivanfranchin/springboot-simple-api-jvm:$SPRING_BOOT_VERSION
podman push ivanfranchin/springboot-simple-api-native:$SPRING_BOOT_VERSION
podman push ivanfranchin/springboot-jpa-mysql-jvm:$SPRING_BOOT_VERSION
podman push ivanfranchin/springboot-jpa-mysql-native:$SPRING_BOOT_VERSION
podman push ivanfranchin/springboot-kafka-producer-jvm:$SPRING_BOOT_VERSION
podman push ivanfranchin/springboot-kafka-consumer-jvm:$SPRING_BOOT_VERSION
podman push ivanfranchin/springboot-kafka-consumer-native:$SPRING_BOOT_VERSION
podman push ivanfranchin/springboot-kafka-producer-native:$SPRING_BOOT_VERSION
podman push ivanfranchin/springboot-elasticsearch-jvm:$SPRING_BOOT_VERSION
podman push ivanfranchin/springboot-elasticsearch-native:$SPRING_BOOT_VERSION
