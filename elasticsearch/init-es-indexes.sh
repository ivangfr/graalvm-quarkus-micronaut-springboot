#!/usr/bin/env bash

echo
echo "Deleting existing indexes"
echo "-------------------------"
curl -X DELETE localhost:9200/quarkus.movies
curl -X DELETE localhost:9200/micronaut.movies
curl -X DELETE localhost:9200/springboot.movies
echo

echo
echo "Creating indexes"
echo "----------------"
curl -X PUT localhost:9200/quarkus.movies -H "Content-Type: application/json" -d @movies-mapping.json
curl -X PUT localhost:9200/micronaut.movies -H "Content-Type: application/json" -d @movies-mapping.json
curl -X PUT localhost:9200/springboot.movies -H "Content-Type: application/json" -d @movies-mapping.json
