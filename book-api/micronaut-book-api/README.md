# `graalvm-quarkus-micronaut-springboot`
## `> book-api > micronaut-book-api`

## Application

### micronaut-book-api

[`Micronaut`](https://micronaut.io/) Java Web application that exposes a REST API for managing books.

It has the following endpoints:
```
GET /api/books
GET /api/books/{id}
POST /api/books {"isbn": "...", "title": "..."}
```

## Running application

> Note: `MySQL` container must be running and initialized as explained [here](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/book-api#start-environment)

### Development Mode

Open a terminal and inside `graalvm-quarkus-micronaut-springboot/book-api/micronaut-book-api` folder run
```
./gradlew run
```

### Docker in JVM Mode

Before building the docker image, you need to package the application `jar` file. So, in a terminal and inside
`graalvm-quarkus-micronaut-springboot/book-api/micronaut-book-api` folder run
```
./gradlew clean assemble
```

Then, build the image with the script
```
./docker-build.sh
```

Finally, run the container using
```
docker run -d --rm --name micronaut-book-api-jvm -p 9087:8080 -e MYSQL_HOST=mysql --network book-api_default docker.mycompany.com/micronaut-book-api-jvm:1.0.0
```

### Docker in Native Mode

Before building the docker image, you need to package the application `jar` file. So, in a terminal and inside
`graalvm-quarkus-micronaut-springboot/book-api/micronaut-book-api` folder run
```
./gradlew clean assemble
```

Then, build the image with the script
```
./docker-build.sh native
```

Finally, run the container using
```
docker run -d --rm --name micronaut-book-api-native -p 9088:8080 -e MYSQL_HOST=mysql --network book-api_default docker.mycompany.com/micronaut-book-api-native:1.0.0
```

## Shutdown

To stop and remove application containers run
```
docker stop micronaut-book-api-jvm micronaut-book-api-native
```
