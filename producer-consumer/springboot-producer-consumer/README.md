# `graalvm-quarkus-micronaut-springboot`
## `> producer-consumer > springboot-producer-consumer`

The goal of this project is to implement two [`Spring Boot`](https://docs.spring.io/spring-boot/docs/current/reference/htmlsingle/) applications: one that _produces_ messages to a [`Kafka`](https://kafka.apache.org/) topic and another that _consumes_ those messages.

## Applications

### producer-api

`Spring Boot` Web Java application that exposes one endpoint at which users can post `news`. Once a request is made, `producer-api` pushes a message about the `news` to `Kafka`.

It has the following endpoint:
```
POST /api/news {"source": "...", "title": "..."}
```

### consumer-api

`Spring Boot` Web Java application that listens to messages (published by the `producer-api`) and logs it.

## Running applications

> **Note:** `Kafka`, `Zookeeper` and other containers present in `docker-compose.yml` file must be up and running as explained [here](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/producer-consumer#start-environment)

### `producer-api`

### Development Mode

Open a terminal and inside `graalvm-quarkus-micronaut-springboot/producer-consumer/springboot-producer-consumer` folder run
```
./mvnw spring-boot:run --projects producer-api
```

### Docker in JVM Mode

Before building the docker image, you need to package the application `jar` file. So, in a terminal and inside `graalvm-quarkus-micronaut-springboot/producer-consumer/springboot-producer-consumer` folder run
```
./mvnw clean package --projects producer-api
```

Then, build the image with the script
```
cd producer-api && ./docker-build.sh && cd ..
```

Finally, run the container using
```
docker run -d --rm --name springboot-producer-api-jvm \
  -p 9104:8080 -e KAFKA_HOST=kafka -e ZIPKIN_HOST=zipkin --network producer-consumer_default \
  docker.mycompany.com/springboot-producer-api-jvm:1.0.0
```

### Docker in Native Mode

Spring team is working on supporting for `GraalVM` native images, https://github.com/spring-projects/spring-framework/wiki/GraalVM-native-image-support

### `consumer-api`

### Development Mode

Open a terminal and inside `graalvm-quarkus-micronaut-springboot/producer-consumer/springboot-producer-consumer` folder run
```
./mvnw spring-boot:run -Dspring-boot.run.jvmArguments="-Dserver.port=8081" --projects consumer-api
```

### Docker in JVM Mode

Before building the docker image, you need to package the application `jar` file. So, in a terminal and inside `graalvm-quarkus-micronaut-springboot/producer-consumer/springboot-producer-consumer` folder run
```
./mvnw clean package --projects consumer-api
```

Then, build the image with the script
```
cd consumer-api && ./docker-build.sh && cd ..
```

Finally, run the container using
```
docker run -d --rm --name springboot-consumer-api-jvm \
  -p 9109:8080 -e KAFKA_HOST=kafka -e ZIPKIN_HOST=zipkin --network producer-consumer_default \
  docker.mycompany.com/springboot-consumer-api-jvm:1.0.0
```

### Docker in Native Mode

Spring team is working on supporting for `GraalVM` native images, https://github.com/spring-projects/spring-framework/wiki/GraalVM-native-image-support

## Simple Test

- Posting a news
  > [HTTPie](https://httpie.org/) is being used here 
  ```
  http :9104/api/news source="Spring Boot Blog" title="Spring Boot Framework"
  ```
- See `springboot-producer-api-jvm` and `springboot-consumer-api-jvm` Docker logs

## Shutdown

To stop and remove application containers run
```
docker stop springboot-producer-api-jvm springboot-consumer-api-jvm
```
