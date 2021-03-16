# graalvm-quarkus-micronaut-springboot
## `> producer-consumer > quarkus-producer-consumer`

The goal of this project is to implement two [`Quarkus`](https://quarkus.io/) applications: one that _produces_ messages to a [`Kafka`](https://kafka.apache.org/) topic and another that _consumes_ those messages. Besides, we will use `GraalVM`'s `native-image` tool to generate the native image of the applications.

## Applications

- ### producer-api

  `Quarkus` Web Java application that exposes one endpoint at which users can post `news`. Once a request is made, `producer-api` pushes a message about the `news` to `Kafka`.

  It has the following endpoint:
  ```
  POST /api/news {"source": "...", "title": "..."}
  ```

- ### consumer-api

  `Quarkus` Web Java application that listens to messages (published by the `producer-api`) and logs it.

## Running applications

> **Note:** `Kafka`, `Zookeeper` and other containers present in `docker-compose.yml` file must be up and running as explained [here](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/producer-consumer#start-environment)

### Development Mode

- **Startup**

  - **producer-api**

    - Open a terminal and navigate to `graalvm-quarkus-micronaut-springboot/producer-consumer/quarkus-producer-consumer` folder

    - Run the command below to start the application
      ```
      ./mvnw clean compile quarkus:dev --projects producer-api
      ```

  - **consumer-api**

    - Open a terminal and navigate to `graalvm-quarkus-micronaut-springboot/producer-consumer/quarkus-producer-consumer` folder

    - Run the command below
      ```
      ./mvnw clean compile quarkus:dev -Ddebug=5006 -Dquarkus.http.port=8081 --projects consumer-api
      ```

- **Simple Test**

  - In a new terminal, post a news
    ```
    curl -i -X POST localhost:8080/api/news -H 'Content-Type: application/json' \
      -d '{ "source":"Quarkus Blog", "title":"Dev Quarkus Framework" }'
    ```
  - See `producer-api` and `consumer-api` logs

- **Shutdown**

  Press `Ctrl+C` in `producer-api` and `consumer-api` terminals

### Docker in JVM Mode

- **Startup**

  - **producer-api**

    - In a terminal, make sure you are inside `graalvm-quarkus-micronaut-springboot/producer-consumer/quarkus-producer-consumer` folder

    - Clean and package the application
      ```
      ./mvnw clean package --projects producer-api
      ```

    - Run the command below to build the Docker image
      ```
      cd producer-api && ./docker-build.sh && cd ..
      ```

    - Run the following command to start the Docker container
      ```
      docker run --rm --name quarkus-producer-api-jvm -p 9100:8080 \
        --network producer-consumer_default \
        docker.mycompany.com/quarkus-producer-api-jvm:1.0.0
      ```

  - **consumer-api**

    - In another terminal, make sure you are inside `graalvm-quarkus-micronaut-springboot/producer-consumer/quarkus-producer-consumer` folder

    - Clean and package the application
      ```
      ./mvnw clean package --projects consumer-api
      ```

    - Run the command below to build the Docker image
      ```
      cd consumer-api && ./docker-build.sh && cd ..
      ```

    - Run the following command to start the Docker container
      ```
      docker run --rm --name quarkus-consumer-api-jvm -p 9106:8080 \
        --network producer-consumer_default \
        docker.mycompany.com/quarkus-consumer-api-jvm:1.0.0
      ```

- **Simple Test**

  - In a new terminal, post a news
    ```
    curl -i -X POST localhost:9100/api/news -H 'Content-Type: application/json' \
      -d '{ "source":"Quarkus Blog", "title":"Quarkus Framework" }'
    ```
  - See `producer-api` and `consumer-api` logs

- **Shutdown**

  Press `Ctrl+C` in `producer-api` and `consumer-api` terminals


### Docker in Native Mode

- **Startup**

  - **producer-api**

    - In a terminal, make sure you are inside `graalvm-quarkus-micronaut-springboot/producer-consumer/quarkus-producer-consumer` folder

    - Clean and package the application
      ```
      ./mvnw clean package -Pnative -Dquarkus.native.container-build=true --projects producer-api
      ```

    - Run the command below to build the Docker image
      ```
      cd producer-api && ./docker-build.sh native && cd ..
      ```

    - Run the following command to start the Docker container
      ```
      docker run --rm --name quarkus-producer-api-native -p 9101:8080 \
        --network producer-consumer_default \
        docker.mycompany.com/quarkus-producer-api-native:1.0.0
      ```

  - **consumer-api**

    - Open another terminal and navigate to `graalvm-quarkus-micronaut-springboot/producer-consumer/quarkus-producer-consumer` folder

    - Clean and package the application
      ```
      ./mvnw clean package -Pnative -Dquarkus.native.container-build=true --projects consumer-api
      ```

    - Run the command below to build the Docker image
      ```
      cd consumer-api && ./docker-build.sh native && cd ..
      ```

    - Run the following command to start the Docker container
      ```
      docker run --rm --name quarkus-consumer-api-native -p 9107:8080 \
        --network producer-consumer_default \
        docker.mycompany.com/quarkus-consumer-api-native:1.0.0
      ```

- **Simple Test**

  - In a new terminal, post a news
    ```
    curl -i -X POST localhost:9101/api/news -H 'Content-Type: application/json' \
      -d '{ "source":"Quarkus Blog", "title":"Quarkus Framework & GraalVM" }'
    ```
  - See `producer-api` and `consumer-api` logs

- **Shutdown**

  Press `Ctrl+C` in `producer-api` and `consumer-api` terminals
