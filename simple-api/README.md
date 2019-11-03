# `graalvm-quarkus-micronaut-springboot`
## `> simple-api`

In this example, we will implement three versions of a simple Greeting REST API using `Quarkus`, `Micronaut` and
`Spring Boot` Frameworks.

## Applications

#### [quarkus-simple-api](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/simple-api/quarkus-simple-api#graalvm-quarkus-micronaut-springboot)

#### [micronaut-simple-api](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/simple-api/micronaut-simple-api#graalvm-quarkus-micronaut-springboot)

#### [springboot-simple-api](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/simple-api/springboot-simple-api#graalvm-quarkus-micronaut-springboot)

## Comparison 

```
                 Application | Packaging Time | Jar Size (bytes) | Docker Build Time | Docker Image Size |
---------------------------- + -------------- + ---------------- + ----------------- + ----------------- |
      quarkus-simple-api-jvm |             9s |           279390 |               14s |            90.6MB |
    micronaut-simple-api-jvm |             8s |         14086712 |                3s |             257MB |
   springboot-simple-api-jvm |             3s |         19479848 |                3s |             104MB |
   quarkus-simple-api-native |           208s |           279490 |                5s |             116MB |
 micronaut-simple-api-native |            11s |         14086716 |              332s |              87MB |
```

```
                 Application | Statup Time | Initial Memory Consumption | Ab Testing Time | Final Memory Consumption |
---------------------------- + ----------- + -------------------------- + --------------- + ------------------------ |
      quarkus-simple-api-jvm |      2684ms |                   84.34MiB |             16s |                 124.1MiB |
    micronaut-simple-api-jvm |      5916ms |                   53.53MiB |             23s |                 130.5MiB |
   springboot-simple-api-jvm |      5905ms |                   179.2MiB |             16s |                 254.6MiB |
   quarkus-simple-api-native |        30ms |                   2.508MiB |             10s |                 253.9MiB |
 micronaut-simple-api-native |        65ms |                   11.64MiB |             12s |                 259.2MiB |
```

`ab` tests used
```
                 Application |                                                       ab Test |
---------------------------- | ------------------------------------------------------------- |
      quarkus-simple-api-jvm | ab -c 10 -n 5000 http://localhost:9080/api/greeting?name=Ivan |
    micronaut-simple-api-jvm | ab -c 10 -n 5000 http://localhost:9082/api/greeting?name=Ivan |
   springboot-simple-api-jvm | ab -c 10 -n 5000 http://localhost:9084/api/greeting?name=Ivan |
   quarkus-simple-api-native | ab -c 10 -n 5000 http://localhost:9081/api/greeting?name=Ivan |
 micronaut-simple-api-native | ab -c 10 -n 5000 http://localhost:9083/api/greeting?name=Ivan |
```
