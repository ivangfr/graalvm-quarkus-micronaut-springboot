#!/bin/sh

SECONDS=0

if [ "$1" = "native" ];
then
  podman build -f src/main/docker/Dockerfile.native -t ivanfranchin/quarkus-jpa-mysql-native:latest .
else
  podman build -f src/main/docker/Dockerfile.jvm -t ivanfranchin/quarkus-jpa-mysql-jvm:latest .
fi

duration=$SECONDS
echo "$(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."