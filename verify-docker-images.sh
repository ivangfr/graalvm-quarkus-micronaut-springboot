#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

MODE="jvm"
ACTION="verify"

source "$SCRIPT_DIR/automation-lib.sh"

function show_verify_help() {
  cat << EOF
Usage: ./verify-docker-images.sh [target]

All:
  all | jvm | native

By Framework:
  quarkus | micronaut | springboot

By Type:
  simple-api | jpa-mysql | elasticsearch | kafka

Simple API:
  quarkus-simple-api | quarkus-simple-api-jvm | quarkus-simple-api-native
  micronaut-simple-api | micronaut-simple-api-jvm | micronaut-simple-api-native
  springboot-simple-api | springboot-simple-api-jvm | springboot-simple-api-native

JPA MySQL:
  quarkus-jpa-mysql | quarkus-jpa-mysql-jvm | quarkus-jpa-mysql-native
  micronaut-jpa-mysql | micronaut-jpa-mysql-jvm | micronaut-jpa-mysql-native
  springboot-jpa-mysql | springboot-jpa-mysql-jvm | springboot-jpa-mysql-native

Kafka (producer + consumer):
  quarkus-kafka | quarkus-kafka-jvm | quarkus-kafka-native
  micronaut-kafka | micronaut-kafka-jvm | micronaut-kafka-native
  springboot-kafka | springboot-kafka-jvm | springboot-kafka-native

Elasticsearch:
  quarkus-elasticsearch | quarkus-elasticsearch-jvm | quarkus-elasticsearch-native
  micronaut-elasticsearch | micronaut-elasticsearch-jvm | micronaut-elasticsearch-native
  springboot-elasticsearch | springboot-elasticsearch-jvm | springboot-elasticsearch-native

Options:
  --builder=BUILDER           Container builder (podman or docker)
  --quarkus-version=TAG       Quarkus image tag (default: ${QUARKUS_VERSION:-latest})
  --micronaut-version=TAG     Micronaut image tag (default: ${MICRONAUT_VERSION:-latest})
  --springboot-version=TAG    Spring Boot image tag (default: ${SPRING_BOOT_VERSION:-latest})
  --csv[=FILE]                Export results to CSV file (default: results-TIMESTAMP.csv)
  --dry-run                   Show what would be tested
  -h, --help                  Show this help

Examples:
  verify-docker-images.sh all
  verify-docker-images.sh jvm
  verify-docker-images.sh native
  verify-docker-images.sh springboot-jvm
  verify-docker-images.sh quarkus-native
  verify-docker-images.sh springboot-simple-api-jvm
  verify-docker-images.sh quarkus --quarkus-version v1.0
  verify-docker-images.sh springboot-kafka-jvm
  verify-docker-images.sh kafka --builder=docker --dry-run
EOF
}

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

# Port mappings for JVM
QUARKUS_SIMPLE_API_PORT=9080
MICRONAUT_SIMPLE_API_PORT=9082
SPRINGBOOT_SIMPLE_API_PORT=9084

QUARKUS_JPA_MYSQL_PORT=9086
MICRONAUT_JPA_MYSQL_PORT=9088
SPRINGBOOT_JPA_MYSQL_PORT=9090

QUARKUS_KAFKA_PRODUCER_PORT=9100
MICRONAUT_KAFKA_PRODUCER_PORT=9102
SPRINGBOOT_KAFKA_PRODUCER_PORT=9104
QUARKUS_KAFKA_CONSUMER_PORT=9106
MICRONAUT_KAFKA_CONSUMER_PORT=9108
SPRINGBOOT_KAFKA_CONSUMER_PORT=9110

QUARKUS_ELASTICSEARCH_PORT=9112
MICRONAUT_ELASTICSEARCH_PORT=9114
SPRINGBOOT_ELASTICSEARCH_PORT=9116

# Port mappings for Native
QUARKUS_SIMPLE_API_NATIVE_PORT=9081
MICRONAUT_SIMPLE_API_NATIVE_PORT=9083
SPRINGBOOT_SIMPLE_API_NATIVE_PORT=9085

QUARKUS_JPA_MYSQL_NATIVE_PORT=9087
MICRONAUT_JPA_MYSQL_NATIVE_PORT=9089
SPRINGBOOT_JPA_MYSQL_NATIVE_PORT=9091

QUARKUS_KAFKA_PRODUCER_NATIVE_PORT=9101
MICRONAUT_KAFKA_PRODUCER_NATIVE_PORT=9103
SPRINGBOOT_KAFKA_PRODUCER_NATIVE_PORT=9105
QUARKUS_KAFKA_CONSUMER_NATIVE_PORT=9107
MICRONAUT_KAFKA_CONSUMER_NATIVE_PORT=9109
SPRINGBOOT_KAFKA_CONSUMER_NATIVE_PORT=9111

QUARKUS_ELASTICSEARCH_NATIVE_PORT=9113
MICRONAUT_ELASTICSEARCH_NATIVE_PORT=9115
SPRINGBOOT_ELASTICSEARCH_NATIVE_PORT=9117

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
init_configs

echo
echo "╔═══════════════════════════════════════════"
echo "║ VERIFYING DOCKER IMAGES"
echo "╚═══════════════════════════════════════════"
echo "Target:   ${TARGET_APP}"
echo "Builder:  ${BUILDER}"
echo

validate_kafka_verify_target() {
  local base="${TARGET_APP%-jvm}"
  base="${base%-native}"
  
  if [[ "$base" == *-kafka-producer || "$base" == *-kafka-consumer ]]; then
    echo "ERROR: Kafka verification requires running producer and consumer together."
    echo "Use: ./verify-docker-images.sh <framework>-kafka or <framework>-kafka-jvm/native"
    echo "Example: ./verify-docker-images.sh springboot-kafka"
    exit 1
  fi
}
validate_kafka_verify_target

# Determine modes to test based on TARGET_APP
# Also determines which apps to test for kafka (producer + consumer)
declare -a KAFKA_APPS_TO_TEST=()
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
  *-kafka-jvm)
    MODES_TO_TEST=(jvm)
    KAFKA_APPS_TO_TEST=(producer consumer)
    ;;
  *-kafka-native)
    MODES_TO_TEST=(native)
    KAFKA_APPS_TO_TEST=(producer consumer)
    ;;
  *-kafka)
    MODES_TO_TEST=(jvm native)
    KAFKA_APPS_TO_TEST=(producer consumer)
    ;;
  kafka)
    MODES_TO_TEST=(jvm native)
    KAFKA_APPS_TO_TEST=(producer consumer)
    ;;
  *)
    if [[ "$TARGET_APP" == *-jvm ]]; then
      MODES_TO_TEST=(jvm)
    elif [[ "$TARGET_APP" == *-native ]]; then
      MODES_TO_TEST=(native)
    else
      MODES_TO_TEST=(jvm native)
    fi
    ;;
esac

# Run verification for each mode
start_time=$(date +"%Y-%m-%d %H:%M:%S")
verify_failed=0

declare -a VERIFY_ORDER=()
declare -A VERIFY_RESULTS=()

# Start infrastructure once for all modes (JVM + Native)
if [[ "$DRY_RUN" != "true" ]]; then
  verify_start_infrastructure_once
fi

for mode in "${MODES_TO_TEST[@]}"; do
  MODE="$mode"
  init_configs
  if ! verify_main "true" "false"; then
    verify_failed=1
  fi
done

# Stop infrastructure once after all modes
if [[ "$DRY_RUN" != "true" ]]; then
  verify_stop_infrastructure_once
fi

print_verify_results

if [[ -n "$CSV_OUTPUT" ]]; then
  export_verify_csv
fi

echo
echo "╔═══════════════════════════════════════════"
echo "║ VERIFICATION SUMMARY"
echo "╚═══════════════════════════════════════════"
echo "Started:  ${start_time}"
echo "Finished: $(date +"%Y-%m-%d %H:%M:%S")"
echo

if [[ $verify_failed -eq 0 ]]; then
  echo "✔ Verification completed successfully"
else
  echo "✘ Verification completed with some failures"
fi

echo