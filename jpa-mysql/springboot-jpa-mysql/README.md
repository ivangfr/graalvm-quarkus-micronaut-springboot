# graalvm-quarkus-micronaut-springboot
## `> jpa-mysql > springboot-jpa-mysql`

## Application

- ### springboot-jpa-mysql

  [`Spring Boot`](https://docs.spring.io/spring-boot/docs/current/reference/htmlsingle/) Java Web application that exposes a REST API for managing books. [Spring Initializr](https://start.spring.io/#!type=maven-project&language=java&platformVersion=3.4.4&packaging=jar&jvmVersion=17&groupId=com.ivanfranchin&artifactId=springboot-jpa-mysql&name=springboot-jpa-mysql&description=Demo%20project%20for%20Spring%20Boot&packageName=com.ivanfranchin.springboot-jpa-mysql&dependencies=webflux,actuator,validation,native,data-jpa,mysql,lombok)

  It has the following endpoints:
  ```text
  GET /api/books
  GET /api/books/{id}
  POST /api/books {"isbn":"...", "title":"..."}
  GET /actuator/health
  GET /actuator/metrics
  ```

## Running application

> **Note**: `MySQL` container must be running and initialized as explained [here](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/jpa-mysql#start-environment).

### Development Mode

- Open a terminal and navigate to the `graalvm-quarkus-micronaut-springboot/jpa-mysql/springboot-jpa-mysql` folder.

- Run the command below to start the application:
  ```bash
  ./mvnw clean spring-boot:run
  ```

- A simple test can be done by opening a new terminal and running:
  ```bash
  curl -i -X POST localhost:8080/api/books -H "Content-Type: application/json" \
    -d '{"isbn":"123", "title":"Learn Java"}'
  
  curl -i localhost:8080/api/books
  ```

- To stop the application, press `Ctrl+C` in its terminal.

### Docker in JVM Mode

- In a terminal, make sure you are inside the `graalvm-quarkus-micronaut-springboot/jpa-mysql/springboot-jpa-mysql` folder.

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
  podman run --rm --name springboot-jpa-mysql-jvm \
    -p 9090:8080 -e MYSQL_HOST=mysql \
    --network jpa-mysql_default \
    ivanfranchin/springboot-jpa-mysql-jvm:latest
  ```

- A simple test can be done by opening a new terminal and running:
  ```bash
  curl -i -X POST localhost:9090/api/books -H "Content-Type: application/json" \
    -d '{"isbn":"456", "title":"Learn Docker"}'
  
  curl -i localhost:9090/api/books
  ```

- To stop and remove application container, press `Ctrl+C` in its terminal.

### Docker in Native Mode

- In a terminal, make sure you are inside the `graalvm-quarkus-micronaut-springboot/jpa-mysql/springboot-jpa-mysql` folder.

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
  podman run --rm --name springboot-jpa-mysql-native \
    -p 9091:8080 -e SPRING_PROFILES_ACTIVE=native -e MYSQL_HOST=mysql \
    --network jpa-mysql_default \
    ivanfranchin/springboot-jpa-mysql-native:latest
  ```

- A simple test can be done by opening a new terminal and running:
  ```bash
  curl -i -X POST localhost:9091/api/books -H "Content-Type: application/json" \
    -d '{"isbn":"789", "title":"Learn GraalVM"}'
  
  curl -i localhost:9091/api/books
  ```

- To stop and remove application container, press `Ctrl+C` in its terminal.
