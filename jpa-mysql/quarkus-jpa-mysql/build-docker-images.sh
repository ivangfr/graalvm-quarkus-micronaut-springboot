#!/usr/bin/env bash

SECONDS=0
BUILDER="${BUILDER:-podman}"

if [ "$1" = "native" ];
then
  $BUILDER build -f src/main/docker/Dockerfile.native -t docker.io/ivanfranchin/quarkus-jpa-mysql-native:latest .
else
  $BUILDER build -f src/main/docker/Dockerfile.jvm -t docker.io/ivanfranchin/quarkus-jpa-mysql-jvm:latest .
fi

duration=$SECONDS
echo "$(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."