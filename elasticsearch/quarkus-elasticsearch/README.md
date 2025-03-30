# graalvm-quarkus-micronaut-springboot
## `> elasticsearch > quarkus-elasticsearch`

## Application

- ### quarkus-elasticsearch

  [`Quarkus`](https://quarkus.io/) Java Web application that exposes a simple REST API for indexing and searching movies in `Elasticsearch`. [code.quarkus.io](https://code.quarkus.io/?g=com.ivanfranchin&a=quarkus-elasticsearch&j=17&e=hibernate-validator&e=smallrye-health&e=elasticsearch-java-client&e=micrometer-registry-prometheus&e=rest-jackson)
  
  It has the following endpoints:
  ```text
  POST /api/movies -d {"imdb":"...", "title":"..."}
  GET /api/movies[?title=...]
  GET /q/health
  GET /q/metrics
  ```

## Running application

> **Note**: `Elasticsearch` container must be running and initialized as explained [here](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/elasticsearch#start-environment)

### Development Mode

- Open a terminal and navigate to the `graalvm-quarkus-micronaut-springboot/elasticsearch/quarkus-elasticsearch` folder

- Run the command below to start the application
  ```bash
  ./mvnw clean compile quarkus:dev
  ```

- A simple test can be done by opening a new terminal and running
  ```bash
  curl -i -X POST "localhost:8080/api/movies" -H "Content-type: application/json" \
    -d '{"imdb":"123", "title":"I, Tonya"}'
  
  curl -i "localhost:8080/api/movies?title=tonya"
  ```

- To stop the application, press `Ctrl+C` in its terminal

### Docker in JVM Mode

- In a terminal, make sure you are inside the `graalvm-quarkus-micronaut-springboot/elasticsearch/quarkus-elasticsearch` folder

- Clean and package the application
  ```bash
  ./mvnw clean package
  ```

- Run the script below to build the Docker image
  ```bash
  ./build-docker-images.sh
  ```

- Run the following command to start the container
  ```bash
  podman run --rm --name quarkus-elasticsearch-jvm \
    -p 9112:8080 -e ELASTICSEARCH_HOST=elasticsearch \
    --network elasticsearch_default \
    ivanfranchin/quarkus-elasticsearch-jvm:latest
  ```

- A simple test can be done by opening a new terminal and running
  ```bash
  curl -i -X POST "localhost:9112/api/movies" -H "Content-type: application/json" \
    -d '{"imdb":"456", "title":"American Pie"}'
  
  curl -i "localhost:9112/api/movies?title=american"
  ```

- To stop and remove application container, press `Ctrl+C` in its terminal

### Docker in Native Mode

- In a terminal, make sure you are inside the `graalvm-quarkus-micronaut-springboot/elasticsearch/quarkus-elasticsearch` folder

- Clean and package the application
  ```bash
  ./mvnw clean package -Pnative -Dquarkus.native.container-build=true
  ```

- Run the script below to build the Docker image
  ```bash
  ./build-docker-images.sh native
  ```

- Run the following command to start the container
  ```bash
  podman run --rm --name quarkus-elasticsearch-native \
    -p 9113:8080 -e QUARKUS_PROFILE=native -e ELASTICSEARCH_HOST=elasticsearch \
    --network elasticsearch_default \
    ivanfranchin/quarkus-elasticsearch-native:latest
  ```

- A simple test can be done by opening a new terminal and running
  ```bash
  curl -i -X POST "localhost:9113/api/movies" -H "Content-type: application/json" \
    -d '{"imdb":"789", "title":"Resident Evil"}'
  
  curl -i "localhost:9113/api/movies?title=evil"
  ```

- To stop and remove application container, press `Ctrl+C` in its terminal
