#!/usr/bin/env bash

set -e

ES_MAPPING="/Users/ivan.franchin/github-projects/graalvm-quarkus-micronaut-springboot/elasticsearch/movies-mapping.json"

echo
echo "Deleting existing indexes"
echo "-------------------------"
curl -sf -X DELETE localhost:9200/quarkus.movies.jvm || true
curl -sf -X DELETE localhost:9200/micronaut.movies.jvm || true
curl -sf -X DELETE localhost:9200/springboot.movies.jvm || true
curl -sf -X DELETE localhost:9200/quarkus.movies.native || true
curl -sf -X DELETE localhost:9200/micronaut.movies.native || true
curl -sf -X DELETE localhost:9200/springboot.movies.native || true
echo

echo "Fix High Disk Watermark"
echo "-----------------------"
# Reference: https://stackoverflow.com/questions/63880017/elasticsearch-docker-flood-stage-disk-watermark-95-exceeded

curl -sf -X PUT http://localhost:9200/_cluster/settings \
  -H "Content-Type: application/json" \
  -d '{ "transient": { "cluster.routing.allocation.disk.threshold_enabled": false } }'

curl -sf -X PUT http://localhost:9200/_all/_settings \
  -H "Content-Type: application/json" \
  -d '{ "index.blocks.read_only_allow_delete": null }' || true

echo
echo
echo "Creating indexes"
echo "----------------"
curl -sf -X PUT localhost:9200/quarkus.movies.jvm -H "Content-Type: application/json" -d @"$ES_MAPPING"
curl -sf -X PUT localhost:9200/micronaut.movies.jvm -H "Content-Type: application/json" -d @"$ES_MAPPING"
curl -sf -X PUT localhost:9200/springboot.movies.jvm -H "Content-Type: application/json" -d @"$ES_MAPPING"
curl -sf -X PUT localhost:9200/quarkus.movies.native -H "Content-Type: application/json" -d @"$ES_MAPPING"
curl -sf -X PUT localhost:9200/micronaut.movies.native -H "Content-Type: application/json" -d @"$ES_MAPPING"
curl -sf -X PUT localhost:9200/springboot.movies.native -H "Content-Type: application/json" -d @"$ES_MAPPING"
echo