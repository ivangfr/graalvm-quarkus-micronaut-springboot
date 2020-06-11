#!/bin/sh

SECONDS=0

./gradlew jibDockerBuild -Djib.to.image=docker.mycompany.com/springboot-simple-api-jvm:1.0.0

duration=$SECONDS
echo "$(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."
