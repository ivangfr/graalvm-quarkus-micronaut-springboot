# graalvm-quarkus-micronaut-springboot
## `> elasticsearch > springboot-elasticsearch`

## Application

- **springboot-elasticsearch**

  [`Spring Boot`](https://docs.spring.io/spring-boot/docs/current/reference/htmlsingle/) Java Web application that expose a simple REST API for indexing and searching movies in `Elasticsearch`.
  
  It has the following endpoint:
  ```
  POST /api/movies -d {"imdb": "...", "title": "..."}
  GET /api/movies[?title=...]
  ```

## Running application

> **Note:** `Elasticsearch` container must be running and initialized as explained [here](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/elasticsearch#start-environment)

### Development Mode

- Open a terminal and navigate to `graalvm-quarkus-micronaut-springboot/elasticsearch/springboot-elasticsearch` folder

- Run the command below to start the application
  ```
  ./mvnw clean spring-boot:run
  ```

- A simple test can be done by opening a new terminal and running
  ```
  curl -i -X POST "localhost:8080/api/movies" -H "Content-type: application/json" \
    -d '{"imdb": "123", "title": "I, Tonya"}'
  
  curl "localhost:8080/api/movies?title=tonya"
  ```

- To stop the application, press `Ctrl+C` in its terminal

### Docker in JVM Mode

- In a terminal, make sure you are inside `graalvm-quarkus-micronaut-springboot/elasticsearch/springboot-elasticsearch` folder

- Package the application `jar` file
  ```
  ./mvnw clean package
  ```

- Run the script below to build the Docker image
  ```
  ./docker-build.sh
  ```

- Run the following command to start the Docker container
  ```
  docker run --rm --name springboot-elasticsearch-jvm \
    -p 9109:8080 -e ELASTICSEARCH_HOST=elasticsearch --network elasticsearch_default \
    docker.mycompany.com/springboot-elasticsearch-jvm:1.0.0
  ```

- A simple test can be done by opening a new terminal and running
  ```
  curl -i -X POST "localhost:9109/api/movies" -H "Content-type: application/json" \
    -d '{"imdb": "456", "title": "American Pie"}'
  
  curl "localhost:9109/api/movies?title=american"
  ```

- To stop and remove application Docker container, press `Ctrl+C` in its terminal

### Docker in Native Mode

Spring team is working on supporting for `GraalVM` native images, https://github.com/spring-projects/spring-framework/wiki/GraalVM-native-image-support
