# graalvm-quarkus-micronaut-springboot
## `> simple-api > springboot-simple-api`

## Application

- ### springboot-simple-api

  [`Spring Boot`](https://docs.spring.io/spring-boot/docs/current/reference/htmlsingle/) Java Web application that exposes a simple REST API for greetings. It has the following endpoint
  ```
  GET /api/greeting[?name=...]
  ```

## Running application

### Development Mode

- Open a terminal and navigate to `graalvm-quarkus-micronaut-springboot/simple-api/springboot-simple-api` folder

- Run the command below to start the application
  ```
  ./mvnw clean spring-boot:run
  ```

- A simple test can be done by opening a new terminal and running
  ```
  curl -i "localhost:8080/api/greeting?name=Ivan"
  ```

- To stop the application, press `Ctrl+C` in its terminal

### Docker in JVM Mode

- In a terminal, make sure you are inside `graalvm-quarkus-micronaut-springboot/simple-api/springboot-simple-api` folder

- Clean the target folder
  ```
  ./mvnw clean
  ```

- Run the script below to build the Docker image
  ```
  ./docker-build.sh
  ```

- Run the following command to start the Docker container
  ```
  docker run --rm --name springboot-simple-api-jvm -p 9084:8080 \
    ivanfranchin/springboot-simple-api-jvm:1.0.0
  ```

- A simple test can be done by opening a new terminal and running
  ```
  curl -i "localhost:9084/api/greeting?name=Ivan"
  ```

- To stop and remove application Docker container, press `Ctrl+C` in its terminal

### Docker in Native Mode

- In a terminal, make sure you are inside `graalvm-quarkus-micronaut-springboot/simple-api/springboot-simple-api` folder

- Clean the target folder
  ```
  ./mvnw clean
  ```

- Run the script below to build the Docker image
  ```
  ./docker-build.sh native
  ```

- Run the following command to start the Docker container
  ```
  docker run --rm --name springboot-simple-api-native -p 9085:8080 \
    ivanfranchin/springboot-simple-api-native:1.0.0
  ```

- A simple test can be done by opening a new terminal and running
  ```
  curl -i "localhost:9085/api/greeting?name=Ivan"
  ```

- To stop and remove application Docker container, press `Ctrl+C` in its terminal
