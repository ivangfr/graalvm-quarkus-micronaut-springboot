# graalvm-quarkus-micronaut-springboot
## `> elasticsearch > springboot-elasticsearch`

## Application

- ### springboot-elasticsearch

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
  ./mvnw clean package spring-boot:run
  ```

- A simple test can be done by opening a new terminal and running
  ```
  curl -i -X POST "localhost:8080/api/movies" -H "Content-type: application/json" \
    -d '{"imdb": "123", "title": "I, Tonya"}'
  
  curl -i "localhost:8080/api/movies?title=tonya"
  ```

- To stop the application, press `Ctrl+C` in its terminal

### Docker in JVM Mode

- In a terminal, make sure you are inside `graalvm-quarkus-micronaut-springboot/elasticsearch/springboot-elasticsearch` folder

- Clean the application
  ```
  ./mvnw clean
  ```

- Run the script below to build the Docker image
  ```
  ./docker-build.sh
  ```

- Run the following command to start the Docker container
  ```
  docker run --rm --name springboot-elasticsearch-jvm \
    -p 9116:8080 -e ELASTICSEARCH_HOST=elasticsearch \
    --network elasticsearch_default \
    docker.mycompany.com/springboot-elasticsearch-jvm:1.0.0
  ```

- A simple test can be done by opening a new terminal and running
  ```
  curl -i -X POST "localhost:9116/api/movies" -H "Content-type: application/json" \
    -d '{"imdb": "456", "title": "American Pie"}'
  
  curl -i "localhost:9116/api/movies?title=american"
  ```

- To stop and remove application Docker container, press `Ctrl+C` in its terminal

### Docker in Native Mode

- In a terminal, make sure you are inside `graalvm-quarkus-micronaut-springboot/elasticsearch/springboot-elasticsearch` folder

- Clean the application
  ```
  ./mvnw clean
  ```

- Run the script below to build the Docker image
  ```
  ./docker-build.sh native
  ```

- Run the following command to start the Docker container
  ```
  docker run --rm --name springboot-elasticsearch-native \
    -p 9117:8080 -e SPRING_PROFILES_ACTIVE=native -e ELASTICSEARCH_HOST=elasticsearch \
    --network elasticsearch_default \
    docker.mycompany.com/springboot-elasticsearch-native:1.0.0
  ```

- A simple test can be done by opening a new terminal and running (See [Issues](#issues))
  ```
  curl -i -X POST "localhost:9117/api/movies" -H "Content-type: application/json" \
    -d '{"imdb": "789", "title": "Resident Evil"}'
  
  curl -i "localhost:9117/api/movies?title=evil"
  ```

- To stop and remove application Docker container, press `Ctrl+C` in its terminal
