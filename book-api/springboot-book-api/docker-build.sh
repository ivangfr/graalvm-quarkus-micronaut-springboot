#!/bin/sh

SECONDS=0

if [ "$1" = "native" ];
then
  ./gradlew -Pnative bootBuildImage
else
  ./gradlew jibDockerBuild
fi

duration=$SECONDS
echo "$(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."
