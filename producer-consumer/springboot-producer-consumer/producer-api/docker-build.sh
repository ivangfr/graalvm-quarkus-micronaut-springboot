#!/bin/sh

SECONDS=0

if [ "$1" = "native" ];
then
  ../mvnw spring-boot:build-image
else
  ../mvnw package jib:dockerBuild
fi

duration=$SECONDS
echo "$(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."
