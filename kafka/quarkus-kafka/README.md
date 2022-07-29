# graalvm-quarkus-micronaut-springboot
## `> kafka > quarkus-kafka`

The goal of this project is to implement two [`Quarkus`](https://quarkus.io/) applications: one that _produces_ messages to a [`Kafka`](https://kafka.apache.org/) topic and another that _consumes_ those messages. Besides, we will use `GraalVM`'s `native-image` tool to generate the native image of the applications.

## Applications

- ### kafka-producer

  `Quarkus` Web Java application that exposes one endpoint at which users can post `news`. Once a request is made, `kafka-producer` pushes a message about the `news` to `Kafka`.

  It has the following endpoints:
  ```
  POST /api/news {"source":"...", "title":"..."}
  GET /q/health
  GET /q/metrics
  ```

- ### kafka-consumer

  `Quarkus` Web Java application that listens to messages (published by the `kafka-producer`) and logs it.

  It has the following endpoints:
  ```
  GET /q/health
  GET /q/metrics
  ```

## Running applications

> **Note**: `Kafka`, `Zookeeper` and other containers present in `docker-compose.yml` file must be up and running as explained [here](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/kafka#start-environment)

### Development Mode

- **Startup**

  - **kafka-producer**

    - Open a terminal and navigate to `graalvm-quarkus-micronaut-springboot/kafka/quarkus-kafka` folder

    - Run the command below to start the application
      ```
      ./mvnw clean compile quarkus:dev --projects kafka-producer
      ```

  - **kafka-consumer**

    - Open a terminal and navigate to `graalvm-quarkus-micronaut-springboot/kafka/quarkus-kafka` folder

    - Run the command below
      ```
      ./mvnw clean compile quarkus:dev --projects kafka-consumer -Ddebug=5006 -Dquarkus.http.port=8081
      ```

- **Simple Test**

  - In a new terminal, post a news
    ```
    curl -i -X POST localhost:8080/api/news -H 'Content-Type: application/json' \
      -d '{"source":"Quarkus Blog", "title":"Dev Quarkus Framework"}'
    ```
  - See `kafka-producer` and `kafka-consumer` logs

- **Shutdown**

  Press `Ctrl+C` in `kafka-producer` and `kafka-consumer` terminals

### Docker in JVM Mode

- **Startup**

  - **kafka-producer**

    - In a terminal, make sure you are inside `graalvm-quarkus-micronaut-springboot/kafka/quarkus-kafka` folder

    - Clean and package the application
      ```
      ./mvnw clean package --projects kafka-producer
      ```

    - Run the command below to build the Docker image
      ```
      cd kafka-producer && ./docker-build.sh && cd ..
      ```

    - Run the following command to start the Docker container
      ```
      docker run --rm --name quarkus-kafka-producer-jvm \
        -p 9100:8080 -e KAFKA_HOST=kafka -e KAFKA_PORT=9092 \
        --network kafka_default \
        ivanfranchin/quarkus-kafka-producer-jvm:1.0.0
      ```

  - **kafka-consumer**

    - In another terminal, make sure you are inside `graalvm-quarkus-micronaut-springboot/kafka/quarkus-kafka` folder

    - Clean and package the application
      ```
      ./mvnw clean package --projects kafka-consumer
      ```

    - Run the command below to build the Docker image
      ```
      cd kafka-consumer && ./docker-build.sh && cd ..
      ```

    - Run the following command to start the Docker container
      ```
      docker run --rm --name quarkus-kafka-consumer-jvm \
        -p 9106:8080 -e KAFKA_HOST=kafka -e KAFKA_PORT=9092 \
        --network kafka_default \
        ivanfranchin/quarkus-kafka-consumer-jvm:1.0.0
      ```

- **Simple Test**

  - In a new terminal, post a news
    ```
    curl -i -X POST localhost:9100/api/news -H 'Content-Type: application/json' \
      -d '{"source":"Quarkus Blog", "title":"Quarkus Framework"}'
    ```
  - See `kafka-producer` and `kafka-consumer` logs

- **Shutdown**

  Press `Ctrl+C` in `kafka-producer` and `kafka-consumer` terminals


### Docker in Native Mode

- **Startup**

  - **kafka-producer**

    - In a terminal, make sure you are inside `graalvm-quarkus-micronaut-springboot/kafka/quarkus-kafka` folder

    - Clean and package the application
      ```
      ./mvnw clean package -Pnative -Dquarkus.native.container-build=true --projects kafka-producer
      ```

    - Run the command below to build the Docker image
      ```
      cd kafka-producer && ./docker-build.sh native && cd ..
      ```

    - Run the following command to start the Docker container
      ```
      docker run --rm --name quarkus-kafka-producer-native \
        -p 9101:8080 -e QUARKUS_PROFILE=native -e KAFKA_HOST=kafka -e KAFKA_PORT=9092 \
        --network kafka_default \
        ivanfranchin/quarkus-kafka-producer-native:1.0.0
      ```

  - **kafka-consumer**

    - Open another terminal and navigate to `graalvm-quarkus-micronaut-springboot/kafka/quarkus-kafka` folder

    - Clean and package the application
      ```
      ./mvnw clean package -Pnative -Dquarkus.native.container-build=true --projects kafka-consumer
      ```

    - Run the command below to build the Docker image
      ```
      cd kafka-consumer && ./docker-build.sh native && cd ..
      ```

    - Run the following command to start the Docker container
      ```
      docker run --rm --name quarkus-kafka-consumer-native \
        -p 9107:8080 -e QUARKUS_PROFILE=native -e KAFKA_HOST=kafka -e KAFKA_PORT=9092 \
        --network kafka_default \
        ivanfranchin/quarkus-kafka-consumer-native:1.0.0
      ```

- **Simple Test**

  - In a new terminal, post a news
    ```
    curl -i -X POST localhost:9101/api/news -H 'Content-Type: application/json' \
      -d '{"source":"Quarkus Blog", "title":"Quarkus Framework & GraalVM"}'
    ```
  - See `kafka-producer` and `kafka-consumer` logs

- **Shutdown**

  Press `Ctrl+C` in `kafka-producer` and `kafka-consumer` terminals
