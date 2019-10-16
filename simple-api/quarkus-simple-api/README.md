# `graalvm-quarkus-micronaut-springboot`
## `> simple-api > quarkus-simple-api`

## Application

### quarkus-simple-api

[`Quarkus`](https://quarkus.io/) Java Web application that expose a simple REST API for greetings. It has the
following endpoint
```
GET /api/greeting[?name=...]
```

## Running application

### Development Mode

Open a terminal and inside `graalvm-quarkus-micronaut-springboot/simple-api/quarkus-simple-api` folder run
```
./mvnw compile quarkus:dev
```

### Docker in JVM Mode

Before building the docker image, you need to package the application `jar` file. So, in a terminal and inside
`graalvm-quarkus-micronaut-springboot/simple-api/quarkus-simple-api` folder run
```
./mvnw clean package
```

Then, build the image with the script
```
./docker-build.sh
```

Finally, run the container using
```
docker run -d --rm --name quarkus-simple-api-jvm -p 9080:8080 \
  docker.mycompany.com/quarkus-simple-api-jvm:1.0.0
```

### Docker in Native Mode

Before building the docker image, you need to package the application `jar` file. So, in a terminal and inside
`quarkus-graalvm-apis/quarkus-simple-api` folder run
```
./mvnw clean package -Pnative -Dnative-image.docker-build=true
```

Then, build the image with the script
```
./docker-build.sh native
```

Finally, run the container using
```
docker run -d --rm --name quarkus-simple-api-native -p 9081:8080 \
  docker.mycompany.com/quarkus-simple-api-native:1.0.0
```

## Shutdown

To stop and remove application containers run
```
docker stop quarkus-simple-api-jvm quarkus-simple-api-native
```
