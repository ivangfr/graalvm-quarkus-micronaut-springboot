# `graalvm-quarkus-micronaut-springboot`
## `> book-api`

In this example, we will implement three versions of a Restful API for handling Books using `Quarkus`, `Micronaut` and
`Spring Boot` Frameworks. The books information are store in a database.

## Applications

#### [quarkus-book-api](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/book-api/quarkus-book-api#graalvm-quarkus-micronaut-springboot)

#### [micronaut-book-api](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/book-api/micronaut-book-api#graalvm-quarkus-micronaut-springboot)

#### [springboot-book-api](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/book-api/springboot-book-api#graalvm-quarkus-micronaut-springboot)

## Start environment

Open a terminal and inside `graalvm-quarkus-micronaut-springboot/book-api` folder run
```
docker-compose up -d
```

Wait a little bit until `MySQL` is `Up (healthy)`. You can check it by running
```
docker-compose ps
```

Finally, run the script below to initialize the database
```
./init-db.sh
```

## Shutdown

To stop and remove containers, networks and volumes, run
```
docker-compose down -v
```
