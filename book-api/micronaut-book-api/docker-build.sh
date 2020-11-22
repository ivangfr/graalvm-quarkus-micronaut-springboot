#!/bin/sh

SECONDS=0

if [ "$1" = "native" ];
then
  ./mvnw package -Dpackaging=docker-native
else
  ./mvnw package -Dpackaging=docker -Djib.to.image=docker.mycompany.com/micronaut-book-api-jvm:1.0.0
fi

duration=$SECONDS
echo "$(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."
