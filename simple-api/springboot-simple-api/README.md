# graalvm-quarkus-micronaut-springboot
## `> simple-api > springboot-simple-api`

## Application

- **springboot-simple-api**

  [`Spring Boot`](https://docs.spring.io/spring-boot/docs/current/reference/htmlsingle/) Java Web application that expose a simple REST API for greetings. It has the following endpoint
  ```
  GET /api/greeting[?name=...]
  ```

## Running application

### Development Mode

- Open a terminal and navigate to `graalvm-quarkus-micronaut-springboot/simple-api/springboot-simple-api` folder

- Run the command below to start the application
  ```
  ./gradlew clean bootRun
  ```

- A simple test can be done by opening a new terminal and running
  ```
  curl "localhost:8080/api/greeting?name=Ivan"
  ```

- To stop the application, press `Ctrl+C` in its terminals

### Docker in JVM Mode

- In a terminal, make sure you are inside `graalvm-quarkus-micronaut-springboot/simple-api/springboot-simple-api` folder

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
  docker run --rm --name springboot-simple-api-jvm -p 9084:8080 \
    docker.mycompany.com/springboot-simple-api-jvm:1.0.0
  ```

- A simple test can be done by opening a new terminal and running
  ```
  curl "localhost:9084/api/greeting?name=Ivan"
  ```

- To stop and remove application Docker container, press `Ctrl+C` in its terminals

### Docker in Native Mode

Spring team is working on supporting for `GraalVM` native images, https://github.com/spring-projects/spring-framework/wiki/GraalVM-native-image-support

