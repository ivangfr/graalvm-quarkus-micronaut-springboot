#!/usr/bin/env bash

source my-functions.sh

docker rmi docker.mycompany.com/springboot-book-api-native:1.0.0

declare -A springboot_book_api_native

start_time=$(date)

echo
echo "========"
echo "BOOK-API"
echo "========"

echo
echo "--------------------------"
echo "SPRINGBOOT-BOOK-API-NATIVE"
echo "--------------------------"

cd book-api/springboot-book-api

package_jar_build_image \
  "./gradlew clean" \
  "./gradlew assemble" \
  "build/libs/springboot-book-api-1.0.0.jar" \
  "./docker-build.sh native" \
  "docker.mycompany.com/springboot-book-api-native:1.0.0"
springboot_book_api_native[packaging_time]=$package_jar_build_image_packaging_time
springboot_book_api_native[jar_size]=$package_jar_build_image_jar_size
springboot_book_api_native[building_time]=$package_jar_build_image_building_time
springboot_book_api_native[docker_image_size]=$package_jar_build_image_docker_image_size

printf "\n"
printf "%30s | %14s | %16s | %17s | %17s |\n" "Application" "Packaging Time" "Jar Size (bytes)" "Docker Build Time" "Docker Image Size"
printf "%30s + %14s + %16s + %17s + %17s |\n" "------------------------------" "--------------" "----------------" "-----------------" "-----------------"
printf "%30s | %14s | %16s | %17s | %17s |\n" "springboot-book-api-native" ${springboot_book_api_native[packaging_time]} ${springboot_book_api_native[jar_size]} ${springboot_book_api_native[building_time]} ${springboot_book_api_native[docker_image_size]}

echo
echo "==>  START AT: ${start_time}"
echo "==> FINISH AT: $(date)"
echo
