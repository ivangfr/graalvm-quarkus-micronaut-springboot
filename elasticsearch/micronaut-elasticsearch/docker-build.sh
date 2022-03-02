#!/bin/sh

SECONDS=0

if [ "$1" = "native" ];
then
  ./mvnw package -Pgraalvm -Dpackaging=docker-native -Djib.to.image=ivanfranchin/micronaut-elasticsearch-native:1.0.0 \
  -Djib.from.image=ghcr.io/graalvm/native-image:ol8-java11-22
else
  ./mvnw package -Dpackaging=docker
fi

duration=$SECONDS
echo "$(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."
