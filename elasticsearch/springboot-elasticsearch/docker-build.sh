#!/bin/sh

SECONDS=0

./mvnw compile jib:dockerBuild -Djib.to.image=docker.mycompany.com/springboot-elasticsearch-jvm:1.0.0

duration=$SECONDS
echo "$(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."
