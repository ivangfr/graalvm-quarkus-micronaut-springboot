#!/bin/sh

SECONDS=0

if [ "$1" = "native" ];
then
  docker build -f src/main/docker/Dockerfile.native -t ivanfranchin/quarkus-producer-api-native:1.0.0 .
else
  docker build -f src/main/docker/Dockerfile.jvm -t ivanfranchin/quarkus-producer-api-jvm:1.0.0 .
fi

duration=$SECONDS
echo "$(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."