#!/usr/bin/env bash

echo
echo "Deleting existing indexes"
echo "-------------------------"
curl -X DELETE localhost:9200/quarkus.movies.jvm
curl -X DELETE localhost:9200/micronaut.movies.jvm
curl -X DELETE localhost:9200/springboot.movies.jvm
curl -X DELETE localhost:9200/quarkus.movies.native
curl -X DELETE localhost:9200/micronaut.movies.native
curl -X DELETE localhost:9200/springboot.movies.native
echo

echo "Fix High Disk Watermark"
echo "-----------------------"
# Reference: https://www.elastic.co/guide/en/elasticsearch/reference/current/fix-watermark-errors.html

curl -X PUT localhost:9200/_cluster/settings \
  -H "Content-Type: application/json" \
  -d '{ "persistent": { "cluster.routing.allocation.disk.watermark.low": "90%", "cluster.routing.allocation.disk.watermark.low.max_headroom": "100GB", "cluster.routing.allocation.disk.watermark.high": "95%", "cluster.routing.allocation.disk.watermark.high.max_headroom": "20GB", "cluster.routing.allocation.disk.watermark.flood_stage": "97%", "cluster.routing.allocation.disk.watermark.flood_stage.max_headroom": "5GB", "cluster.routing.allocation.disk.watermark.flood_stage.frozen": "97%", "cluster.routing.allocation.disk.watermark.flood_stage.frozen.max_headroom": "5GB" } }'

echo
echo "Creating indexes"
echo "----------------"
curl -X PUT localhost:9200/quarkus.movies.jvm -H "Content-Type: application/json" -d @movies-mapping.json
curl -X PUT localhost:9200/micronaut.movies.jvm -H "Content-Type: application/json" -d @movies-mapping.json
curl -X PUT localhost:9200/springboot.movies.jvm -H "Content-Type: application/json" -d @movies-mapping.json
curl -X PUT localhost:9200/quarkus.movies.native -H "Content-Type: application/json" -d @movies-mapping.json
curl -X PUT localhost:9200/micronaut.movies.native -H "Content-Type: application/json" -d @movies-mapping.json
curl -X PUT localhost:9200/springboot.movies.native -H "Content-Type: application/json" -d @movies-mapping.json
