# `graalvm-quarkus-micronaut-springboot`
## `> book-api > quarkus-book-api`

## Application

### quarkus-book-api

[`Quarkus`](https://quarkus.io/) Java Web application that exposes a REST API for managing books.
                                 
It has the following endpoints:
```
GET /api/books
GET /api/books/{id}
POST /api/books {"isbn": "...", "title": "..."}
```

## Running application

> Note: `MySQL` container must be running and initialized as explained [here](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/book-api#start-environment)

### Development Mode

Open a terminal and inside `graalvm-quarkus-micronaut-springboot/book-api/quarkus-book-api` folder run
```
./mvnw compile quarkus:dev
```

### Docker in JVM Mode

Before building the docker image, you need to package the application `jar` file. So, in a terminal and inside
`graalvm-quarkus-micronaut-springboot/book-api/quarkus-book-api` folder run
```
./mvnw clean package -DskipTests
```

Then, build the image with the script
```
./docker-build.sh
```

Finally, run the container using
```
docker run -d --rm --name quarkus-book-api-jvm -p 9085:8080 -e MYSQL_HOST=mysql --network book-api_default docker.mycompany.com/quarkus-book-api-jvm:1.0.0
```

### Docker in Native Mode

Before building the docker image, you need to package the application `jar` file. So, in a terminal and inside
`graalvm-quarkus-micronaut-springboot/book-api/quarkus-book-api` folder run
```
./mvnw clean package -Pnative -Dnative-image.docker-build=true -DskipTests
```

Then, build the image with the script
```
./docker-build.sh native
```

Finally, run the container using
```
docker run -d --rm --name quarkus-book-api-native -p 9086:8080 -e MYSQL_HOST=mysql --network book-api_default docker.mycompany.com/quarkus-book-api-native:1.0.0
```

## Shutdown

To stop and remove application containers run
```
docker stop quarkus-book-api-jvm quarkus-book-api-native
```
