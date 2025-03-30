# graalvm-quarkus-micronaut-springboot
## `> elasticsearch > springboot-elasticsearch`

## Application

- ### springboot-elasticsearch

  [`Spring Boot`](https://docs.spring.io/spring-boot/docs/current/reference/htmlsingle/) Java Web application that exposes a simple REST API for indexing and searching movies in `Elasticsearch`. [Spring Initializr](https://start.spring.io/#!type=maven-project&language=java&platformVersion=3.4.4&packaging=jar&jvmVersion=17&groupId=com.ivanfranchin&artifactId=springboot-elasticsearch&name=springboot-elasticsearch&description=Demo%20project%20for%20Spring%20Boot&packageName=com.ivanfranchin.springboot-elasticsearch&dependencies=webflux,actuator,validation,native,data-elasticsearch)
  
  It has the following endpoints:
  ```text
  POST /api/movies -d {"imdb":"...", "title":"..."}
  GET /api/movies[?title=...]
  GET /actuator/health
  GET /actuator/metrics
  ```

## Running application

> **Note**: `Elasticsearch` container must be running and initialized as explained [here](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/elasticsearch#start-environment)

### Development Mode

- Open a terminal and navigate to the `graalvm-quarkus-micronaut-springboot/elasticsearch/springboot-elasticsearch` folder

- Run the command below to start the application
  ```bash
  ./mvnw clean spring-boot:run
  ```

- A simple test can be done by opening a new terminal and running
  ```bash
  curl -i -X POST "localhost:8080/api/movies" -H "Content-type: application/json" \
    -d '{"imdb":"123", "title":"I, Tonya"}'
  
  curl -i "localhost:8080/api/movies?title=tonya"
  ```

- To stop the application, press `Ctrl+C` in its terminal

### Docker in JVM Mode

- In a terminal, make sure you are inside the `graalvm-quarkus-micronaut-springboot/elasticsearch/springboot-elasticsearch` folder

- Clean the target folder
  ```bash
  ./mvnw clean
  ```

- Run the script below to build the Docker image
  ```bash
  ./build-docker-images.sh
  ```

- Run the following command to start the container
  ```bash
  podman run --rm --name springboot-elasticsearch-jvm \
    -p 9116:8080 -e ELASTICSEARCH_HOST=elasticsearch \
    --network elasticsearch_default \
    ivanfranchin/springboot-elasticsearch-jvm:latest
  ```

- A simple test can be done by opening a new terminal and running
  ```bash
  curl -i -X POST "localhost:9116/api/movies" -H "Content-type: application/json" \
    -d '{"imdb":"456", "title":"American Pie"}'
  
  curl -i "localhost:9116/api/movies?title=american"
  ```

- To stop and remove application container, press `Ctrl+C` in its terminal

### Docker in Native Mode

- In a terminal, make sure you are inside the `graalvm-quarkus-micronaut-springboot/elasticsearch/springboot-elasticsearch` folder

- Clean the target folder
  ```bash
  ./mvnw clean
  ```

- Run the script below to build the Docker image
  ```bash
  ./build-docker-images.sh native
  ```

- Run the following command to start the container
  ```bash
  podman run --rm --name springboot-elasticsearch-native \
    -p 9117:8080 -e SPRING_PROFILES_ACTIVE=native -e ELASTICSEARCH_HOST=elasticsearch \
    --network elasticsearch_default \
    ivanfranchin/springboot-elasticsearch-native:latest
  ```

- A simple test can be done by opening a new terminal and running
  ```bash
  curl -i -X POST "localhost:9117/api/movies" -H "Content-type: application/json" \
    -d '{"imdb":"789", "title":"Resident Evil"}'
  
  curl -i "localhost:9117/api/movies?title=evil"
  ```

- To stop and remove application container, press `Ctrl+C` in its terminal
