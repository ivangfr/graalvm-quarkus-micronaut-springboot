# `graalvm-quarkus-micronaut-springboot`
## `> producer-consumer > quarkus`

The goal of this project is to implement two [`Quarkus`](https://quarkus.io/) applications: one that _produces_ messages to a [`Kafka`](https://kafka.apache.org/) topic and another that _consumes_ those messages. Besides, we will use `GraalVM`'s `native-image` tool to generate the native image of the applications.

## Applications

### producer-api

`Quarkus` Web Java application that exposes one endpoint at which users can post `news`. Once a request is made, `producer-api` pushes a message about the `news` to `Kafka`.

It has the following endpoint:
```
POST /api/news {"source": "...", "title": "..."}
```

### consumer-api

`Quarkus` Web Java application that listens to messages (published by the `producer-api`) and logs it.

## Running applications

> Note: `Kafka`, `Zookeeper` and other containers present in `docker-compose.yml` file must be up and running as explained [here](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/producer-consumer#start-environment)

### `producer-api`

### Development Mode

Open a terminal and inside `graalvm-quarkus-micronaut-springboot/producer-consumer/quarkus/producer-api` folder run
```
./mvnw compile quarkus:dev
```

### Docker in JVM Mode

Before building the docker image, you need to package the application `jar` file. So, in a terminal and inside
`graalvm-quarkus-micronaut-springboot/producer-consumer/quarkus/producer-api` folder run
```
./mvnw clean package
```

Then, build the image with the script
```
./docker-build.sh
```

Finally, run the container using
```
docker run -d --rm --name quarkus-producer-api-jvm --network producer-consumer_default -e KAFKA_HOST=kafka -p 9100:8080 docker.mycompany.com/quarkus-producer-api-jvm:1.0.0
```

### Docker in Native Mode

Before building the docker image, you need to package the application `jar` file. So, in a terminal and inside
`graalvm-quarkus-micronaut-springboot/producer-consumer/quarkus/producer-api` folder run
```
./mvnw clean package -Pnative -Dnative-image.docker-build=true
```

Then, build the image with the script
```
./docker-build.sh native
```

Finally, run the container using
```
docker run -d --rm --name quarkus-producer-api-native --network producer-consumer_default -e KAFKA_HOST=kafka -p 9101:8080 docker.mycompany.com/quarkus-producer-api-native:1.0.0
```

### `consumer-api`

### Development Mode

Open a terminal and inside `graalvm-quarkus-micronaut-springboot/producer-consumer/quarkus/consumer-api` folder run
```
./mvnw compile quarkus:dev -Ddebug=5006 -Dquarkus.http.port=8081
```

### Docker in JVM Mode

Before building the docker image, you need to package the application `jar` file. So, in a terminal and inside
`graalvm-quarkus-micronaut-springboot/producer-consumer/quarkus/consumer-api` folder run
```
./mvnw clean package
```

Then, build the image with the script
```
./docker-build.sh
```

Finally, run the container using
```
docker run -d --rm --name quarkus-consumer-api-jvm --network producer-consumer_default -e KAFKA_HOST=kafka -p 9105:8080 docker.mycompany.com/quarkus-consumer-api-jvm:1.0.0
```

### Docker in Native Mode

Before building the docker image, you need to package the application `jar` file. So, in a terminal and inside
`graalvm-quarkus-micronaut-springboot/producer-consumer/quarkus/consumer-api` folder run
```
./mvnw clean package -Pnative -Dnative-image.docker-build=true
```

Then, build the image with the script
```
./docker-build.sh native
```

Finally, run the container using
```
docker run -d --rm --name quarkus-consumer-api-native --network producer-consumer_default -e KAFKA_HOST=kafka -p 9106:8080 docker.mycompany.com/quarkus-consumer-api-native:1.0.0
```

## Simple Test

- Posting a news
> I am using [HTTPie](https://httpie.org/) 
```
http :9100/api/news source="Quarkus Blog" title="Quarkus Framework"
http :9101/api/news source="Quarkus Blog" title="Quarkus Framework & GraalVM"
```

- See `producer` and `consumer` Docker logs

## Shutdown

To stop and remove application containers run
```
docker stop quarkus-producer-api-jvm quarkus-producer-api-native quarkus-consumer-api-jvm quarkus-consumer-api-native
```
