# `graalvm-quarkus-micronaut-springboot`
## `> book-api`

In this example, we will implement three versions of a Restful API for handling Books using `Quarkus`, `Micronaut` and `Spring Boot` Frameworks. The books information are store in a database.

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

## Comparison 

| Criteria                                  | Quarkus-JVM | Quarkus-Native | Micronaut-JVM | Micronaut-Native | Spring Boot |
| ----------------------------------------- | ----------- | -------------- | ------------- | ---------------- | ------------|
| Jar packaging time                        |             |                |               |                  |             |
| Size of the jar                           |             |                |               |                  |             |
| Docker building time                      |             |                |               |                  |             |
| Docker image size                         |             |                |               |                  |             |
| Startup time                              |             |                |               |                  |             |
| Initial memory consumption                |             |                |               |                  |             |
| Time to run the ab test POST <sup>1</sup> |             |                |               |                  |             |
| Time to run the ab test GET <sup>2</sup>  |             |                |               |                  |             |
| Final memory consumption                  |             |                |               |                  |             |

<sup>1</sup> `ab` tests used
```
| Framework-Mode   | ab Test |
| ---------------- | ------- |
| Quarkus-JVM      | ab -p test-books.json -T 'application/json' -n 10000 -c 100 http://localhost:9085/api/books |
| Quarkus-Native   | ab -p test-books.json -T 'application/json' -n 10000 -c 100 http://localhost:9086/api/books |
| Micronaut-JVM    | ab -p test-books.json -T 'application/json' -n 10000 -c 100 http://localhost:9087/api/books |
| Micronaut-Native | ab -p test-books.json -T 'application/json' -n 10000 -c 100 http://localhost:9088/api/books |
| Spring Boot      | ab -p test-books.json -T 'application/json' -n 10000 -c 100 http://localhost:9089/api/books |
```

<sup>2</sup> `ab` tests used
```
| Framework-Mode   | ab Test |
| ---------------- | ------- |
| Quarkus-JVM      | ab -n 10000 -c 100 http://localhost:9085/api/books/1 |
| Quarkus-Native   | ab -n 10000 -c 100 http://localhost:9086/api/books/1 |
| Micronaut-JVM    | ab -n 10000 -c 100 http://localhost:9087/api/books/1 |
| Micronaut-Native | ab -n 10000 -c 100 http://localhost:9088/api/books/1 |
| Spring Boot      | ab -n 10000 -c 100 http://localhost:9089/api/books/1 |
```

<sup>3</sup> Unable to run `native-image` while building docker image. See **Issues** section.

## Shutdown

To stop and remove containers, networks and volumes, run
```
docker-compose down -v
```
