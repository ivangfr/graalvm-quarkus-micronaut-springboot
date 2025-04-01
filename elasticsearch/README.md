# graalvm-quarkus-micronaut-springboot
## `> elasticsearch`

In this category, we have implemented three versions of a Restful API for handling Movies in `Elasticsearch` using `Quarkus`, `Micronaut` and `Spring Boot` Frameworks.

## Applications

- ### [quarkus-elasticsearch](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/elasticsearch/quarkus-elasticsearch#graalvm-quarkus-micronaut-springboot)
- ### [micronaut-elasticsearch](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/elasticsearch/micronaut-elasticsearch#graalvm-quarkus-micronaut-springboot)
- ### [springboot-elasticsearch](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/elasticsearch/springboot-elasticsearch#graalvm-quarkus-micronaut-springboot)

## Dependency version

| Framework   | Elasticsearch |
|-------------|---------------|
| Quarkus     | 8.17.2        |
| Micronaut   | 8.15.3        |
| Spring Boot | 8.15.5        |

## Start Environment

- Open a terminal and navigate to the `graalvm-quarkus-micronaut-springboot/elasticsearch` folder.

- Run the command:
  ```bash
  podman compose up -d
  ```

- Wait for `Elasticsearch` container to be up and running. To check it, run:
  ```bash
  podman compose ps
  ```

- Finally, run the script below to initialize the `Elasticsearch` indexes:
  ```bash
  ./init-es-indexes.sh
  ```

## Useful Commands

- **Elasticsearch**

  - Reset indexes script (make sure you are in the `graalvm-quarkus-micronaut-springboot/elasticsearch` folder):
    ```bash
    ./init-es-indexes.sh
    ```

  - Check indexes:
    ```bash
    curl "localhost:9200/_cat/indices?v"
    ```

  - Perform search:
    ```bash
    curl "localhost:9200/quarkus.movies.jvm/_search?pretty"
    curl "localhost:9200/micronaut.movies.jvm/_search?pretty"
    curl "localhost:9200/springboot.movies.jvm/_search?pretty"

    curl "localhost:9200/quarkus.movies.native/_search?pretty"
    curl "localhost:9200/micronaut.movies.native/_search?pretty"
    curl "localhost:9200/springboot.movies.native/_search?pretty"
    ```

## Shutdown

- In a terminal, make sure you are in the `graalvm-quarkus-micronaut-springboot/elasticsearch` folder.

- To stop and remove compose containers, networks and volumes, run:
  ```bash
  podman compose down -v
  ```
