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

## Comparison

```
                   Application | Packaging Time | Jar Size (bytes) | Docker Build Time | Docker Image Size |
------------------------------ + -------------- + ---------------- + ----------------- + ----------------- |
          quarkus-book-api-jvm |            13s |           443792 |               23s |             120MB |
        micronaut-book-api-jvm |            16s |         32803668 |                3s |             276MB |
       springboot-book-api-jvm |             5s |         42354478 |                4s |             127MB |
       quarkus-book-api-native |           364s |           443925 |                9s |             153MB |
     micronaut-book-api-native |            17s |         32803649 |              601s |             145MB |
```

```
                   Application | Statup Time | Initial Memory Consumption | Ab Testing Time | Final Memory Consumption |
------------------------------ + ----------- + -------------------------- + --------------- + ------------------------ |
          quarkus-book-api-jvm |      6377ms |                   143.4MiB |             30s |                 167.4MiB |
        micronaut-book-api-jvm |      9838ms |                   82.02MiB |             40s |                 162.2MiB |
       springboot-book-api-jvm |     14009ms |                   492.1MiB |             46s |                 600.9MiB |
       quarkus-book-api-native |        30ms |                   4.059MiB |             17s |                 253.9MiB |
     micronaut-book-api-native |           - |                          - |               - |                        - |
```
> Note. There is no results for `micronaut-book-api-native` because we are getting an error while trying to run it. It
> id related to this [issue](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/book-api/micronaut-book-api#issues) 

`ab` tests used
```
               Application |                                                                                  ab Test |
-------------------------- | ---------------------------------------------------------------------------------------- |
      quarkus-book-api-jvm | ab -p test-books.json -T 'application/json' -c 5 -n 2500 http://localhost:9085/api/books |
    micronaut-book-api-jvm | ab -p test-books.json -T 'application/json' -c 5 -n 2500 http://localhost:9087/api/books |
   springboot-book-api-jvm | ab -p test-books.json -T 'application/json' -c 5 -n 2500 http://localhost:9089/api/books |
   quarkus-book-api-native | ab -p test-books.json -T 'application/json' -c 5 -n 2500 http://localhost:9086/api/books |
 micronaut-book-api-native | ab -p test-books.json -T 'application/json' -c 5 -n 2500 http://localhost:9088/api/books |
```

## Shutdown

To stop and remove containers, networks and volumes, run
```
docker-compose down -v
```
