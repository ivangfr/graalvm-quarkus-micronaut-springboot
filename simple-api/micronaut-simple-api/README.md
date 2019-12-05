# `graalvm-quarkus-micronaut-springboot`
## `> simple-api > micronaut-simple-api`

## Application

### micronaut-simple-api

[`Micronaut`](https://micronaut.io/) Java Web application that expose a simple REST API for greetings. It has the following endpoint
```
GET /api/greeting[?name=...]
```

## Running application

### Development Mode

In a terminal and inside `graalvm-quarkus-micronaut-springboot/simple-api/micronaut-simple-api` folder run
```
./gradlew run
```

### Docker in JVM Mode

Before building the docker image, you need to package the application `jar` file. So, in a terminal and inside `graalvm-quarkus-micronaut-springboot/simple-api/micronaut-simple-api` folder run
```
./gradlew clean assemble
```

Then, build the image with the script
```
./docker-build.sh
```

Finally, run the container using
```
docker run -d --rm --name micronaut-simple-api-jvm -p 9082:8080 \
  docker.mycompany.com/micronaut-simple-api-jvm:1.0.0
```

### Docker in Native Mode

Before building the docker image, you need to package the application `jar` file. So, in a terminal and inside `graalvm-quarkus-micronaut-springboot/simple-api/micronaut-simple-api` folder run
```
./gradlew clean assemble
```

Then, build the image with the script
```
./docker-build.sh native
```

Finally, run the container using
```
docker run -d --rm --name micronaut-simple-api-native -p 9083:8080 \
  docker.mycompany.com/micronaut-native-simple-api-native:1.0.0
```

## Shutdown

To stop and remove application containers run
```
docker stop micronaut-simple-api-jvm micronaut-simple-api-native
```
