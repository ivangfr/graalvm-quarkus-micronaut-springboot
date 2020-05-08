# graalvm-quarkus-micronaut-springboot
## `> book-api > springboot-book-api`

## Application

- **springboot-book-api**

  [`Spring Boot`](https://docs.spring.io/spring-boot/docs/current/reference/htmlsingle/) Java Web application that exposes a REST API for managing books.

  It has the following endpoints:
  ```
  GET /api/books
  GET /api/books/{id}
  POST /api/books {"isbn": "...", "title": "..."}
  ```

## Running application

> **Note:** `MySQL` container must be running and initialized as explained [here](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/book-api#start-environment)

### Development Mode

- Open a terminal and navigate to `graalvm-quarkus-micronaut-springboot/book-api/springboot-book-api` folder

- Run the command below
  ```
  ./gradlew bootRun
  ```

### Docker in JVM Mode

- In a terminal, make sure you are inside `graalvm-quarkus-micronaut-springboot/book-api/springboot-book-api` folder

- Package the application `jar` file
  ```
  ./gradlew clean assemble
  ```

- Run the script below to build the Docker image
  ```
  ./docker-build.sh
  ```

- Run the following command to start the Docker container
  ```
  docker run -d --rm --name springboot-book-api-jvm \
    -p 9089:8080 -e MYSQL_HOST=mysql --network book-api_default \
    docker.mycompany.com/springboot-book-api-jvm:1.0.0
  ```

### Docker in Native Mode

Spring team is working on supporting for `GraalVM` native images, https://github.com/spring-projects/spring-framework/wiki/GraalVM-native-image-support

## Shutdown

- Open a terminal

- To stop and remove application container run
  ```
  docker stop springboot-book-api-jvm
  ```
