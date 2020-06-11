#!/bin/sh

SECONDS=0

if [ "$1" = "native" ];
then
  docker build -f src/main/docker/Dockerfile.native -t docker.mycompany.com/micronaut-producer-api-native:1.0.0 .
else
  ../gradlew jibDockerBuild -Djib.to.image=docker.mycompany.com/micronaut-producer-api-jvm:1.0.0
fi

duration=$SECONDS
echo "$(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."