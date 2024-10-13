#!/usr/bin/env bash

QUARKUS_VERSION=3.14.2-17
MICRONAUT_VERSION=4.6.1-17
SPRING_BOOT_VERSION=3.3.4-17

docker tag ivanfranchin/quarkus-simple-api-jvm:latest ivanfranchin/quarkus-simple-api-jvm:$QUARKUS_VERSION
docker tag ivanfranchin/quarkus-simple-api-native:latest ivanfranchin/quarkus-simple-api-native:$QUARKUS_VERSION
docker tag ivanfranchin/quarkus-jpa-mysql-jvm:latest ivanfranchin/quarkus-jpa-mysql-jvm:$QUARKUS_VERSION
docker tag ivanfranchin/quarkus-jpa-mysql-native:latest ivanfranchin/quarkus-jpa-mysql-native:$QUARKUS_VERSION
docker tag ivanfranchin/quarkus-kafka-consumer-jvm:latest ivanfranchin/quarkus-kafka-consumer-jvm:$QUARKUS_VERSION
docker tag ivanfranchin/quarkus-kafka-producer-jvm:latest ivanfranchin/quarkus-kafka-producer-jvm:$QUARKUS_VERSION
docker tag ivanfranchin/quarkus-kafka-consumer-native:latest ivanfranchin/quarkus-kafka-consumer-native:$QUARKUS_VERSION
docker tag ivanfranchin/quarkus-kafka-producer-native:latest ivanfranchin/quarkus-kafka-producer-native:$QUARKUS_VERSION
docker tag ivanfranchin/quarkus-elasticsearch-jvm:latest ivanfranchin/quarkus-elasticsearch-jvm:$QUARKUS_VERSION
docker tag ivanfranchin/quarkus-elasticsearch-native:latest ivanfranchin/quarkus-elasticsearch-native:$QUARKUS_VERSION

docker tag ivanfranchin/micronaut-simple-api-jvm:latest ivanfranchin/micronaut-simple-api-jvm:$MICRONAUT_VERSION
docker tag ivanfranchin/micronaut-simple-api-native:latest ivanfranchin/micronaut-simple-api-native:$MICRONAUT_VERSION
docker tag ivanfranchin/micronaut-jpa-mysql-jvm:latest ivanfranchin/micronaut-jpa-mysql-jvm:$MICRONAUT_VERSION
docker tag ivanfranchin/micronaut-jpa-mysql-native:latest ivanfranchin/micronaut-jpa-mysql-native:$MICRONAUT_VERSION
docker tag ivanfranchin/micronaut-kafka-producer-jvm:latest ivanfranchin/micronaut-kafka-producer-jvm:$MICRONAUT_VERSION
docker tag ivanfranchin/micronaut-kafka-consumer-jvm:latest ivanfranchin/micronaut-kafka-consumer-jvm:$MICRONAUT_VERSION
docker tag ivanfranchin/micronaut-kafka-consumer-native:latest ivanfranchin/micronaut-kafka-consumer-native:$MICRONAUT_VERSION
docker tag ivanfranchin/micronaut-kafka-producer-native:latest ivanfranchin/micronaut-kafka-producer-native:$MICRONAUT_VERSION
docker tag ivanfranchin/micronaut-elasticsearch-jvm:latest ivanfranchin/micronaut-elasticsearch-jvm:$MICRONAUT_VERSION
docker tag ivanfranchin/micronaut-elasticsearch-native:latest ivanfranchin/micronaut-elasticsearch-native:$MICRONAUT_VERSION

docker tag ivanfranchin/springboot-simple-api-jvm:latest ivanfranchin/springboot-simple-api-jvm:$SPRING_BOOT_VERSION
docker tag ivanfranchin/springboot-simple-api-native:latest ivanfranchin/springboot-simple-api-native:$SPRING_BOOT_VERSION
docker tag ivanfranchin/springboot-jpa-mysql-jvm:latest ivanfranchin/springboot-jpa-mysql-jvm:$SPRING_BOOT_VERSION
docker tag ivanfranchin/springboot-jpa-mysql-native:latest ivanfranchin/springboot-jpa-mysql-native:$SPRING_BOOT_VERSION
docker tag ivanfranchin/springboot-kafka-producer-jvm:latest ivanfranchin/springboot-kafka-producer-jvm:$SPRING_BOOT_VERSION
docker tag ivanfranchin/springboot-kafka-consumer-jvm:latest ivanfranchin/springboot-kafka-consumer-jvm:$SPRING_BOOT_VERSION
docker tag ivanfranchin/springboot-kafka-consumer-native:latest ivanfranchin/springboot-kafka-consumer-native:$SPRING_BOOT_VERSION
docker tag ivanfranchin/springboot-kafka-producer-native:latest ivanfranchin/springboot-kafka-producer-native:$SPRING_BOOT_VERSION
docker tag ivanfranchin/springboot-elasticsearch-jvm:latest ivanfranchin/springboot-elasticsearch-jvm:$SPRING_BOOT_VERSION
docker tag ivanfranchin/springboot-elasticsearch-native:latest ivanfranchin/springboot-elasticsearch-native:$SPRING_BOOT_VERSION