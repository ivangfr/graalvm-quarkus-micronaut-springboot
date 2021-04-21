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

echo
echo "Creating indexes"
echo "----------------"
curl -X PUT localhost:9200/quarkus.movies.jvm -H "Content-Type: application/json" -d @movies-mapping.json
curl -X PUT localhost:9200/micronaut.movies.jvm -H "Content-Type: application/json" -d @movies-mapping.json
curl -X PUT localhost:9200/springboot.movies.jvm -H "Content-Type: application/json" -d @movies-mapping.json
curl -X PUT localhost:9200/quarkus.movies.native -H "Content-Type: application/json" -d @movies-mapping.json
curl -X PUT localhost:9200/micronaut.movies.native -H "Content-Type: application/json" -d @movies-mapping.json
curl -X PUT localhost:9200/springboot.movies.native -H "Content-Type: application/json" -d @movies-mapping.json
