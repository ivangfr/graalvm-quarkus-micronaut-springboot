# `graalvm-quarkus-micronaut-springboot`
## `> book-api > springboot-book-api`

## Application

### springboot-book-api

[`Spring Boot`](https://docs.spring.io/spring-boot/docs/current/reference/htmlsingle/) Java Web application that
exposes a REST API for managing books.

It has the following endpoints:
```
GET /api/books
GET /api/books/{id}
POST /api/books {"isbn": "...", "title": "..."}
```

## Running application

> Note: `MySQL` container must be running and initialized as explained [here](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/book-api#start-environment)

### Development Mode

Open a terminal and inside `graalvm-quarkus-micronaut-springboot/book-api/springboot-book-api` folder run
```
./gradlew bootRun
```

### Docker in JVM Mode

Before building the docker image, you need to package the application `jar` file. So, in a terminal and inside
`graalvm-quarkus-micronaut-springboot/book-api/springboot-book-api` folder run
```
./gradlew clean assemble
```

Then, build the image with the script
```
./docker-build.sh
```

Finally, run the container using
```
docker run -d --rm --name springboot-book-api-jvm \
  -p 9089:8080 -e MYSQL_HOST=mysql --network book-api_default \
  docker.mycompany.com/springboot-book-api-jvm:1.0.0
```

### Docker in Native Mode

Spring team is working on supporting for `GraalVM` native images, https://github.com/spring-projects/spring-framework/wiki/GraalVM-native-image-support

## Shutdown

To stop and remove application container run
```
docker stop springboot-book-api-jvm
```
