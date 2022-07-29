# graalvm-quarkus-micronaut-springboot
## `> simple-api > quarkus-simple-api`

## Application

- ### quarkus-simple-api

  [`Quarkus`](https://quarkus.io/) Java Web application that exposes a simple REST API for greetings.
  
  It has the following endpoints
  ```
  GET /api/greeting[?name=...]
  GET /q/health
  GET /q/metrics
  ```

## Running application

### Development Mode

- Open a terminal navigate to `graalvm-quarkus-micronaut-springboot/simple-api/quarkus-simple-api` folder

- Run the command below to start the application
  ```
  ./mvnw clean compile quarkus:dev
  ```

- A simple test can be done by opening a new terminal and running
  ```
  curl -i "localhost:8080/api/greeting?name=Ivan"
  ```

- To stop the application, press `Ctrl+C` in its terminal

### Docker in JVM Mode

- In a terminal, make sure you are inside `graalvm-quarkus-micronaut-springboot/simple-api/quarkus-simple-api` folder

- Clean and package the application
  ```
  ./mvnw clean package
  ```

- Run the script below to build the Docker image
  ```
  ./docker-build.sh
  ```

- Run the following command to start the Docker container
  ```
  docker run --rm --name quarkus-simple-api-jvm -p 9080:8080 \
    ivanfranchin/quarkus-simple-api-jvm:1.0.0
  ```

- A simple test can be done by opening a new terminal and running
  ```
  curl -i "localhost:9080/api/greeting?name=Ivan"
  ```

- To stop and remove application Docker container, press `Ctrl+C` in its terminal

### Docker in Native Mode

- In a terminal, make sure you are inside `graalvm-quarkus-micronaut-springboot/simple-api/quarkus-simple-api` folder

- Clean and package the application
  ```
  ./mvnw clean package -Pnative -Dquarkus.native.container-build=true
  ```

- Run the script below to build the Docker image
  ```
  ./docker-build.sh native
  ```

- Run the following command to start the Docker container
  ```
  docker run --rm --name quarkus-simple-api-native -p 9081:8080 \
    ivanfranchin/quarkus-simple-api-native:1.0.0
  ```

- A simple test can be done by opening a new terminal and running
  ```
  curl -i "localhost:9081/api/greeting?name=Ivan"
  ```

- To stop and remove application Docker container, press `Ctrl+C` in its terminal
