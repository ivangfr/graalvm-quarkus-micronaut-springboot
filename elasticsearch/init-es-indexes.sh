#!/usr/bin/env bash

curl -X DELETE localhost:9200/quarkus.movies
curl -X DELETE localhost:9200/micronaut.movies
curl -X DELETE localhost:9200/springboot.movies

curl -X PUT localhost:9200/quarkus.movies -H "Content-Type: application/json" -d @movies-mapping.json
curl -X PUT localhost:9200/micronaut.movies -H "Content-Type: application/json" -d @movies-mapping.json
curl -X PUT localhost:9200/springboot.movies -H "Content-Type: application/json" -d @movies-mapping.json
