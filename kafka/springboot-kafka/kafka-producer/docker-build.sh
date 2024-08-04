#!/bin/sh

SECONDS=0

if [ "$1" = "native" ];
then
  ../mvnw -Pnative spring-boot:build-image -Dspring-boot.build-image.imageName=ivanfranchin/springboot-kafka-producer-native:latest
else
  ../mvnw spring-boot:build-image -Dspring-boot.build-image.imageName=ivanfranchin/springboot-kafka-producer-jvm:latest
fi

duration=$SECONDS
echo "$(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."
