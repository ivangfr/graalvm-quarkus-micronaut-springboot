#!/bin/sh

SECONDS=0

if [ "$1" = "native" ];
then
  ./mvnw package -Pgraalvm -Dpackaging=docker-native -Djib.to.image=ivanfranchin/micronaut-elasticsearch-native:latest
else
  ./mvnw package -Dpackaging=docker -Djib.to.image=ivanfranchin/micronaut-elasticsearch-jvm:latest
fi

duration=$SECONDS
echo "$(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."
