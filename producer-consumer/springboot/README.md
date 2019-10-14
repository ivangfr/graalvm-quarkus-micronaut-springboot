# `graalvm-quarkus-micronaut-springboot`
## `> producer-consumer > springboot`

Instead of re-implement a new Kafka `producer` and `consumer` using [`Spring Boot`](https://docs.spring.io/spring-boot/docs/current/reference/htmlsingle/), we will re-use the ones implemented in the repository [`springboot-cloudkarafka`](https://github.com/ivangfr/springboot-cloudkarafka).

So, go ahead and clone it
```
git clone https://github.com/ivangfr/springboot-cloudkarafka.git
```

It contains two types of implementations for `producer` and `consumer`. One uses [`Spring Kafka`](https://github.com/ivangfr/springboot-cloudkarafka/tree/master/spring-kafka#springboot-cloudkarafka) and another [`Spring Cloud Stream`](https://github.com/ivangfr/springboot-cloudkarafka/tree/master/spring-cloud-stream#springboot-cloudkarafka).

In this documentation, we will use the `Spring Kafka` implementation.

## Applications

### [producer-kafka](https://github.com/ivangfr/springboot-cloudkarafka/tree/master/spring-kafka#producer-kafka)

### [consumer-kafka](https://github.com/ivangfr/springboot-cloudkarafka/tree/master/spring-kafka#consumer-kafka)

## Running applications

> Note: `Kafka`, `Zookeeper` and other containers present in `docker-compose.yml` file must be up and running as explained [here](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/producer-consumer#start-environment)

### `producer-kafka`

### Development Mode

Open a terminal and inside `springboot-cloudkarafka` root folder run
```
./mvnw spring-boot:run --projects spring-kafka/producer-kafka -Dspring-boot.run.jvmArguments="-Dserver.port=9104"
```

### Docker in JVM Mode

In a terminal and inside `springboot-cloudkarafka` folder run
```
./mvnw clean package dockerfile:build -DskipTests --projects spring-kafka/producer-kafka
```

Then, run the container using
```
docker run -d --rm --name producer-kafka --network producer-consumer_default -e KAFKA_URL=kafka:9092 -p 9104:8080 docker.mycompany.com/producer-kafka:1.0.0
```

### Docker in Native Mode

Spring team is working on supporting for `GraalVM` native images, https://github.com/spring-projects/spring-framework/wiki/GraalVM-native-image-support

### `consumer-kafka`

### Development Mode

Open a terminal and inside `springboot-cloudkarafka` folder run
```
./mvnw spring-boot:run --projects spring-kafka/consumer-kafka -Dspring-boot.run.jvmArguments="-Dserver.port=9109"
```

### Docker in JVM Mode

In a terminal and inside `springboot-cloudkarafka` folder run
```
./mvnw clean package dockerfile:build -DskipTests --projects spring-kafka/consumer-kafka
```

Then, run the container using
```
docker run -d --rm --name consumer-kafka --network producer-consumer_default -e KAFKA_URL=kafka:9092 -p 9109:8080 docker.mycompany.com/consumer-kafka:1.0.0
```

### Docker in Native Mode

Spring team is working on supporting for `GraalVM` native images, https://github.com/spring-projects/spring-framework/wiki/GraalVM-native-image-support

## Simple Test

- Posting a news
> I am using [HTTPie](https://httpie.org/) 
```
http :9104/api/news source="Spring Boot Blog" title="Spring Boot Framework"
```

- See `producer-kafka` and `consumer-kafka` Docker logs

## Shutdown

To stop and remove application containers run
```
docker stop producer-kafka consumer-kafka
```
