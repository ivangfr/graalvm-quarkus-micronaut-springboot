# graalvm-quarkus-micronaut-springboot
## `> producer-consumer > micronaut-producer-consumer`

The goal of this project is to implement two [`Micronaut`](https://micronaut.io/) applications: one that _produces_ messages to a [`Kafka`](https://kafka.apache.org/) topic and another that _consumes_ those messages. Besides, we will use `GraalVM`'s `native-image` tool to generate the native image of the applications.

## Applications

- **producer-api**

  `Micronaut` Web Java application that exposes one endpoint at which users can post `news`. Once a request is made, `producer-api` pushes a message about the `news` to `Kafka`.

  It has the following endpoint:
  ```
  POST /api/news {"source": "...", "title": "..."}
  ```

- **consumer-api**

  `Micronaut` Web Java application that listens to messages (published by the `producer-api`) and logs it.

## Running applications

> **Note:** `Kafka`, `Zookeeper` and other containers present in `docker-compose.yml` file must be up and running as explained [here](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/producer-consumer#start-environment)

### Development Mode

- **Startup**

  - **producer-api**

    - Open a terminal and navigate to `graalvm-quarkus-micronaut-springboot/producer-consumer/micronaut-producer-consumer` folder

    - Run the command below
      ```
      ./mvnw clean mn:run --projects producer-api
      ```

  - **consumer-api**

    - Open another terminal and navigate to `graalvm-quarkus-micronaut-springboot/producer-consumer/micronaut-producer-consumer` folder

    - Run the command below
      ```
      export MICRONAUT_SERVER_PORT=8081 && ./mvnw clean mn:run --projects consumer-api
      ```

- **Simple Test**

  - In a new terminal, post a news
    ```
    curl -i -X POST localhost:8080/api/news -H 'Content-Type: application/json' \
      -d '{ "source":"Micronaut Blog", "title":"Dev Micronaut Framework" }'
    ```

  - See `producer-api` and `consumer-api` logs

- **Shutdown**

  Press `Ctrl+C` in `producer-api` and `consumer-api` terminals

### Docker in JVM Mode

- **Startup**

  - **producer-api**

    - In a terminal, make sure you are inside `graalvm-quarkus-micronaut-springboot/producer-consumer/micronaut-producer-consumer` folder

    - Run the script below to build the Docker image
      ```
      cd producer-api && ./docker-build.sh && cd ..
      ```

    - Run the following command to start the Docker container
      ```
      docker run --rm --name micronaut-producer-api-jvm \
        -p 9102:8080 -e KAFKA_HOST=kafka -e KAFKA_PORT=9092 \
        --network producer-consumer_default \
        docker.mycompany.com/micronaut-producer-api-jvm:1.0.0
      ```

  - **consumer-api**

    - In another terminal, make sure you are inside `graalvm-quarkus-micronaut-springboot/producer-consumer/micronaut-producer-consumer` folder

    - Run the script below to build the Docker image
      ```
      cd consumer-api && ./docker-build.sh && cd ..
      ```

    - Run the following command to start the Docker container
      ```
      docker run --rm --name micronaut-consumer-api-jvm \
        -p 9107:8080 -e KAFKA_HOST=kafka -e KAFKA_PORT=9092 \
        --network producer-consumer_default \
        docker.mycompany.com/micronaut-consumer-api-jvm:1.0.0
      ```

- **Simple Test**

  - In a new terminal, post a news
    ```
    curl -i -X POST localhost:9102/api/news -H 'Content-Type: application/json' \
      -d '{ "source":"Micronaut Blog", "title":"Micronaut Framework" }'
    ```

  - See `producer-api` and `consumer-api` Docker logs

- **Shutdown**

  Press `Ctrl+C` in `producer-api` and `consumer-api` terminals

### Docker in Native Mode

- **Startup**

  - **producer-api**

    - In a terminal, make sure you are inside `graalvm-quarkus-micronaut-springboot/producer-consumer/micronaut-producer-consumer` folder

    - Run the script below to build the Docker image
      ```
      cd producer-api && ./docker-build.sh native && cd ..
      ```

    - Run the following command to start the Docker container
      ```
      docker run --rm --name micronaut-producer-api-native \
        -p 9103:8080 -e KAFKA_HOST=kafka -e KAFKA_PORT=9092 \
        --network producer-consumer_default \
        docker.mycompany.com/micronaut-producer-api-native:1.0.0
      ```

  - **consumer-api**

    - In another terminal, make sure you are inside `graalvm-quarkus-micronaut-springboot/producer-consumer/micronaut-producer-consumer` folder

    - Run the script below to build the Docker image
      ```
      cd consumer-api && ./docker-build.sh native && cd ..
      ```

    - Run the following command to start the Docker container
      ```
      docker run --rm --name micronaut-consumer-api-native \
        -p 9108:8080 -e KAFKA_HOST=kafka -e KAFKA_PORT=9092 \
        --network producer-consumer_default \
        docker.mycompany.com/micronaut-consumer-api-native:1.0.0
      ```

- **Simple Test**

  - In a new terminal, post a news
    ```
    curl -i -X POST localhost:9103/api/news -H 'Content-Type: application/json' \
      -d '{ "source":"Micronaut Blog", "title":"Micronaut Framework & GraalVM" }'
    ```

  - See `producer-api` and `consumer-api` Docker logs

- **Shutdown**

  To stop and remove `producer-api` and `consumer-api` Docker containers, run in a terminal
  ```
  docker stop micronaut-producer-api-native micronaut-consumer-api-native
  ```
