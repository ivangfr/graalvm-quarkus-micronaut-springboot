# graalvm-quarkus-micronaut-springboot
## `> kafka > micronaut-kafka`

The goal of this project is to implement two [`Micronaut`](https://micronaut.io/) applications: one that _produces_ messages to a [`Kafka`](https://kafka.apache.org/) topic and another that _consumes_ those messages. Besides, we will use `GraalVM`'s `native-image` tool to generate the native image of the applications.

## Applications

- ### kafka-producer

  `Micronaut` Web Java application that exposes one endpoint at which users can post `news`. Once a request is made, `kafka-producer` pushes a message about the `news` to `Kafka`. [Micronaut Launch](https://micronaut.io/launch?type=DEFAULT&name=micronaut-kafka-producer&package=com.ivanfranchin.kafkaproducer&javaVersion=JDK_17&lang=JAVA&build=MAVEN&test=JUNIT&features=jib&features=graalvm&features=http-client&features=micrometer-prometheus&features=validation&features=jackson-databind&features=kafka&version=4.6.1)

  It has the following endpoints:
  ```
  POST /api/news {"source":"...", "title":"..."}
  GET /health
  GET /metrics
  ```

- ### kafka-consumer

  `Micronaut` Web Java application that listens to messages (published by the `kafka-producer`) and logs it. [Micronaut Launch](https://micronaut.io/launch?type=DEFAULT&name=micronaut-kafka-consumer&package=com.ivanfranchin.kafkaconsumer&javaVersion=JDK_17&lang=JAVA&build=MAVEN&test=JUNIT&features=jib&features=graalvm&features=http-client&features=micrometer-prometheus&features=jackson-databind&features=kafka&version=4.6.1)

  It has the following endpoints:
  ```
  GET /health
  GET /metrics
  ```

## Running applications

> **Note**: `Kafka`, `Zookeeper` and other containers present in `docker-compose.yml` file must be up and running as explained [here](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/kafka#start-environment)

### Development Mode

- **Startup**

  - **kafka-producer**

    - Open a terminal and navigate to `graalvm-quarkus-micronaut-springboot/kafka/micronaut-kafka` folder

    - Run the command below
      ```
      ./mvnw clean mn:run --projects kafka-producer
      ```

  - **kafka-consumer**

    - Open another terminal and navigate to `graalvm-quarkus-micronaut-springboot/kafka/micronaut-kafka` folder

    - Run the command below
      ```
      export MICRONAUT_SERVER_PORT=8081 && ./mvnw clean mn:run --projects kafka-consumer
      ```

- **Simple Test**

  - In a new terminal, post a news
    ```
    curl -i -X POST localhost:8080/api/news -H 'Content-Type: application/json' \
      -d '{"source":"Micronaut Blog", "title":"Dev Micronaut Framework"}'
    ```

  - See `kafka-producer` and `kafka-consumer` logs

- **Shutdown**

  Press `Ctrl+C` in `kafka-producer` and `kafka-consumer` terminals

### Docker in JVM Mode

- **Startup**

  - **kafka-producer**

    - In a terminal, make sure you are inside `graalvm-quarkus-micronaut-springboot/kafka/micronaut-kafka` folder

    - Clean the target folder
      ```
      ./mvnw clean --projects kafka-producer
      ```

    - Run the command below to build the Docker image
      ```
      cd kafka-producer && ./docker-build.sh && cd ..
      ```

    - Run the following command to start the Docker container
      ```
      docker run --rm --name micronaut-kafka-producer-jvm \
        -p 9102:8080 -e KAFKA_HOST=kafka -e KAFKA_PORT=9092 \
        --network kafka_default \
        ivanfranchin/micronaut-kafka-producer-jvm:latest
      ```

  - **kafka-consumer**

    - In another terminal, make sure you are inside `graalvm-quarkus-micronaut-springboot/kafka/micronaut-kafka` folder

    - Clean the target folder
      ```
      ./mvnw clean --projects kafka-consumer
      ```

    - Run the command below to build the Docker image
      ```
      cd kafka-consumer && ./docker-build.sh && cd ..
      ```

    - Run the following command to start the Docker container
      ```
      docker run --rm --name micronaut-kafka-consumer-jvm \
        -p 9108:8080 -e KAFKA_HOST=kafka -e KAFKA_PORT=9092 \
        --network kafka_default \
        ivanfranchin/micronaut-kafka-consumer-jvm:latest
      ```

- **Simple Test**

  - In a new terminal, post a news
    ```
    curl -i -X POST localhost:9102/api/news -H 'Content-Type: application/json' \
      -d '{"source":"Micronaut Blog", "title":"Micronaut Framework"}'
    ```

  - See `kafka-producer` and `kafka-consumer` Docker logs

- **Shutdown**

  Press `Ctrl+C` in `kafka-producer` and `kafka-consumer` terminals

### Docker in Native Mode

- **Startup**

  - **kafka-producer**

    - In a terminal, make sure you are inside `graalvm-quarkus-micronaut-springboot/kafka/micronaut-kafka` folder

    - Clean the target folder
      ```
      ./mvnw clean --projects kafka-producer
      ```

    - Run the command below to build the Docker image
      ```
      cd kafka-producer && ./docker-build.sh native && cd ..
      ```

    - Run the following command to start the Docker container
      ```
      docker run --rm --name micronaut-kafka-producer-native \
        -p 9103:8080 -e MICRONAUT_ENVIRONMENTS=native -e KAFKA_HOST=kafka -e KAFKA_PORT=9092 \
        --network kafka_default \
        ivanfranchin/micronaut-kafka-producer-native:latest
      ```

  - **kafka-consumer**

    - In another terminal, make sure you are inside `graalvm-quarkus-micronaut-springboot/kafka/micronaut-kafka` folder

    - Clean the target folder
      ```
      ./mvnw clean --projects kafka-consumer
      ```

    - Run the command below to build the Docker image
      ```
      cd kafka-consumer && ./docker-build.sh native && cd ..
      ```

    - Run the following command to start the Docker container
      ```
      docker run --rm --name micronaut-kafka-consumer-native \
        -p 9109:8080 -e MICRONAUT_ENVIRONMENTS=native -e KAFKA_HOST=kafka -e KAFKA_PORT=9092 \
        --network kafka_default \
        ivanfranchin/micronaut-kafka-consumer-native:latest
      ```

- **Simple Test**

  - In a new terminal, post a news
    ```
    curl -i -X POST localhost:9103/api/news -H 'Content-Type: application/json' \
      -d '{"source":"Micronaut Blog", "title":"Micronaut Framework & GraalVM"}'
    ```

  - See `kafka-producer` and `kafka-consumer` Docker logs

- **Shutdown**

  Press `Ctrl+C` in `kafka-producer` and `kafka-consumer` terminals
