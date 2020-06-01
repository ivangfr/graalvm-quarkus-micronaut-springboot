#!/usr/bin/env bash

curl -X PUT localhost:9200/quarkus.movies -H "Content-Type: application/json" -d @movies-mapping.json
curl -X PUT localhost:9200/micronaut.movies -H "Content-Type: application/json" -d @movies-mapping.json
curl -X PUT localhost:9200/springboot.movies -H "Content-Type: application/json" -d @movies-mapping.json
