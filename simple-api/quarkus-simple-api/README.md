# graalvm-quarkus-micronaut-springboot
## `> simple-api > quarkus-simple-api`

## Application

- ### quarkus-simple-api

  [`Quarkus`](https://quarkus.io/) Java Web application that exposes a simple REST API for greetings. [code.quarkus.io](https://code.quarkus.io/?g=com.ivanfranchin&a=quarkus-simple-api&j=17&e=hibernate-validator&e=smallrye-health&e=micrometer-registry-prometheus&e=rest-jackson)
  
  It has the following endpoints
  ```text
  GET /api/greeting[?name=...]
  GET /q/health
  GET /q/metrics
  ```

## Running application

### Development Mode

- Open a terminal navigate to the `graalvm-quarkus-micronaut-springboot/simple-api/quarkus-simple-api` folder

- Run the command below to start the application
  ```bash
  ./mvnw clean compile quarkus:dev
  ```

- A simple test can be done by opening a new terminal and running
  ```bash
  curl -i "localhost:8080/api/greeting?name=Ivan"
  ```

- To stop the application, press `Ctrl+C` in its terminal

### Docker in JVM Mode

- In a terminal, make sure you are inside the `graalvm-quarkus-micronaut-springboot/simple-api/quarkus-simple-api` folder

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
  podman run --rm --name quarkus-simple-api-jvm -p 9080:8080 \
    ivanfranchin/quarkus-simple-api-jvm:latest
  ```

- A simple test can be done by opening a new terminal and running
  ```bash
  curl -i "localhost:9080/api/greeting?name=Ivan"
  ```

- To stop and remove application container, press `Ctrl+C` in its terminal

### Docker in Native Mode

- In a terminal, make sure you are inside the `graalvm-quarkus-micronaut-springboot/simple-api/quarkus-simple-api` folder

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
  podman run --rm --name quarkus-simple-api-native -p 9081:8080 \
    ivanfranchin/quarkus-simple-api-native:latest
  ```

- A simple test can be done by opening a new terminal and running
  ```bash
  curl -i "localhost:9081/api/greeting?name=Ivan"
  ```

- To stop and remove application container, press `Ctrl+C` in its terminal
