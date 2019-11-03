# `graalvm-quarkus-micronaut-springboot`
## `> simple-api > springboot-simple-api`

## Application

### springboot-simple-api

[`Spring Boot`](https://docs.spring.io/spring-boot/docs/current/reference/htmlsingle/) Java Web application that expose
a simple REST API for greetings. It has the following endpoint
```
GET /api/greeting[?name=...]
```

## Running application

### Development Mode

Open a terminal and inside `graalvm-quarkus-micronaut-springboot/simple-api/springboot-simple-api` folder run
```
./gradlew bootRun
```

### Docker in JVM Mode

Before building the docker image, you need to package the application `jar` file. So, in a terminal and inside
`graalvm-quarkus-micronaut-springboot/simple-api/springboot-simple-api` folder run
```
./gradlew clean assemble
```

Then, build the image with the script
```
./docker-build.sh
```

Finally, run the container using
```
docker run -d --rm --name springboot-simple-api-jvm -p 9084:8080 \
  docker.mycompany.com/springboot-simple-api-jvm:1.0.0
```

### Docker in Native Mode

Spring team is working on supporting for `GraalVM` native images, https://github.com/spring-projects/spring-framework/wiki/GraalVM-native-image-support

## Shutdown

To stop and remove application container run
```
docker stop springboot-simple-api-jvm
```
