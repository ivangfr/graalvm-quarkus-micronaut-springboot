# graalvm-quarkus-micronaut-springboot
## `> jpa-mysql > quarkus-jpa-mysql`

## Application

- ### quarkus-jpa-mysql

  [`Quarkus`](https://quarkus.io/) Java Web application that exposes a REST API for managing books. [code.quarkus.io](https://code.quarkus.io/?g=com.ivanfranchin&a=quarkus-jpa-mysql&j=17&e=hibernate-validator&e=smallrye-health&e=spring-data-jpa&e=jdbc-mysql&e=micrometer-registry-prometheus&e=rest-jackson)
                                 
  It has the following endpoints:
  ```text
  GET /api/books
  GET /api/books/{id}
  POST /api/books {"isbn":"...", "title":"..."}
  GET /q/health
  GET /q/metrics
  ```

## Running application

> **Note**: `MySQL` container must be running and initialized as explained [here](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/jpa-mysql#start-environment).

### Development Mode

- Open a terminal and navigate to the `graalvm-quarkus-micronaut-springboot/jpa-mysql/quarkus-jpa-mysql` folder.

- Run the command below to start the application:
  ```bash
  ./mvnw clean compile quarkus:dev
  ```

- A simple test can be done by opening a new terminal and running:
  ```bash
  curl -i -X POST localhost:8080/api/books -H "Content-Type: application/json" \
    -d '{"isbn":"123", "title":"Learn Java"}'
  
  curl -i localhost:8080/api/books
  ```

- To stop the application, press `Ctrl+C` in its terminal.

### Docker in JVM Mode

- In a terminal, make sure you are inside the `graalvm-quarkus-micronaut-springboot/jpa-mysql/quarkus-jpa-mysql` folder.

- Clean and package the application:
  ```bash
  ./mvnw clean package
  ```

- Run the script below to build the Docker image:
  ```bash
  ./build-docker-images.sh
  ```

- Run the following command to start the container:
  ```bash
  podman run --rm --name quarkus-jpa-mysql-jvm \
    -p 9086:8080 -e MYSQL_HOST=mysql \
    --network jpa-mysql_default \
    ivanfranchin/quarkus-jpa-mysql-jvm:latest
  ```

- A simple test can be done by opening a new terminal and running:
  ```bash
  curl -i -X POST localhost:9086/api/books -H "Content-Type: application/json" \
    -d '{"isbn":"456", "title":"Learn Docker"}'
  
  curl -i localhost:9086/api/books
  ```

- To stop and remove application container, press `Ctrl+C` in its terminal.

### Docker in Native Mode

- In a terminal, make sure you are inside the `graalvm-quarkus-micronaut-springboot/jpa-mysql/quarkus-jpa-mysql` folder.

- Clean and package the application:
  ```bash
  ./mvnw clean package -Pnative -Dquarkus.native.container-build=true
  ```

- Run the script below to build the Docker image:
  ```bash
  ./build-docker-images.sh native
  ```

- Run the following command to start the container:
  ```bash
  podman run --rm --name quarkus-jpa-mysql-native \
    -p 9087:8080 -e QUARKUS_PROFILE=native -e MYSQL_HOST=mysql \
    --network jpa-mysql_default \
    ivanfranchin/quarkus-jpa-mysql-native:latest
  ```

- A simple test can be done by opening a new terminal and running:
  ```bash
  curl -i -X POST localhost:9087/api/books -H "Content-Type: application/json" \
    -d '{"isbn":"789", "title":"Learn GraalVM"}'
  
  curl -i localhost:9087/api/books
  ```

- To stop and remove application container, press `Ctrl+C` in its terminal.
