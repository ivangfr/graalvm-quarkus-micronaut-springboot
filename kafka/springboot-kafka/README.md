# graalvm-quarkus-micronaut-springboot
## `> kafka > springboot-kafka`

The goal of this project is to implement two [`Spring Boot`](https://docs.spring.io/spring-boot/docs/current/reference/htmlsingle/) applications: one that _produces_ messages to a [`Kafka`](https://kafka.apache.org/) topic and another that _consumes_ those messages.

## Applications

- ### kafka-producer

  `Spring Boot` Web Java application that exposes one endpoint at which users can post `news`. Once a request is made, `kafka-producer` pushes a message about the `news` to `Kafka`. [Spring Initializr](https://start.spring.io/#!type=maven-project&language=java&platformVersion=3.4.4&packaging=jar&jvmVersion=17&groupId=com.ivanfranchin&artifactId=springboot-kafka-producer&name=springboot-kafka-producer&description=Demo%20project%20for%20Spring%20Boot&packageName=com.ivanfranchin.springboot-kafka-producer&dependencies=webflux,actuator,validation,native,kafka)

  It has the following endpoints:
  ```text
  POST /api/news {"source":"...", "title":"..."}
  GET /actuator/health
  GET /actuator/metrics
  ```

- ### kafka-consumer

  `Spring Boot` Web Java application that listens to messages (published by the `kafka-producer`) and logs it. [Spring Initializr](https://start.spring.io/#!type=maven-project&language=java&platformVersion=3.4.4&packaging=jar&jvmVersion=17&groupId=com.ivanfranchin&artifactId=springboot-kafka-consumer&name=springboot-kafka-consumer&description=Demo%20project%20for%20Spring%20Boot&packageName=com.ivanfranchin.springboot-kafka-consumer&dependencies=webflux,actuator,native,kafka)

  It has the following endpoints:
  ```text
  GET /actuator/health
  GET /actuator/metrics
  ```

## Running applications

> **Note**: `Kafka`, `Zookeeper` and other containers present in `docker-compose.yml` file must be up and running as explained [here](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/kafka#start-environment).

### Development Mode

- **Startup**

  - **kafka-producer**

    - Open a terminal and navigate to the `graalvm-quarkus-micronaut-springboot/kafka/springboot-kafka` folder.

    - Run the command below to start the application:
      ```bash
      ./mvnw clean spring-boot:run --projects kafka-producer
      ```

  - **kafka-consumer**

    - Open another terminal and make sure you are in the `graalvm-quarkus-micronaut-springboot/kafka/springboot-kafka` folder.

    - Run the command below to start the application:
      ```bash
      ./mvnw clean spring-boot:run --projects kafka-consumer -Dspring-boot.run.jvmArguments="-Dserver.port=8081"
      ```

- **Simple Test**

  - In a new terminal, post a news:
    ```bash
    curl -i -X POST localhost:8080/api/news -H 'Content-Type: application/json' \
      -d '{"source":"Spring Boot Blog", "title":"Dev Spring Boot Framework"}'
    ```

  - See `kafka-producer` and `kafka-consumer` logs.

- **Shutdown**

  Press `Ctrl+C` in `kafka-producer` and `kafka-consumer` terminals.

### Docker in JVM Mode

- **Startup**

  - **kafka-producer**

    - In a terminal, make sure you are inside the `graalvm-quarkus-micronaut-springboot/kafka/springboot-kafka` folder.

    - Clean the target folder:
      ```bash
      ./mvnw clean --projects kafka-producer
      ```

    - Run the command below to build the Docker image:
      ```bash
      cd kafka-producer && ./build-docker-images.sh && cd ..
      ```

    - Run the following command to start the container:
      ```bash
      podman run --rm --name springboot-kafka-producer-jvm \
        -p 9104:8080 -e KAFKA_HOST=kafka -e KAFKA_PORT=9092 \
        --network kafka_default \
        ivanfranchin/springboot-kafka-producer-jvm:latest
      ```

  - **kafka-consumer**

    - In another terminal, make sure you are inside the `graalvm-quarkus-micronaut-springboot/kafka/springboot-kafka` folder.

    - Clean the target folder:
      ```bash
      ./mvnw clean --projects kafka-consumer
      ```

    - Run the command below to build the Docker image:
      ```bash
      cd kafka-consumer && ./build-docker-images.sh && cd ..
      ```

    - Run the following command to start the container:
      ```bash
      podman run --rm --name springboot-kafka-consumer-jvm \
        -p 9110:8080 -e KAFKA_HOST=kafka -e KAFKA_PORT=9092 \
        --network kafka_default \
        ivanfranchin/springboot-kafka-consumer-jvm:latest
      ```

- **Simple Test**

  - In a new terminal, post a news:
    ```bash
    curl -i -X POST localhost:9104/api/news -H 'Content-Type: application/json' \
      -d '{"source":"Spring Boot Blog", "title":"Spring Boot Framework"}'
    ```

  - See `kafka-producer` and `kafka-consumer` logs.

- **Shutdown**

  Press `Ctrl+C` in `kafka-producer` and `kafka-consumer` terminals.

### Docker in Native Mode

- **Startup**

  - **kafka-producer**

    - In a terminal, make sure you are inside the `graalvm-quarkus-micronaut-springboot/kafka/springboot-kafka` folder.

    - Clean the target folder:
      ```bash
      ./mvnw clean --projects kafka-producer
      ```

    - Run the command below to build the Docker image:
      ```bash
      cd kafka-producer && ./build-docker-images.sh native && cd ..
      ```

    - Run the following command to start the container:
      ```bash
      podman run --rm --name springboot-kafka-producer-native \
        -p 9105:8080 -e SPRING_PROFILES_ACTIVE=native -e KAFKA_HOST=kafka -e KAFKA_PORT=9092 \
        --network kafka_default \
        ivanfranchin/springboot-kafka-producer-native:latest
      ```

  - **kafka-consumer**

    - In another terminal, make sure you are inside the `graalvm-quarkus-micronaut-springboot/kafka/springboot-kafka` folder.

    - Clean the target folder:
      ```bash
      ./mvnw clean --projects kafka-consumer
      ```

    - Run the command below to build the Docker image:
      ```bash
      cd kafka-consumer && ./build-docker-images.sh native && cd ..
      ```

    - Run the following command to start the container:
      ```bash
      podman run --rm --name springboot-kafka-consumer-native \
        -p 9111:8080 -e SPRING_PROFILES_ACTIVE=native -e KAFKA_HOST=kafka -e KAFKA_PORT=9092 \
        --network kafka_default \
        ivanfranchin/springboot-kafka-consumer-native:latest
      ```

- **Simple Test**

  - In a new terminal, post a news:
    ```bash
    curl -i -X POST localhost:9105/api/news -H 'Content-Type: application/json' \
      -d '{"source":"Spring Boot Blog", "title":"Spring Boot Framework & GraalVM"}'
    ```

  - See `kafka-producer` and `kafka-consumer` logs.

- **Shutdown**

  Press `Ctrl+C` in `kafka-producer` and `kafka-consumer` terminals.
