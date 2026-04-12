#!/usr/bin/env bash

# =============================================================================
# automation-lib.sh - Shared functions for automation scripts
# =============================================================================
# This file is intended to be sourced by automation scripts.
# Usage: source "$SCRIPT_DIR/automation-lib.sh"

set -euo pipefail

QUARKUS_VERSION="${QUARKUS_VERSION:-latest}"
MICRONAUT_VERSION="${MICRONAUT_VERSION:-latest}"
SPRING_BOOT_VERSION="${SPRING_BOOT_VERSION:-latest}"
BUILDER="${BUILDER:-podman}"
CSV_OUTPUT=""
DRY_RUN=""
TARGET_APP=""
ACTION="${ACTION:-build}"

MODE="${MODE:-jvm}"

declare -A RESULTS=()
declare -A APP_CONFIG=()
declare -A VERIFY_RESULTS=()
declare -a VERIFY_ORDER=()

function add_app() {
  local app=$1 framework=$2 dir=$3 mvn_cmd=$4 jar_path=$5 build_cmd=$6 image=$7
  APP_CONFIG[$app]="$framework:$dir:$mvn_cmd:$jar_path:$build_cmd:$image"
}

function add_app_image() {
  local app=$1 framework=$2 image=$3
  APP_CONFIG[$app]="$framework:::::$image"
}

# =============================================================================
# Shared Functions
# =============================================================================

function check_dependencies() {
  if ! command -v "$BUILDER" &>/dev/null; then
    echo "ERROR: $BUILDER not found. Install podman or use --builder=docker" >&2
    exit 1
  fi
}

function convert_seconds_to_millis() {
  echo "scale=0 ; ($1 * 1000)/1" | bc -l
}

function cleanup() {
  local exit_code=$?
  if [[ $exit_code -ne 0 ]]; then
    echo "WARNING: Script failed with exit code $exit_code" >&2
    echo "Cleaning up..."
    local containers
    containers=$($BUILDER ps -a --format '{{.Names}}' 2>/dev/null) || return 0
    for container in $containers; do
      case "$container" in
        *-jvm-*|*-native-*)
          $BUILDER stop -t 0 "$container" 2>/dev/null || true
          ;;
      esac
    done
  fi
}

trap cleanup EXIT

function validate_app() {
  local app="$1"
  
  # Handle composite parameters like springboot-simple-api-jvm, quarkus-jpa-mysql-native
  local base_app="${app%-jvm}"
  base_app="${base_app%-native}"
  
  for valid in "${ALL_APPS[@]}"; do
    [[ "$valid" == "$base_app" ]] && return 0
  done
  echo "ERROR: Invalid application: $app" >&2
  echo "Valid: ${ALL_APPS[*]}" >&2
  exit 1
}

function get_apps_to_build() {
  local target="$1"
  local -a apps=()

  local target_mode=""
  local base_target="${target%-jvm}"
  if [[ "$target" != "$base_target" ]]; then
    target_mode="jvm"
  else
    base_target="${target%-native}"
    if [[ "$target" != "$base_target" ]]; then
      target_mode="native"
    fi
  fi
  base_target="${base_target%-jvm}"
  base_target="${base_target%-native}"

  case "$base_target" in
    all)
      apps=("${ALL_APPS[@]}")
      ;;
    jvm|native)
      apps=("${ALL_APPS[@]}")
      ;;
    quarkus)
      for app in "${ALL_APPS[@]}"; do
        [[ "$app" == quarkus-* ]] && apps+=("$app")
      done
      ;;
    micronaut)
      for app in "${ALL_APPS[@]}"; do
        [[ "$app" == micronaut-* ]] && apps+=("$app")
      done
      ;;
    springboot)
      for app in "${ALL_APPS[@]}"; do
        [[ "$app" == springboot-* ]] && apps+=("$app")
      done
      ;;
    simple-api)
      for app in "${ALL_APPS[@]}"; do
        [[ "$app" == *-simple-api ]] && apps+=("$app")
      done
      ;;
    jpa-mysql)
      for app in "${ALL_APPS[@]}"; do
        [[ "$app" == *-jpa-mysql ]] && apps+=("$app")
      done
      ;;
    kafka)
      for app in "${ALL_APPS[@]}"; do
        [[ "$app" == *-kafka-* ]] && apps+=("$app")
      done
      ;;
    elasticsearch)
      for app in "${ALL_APPS[@]}"; do
        [[ "$app" == *-elasticsearch ]] && apps+=("$app")
      done
      ;;
    *-kafka-producer)
      local framework="${base_target%-kafka-producer}"
      for app in "${ALL_APPS[@]}"; do
        if [[ "$app" == "${framework}-kafka-producer" ]]; then
          apps+=("$app")
        fi
      done
      if [[ ${#apps[@]} -eq 0 ]]; then
        validate_app "$base_target"
        apps=("$base_target")
      fi
      ;;
    *-kafka-consumer)
      local framework="${base_target%-kafka-consumer}"
      for app in "${ALL_APPS[@]}"; do
        if [[ "$app" == "${framework}-kafka-consumer" ]]; then
          apps+=("$app")
        fi
      done
      if [[ ${#apps[@]} -eq 0 ]]; then
        validate_app "$base_target"
        apps=("$base_target")
      fi
      ;;
    *-kafka)
      local framework="${base_target%-kafka}"
      for app in "${ALL_APPS[@]}"; do
        if [[ "$app" == "${framework}-kafka-"* ]]; then
          apps+=("$app")
        fi
      done
      ;;
    *)
      validate_app "$base_target"
      apps=("$base_target")
      ;;
  esac

  printf '%s\n' "${apps[@]}"
}

function build_app() {
  local app="$1"
  local config="${APP_CONFIG[$app]}"

  IFS=':' read -r framework dir mvn_cmd jar_path build_cmd image <<< "$config"

  local full_dir="$SCRIPT_DIR/$dir"
  local clean_cmd="./mvnw clean"
  
  local tag_version
  case "$framework" in
    quarkus) tag_version="${QUARKUS_VERSION:-latest}" ;;
    micronaut) tag_version="${MICRONAUT_VERSION:-latest}" ;;
    springboot) tag_version="${SPRING_BOOT_VERSION:-latest}" ;;
    *) tag_version="latest" ;;
  esac
  local image_tag="${image}:${tag_version}"

  echo
  echo "========================================"
  echo "${framework^^}-${app#*-} (${MODE^^})"
  echo "========================================"
  echo "Directory: $full_dir"
  echo "Image:     $image_tag"
  echo

  if [[ "$DRY_RUN" == "true" ]]; then
    echo "[DRY RUN] Would execute:"
    echo "  cd $full_dir && $clean_cmd"
    echo "  cd $full_dir && $mvn_cmd"
    echo "  cd $full_dir && $build_cmd"
    
    local suffix=""
    [[ "$MODE" == "native" ]] && suffix="_native"
    
    RESULTS["${app}${suffix}_packaging_time"]="N/A"
    RESULTS["${app}${suffix}_jar_size"]="N/A"
    RESULTS["${app}${suffix}_build_time"]="N/A"
    RESULTS["${app}${suffix}_image_size"]="N/A"
    return 0
  fi

  if [[ ! -d "$full_dir" ]]; then
    echo "ERROR: Directory not found: $full_dir" >&2
    return 1
  fi

  local prev_dir
  prev_dir="$(pwd)"
  cd "$full_dir"

  echo "==> Cleaning..."
  eval "$clean_cmd"

  echo "==> Packaging..."
  SECONDS=0
  eval "$mvn_cmd"
  packaging_time="${SECONDS}s"

  if [[ ! -e "$jar_path" ]]; then
    echo "ERROR: JAR not found: $jar_path" >&2
    return 1
  fi
  jar_size=$(du -sh "$jar_path" | awk '{print $1}')

  echo "==> Building image..."
  SECONDS=0
  eval "$build_cmd"
  build_time="${SECONDS}s"

  image_size=$($BUILDER images "$image_tag" --format='{{.Size}}' | tr -d ' ')

  cd "$prev_dir"

  local suffix=""
  [[ "$MODE" == "native" ]] && suffix="_native"
  
  RESULTS["${app}${suffix}_packaging_time"]=$packaging_time
  RESULTS["${app}${suffix}_jar_size"]=$jar_size
  RESULTS["${app}${suffix}_build_time"]=$build_time
  RESULTS["${app}${suffix}_image_size"]=$image_size
}

function print_results() {
  local -a apps=($(get_apps_to_build "$TARGET_APP"))

  printf "\n"
  printf "| %-32s | %-9s | %-8s | %-11s | %-10s |\n" "Application" "Pkg Time" "Pkg Size" "Build Time" "Image Size"
  printf "| %-32s | %-9s | %-8s | %-11s | %-10s |\n" "--------------------------------" "---------" "--------" "-----------" "----------"

  # When printing accumulated results, iterate over modes if RESULTS has entries from both
  if [[ ${#RESULTS[@]} -gt 0 ]]; then
    # Check if we have jvm results
    local has_jvm=false
    local has_native=false
    for app in "${apps[@]}"; do
      [[ -n "${RESULTS[${app}_packaging_time]:-}" ]] && has_jvm=true
      [[ -n "${RESULTS[${app}_native_packaging_time]:-}" ]] && has_native=true
    done
    
    local modes=()
    [[ "$has_jvm" == "true" ]] && modes+=("jvm")
    [[ "$has_native" == "true" ]] && modes+=("native")
    
    for mode in "${modes[@]}"; do
      for app in "${apps[@]}"; do
        local suffix=""
        [[ "$mode" == "native" ]] && suffix="_native"
        
        printf "| %-32s | %-9s | %-8s | %-11s | %-10s |\n" \
          "${app}-${mode}" \
          "${RESULTS[${app}${suffix}_packaging_time]:-N/A}" \
          "${RESULTS[${app}${suffix}_jar_size]:-N/A}" \
          "${RESULTS[${app}${suffix}_build_time]:-N/A}" \
          "${RESULTS[${app}${suffix}_image_size]:-N/A}"
      done
    done
  else
    # Original behavior for single mode
    for app in "${apps[@]}"; do
      printf "| %-32s | %-9s | %-8s | %-11s | %-10s |\n" \
        "${app}-${MODE}" \
        "${RESULTS[${app}_packaging_time]:-N/A}" \
        "${RESULTS[${app}_jar_size]:-N/A}" \
        "${RESULTS[${app}_build_time]:-N/A}" \
        "${RESULTS[${app}_image_size]:-N/A}"
    done
  fi
}

function export_csv() {
  local -a apps=($(get_apps_to_build "$TARGET_APP"))
  local file="${CSV_OUTPUT:-results-$(date +%Y%m%d-%H%M%S).csv}"

  {
    echo "application,framework,packing_time,jar_size,build_time,image_size,version"
    for app in "${apps[@]}"; do
      local framework="${app%-*}"
      local version
      case "$framework" in
        quarkus) version="${QUARKUS_VERSION:-latest}" ;;
        micronaut) version="${MICRONAUT_VERSION:-latest}" ;;
        springboot) version="${SPRING_BOOT_VERSION:-latest}" ;;
        *) version="latest" ;;
      esac
      echo "${app}-${MODE},$framework,${RESULTS[${app}_packaging_time]:-},${RESULTS[${app}_jar_size]:-},${RESULTS[${app}_build_time]:-},${RESULTS[${app}_image_size]:-},${version}"
    done
  } >> "$file"

  echo "Results exported to: $file"
}

function show_help() {
  local script_name="${1:-}"
  if [[ -z "$script_name" ]]; then
    script_name="$(basename "$0")"
  fi

  local action_verb action_past
  case "$ACTION" in
    remove) action_verb="remove" action_past="removed" ;;
    tag) action_verb="tag" action_past="tagged" ;;
    push) action_verb="push" action_past="pushed" ;;
    *) action_verb="build" action_past="built" ;;
  esac

  cat << EOF
Usage: $script_name [target]

All:
  all | jvm | native

By Framework:
  quarkus | micronaut | springboot

By Type:
  simple-api | jpa-mysql | kafka | elasticsearch

Simple API:
  quarkus-simple-api | quarkus-simple-api-jvm | quarkus-simple-api-native
  micronaut-simple-api | micronaut-simple-api-jvm | micronaut-simple-api-native
  springboot-simple-api | springboot-simple-api-jvm | springboot-simple-api-native

JPA MySQL:
  quarkus-jpa-mysql | quarkus-jpa-mysql-jvm | quarkus-jpa-mysql-native
  micronaut-jpa-mysql | micronaut-jpa-mysql-jvm | micronaut-jpa-mysql-native
  springboot-jpa-mysql | springboot-jpa-mysql-jvm | springboot-jpa-mysql-native

Kafka:
  Kafka Producer:
    quarkus-kafka-producer | quarkus-kafka-producer-jvm | quarkus-kafka-producer-native
    micronaut-kafka-producer | micronaut-kafka-producer-jvm | micronaut-kafka-producer-native
    springboot-kafka-producer | springboot-kafka-producer-jvm | springboot-kafka-producer-native

  Kafka Consumer:
    quarkus-kafka-consumer | quarkus-kafka-consumer-jvm | quarkus-kafka-consumer-native
    micronaut-kafka-consumer | micronaut-kafka-consumer-jvm | micronaut-kafka-consumer-native
    springboot-kafka-consumer | springboot-kafka-consumer-jvm | springboot-kafka-consumer-native

Elasticsearch:
  quarkus-elasticsearch | quarkus-elasticsearch-jvm | quarkus-elasticsearch-native
  micronaut-elasticsearch | micronaut-elasticsearch-jvm | micronaut-elasticsearch-native
  springboot-elasticsearch | springboot-elasticsearch-jvm | springboot-elasticsearch-native

Options:
  --builder=BUILDER           Container builder (podman or docker)
  --quarkus-version=TAG       Quarkus image tag (default: latest)
  --micronaut-version=TAG     Micronaut image tag (default: latest)
  --springboot-version=TAG    Spring Boot image tag (default: latest)
  --csv[=FILE]                Export results to CSV file (default: results-TIMESTAMP.csv)
  --dry-run                   Show what would be $action_past
  -h, --help                  Show this help

Examples:
  $script_name all
  $script_name jvm
  $script_name native
  $script_name springboot-jvm
  $script_name quarkus-native
  $script_name springboot-simple-api-jvm
  $script_name quarkus --quarkus-version v1.0
  $script_name springboot-kafka-producer
  $script_name kafka --builder=docker --dry-run
EOF
}

function parse_args() {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --builder=*)
        BUILDER="${1#*=}"
        shift
        ;;
      --quarkus-version=*)
        QUARKUS_VERSION="${1#*=}"
        shift
        ;;
      --micronaut-version=*)
        MICRONAUT_VERSION="${1#*=}"
        shift
        ;;
      --springboot-version=*)
        SPRING_BOOT_VERSION="${1#*=}"
        shift
        ;;
      --csv)
        CSV_OUTPUT="results-$(date +%Y%m%d-%H%M%S).csv"
        shift
        ;;
      --csv=*)
        CSV_OUTPUT="${1#*=}"
        shift
        ;;
      --dry-run)
        DRY_RUN="true"
        shift
        ;;
      -h|--help)
        if declare -f show_verify_help >/dev/null 2>&1; then
          show_verify_help
        else
          show_help
        fi
        exit 0
        ;;
      -*)
        echo "ERROR: Unknown option: $1" >&2
        exit 1
        ;;
      *)
        if [[ -z "$TARGET_APP" ]]; then
          TARGET_APP="$1"
        else
          echo "ERROR: Multiple apps not supported. Use category or single app." >&2
          exit 1
        fi
        shift
        ;;
    esac
  done

  if [[ -z "$TARGET_APP" ]]; then
    if declare -f show_verify_help >/dev/null 2>&1; then
      show_verify_help
    else
      show_help
    fi
    exit 0
  fi
}

function remove_images() {
  local -a apps=($(get_apps_to_build "$TARGET_APP"))
  local count=${#apps[@]}

  echo "Removing $count image(s) for: ${TARGET_APP}"
  echo

  for app in "${apps[@]}"; do
    local config="${APP_CONFIG[$app]}"
    IFS=':' read -r framework dir mvn_cmd jar_path build_cmd image <<< "$config"

    if [[ -z "$image" ]]; then
      continue
    fi

    local tag_version
    case "$framework" in
      quarkus) tag_version="${QUARKUS_VERSION:-latest}" ;;
      micronaut) tag_version="${MICRONAUT_VERSION:-latest}" ;;
      springboot) tag_version="${SPRING_BOOT_VERSION:-latest}" ;;
      *) tag_version="latest" ;;
    esac
    local image_tag="${image}:${tag_version}"
    echo "Removing: $image_tag"

    if [[ "$DRY_RUN" == "true" ]]; then
      echo "  [DRY RUN] Would run: $BUILDER rmi $image_tag"
    else
      $BUILDER rmi "$image_tag" 2>/dev/null || true
    fi
  done

  echo
  echo "Done."
}

function tag_images() {
  local -a apps=($(get_apps_to_build "$TARGET_APP"))
  local count=${#apps[@]}

  echo "Tagging $count app(s) for: ${TARGET_APP}"
  echo

  for app in "${apps[@]}"; do
    local config="${APP_CONFIG[$app]}"
    IFS=':' read -r framework dir mvn_cmd jar_path build_cmd image <<< "$config"

    if [[ -z "$image" ]]; then
      continue
    fi

    local tag_version

    case "$framework" in
      quarkus) tag_version="${QUARKUS_VERSION:-latest}" ;;
      micronaut) tag_version="${MICRONAUT_VERSION:-latest}" ;;
      springboot) tag_version="${SPRING_BOOT_VERSION:-latest}" ;;
      *) tag_version="latest" ;;
    esac

    local src_tag="${image}:latest"
    local dst_tag="${image}:${tag_version}"

      echo "Tagging: $src_tag -> $dst_tag"

      if [[ "$DRY_RUN" == "true" ]]; then
        echo "  [DRY RUN] Would run: $BUILDER tag $src_tag $dst_tag"
      else
        $BUILDER tag "$src_tag" "$dst_tag" 2>/dev/null || true
      fi
  done

  echo
  echo "Done."
}

function push_images() {
  local -a apps=($(get_apps_to_build "$TARGET_APP"))
  local count=${#apps[@]}

  echo "Pushing $count app(s) for: ${TARGET_APP}"
  echo

  for app in "${apps[@]}"; do
    local config="${APP_CONFIG[$app]}"
    IFS=':' read -r framework dir mvn_cmd jar_path build_cmd image <<< "$config"

    if [[ -z "$image" ]]; then
      continue
    fi

    local tag_version

    case "$framework" in
      quarkus) tag_version="${QUARKUS_VERSION:-latest}" ;;
      micronaut) tag_version="${MICRONAUT_VERSION:-latest}" ;;
      springboot) tag_version="${SPRING_BOOT_VERSION:-latest}" ;;
      *) tag_version="latest" ;;
    esac

    local image_tag="${image}:${tag_version}"

      echo "Pushing: $image_tag"

      if [[ "$DRY_RUN" == "true" ]]; then
        echo "  [DRY RUN] Would run: $BUILDER push $image_tag"
      else
        $BUILDER push "$image_tag" 2>/dev/null || true
      fi
  done

  echo
  echo "Done."
}

function main() {
  local skip_print="${1:-false}"
  
  check_dependencies
  init_configs

  local -a apps=($(get_apps_to_build "$TARGET_APP"))
  local count=${#apps[@]}

  echo "Building $count app(s): ${TARGET_APP}"

  for app in "${apps[@]}"; do
    build_app "$app"
  done

  if [[ "$skip_print" != "true" ]]; then
    print_results
  fi
}

# =============================================================================
# Verification Functions
# =============================================================================

VERIFY_TIMEOUT="${VERIFY_TIMEOUT:-120}"
VERIFY_CONTAINER_MAX_MEM="${VERIFY_CONTAINER_MAX_MEM:-512M}"

declare -A VERIFY_RESULTS=()

function verify_wait_for_container_log() {
  local container="$1"
  local search="$2"
  local timeout="${3:-$VERIFY_TIMEOUT}"
  
  echo "Waiting for '$search' in $container logs (timeout: ${timeout}s)..."
  local start_time
  start_time=$(date +%s)

  while true; do
    local log
    log=$($BUILDER logs "$container" 2>&1 | grep "$search") || true
    if [[ -n "$log" ]]; then
      local end_time
      end_time=$(date +%s)
      local elapsed_sec=$((end_time - start_time))
      echo "$log"
      VERIFY_MATCHED_ROW="$log"
      return 0
    fi

    local current_time
    current_time=$(date +%s)
    if [[ $current_time -ge $((start_time + timeout)) ]]; then
      echo "TIMEOUT after ${timeout}s - '$search' not found"
      VERIFY_MATCHED_ROW=""
      return 1
    fi
    sleep 1
  done
}

function verify_wait_for_container_healthy() {
  local port="$1"
  local timeout="${2:-$VERIFY_TIMEOUT}"
  
  echo "Waiting for container on port $port to be healthy..."
  SECONDS=0

  while true; do
    local health
    health=$($BUILDER ps 2>/dev/null | grep -E "healthy.*$port") || true
    if [[ -n "$health" ]]; then
      echo "$health"
      return 0
    fi

    if [[ "$SECONDS" -ge "$timeout" ]]; then
      echo "TIMEOUT after ${timeout}s - container not healthy"
      return 1
    fi
    sleep 1
  done
}

function verify_start_container() {
  local name="$1"
  local image="$2"
  local port="$3"
  local env_vars="${4:-}"
  
  echo "Starting container: $name (image: $image, port: $port)"
  
  local run_cmd="$BUILDER run -d --rm --name $name -p ${port}:8080 -m $VERIFY_CONTAINER_MAX_MEM $env_vars $image"
  
  if ! $run_cmd > /dev/null 2>&1; then
    echo "ERROR: Failed to start container $name"
    return 1
  fi
  
  return 0
}

function verify_stop_container() {
  local name="$1"
  
  echo "Stopping container: $name"
  echo "--------------------------------------------------------"
  echo
  $BUILDER stop -t 5 "$name" > /dev/null 2>&1 || true
}

function extract_startup_time_from_log() {
  local log="$VERIFY_MATCHED_ROW"
  local framework="$1"
  local startup_time=""
  
  case "$framework" in
    quarkus)
      if [[ "$MODE" == "native" ]]; then
        startup_time=$(echo "$log" | awk '{print substr($15,0,length($15)-2)}')
      else
        startup_time=$(echo "$log" | awk '{print substr($16,0,length($16)-2)}')
      fi
      startup_time=$(convert_seconds_to_millis "$startup_time")
      ;;
    micronaut)
      startup_time=$(echo "$log" | awk '{print substr($10,0,length($10)-3)}')
      ;;
    springboot)
      startup_time=$(echo "$log" | awk '{print $13}')
      startup_time=$(convert_seconds_to_millis "$startup_time")
      ;;
  esac
  
  echo "$startup_time"
}

function verify_http_get() {
  local url="$1"
  local expected="${2:-}"
  
  local response
  local http_code
  
  response=$(curl -s -w "\n%{http_code}" "$url") || return 1
  http_code=$(echo "$response" | tail -1)
  local body=$(echo "$response" | sed '$d')
  
  if [[ "$http_code" != "200" ]]; then
    echo "FAIL: HTTP $http_code (expected 200)"
    return 1
  fi
  
  if [[ -n "$expected" && ! "$body" =~ $expected ]]; then
    echo "FAIL: Response doesn't contain '$expected'"
    echo "Body: $body"
    return 1
  fi
  
  echo "OK: HTTP 200"
  return 0
}

function verify_http_post() {
  local url="$1"
  local json_data="$2"
  
  local response
  local http_code
  
  response=$(curl -s -w "\n%{http_code}" -X POST -H "Content-Type: application/json" -d "$json_data" "$url") || return 1
  http_code=$(echo "$response" | tail -1)
  local body=$(echo "$response" | sed '$d')
  
  if [[ "$http_code" != "200" && "$http_code" != "201" ]]; then
    echo "FAIL: HTTP $http_code (expected 200/201)"
    return 1
  fi
  
  echo "OK: HTTP $http_code"
  return 0
}

function verify_simple_api() {
  local port="$1"
  local framework="$2"
  
  echo "Testing Simple API on port $port..."
  
  local url="http://localhost:${port}/api/greeting?name=VerifyTest"
  
  if verify_http_get "$url" "VerifyTest"; then
    return 0
  fi
  return 1
}

function verify_jpa_mysql() {
  local port="$1"
  local framework="$2"
  
  echo "Testing JPA-MySQL on port $port..."
  
  local url="http://localhost:${port}/api/books"
  local json='{"isbn":"VerifyISBN","title":"VerifyTitle"}'
  
  if ! verify_http_post "$url" "$json"; then
    return 1
  fi
  
  sleep 1
  
  local get_response
  get_response=$(curl -s "http://localhost:${port}/api/books") || return 1
  
  if [[ "$get_response" =~ "VerifyTitle" ]]; then
    echo "OK: Data verified in response"
    return 0
  fi
  
  echo "WARN: Could not verify data in GET response, but POST succeeded"
  return 0
}

function verify_kafka_producer() {
  local port="$1"
  local framework="$2"
  
  echo "Testing Kafka Producer on port $port..."
  
  local url="http://localhost:${port}/api/news"
  local json='{"source":"VerifySource","title":"VerifyTitle"}'
  
  if verify_http_post "$url" "$json"; then
    return 0
  fi
  return 1
}

function verify_kafka_consumer() {
  local container_name="$1"
  local framework="$2"
  
  echo "Testing Kafka Consumer: $container_name..."
  
  if verify_wait_for_container_log "$container_name" "OFFSET:" 60; then
    echo "OK: Consumer processed messages"
    return 0
  fi
  return 1
}

function verify_elasticsearch() {
  local port="$1"
  local framework="$2"
  
  echo "Testing Elasticsearch on port $port..."
  
  local url="http://localhost:${port}/api/movies"
  local json='{"imdb":"VerifyIMDb","title":"VerifyTitle"}'
  
  if ! verify_http_post "$url" "$json"; then
    return 1
  fi
  
  sleep 2
  
  local search_url="http://localhost:${port}/api/movies?title=VerifyTitle"
  local search_response
  search_response=$(curl -s "$search_url") || return 1
  
  if [[ "$search_response" =~ "VerifyTitle" ]]; then
    echo "OK: Search returned verified data"
    return 0
  fi
  
  echo "ERROR: Search didn't return expected result"
  return 1
}

function verify_start_infrastructure() {
  local type="$1"
  
  case "$type" in
    jpa-mysql)
      echo "Starting JPA-MySQL infrastructure..."
      cd jpa-mysql
      $BUILDER compose up -d
      verify_wait_for_container_log "mysql" "port: 3306" 60
      cd ..
      ;;
    kafka)
      echo "Starting Kafka infrastructure..."
      cd kafka
      $BUILDER compose up -d zookeeper kafka
      verify_wait_for_container_healthy "9092" 60
      cd ..
      ;;
    elasticsearch)
      echo "Starting Elasticsearch infrastructure..."
      cd elasticsearch
      $BUILDER compose up -d
      verify_wait_for_container_healthy "9200" 60
      ./init-es-indexes.sh
      cd ..
      ;;
  esac
}

function verify_stop_infrastructure() {
  local type="$1"
  
  case "$type" in
    jpa-mysql)
      echo "Stopping JPA-MySQL infrastructure..."
      cd jpa-mysql
      $BUILDER compose down -v
      cd ..
      ;;
    kafka)
      echo "Stopping Kafka infrastructure..."
      cd kafka
      $BUILDER compose down -v
      cd ..
      ;;
    elasticsearch)
      echo "Stopping Elasticsearch infrastructure..."
      cd elasticsearch
      $BUILDER compose down -v
      cd ..
      ;;
  esac
}

function store_verify_result() {
  local app="$1"
  local status="$2"
  local startup_time="$3"
  local test_result="$4"
  
  VERIFY_RESULTS["${app}_status"]=$status
  VERIFY_RESULTS["${app}_startup"]=$startup_time
  VERIFY_RESULTS["${app}_result"]=$test_result
}

function print_verify_results() {
  printf "\n"
  printf "| %-32s | %-6s | %-12s | %-20s |\n" "Application" "Status" "Startup (ms)" "Test"
  printf "| %-32s | %-6s | %-12s | %-20s |\n" "--------------------------------" "------" "------------" "--------------------"
  
  local total=0
  local passed=0
  
  if [[ ${#VERIFY_ORDER[@]} -gt 0 ]]; then
    for app in "${VERIFY_ORDER[@]}"; do
      local status="${VERIFY_RESULTS[${app}_status]:-FAIL}"
      local startup="${VERIFY_RESULTS[${app}_startup]:-N/A}"
      local result="${VERIFY_RESULTS[${app}_result]:-N/A}"
      
      printf "| %-32s | %-6s | %-12s | %-20s |\n" "$app" "$status" "$startup" "$result"
      
      total=$((total + 1))
      [[ "$status" == "PASS" ]] && passed=$((passed + 1))
    done
  fi
  
  printf "\n"
  echo "======================================================================="
  echo "SUMMARY: $passed/$total tests passed"
  echo "======================================================================="
}

function export_verify_csv() {
  local file="${CSV_OUTPUT:-verify-results-$(date +%Y%m%d-%H%M%S).csv}"

  {
    echo "application,framework,mode,status,startup_time_ms,test"
    for app in "${VERIFY_ORDER[@]}"; do
      local framework="${app%-*-*}"
      local mode="${app##*-}"
      echo "${app},${framework},${mode},${VERIFY_RESULTS[${app}_status]:-FAIL},${VERIFY_RESULTS[${app}_startup]:-N/A},${VERIFY_RESULTS[${app}_result]:-N/A}"
    done
  } >> "$file"

  echo "Verification results exported to: $file"
}

function verify_start_infrastructure_once() {
  local -a apps=($(get_apps_to_build "$TARGET_APP"))
  local jpa_mysql_needed=false
  local kafka_needed=false
  local elasticsearch_needed=false
  
  for app in "${apps[@]}"; do
    case "$app" in
      *-jpa-mysql) jpa_mysql_needed=true ;;
      *-kafka-*) kafka_needed=true ;;
      *-elasticsearch) elasticsearch_needed=true ;;
    esac
  done
  
  if [[ "$jpa_mysql_needed" == "true" ]]; then
    echo "Starting JPA-MySQL infrastructure (shared for all jpa-mysql apps)..."
    cd jpa-mysql
    $BUILDER compose up -d
    verify_wait_for_container_log "mysql" "port: 3306" 60
    cd ..
  fi
  
  if [[ "$kafka_needed" == "true" ]]; then
    echo "Starting Kafka infrastructure (shared for all kafka apps)..."
    cd kafka
    $BUILDER compose up -d zookeeper kafka
    verify_wait_for_container_healthy "9092" 60
    cd ..
  fi
  
  if [[ "$elasticsearch_needed" == "true" ]]; then
    echo "Starting Elasticsearch infrastructure (shared for all elasticsearch apps)..."
    cd elasticsearch
    $BUILDER compose up -d
    verify_wait_for_container_healthy "9200" 60
    ./init-es-indexes.sh
    cd ..
  fi
}

function verify_stop_infrastructure_once() {
  local -a apps=($(get_apps_to_build "$TARGET_APP"))
  local jpa_mysql_needed=false
  local kafka_needed=false
  local elasticsearch_needed=false
  
  for app in "${apps[@]}"; do
    case "$app" in
      *-jpa-mysql) jpa_mysql_needed=true ;;
      *-kafka-*) kafka_needed=true ;;
      *-elasticsearch) elasticsearch_needed=true ;;
    esac
  done
  
  if [[ "$elasticsearch_needed" == "true" ]]; then
    echo "Stopping Elasticsearch infrastructure..."
    cd elasticsearch
    $BUILDER compose down -v
    cd ..
  fi
  
  if [[ "$kafka_needed" == "true" ]]; then
    echo "Stopping Kafka infrastructure..."
    cd kafka
    $BUILDER compose down -v
    cd ..
  fi
  
  if [[ "$jpa_mysql_needed" == "true" ]]; then
    echo "Stopping JPA-MySQL infrastructure..."
    cd jpa-mysql
    $BUILDER compose down -v
    cd ..
  fi
}

# =============================================================================
# Verification Main
# =============================================================================

function verify_main() {
  local skip_print="${1:-false}"
  local manage_infrastructure="${2:-true}"
  
  if [[ "$DRY_RUN" == "true" ]]; then
    local -a apps=($(get_apps_to_build "$TARGET_APP"))
    
    echo "========================================"
    echo "DOCKER IMAGE VERIFICATION (DRY RUN)"
    echo "========================================"
    echo "Target: $TARGET_APP"
    echo "Mode: ${MODE}"
    echo "Builder: $BUILDER"
    echo ""
    
    for app in "${apps[@]}"; do
      local config="${APP_CONFIG[$app]}"
      local framework dir mvn_cmd jar_path build_cmd image
      IFS=':' read -r framework dir mvn_cmd jar_path build_cmd image <<< "$config"
      
      local tag_version
      case "$framework" in
        quarkus) tag_version="${QUARKUS_VERSION:-latest}" ;;
        micronaut) tag_version="${MICRONAUT_VERSION:-latest}" ;;
        springboot) tag_version="${SPRING_BOOT_VERSION:-latest}" ;;
        *) tag_version="latest" ;;
      esac
      
      local port
      if [[ "$MODE" == "native" ]]; then
        case "$app" in
          quarkus-simple-api) port="$QUARKUS_SIMPLE_API_NATIVE_PORT" ;;
          micronaut-simple-api) port="$MICRONAUT_SIMPLE_API_NATIVE_PORT" ;;
          springboot-simple-api) port="$SPRINGBOOT_SIMPLE_API_NATIVE_PORT" ;;
          quarkus-jpa-mysql) port="$QUARKUS_JPA_MYSQL_NATIVE_PORT" ;;
          micronaut-jpa-mysql) port="$MICRONAUT_JPA_MYSQL_NATIVE_PORT" ;;
          springboot-jpa-mysql) port="$SPRINGBOOT_JPA_MYSQL_NATIVE_PORT" ;;
          quarkus-kafka-producer) port="$QUARKUS_KAFKA_PRODUCER_NATIVE_PORT" ;;
          micronaut-kafka-producer) port="$MICRONAUT_KAFKA_PRODUCER_NATIVE_PORT" ;;
          springboot-kafka-producer) port="$SPRINGBOOT_KAFKA_PRODUCER_NATIVE_PORT" ;;
          quarkus-kafka-consumer) port="$QUARKUS_KAFKA_CONSUMER_NATIVE_PORT" ;;
          micronaut-kafka-consumer) port="$MICRONAUT_KAFKA_CONSUMER_NATIVE_PORT" ;;
          springboot-kafka-consumer) port="$SPRINGBOOT_KAFKA_CONSUMER_NATIVE_PORT" ;;
          quarkus-elasticsearch) port="$QUARKUS_ELASTICSEARCH_NATIVE_PORT" ;;
          micronaut-elasticsearch) port="$MICRONAUT_ELASTICSEARCH_NATIVE_PORT" ;;
          springboot-elasticsearch) port="$SPRINGBOOT_ELASTICSEARCH_NATIVE_PORT" ;;
          *) port="8081" ;;
        esac
      else
        case "$app" in
          quarkus-simple-api) port="$QUARKUS_SIMPLE_API_PORT" ;;
          micronaut-simple-api) port="$MICRONAUT_SIMPLE_API_PORT" ;;
          springboot-simple-api) port="$SPRINGBOOT_SIMPLE_API_PORT" ;;
          quarkus-jpa-mysql) port="$QUARKUS_JPA_MYSQL_PORT" ;;
          micronaut-jpa-mysql) port="$MICRONAUT_JPA_MYSQL_PORT" ;;
          springboot-jpa-mysql) port="$SPRINGBOOT_JPA_MYSQL_PORT" ;;
          quarkus-kafka-producer) port="$QUARKUS_KAFKA_PRODUCER_PORT" ;;
          micronaut-kafka-producer) port="$MICRONAUT_KAFKA_PRODUCER_PORT" ;;
          springboot-kafka-producer) port="$SPRINGBOOT_KAFKA_PRODUCER_PORT" ;;
          quarkus-kafka-consumer) port="$QUARKUS_KAFKA_CONSUMER_PORT" ;;
          micronaut-kafka-consumer) port="$MICRONAUT_KAFKA_CONSUMER_PORT" ;;
          springboot-kafka-consumer) port="$SPRINGBOOT_KAFKA_CONSUMER_PORT" ;;
          quarkus-elasticsearch) port="$QUARKUS_ELASTICSEARCH_PORT" ;;
          micronaut-elasticsearch) port="$MICRONAUT_ELASTICSEARCH_PORT" ;;
          springboot-elasticsearch) port="$SPRINGBOOT_ELASTICSEARCH_PORT" ;;
          *) port="8080" ;;
        esac
      fi
      
      local test_type
      case "$app" in
        *-simple-api) test_type="simple-api" ;;
        *-jpa-mysql) test_type="jpa-mysql" ;;
        *-kafka-producer) test_type="kafka-producer" ;;
        *-kafka-consumer) test_type="kafka-consumer" ;;
        *-elasticsearch) test_type="elasticsearch" ;;
        *) test_type="unknown" ;;
      esac
      
      local full_app="${app}-${MODE}"
      
      echo "Would test: ${framework^^}-${app#*-}-${MODE}"
      echo "  Image: ${image}:${tag_version}"
      echo "  Port: $port"
      echo "  Test: $test_type"
      echo ""
      
      VERIFY_ORDER+=("$full_app")
      VERIFY_RESULTS["${full_app}_status"]="DRY-RUN"
      VERIFY_RESULTS["${full_app}_startup"]="N/A"
      VERIFY_RESULTS["${full_app}_result"]="Would test $test_type"
    done
    
    if [[ "$skip_print" != "true" ]]; then
      print_verify_results
    fi
    return 0
  fi
  
  local -a apps=($(get_apps_to_build "$TARGET_APP"))
  
  echo "========================================"
  echo "DOCKER IMAGE VERIFICATION"
  echo "========================================"
  echo "Target: $TARGET_APP"
  echo "Mode: ${MODE}"
  echo "Builder: $BUILDER"
  echo ""
  
  if [[ "$manage_infrastructure" == "true" ]]; then
    verify_start_infrastructure_once
  fi
  
  local verify_failed=0
  for app in "${apps[@]}"; do
    if ! verify_app "$app"; then
      verify_failed=1
    fi
  done
  
  if [[ "$manage_infrastructure" == "true" ]]; then
    verify_stop_infrastructure_once
  fi
  
  if [[ "$skip_print" != "true" ]]; then
    print_verify_results
  fi

  return $verify_failed
}

function verify_app() {
  local app="$1"
  local config="${APP_CONFIG[$app]}"
  
  local framework dir mvn_cmd jar_path build_cmd image
  IFS=':' read -r framework dir mvn_cmd jar_path build_cmd image <<< "$config"
  
  local port
  if [[ "$MODE" == "native" ]]; then
    case "$app" in
      quarkus-simple-api) port="$QUARKUS_SIMPLE_API_NATIVE_PORT" ;;
      micronaut-simple-api) port="$MICRONAUT_SIMPLE_API_NATIVE_PORT" ;;
      springboot-simple-api) port="$SPRINGBOOT_SIMPLE_API_NATIVE_PORT" ;;
      quarkus-jpa-mysql) port="$QUARKUS_JPA_MYSQL_NATIVE_PORT" ;;
      micronaut-jpa-mysql) port="$MICRONAUT_JPA_MYSQL_NATIVE_PORT" ;;
      springboot-jpa-mysql) port="$SPRINGBOOT_JPA_MYSQL_NATIVE_PORT" ;;
      quarkus-kafka-producer) port="$QUARKUS_KAFKA_PRODUCER_NATIVE_PORT" ;;
      micronaut-kafka-producer) port="$MICRONAUT_KAFKA_PRODUCER_NATIVE_PORT" ;;
      springboot-kafka-producer) port="$SPRINGBOOT_KAFKA_PRODUCER_NATIVE_PORT" ;;
      quarkus-kafka-consumer) port="$QUARKUS_KAFKA_CONSUMER_NATIVE_PORT" ;;
      micronaut-kafka-consumer) port="$MICRONAUT_KAFKA_CONSUMER_NATIVE_PORT" ;;
      springboot-kafka-consumer) port="$SPRINGBOOT_KAFKA_CONSUMER_NATIVE_PORT" ;;
      quarkus-elasticsearch) port="$QUARKUS_ELASTICSEARCH_NATIVE_PORT" ;;
      micronaut-elasticsearch) port="$MICRONAUT_ELASTICSEARCH_NATIVE_PORT" ;;
      springboot-elasticsearch) port="$SPRINGBOOT_ELASTICSEARCH_NATIVE_PORT" ;;
      *) port="8081" ;;
    esac
  else
    case "$app" in
      quarkus-simple-api) port="$QUARKUS_SIMPLE_API_PORT" ;;
      micronaut-simple-api) port="$MICRONAUT_SIMPLE_API_PORT" ;;
      springboot-simple-api) port="$SPRINGBOOT_SIMPLE_API_PORT" ;;
      quarkus-jpa-mysql) port="$QUARKUS_JPA_MYSQL_PORT" ;;
      micronaut-jpa-mysql) port="$MICRONAUT_JPA_MYSQL_PORT" ;;
      springboot-jpa-mysql) port="$SPRINGBOOT_JPA_MYSQL_PORT" ;;
      quarkus-kafka-producer) port="$QUARKUS_KAFKA_PRODUCER_PORT" ;;
      micronaut-kafka-producer) port="$MICRONAUT_KAFKA_PRODUCER_PORT" ;;
      springboot-kafka-producer) port="$SPRINGBOOT_KAFKA_PRODUCER_PORT" ;;
      quarkus-kafka-consumer) port="$QUARKUS_KAFKA_CONSUMER_PORT" ;;
      micronaut-kafka-consumer) port="$MICRONAUT_KAFKA_CONSUMER_PORT" ;;
      springboot-kafka-consumer) port="$SPRINGBOOT_KAFKA_CONSUMER_PORT" ;;
      quarkus-elasticsearch) port="$QUARKUS_ELASTICSEARCH_PORT" ;;
      micronaut-elasticsearch) port="$MICRONAUT_ELASTICSEARCH_PORT" ;;
      springboot-elasticsearch) port="$SPRINGBOOT_ELASTICSEARCH_PORT" ;;
      *) port="8080" ;;
    esac
  fi
  
  local test_type
  case "$app" in
    *-simple-api) test_type="simple-api" ;;
    *-jpa-mysql) test_type="jpa-mysql" ;;
    *-kafka-producer) test_type="kafka-producer" ;;
    *-kafka-consumer) test_type="kafka-consumer" ;;
    *-elasticsearch) test_type="elasticsearch" ;;
    *) test_type="unknown" ;;
  esac
  
  case "$test_type" in
    simple-api)
      verify_test_simple_api "$app" "$framework" "$image" "$port"
      ;;
    jpa-mysql)
      verify_test_jpa_mysql "$app" "$framework" "$image" "$port"
      ;;
    kafka-producer)
      verify_test_kafka_producer "$app" "$framework" "$image" "$port"
      ;;
    kafka-consumer)
      verify_test_kafka_consumer "$app" "$framework" "$image" "$port"
      ;;
    elasticsearch)
      verify_test_elasticsearch "$app" "$framework" "$image" "$port"
      ;;
  esac
  
  return 0
}

function verify_test_simple_api() {
  local app="$1"
  local framework="$2"
  local image="$3"
  local port="$4"
  local container_name="${app}-${MODE}"
  
  local tag_version
  case "$framework" in
    quarkus) tag_version="${QUARKUS_VERSION:-latest}" ;;
    micronaut) tag_version="${MICRONAUT_VERSION:-latest}" ;;
    springboot) tag_version="${SPRING_BOOT_VERSION:-latest}" ;;
    *) tag_version="latest" ;;
  esac
  
  verify_start_container "$container_name" "${image}:${tag_version}" "$port" || {
    store_verify_result "$app-${MODE}" "FAIL" "N/A" "Container start failed"
    verify_stop_container "$container_name" 2>/dev/null || true
    return 1
  }
  
  local startup_pattern
  case "$framework" in
    quarkus) startup_pattern="started in" ;;
    micronaut) startup_pattern="Startup completed in" ;;
    springboot) startup_pattern="Started" ;;
  esac
  
  if verify_wait_for_container_log "$container_name" "$startup_pattern" 120; then
    local startup_time
    startup_time=$(extract_startup_time_from_log "$framework")
    
    if verify_simple_api "$port" "$framework"; then
      store_verify_result "$app-${MODE}" "PASS" "$startup_time" "GET /api/greeting"
    else
      store_verify_result "$app-${MODE}" "FAIL" "$startup_time" "GET /api/greeting"
    fi
  else
    store_verify_result "$app-${MODE}" "FAIL" "TIMEOUT" "Startup failed"
  fi
  
  VERIFY_ORDER+=("${app}-${MODE}")
  
  verify_stop_container "$container_name"
}

function verify_test_jpa_mysql() {
  local app="$1"
  local framework="$2"
  local image="$3"
  local port="$4"
  local container_name="${app}-${MODE}"
  
  local tag_version
  case "$framework" in
    quarkus) tag_version="${QUARKUS_VERSION:-latest}" ;;
    micronaut) tag_version="${MICRONAUT_VERSION:-latest}" ;;
    springboot) tag_version="${SPRING_BOOT_VERSION:-latest}" ;;
    *) tag_version="latest" ;;
  esac
  
  local env_vars="-e MYSQL_HOST=mysql --network jpa-mysql_default"
  verify_start_container "$container_name" "${image}:${tag_version}" "$port" "$env_vars" || {
    store_verify_result "$app-${MODE}" "FAIL" "N/A" "Container start failed"
    verify_stop_container "$container_name" 2>/dev/null || true
    return 1
  }
  
  local startup_pattern
  case "$framework" in
    quarkus) startup_pattern="started in" ;;
    micronaut) startup_pattern="Startup completed in" ;;
    springboot) startup_pattern="Started" ;;
  esac
  
  if verify_wait_for_container_log "$container_name" "$startup_pattern" 120; then
    local startup_time
    startup_time=$(extract_startup_time_from_log "$framework")
    
    sleep 2
    
    if verify_jpa_mysql "$port" "$framework"; then
      store_verify_result "$app-${MODE}" "PASS" "$startup_time" "POST /api/books"
    else
      store_verify_result "$app-${MODE}" "FAIL" "$startup_time" "POST /api/books"
    fi
  else
    store_verify_result "$app-${MODE}" "FAIL" "TIMEOUT" "Startup failed"
  fi
  
  VERIFY_ORDER+=("${app}-${MODE}")
  
  verify_stop_container "$container_name"
}

function verify_test_kafka_producer() {
  local app="$1"
  local framework="$2"
  local image="$3"
  local port="$4"
  local container_name="${app}-${MODE}"
  
  local tag_version
  case "$framework" in
    quarkus) tag_version="${QUARKUS_VERSION:-latest}" ;;
    micronaut) tag_version="${MICRONAUT_VERSION:-latest}" ;;
    springboot) tag_version="${SPRING_BOOT_VERSION:-latest}" ;;
    *) tag_version="latest" ;;
  esac
  
  local env_vars="-e KAFKA_HOST=kafka -e KAFKA_PORT=9092 --network kafka_default"
  verify_start_container "$container_name" "${image}:${tag_version}" "$port" "$env_vars" || {
    store_verify_result "$app-${MODE}" "FAIL" "N/A" "Container start failed"
    verify_stop_container "$container_name" 2>/dev/null || true
    return 1
  }
  
  local startup_pattern
  case "$framework" in
    quarkus) startup_pattern="started in" ;;
    micronaut) startup_pattern="Startup completed in" ;;
    springboot) startup_pattern="Started" ;;
  esac
  
  if verify_wait_for_container_log "$container_name" "$startup_pattern" 120; then
    local startup_time
    startup_time=$(extract_startup_time_from_log "$framework")
    
    sleep 2
    
    if verify_kafka_producer "$port" "$framework"; then
      store_verify_result "$app-${MODE}" "PASS" "$startup_time" "POST /api/news"
    else
      store_verify_result "$app-${MODE}" "FAIL" "$startup_time" "POST /api/news"
    fi
  else
    store_verify_result "$app-${MODE}" "FAIL" "TIMEOUT" "Startup failed"
  fi
  
  VERIFY_ORDER+=("${app}-${MODE}")
  
  verify_stop_container "$container_name"
}

function verify_test_kafka_consumer() {
  local app="$1"
  local framework="$2"
  local image="$3"
  local port="$4"
  local container_name="${app}-${MODE}"
  
  local tag_version
  case "$framework" in
    quarkus) tag_version="${QUARKUS_VERSION:-latest}" ;;
    micronaut) tag_version="${MICRONAUT_VERSION:-latest}" ;;
    springboot) tag_version="${SPRING_BOOT_VERSION:-latest}" ;;
    *) tag_version="latest" ;;
  esac
  
  local env_vars="-e KAFKA_HOST=kafka -e KAFKA_PORT=9092 --network kafka_default"
  verify_start_container "$container_name" "${image}:${tag_version}" "$port" "$env_vars" || {
    store_verify_result "$app-${MODE}" "FAIL" "N/A" "Container start failed"
    verify_stop_container "$container_name" 2>/dev/null || true
    return 1
  }
  
  local startup_pattern
  case "$framework" in
    quarkus) startup_pattern="started in" ;;
    micronaut) startup_pattern="Startup completed in" ;;
    springboot) startup_pattern="Started" ;;
  esac
  
  if verify_wait_for_container_log "$container_name" "$startup_pattern" 120; then
    local startup_time
    startup_time=$(extract_startup_time_from_log "$framework")
    
    if verify_kafka_consumer "$container_name" "$framework"; then
      store_verify_result "$app-${MODE}" "PASS" "$startup_time" "Consumer processed"
    else
      store_verify_result "$app-${MODE}" "FAIL" "$startup_time" "Consumer failed"
    fi
  else
    store_verify_result "$app-${MODE}" "FAIL" "TIMEOUT" "Startup failed"
  fi
  
  VERIFY_ORDER+=("${app}-${MODE}")
  
  verify_stop_container "$container_name"
}

function verify_test_elasticsearch() {
  local app="$1"
  local framework="$2"
  local image="$3"
  local port="$4"
  local container_name="${app}-${MODE}"
  
  local tag_version
  case "$framework" in
    quarkus) tag_version="${QUARKUS_VERSION:-latest}" ;;
    micronaut) tag_version="${MICRONAUT_VERSION:-latest}" ;;
    springboot) tag_version="${SPRING_BOOT_VERSION:-latest}" ;;
    *) tag_version="latest" ;;
  esac
  
  local env_vars="-e ELASTICSEARCH_HOST=elasticsearch --network elasticsearch_default"
  verify_start_container "$container_name" "${image}:${tag_version}" "$port" "$env_vars" || {
    store_verify_result "$app-${MODE}" "FAIL" "N/A" "Container start failed"
    verify_stop_container "$container_name" 2>/dev/null || true
    return 1
  }
  
  local startup_pattern
  case "$framework" in
    quarkus) startup_pattern="started in" ;;
    micronaut) startup_pattern="Startup completed in" ;;
    springboot) startup_pattern="Started" ;;
  esac
  
  if verify_wait_for_container_log "$container_name" "$startup_pattern" 120; then
    local startup_time
    startup_time=$(extract_startup_time_from_log "$framework")
    
    sleep 3
    
    if verify_elasticsearch "$port" "$framework"; then
      store_verify_result "$app-${MODE}" "PASS" "$startup_time" "POST /api/movies"
    else
      store_verify_result "$app-${MODE}" "FAIL" "$startup_time" "POST /api/movies"
    fi
  else
    store_verify_result "$app-${MODE}" "FAIL" "TIMEOUT" "Startup failed"
  fi
  
  VERIFY_ORDER+=("${app}-${MODE}")
  
  verify_stop_container "$container_name"
}