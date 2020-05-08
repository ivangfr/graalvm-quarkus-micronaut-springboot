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

- Run the command below
  ```
  ./gradlew bootRun
  ```

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
  docker run -d --rm --name springboot-simple-api-jvm -p 9084:8080 \
    docker.mycompany.com/springboot-simple-api-jvm:1.0.0
  ```

### Docker in Native Mode

Spring team is working on supporting for `GraalVM` native images, https://github.com/spring-projects/spring-framework/wiki/GraalVM-native-image-support

## Shutdown

- Open a terminal

- To stop and remove application container run
  ```
  docker stop springboot-simple-api-jvm
  ```
