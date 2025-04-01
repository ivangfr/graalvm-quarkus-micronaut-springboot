# graalvm-quarkus-micronaut-springboot
## `> simple-api > micronaut-simple-api`

## Application

- ### micronaut-simple-api

  [`Micronaut`](https://micronaut.io/) Java Web application that exposes a simple REST API for greetings. [Micronaut Launch](https://micronaut.io/launch?type=DEFAULT&name=micronaut-simple-api&package=com.ivanfranchin.micronautsimpleapi&javaVersion=JDK_17&lang=JAVA&build=MAVEN&test=JUNIT&features=jib&features=graalvm&features=http-client&features=micrometer-prometheus&features=validation&features=jackson-databind&version=4.7.6)
  
  It has the following endpoints:
  ```text
  GET /api/greeting[?name=...]
  GET /health
  GET /metrics
  ```

## Running application

### Development Mode

- Open a terminal and navigate to the `graalvm-quarkus-micronaut-springboot/simple-api/micronaut-simple-api` folder.

- Run the command below to start the application:
  ```bash
  ./mvnw clean mn:run
  ```

- A simple test can be done by opening a new terminal and running:
  ```bash
  curl -i "localhost:8080/api/greeting?name=Ivan"
  ```

- To stop the application, press `Ctrl+C` in its terminal.

### Docker in JVM Mode

- In a terminal, make sure you are inside the `graalvm-quarkus-micronaut-springboot/simple-api/micronaut-simple-api` folder.

- Clean the target folder:
  ```bash
  ./mvnw clean
  ```

- Run the script below to build the Docker image:
  ```bash
  ./build-docker-images.sh
  ```

- Run the following command to start the container:
  ```bash
  podman run --rm --name micronaut-simple-api-jvm -p 9082:8080 \
    ivanfranchin/micronaut-simple-api-jvm:latest
  ```

- A simple test can be done by opening a new terminal and running:
  ```bash
  curl -i "localhost:9082/api/greeting?name=Ivan"
  ```

- To stop and remove application container, press `Ctrl+C` in its terminal.

### Docker in Native Mode

- In a terminal, make sure you are inside the `graalvm-quarkus-micronaut-springboot/simple-api/micronaut-simple-api` folder.

- Clean the target folder:
  ```bash
  ./mvnw clean
  ```

- Run the script below to build the Docker image:
  ```bash
  ./build-docker-images.sh native
  ```

- Run the following command to start the container:
  ```bash
  podman run --rm --name micronaut-simple-api-native -p 9083:8080 \
    ivanfranchin/micronaut-simple-api-native:latest
  ```

- A simple test can be done by opening a new terminal and running:
  ```bash
  curl -i "localhost:9083/api/greeting?name=Ivan"
  ```

- To stop and remove application container, press `Ctrl+C` in its terminal.
