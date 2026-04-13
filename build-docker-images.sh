#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

ACTION="build"
MODE="jvm"

source "$SCRIPT_DIR/automation-lib.sh"

declare -a ALL_APPS=(
  "quarkus-simple-api"
  "micronaut-simple-api"
  "springboot-simple-api"
  "quarkus-jpa-mysql"
  "micronaut-jpa-mysql"
  "springboot-jpa-mysql"
  "quarkus-kafka-producer"
  "quarkus-kafka-consumer"
  "micronaut-kafka-producer"
  "micronaut-kafka-consumer"
  "springboot-kafka-producer"
  "springboot-kafka-consumer"
  "quarkus-elasticsearch"
  "micronaut-elasticsearch"
  "springboot-elasticsearch"
)

function init_configs() {
  if [[ "$MODE" == "native" ]]; then
    # =========================================================================
    # Native builds
    # =========================================================================
    add_app "quarkus-simple-api" \
      "quarkus" "simple-api/quarkus-simple-api" \
      "./mvnw package -Pnative -Dquarkus.native.container-build=true" "target/quarkus-simple-api-1.0.0-runner" \
      "./build-docker-images.sh native" "ivanfranchin/quarkus-simple-api-native"

    add_app "micronaut-simple-api" \
      "micronaut" "simple-api/micronaut-simple-api" \
      "./mvnw package" "target/micronaut-simple-api-1.0.0.jar" \
      "./build-docker-images.sh native" "ivanfranchin/micronaut-simple-api-native"

    add_app "springboot-simple-api" \
      "springboot" "simple-api/springboot-simple-api" \
      "./mvnw package" "target/springboot-simple-api-1.0.0.jar" \
      "./build-docker-images.sh native" "ivanfranchin/springboot-simple-api-native"

    # =========================================================================
    # JPA MySQL Native
    # =========================================================================
    add_app "quarkus-jpa-mysql" \
      "quarkus" "jpa-mysql/quarkus-jpa-mysql" \
      "./mvnw package -Pnative -Dquarkus.native.container-build=true" "target/quarkus-jpa-mysql-1.0.0-runner" \
      "./build-docker-images.sh native" "ivanfranchin/quarkus-jpa-mysql-native"

    add_app "micronaut-jpa-mysql" \
      "micronaut" "jpa-mysql/micronaut-jpa-mysql" \
      "./mvnw package" "target/micronaut-jpa-mysql-1.0.0.jar" \
      "./build-docker-images.sh native" "ivanfranchin/micronaut-jpa-mysql-native"

    add_app "springboot-jpa-mysql" \
      "springboot" "jpa-mysql/springboot-jpa-mysql" \
      "./mvnw package" "target/springboot-jpa-mysql-1.0.0.jar" \
      "./build-docker-images.sh native" "ivanfranchin/springboot-jpa-mysql-native"

    # =========================================================================
    # Kafka Producer Native
    # =========================================================================
    add_app "quarkus-kafka-producer" \
      "quarkus" "kafka/quarkus-kafka" \
      "./mvnw package -Pnative -Dquarkus.native.container-build=true --projects kafka-producer" "kafka-producer/target/kafka-producer-1.0.0-runner" \
      "cd kafka-producer && ./build-docker-images.sh native && cd .." "ivanfranchin/quarkus-kafka-producer-native"

    add_app "micronaut-kafka-producer" \
      "micronaut" "kafka/micronaut-kafka" \
      "./mvnw package --projects kafka-producer" "kafka-producer/target/kafka-producer-1.0.0.jar" \
      "cd kafka-producer && ./build-docker-images.sh native && cd .." "ivanfranchin/micronaut-kafka-producer-native"

    add_app "springboot-kafka-producer" \
      "springboot" "kafka/springboot-kafka" \
      "./mvnw package --projects kafka-producer" "kafka-producer/target/kafka-producer-1.0.0.jar" \
      "cd kafka-producer && ./build-docker-images.sh native && cd .." "ivanfranchin/springboot-kafka-producer-native"

    # =========================================================================
    # Kafka Consumer Native
    # =========================================================================
    add_app "quarkus-kafka-consumer" \
      "quarkus" "kafka/quarkus-kafka" \
      "./mvnw package -Pnative -Dquarkus.native.container-build=true --projects kafka-consumer" "kafka-consumer/target/kafka-consumer-1.0.0-runner" \
      "cd kafka-consumer && ./build-docker-images.sh native && cd .." "ivanfranchin/quarkus-kafka-consumer-native"

    add_app "micronaut-kafka-consumer" \
      "micronaut" "kafka/micronaut-kafka" \
      "./mvnw package --projects kafka-consumer" "kafka-consumer/target/kafka-consumer-1.0.0.jar" \
      "cd kafka-consumer && ./build-docker-images.sh native && cd .." "ivanfranchin/micronaut-kafka-consumer-native"

    add_app "springboot-kafka-consumer" \
      "springboot" "kafka/springboot-kafka" \
      "./mvnw package --projects kafka-consumer" "kafka-consumer/target/kafka-consumer-1.0.0.jar" \
      "cd kafka-consumer && ./build-docker-images.sh native && cd .." "ivanfranchin/springboot-kafka-consumer-native"

    # =========================================================================
    # Elasticsearch Native
    # =========================================================================
    add_app "quarkus-elasticsearch" \
      "quarkus" "elasticsearch/quarkus-elasticsearch" \
      "./mvnw package -Pnative -Dquarkus.native.container-build=true" "target/quarkus-elasticsearch-1.0.0-runner" \
      "./build-docker-images.sh native" "ivanfranchin/quarkus-elasticsearch-native"

    add_app "micronaut-elasticsearch" \
      "micronaut" "elasticsearch/micronaut-elasticsearch" \
      "./mvnw package" "target/micronaut-elasticsearch-1.0.0.jar" \
      "./build-docker-images.sh native" "ivanfranchin/micronaut-elasticsearch-native"

    add_app "springboot-elasticsearch" \
      "springboot" "elasticsearch/springboot-elasticsearch" \
      "./mvnw package" "target/springboot-elasticsearch-1.0.0.jar" \
      "./build-docker-images.sh native" "ivanfranchin/springboot-elasticsearch-native"

  else
    # =========================================================================
    # JVM builds
    # =========================================================================
    add_app "quarkus-simple-api" \
      "quarkus" "simple-api/quarkus-simple-api" \
      "./mvnw package" "target/quarkus-app" \
      "./build-docker-images.sh" "ivanfranchin/quarkus-simple-api-jvm"

    add_app "micronaut-simple-api" \
      "micronaut" "simple-api/micronaut-simple-api" \
      "./mvnw package" "target/micronaut-simple-api-1.0.0.jar" \
      "./build-docker-images.sh" "ivanfranchin/micronaut-simple-api-jvm"

    add_app "springboot-simple-api" \
      "springboot" "simple-api/springboot-simple-api" \
      "./mvnw package" "target/springboot-simple-api-1.0.0.jar" \
      "./build-docker-images.sh" "ivanfranchin/springboot-simple-api-jvm"

    # =========================================================================
    # JPA MySQL JVM
    # =========================================================================
    add_app "quarkus-jpa-mysql" \
      "quarkus" "jpa-mysql/quarkus-jpa-mysql" \
      "./mvnw package" "target/quarkus-app" \
      "./build-docker-images.sh" "ivanfranchin/quarkus-jpa-mysql-jvm"

    add_app "micronaut-jpa-mysql" \
      "micronaut" "jpa-mysql/micronaut-jpa-mysql" \
      "./mvnw package" "target/micronaut-jpa-mysql-1.0.0.jar" \
      "./build-docker-images.sh" "ivanfranchin/micronaut-jpa-mysql-jvm"

    add_app "springboot-jpa-mysql" \
      "springboot" "jpa-mysql/springboot-jpa-mysql" \
      "./mvnw package" "target/springboot-jpa-mysql-1.0.0.jar" \
      "./build-docker-images.sh" "ivanfranchin/springboot-jpa-mysql-jvm"

    # =========================================================================
    # Kafka Producer JVM
    # =========================================================================
    add_app "quarkus-kafka-producer" \
      "quarkus" "kafka/quarkus-kafka" \
      "./mvnw package --projects kafka-producer" "kafka-producer/target/quarkus-app" \
      "cd kafka-producer && ./build-docker-images.sh && cd .." "ivanfranchin/quarkus-kafka-producer-jvm"

    add_app "micronaut-kafka-producer" \
      "micronaut" "kafka/micronaut-kafka" \
      "./mvnw package --projects kafka-producer" "kafka-producer/target/kafka-producer-1.0.0.jar" \
      "cd kafka-producer && ./build-docker-images.sh && cd .." "ivanfranchin/micronaut-kafka-producer-jvm"

    add_app "springboot-kafka-producer" \
      "springboot" "kafka/springboot-kafka" \
      "./mvnw package --projects kafka-producer" "kafka-producer/target/kafka-producer-1.0.0.jar" \
      "cd kafka-producer && ./build-docker-images.sh && cd .." "ivanfranchin/springboot-kafka-producer-jvm"

    # =========================================================================
    # Kafka Consumer JVM
    # =========================================================================
    add_app "quarkus-kafka-consumer" \
      "quarkus" "kafka/quarkus-kafka" \
      "./mvnw package --projects kafka-consumer" "kafka-consumer/target/quarkus-app" \
      "cd kafka-consumer && ./build-docker-images.sh && cd .." "ivanfranchin/quarkus-kafka-consumer-jvm"

    add_app "micronaut-kafka-consumer" \
      "micronaut" "kafka/micronaut-kafka" \
      "./mvnw package --projects kafka-consumer" "kafka-consumer/target/kafka-consumer-1.0.0.jar" \
      "cd kafka-consumer && ./build-docker-images.sh && cd .." "ivanfranchin/micronaut-kafka-consumer-jvm"

    add_app "springboot-kafka-consumer" \
      "springboot" "kafka/springboot-kafka" \
      "./mvnw package --projects kafka-consumer" "kafka-consumer/target/kafka-consumer-1.0.0.jar" \
      "cd kafka-consumer && ./build-docker-images.sh && cd .." "ivanfranchin/springboot-kafka-consumer-jvm"

    # =========================================================================
    # Elasticsearch JVM
    # =========================================================================
    add_app "quarkus-elasticsearch" \
      "quarkus" "elasticsearch/quarkus-elasticsearch" \
      "./mvnw package" "target/quarkus-app" \
      "./build-docker-images.sh" "ivanfranchin/quarkus-elasticsearch-jvm"

    add_app "micronaut-elasticsearch" \
      "micronaut" "elasticsearch/micronaut-elasticsearch" \
      "./mvnw package" "target/micronaut-elasticsearch-1.0.0.jar" \
      "./build-docker-images.sh" "ivanfranchin/micronaut-elasticsearch-jvm"

    add_app "springboot-elasticsearch" \
      "springboot" "elasticsearch/springboot-elasticsearch" \
      "./mvnw package" "target/springboot-elasticsearch-1.0.0.jar" \
      "./build-docker-images.sh" "ivanfranchin/springboot-elasticsearch-jvm"
  fi
}

parse_args "$@"
init_configs

echo
echo "┌───────────────────────────────────────────"
echo "│ BUILDING DOCKER IMAGES"
echo "└───────────────────────────────────────────"
echo "Target:   ${TARGET_APP}"
echo "Builder:  ${BUILDER}"
echo

# Determine modes to test based on TARGET_APP
MODES_TO_TEST=()

case "$TARGET_APP" in
  all)
    MODES_TO_TEST=(jvm native)
    ;;
  jvm)
    MODES_TO_TEST=(jvm)
    ;;
  native)
    MODES_TO_TEST=(native)
    ;;
  *-jvm)
    MODES_TO_TEST=(jvm)
    ;;
  *-native)
    MODES_TO_TEST=(native)
    ;;
  *-kafka)
    MODES_TO_TEST=(jvm native)
    ;;
  *)
    MODES_TO_TEST=(jvm native)
    ;;
esac

# Run build for each mode
start_time=$(date +"%Y-%m-%d %H:%M:%S")
build_failed=0

declare -A RESULTS=()

for mode in "${MODES_TO_TEST[@]}"; do
  MODE="$mode"
  if ! main "true"; then
    build_failed=1
  fi
done

print_results

if [[ -n "$CSV_OUTPUT" ]]; then
  export_csv
fi

echo
echo "┌───────────────────────────────────────────"
echo "│ BUILD SUMMARY"
echo "└───────────────────────────────────────────"
echo "Started:  ${start_time}"
echo "Finished: $(date +"%Y-%m-%d %H:%M:%S")"
echo

if [[ $build_failed -eq 0 ]]; then
  echo "✔ Build completed successfully"
else
  echo "✘ Build completed with some failures"
fi

echo