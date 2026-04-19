#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

ACTION="push"
MODE="jvm"

QUARKUS_VERSION="${QUARKUS_VERSION:-3.34.3-17}"
MICRONAUT_VERSION="${MICRONAUT_VERSION:-4.10.11-17}"
SPRING_BOOT_VERSION="${SPRING_BOOT_VERSION:-4.0.5-17}"

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
    # Native image configs
    # =========================================================================
    add_app_image "quarkus-simple-api" "quarkus" "ivanfranchin/quarkus-simple-api-native"
    add_app_image "micronaut-simple-api" "micronaut" "ivanfranchin/micronaut-simple-api-native"
    add_app_image "springboot-simple-api" "springboot" "ivanfranchin/springboot-simple-api-native"

    add_app_image "quarkus-jpa-mysql" "quarkus" "ivanfranchin/quarkus-jpa-mysql-native"
    add_app_image "micronaut-jpa-mysql" "micronaut" "ivanfranchin/micronaut-jpa-mysql-native"
    add_app_image "springboot-jpa-mysql" "springboot" "ivanfranchin/springboot-jpa-mysql-native"

    add_app_image "quarkus-kafka-producer" "quarkus" "ivanfranchin/quarkus-kafka-producer-native"
    add_app_image "quarkus-kafka-consumer" "quarkus" "ivanfranchin/quarkus-kafka-consumer-native"
    add_app_image "micronaut-kafka-producer" "micronaut" "ivanfranchin/micronaut-kafka-producer-native"
    add_app_image "micronaut-kafka-consumer" "micronaut" "ivanfranchin/micronaut-kafka-consumer-native"
    add_app_image "springboot-kafka-producer" "springboot" "ivanfranchin/springboot-kafka-producer-native"
    add_app_image "springboot-kafka-consumer" "springboot" "ivanfranchin/springboot-kafka-consumer-native"

    add_app_image "quarkus-elasticsearch" "quarkus" "ivanfranchin/quarkus-elasticsearch-native"
    add_app_image "micronaut-elasticsearch" "micronaut" "ivanfranchin/micronaut-elasticsearch-native"
    add_app_image "springboot-elasticsearch" "springboot" "ivanfranchin/springboot-elasticsearch-native"
  else
    # =========================================================================
    # JVM image configs
    # =========================================================================
    add_app_image "quarkus-simple-api" "quarkus" "ivanfranchin/quarkus-simple-api-jvm"
    add_app_image "micronaut-simple-api" "micronaut" "ivanfranchin/micronaut-simple-api-jvm"
    add_app_image "springboot-simple-api" "springboot" "ivanfranchin/springboot-simple-api-jvm"

    add_app_image "quarkus-jpa-mysql" "quarkus" "ivanfranchin/quarkus-jpa-mysql-jvm"
    add_app_image "micronaut-jpa-mysql" "micronaut" "ivanfranchin/micronaut-jpa-mysql-jvm"
    add_app_image "springboot-jpa-mysql" "springboot" "ivanfranchin/springboot-jpa-mysql-jvm"

    add_app_image "quarkus-kafka-producer" "quarkus" "ivanfranchin/quarkus-kafka-producer-jvm"
    add_app_image "quarkus-kafka-consumer" "quarkus" "ivanfranchin/quarkus-kafka-consumer-jvm"
    add_app_image "micronaut-kafka-producer" "micronaut" "ivanfranchin/micronaut-kafka-producer-jvm"
    add_app_image "micronaut-kafka-consumer" "micronaut" "ivanfranchin/micronaut-kafka-consumer-jvm"
    add_app_image "springboot-kafka-producer" "springboot" "ivanfranchin/springboot-kafka-producer-jvm"
    add_app_image "springboot-kafka-consumer" "springboot" "ivanfranchin/springboot-kafka-consumer-jvm"

    add_app_image "quarkus-elasticsearch" "quarkus" "ivanfranchin/quarkus-elasticsearch-jvm"
    add_app_image "micronaut-elasticsearch" "micronaut" "ivanfranchin/micronaut-elasticsearch-jvm"
    add_app_image "springboot-elasticsearch" "springboot" "ivanfranchin/springboot-elasticsearch-jvm"
  fi
}

parse_args "$@"

# Determine modes based on TARGET_APP
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

# Run push for each mode
start_time=$(date +"%Y-%m-%d %H:%M:%S")
push_failed=0

for mode in "${MODES_TO_TEST[@]}"; do
  MODE="$mode"
  init_configs
  push_images || push_failed=1
done

echo
echo "┌───────────────────────────────────────────"
echo "│ PUSH SUMMARY"
echo "└───────────────────────────────────────────"
echo "Started:  ${start_time}"
echo "Finished: $(date +"%Y-%m-%d %H:%M:%S")"
echo

if [[ $push_failed -eq 0 ]]; then
  echo "✔ Push completed successfully"
else
  echo "✘ Push completed with some failures"
fi