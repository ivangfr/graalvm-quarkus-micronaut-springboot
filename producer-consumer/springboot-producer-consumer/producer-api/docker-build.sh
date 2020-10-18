#!/bin/sh

SECONDS=0

../mvnw compile jib:dockerBuild

duration=$SECONDS
echo "$(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."
