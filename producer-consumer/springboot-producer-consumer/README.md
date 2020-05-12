# graalvm-quarkus-micronaut-springboot
## `> producer-consumer > springboot-producer-consumer`

The goal of this project is to implement two [`Spring Boot`](https://docs.spring.io/spring-boot/docs/current/reference/htmlsingle/) applications: one that _produces_ messages to a [`Kafka`](https://kafka.apache.org/) topic and another that _consumes_ those messages.

## Applications

- **producer-api**

  `Spring Boot` Web Java application that exposes one endpoint at which users can post `news`. Once a request is made, `producer-api` pushes a message about the `news` to `Kafka`.

  It has the following endpoint:
  ```
  POST /api/news {"source": "...", "title": "..."}
  ```

- **consumer-api**

  `Spring Boot` Web Java application that listens to messages (published by the `producer-api`) and logs it.

## Running applications

> **Note:** `Kafka`, `Zookeeper` and other containers present in `docker-compose.yml` file must be up and running as explained [here](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/producer-consumer#start-environment)

### Development Mode

- **Startup**

  - **producer-api**

    - Open a terminal and navigate to `graalvm-quarkus-micronaut-springboot/producer-consumer/springboot-producer-consumer` folder

    - Run the command below to start the application
      ```
      ./mvnw clean spring-boot:run --projects producer-api
      ```

  - **consumer-api**

    - Open another terminal and make sure your are in `graalvm-quarkus-micronaut-springboot/producer-consumer/springboot-producer-consumer` folder

    - Run the command below to start the application
      ```
      ./mvnw clean spring-boot:run -Dspring-boot.run.jvmArguments="-Dserver.port=8081" --projects consumer-api
      ```

- **Simple Test**

  - In a new terminal, post a news
    ```
    curl -X POST localhost:8080/api/news -H 'Content-Type: application/json' \
      -d '{ "source":"Spring Boot Blog", "title":"Dev Spring Boot Framework" }'
    ```

  - See `producer-api` and `consumer-api` logs

- **Shutdown**

  Press `Ctrl+C` in `producer-api` and `consumer-api` terminals

### Docker in JVM Mode

- **Startup**

  - **producer-api**

    - In a terminal, make sure you are inside `graalvm-quarkus-micronaut-springboot/producer-consumer/springboot-producer-consumer` folder

    - Package the application `jar` file
      ```
      ./mvnw clean package --projects producer-api
      ```

    - Run the script below to build the Docker image
      ```
      cd producer-api && ./docker-build.sh && cd ..
      ```

    - Run the following command to start the Docker container
      ```
      docker run --rm --name springboot-producer-api-jvm -p 9104:8080 \
        -e KAFKA_HOST=kafka -e ZIPKIN_HOST=zipkin --network producer-consumer_default \
        docker.mycompany.com/springboot-producer-api-jvm:1.0.0
      ```

  - **consumer-api**

    - In another terminal, make sure you are inside `graalvm-quarkus-micronaut-springboot/producer-consumer/springboot-producer-consumer` folder

    - Package the application `jar` file
      ```
      ./mvnw clean package --projects consumer-api
      ```

    - Run the script below to build the Docker image
      ```
      cd consumer-api && ./docker-build.sh && cd ..
      ```

    - Run the following command to start the Docker container
      ```
      docker run --rm --name springboot-consumer-api-jvm -p 9109:8080 \
        -e KAFKA_HOST=kafka -e ZIPKIN_HOST=zipkin --network producer-consumer_default \
        docker.mycompany.com/springboot-consumer-api-jvm:1.0.0
      ```

- **Simple Test**

  - In a new terminal, post a news
    ```
    curl -X POST localhost:9104/api/news -H 'Content-Type: application/json' \
      -d '{ "source":"Spring Boot Blog", "title":"Dev Spring Boot Framework" }'
    ```

  - See `producer-api` and `consumer-api` logs

- **Shutdown**

  Press `Ctrl+C` in `producer-api` and `consumer-api` terminals

### Docker in Native Mode

Spring team is working on supporting for `GraalVM` native images, https://github.com/spring-projects/spring-framework/wiki/GraalVM-native-image-support
