# graalvm-quarkus-micronaut-springboot
## `> elasticsearch > micronaut-elasticsearch`

## Application

- ### micronaut-elasticsearch

  [`Micronaut`](https://micronaut.io/) Java Web application that exposes a simple REST API for indexing and searching movies in `Elasticsearch`. [Micronaut Launch](https://micronaut.io/launch?type=DEFAULT&name=micronaut-elasticsearch&package=com.ivanfranchin.micronautelasticsearch&javaVersion=JDK_17&lang=JAVA&build=MAVEN&test=JUNIT&features=jib&features=graalvm&features=http-client&features=micrometer-prometheus&features=validation&features=jackson-databind&features=elasticsearch&version=4.7.6)
  
  It has the following endpoints:
  ```text
  POST /api/movies -d {"imdb":"...", "title":"..."}
  GET /api/movies[?title=...]
  GET /health
  GET /metrics
  ```

## Running application

> **Note**: `Elasticsearch` container must be running and initialized as explained [here](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/elasticsearch#start-environment)

### Development Mode

- Open a terminal and navigate to the `graalvm-quarkus-micronaut-springboot/elasticsearch/micronaut-elasticsearch` folder

- Run the command below to start the application
  ```bash
  ./mvnw clean mn:run
  ```

- A simple test can be done by opening a new terminal and running
  ```bash
  curl -i -X POST "localhost:8080/api/movies" -H "Content-type: application/json" \
    -d '{"imdb":"123", "title":"I, Tonya"}'
  
  curl -i "localhost:8080/api/movies?title=tonya"
  ```

- To stop the application, press `Ctrl+C` in its terminal

### Docker in JVM Mode

- In a terminal, make sure you are inside the `graalvm-quarkus-micronaut-springboot/elasticsearch/micronaut-elasticsearch` folder

- Clean the target folder
  ```bash
  ./mvnw clean
  ```

- Run the script below to build the Docker image
  ```bash
  ./docker-build.sh
  ```

- Run the following command to start the Docker container
  ```bash
  docker run --rm --name micronaut-elasticsearch-jvm \
    -p 9114:8080 -e ELASTICSEARCH_HOST=elasticsearch \
    --network elasticsearch_default \
    ivanfranchin/micronaut-elasticsearch-jvm:latest
  ```

- A simple test can be done by opening a new terminal and running
  ```bash
  curl -i -X POST "localhost:9114/api/movies" -H "Content-type: application/json" \
    -d '{"imdb":"456", "title":"American Pie"}'
  
  curl -i "localhost:9114/api/movies?title=american"
  ```

- To stop and remove application Docker container, press `Ctrl+C` in its terminal

### Docker in Native Mode

- In a terminal, make sure you are inside the `graalvm-quarkus-micronaut-springboot/elasticsearch/micronaut-elasticsearch` folder

- Clean the target folder
  ```bash
  ./mvnw clean
  ```

- Run the script below to build the Docker image
  ```bash
  ./docker-build.sh native
  ```

- Run the following command to start the Docker container
  ```bash
  docker run --rm --name micronaut-elasticsearch-native \
    -p 9115:8080 -e MICRONAUT_ENVIRONMENTS=native -e ELASTICSEARCH_HOST=elasticsearch \
    --network elasticsearch_default \
    ivanfranchin/micronaut-elasticsearch-native:latest
  ```

- A simple test can be done by opening a new terminal and running
  ```bash
  curl -i -X POST "localhost:9115/api/movies" -H "Content-type: application/json" \
    -d '{"imdb":"789", "title":"Resident Evil"}'
  
  curl -i "localhost:9115/api/movies?title=evil"
  ```

- To stop and remove application Docker container, press `Ctrl+C` in its terminal
