# graalvm-quarkus-micronaut-springboot

The goal of this project is to compare some Java frameworks like: [`Quarkus`](https://quarkus.io/), [`Micronaut`](https://micronaut.io/) and [`Spring Boot`](https://docs.spring.io/spring-boot/docs/current/reference/htmlsingle/). For it, we will implement applications using those frameworks, measure their start-up times, memory footprint, etc.

Besides, as `Quarkus` and `Micronaut` support [`GraalVM`](https://www.graalvm.org/) out-of-the-box, we will use `GraalVM`’s `native-image` tool to build `Quarkus` and `Micronaut` native applications.

> **Note:** Spring team is working on supporting for `GraalVM` native images, https://github.com/spring-projects/spring-framework/wiki/GraalVM-native-image-support

## Prerequisites

- `Java 11+`
- `Docker`
- `Docker-Compose`

## Examples

- ### [simple-api](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/simple-api#graalvm-quarkus-micronaut-springboot)
- ### [book-api](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/book-api#graalvm-quarkus-micronaut-springboot)
- ### [producer-consumer](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/producer-consumer#graalvm-quarkus-micronaut-springboot)
- ### [elasticsearch](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/elasticsearch#graalvm-quarkus-micronaut-springboot)

## Framework version

We are using the following Framework versions

| Framework   | Version       |
| ----------- | ------------- |
| Quarkus     | 1.5.0.Final   |
| Micronaut   | 2.0.0.M3      |
| Spring Boot | 2.3.0.RELEASE |

## Bash scripts

In order to make it easier to collect data that will be used for comparing the frameworks, we've implemented some bash scripts.

| Bash script                             | Description |
| --------------------------------------- | ----------- |
| collect-jvm-jar-docker-size-times.sh    | it packages/assembles jar files and builds docker images of all JVM applications, collecting data like: jar packaging Time, size of the jar, docker build time and docker image size |
| collect-native-jar-docker-size-times.sh | it packages/assembles jar files and builds docker images of all Native applications, collecting data like: jar packaging Time, size of the jar, docker build time and docker image size |
| collect-startup-ab-times.sh             | it starts docker container of all applications (JVM and Native), collecting data like: startup time, initial memory consumption, time spent to run some ab tests and final memory consumption |

## Comparison

The following table shows the results after running the script `collect-jvm-jar-docker-size-times.sh`
```
                   Application | Packaging Time | Jar Size (bytes) | Docker Build Time | Docker Image Size |
------------------------------ + -------------- + ---------------- + ----------------- + ----------------- |
        quarkus-simple-api-jvm |            11s |           307127 |                8s |             512MB |
      micronaut-simple-api-jvm |            13s |         15705448 |                9s |             212MB |
     springboot-simple-api-jvm |             4s |         21922346 |                9s |             218MB |
.............................. + .............. + ................ + ................. + ................. |
          quarkus-book-api-jvm |            11s |           520702 |               12s |             534MB |
        micronaut-book-api-jvm |            17s |         34478536 |               13s |             231MB |
       springboot-book-api-jvm |             6s |         43169753 |               12s |             239MB |
.............................. + .............. + ................ + ................. + ................. |
      quarkus-producer-api-jvm |            12s |           419867 |               13s |             534MB |
    micronaut-producer-api-jvm |            14s |         26742899 |               12s |             152MB |
   springboot-producer-api-jvm |             6s |         35439214 |               13s |             231MB |
.............................. + .............. + ................ + ................. + ................. |
      quarkus-consumer-api-jvm |            11s |           396316 |               12s |             534MB |
    micronaut-consumer-api-jvm |            10s |         26723265 |                8s |             152MB |
   springboot-consumer-api-jvm |             5s |         35436506 |               12s |             231MB |
.............................. + .............. + ................ + ................. + ................. |
     quarkus-elasticsearch-jvm |            10s |           336076 |               13s |             542MB |
   micronaut-elasticsearch-jvm |            18s |         42408964 |               10s |             239MB |
  springboot-elasticsearch-jvm |             8s |         54347679 |               16s |             248MB |
```

Table below shows the results after running the script `collect-native-jar-docker-size-times.sh`
```
                   Application | Packaging Time | Jar Size (bytes) | Docker Build Time | Docker Image Size |
------------------------------ + -------------- + ---------------- + ----------------- + ----------------- |
     quarkus-simple-api-native |           238s |         31280472 |                2s |             138MB |
   micronaut-simple-api-native |             9s |         15705443 |              372s |            95.6MB |
.............................. + .............. + ................ + ................. + ................. |
       quarkus-book-api-native |           568s |         75261352 |                6s |             182MB |
     micronaut-book-api-native |            16s |         34478524 |              889s |             152MB |
.............................. + .............. + ................ + ................. + ................. |
   quarkus-producer-api-native |           404s |         53223032 |                5s |             160MB |
 micronaut-producer-api-native |            12s |         26742894 |              375s |             114MB |
.............................. + .............. + ................ + ................. + ................. |
   quarkus-consumer-api-native |           344s |         47205336 |                4s |             154MB |
 micronaut-consumer-api-native |            12s |         26723260 |              370s |             114MB |
.............................. + .............. + ................ + ................. + ................. |
  quarkus-elasticsearch-native |           319s |         37936472 |                4s |             145MB |
micronaut-elasticsearch-native |            19s |         42408980 |              591s |             131MB |
```

Finally, the following table shows the results after running the script `collect-startup-ab-times.sh`
```
                   Application | Startup Time | Initial Memory Consumption | Ab Testing Time | Final Memory Consumption |
------------------------------ + ------------ + -------------------------- + --------------- + ------------------------ |
        quarkus-simple-api-jvm |       2209ms |                   101.8MiB |             20s |                 193.5MiB |
      micronaut-simple-api-jvm |       2790ms |                   119.8MiB |             27s |                   360MiB |
     springboot-simple-api-jvm |       5266ms |                   212.8MiB |             26s |                 404.5MiB |
     quarkus-simple-api-native |        101ms |                   4.543MiB |             19s |                 261.9MiB |
   micronaut-simple-api-native |        135ms |                   9.629MiB |             18s |                 328.7MiB |
.............................. +  ........... + .......................... + ............... + ........................ |
          quarkus-book-api-jvm |       4072ms |                   170.7MiB |             23s |                 284.9MiB |
        micronaut-book-api-jvm |       5856ms |                   254.6MiB |             25s |                 477.2MiB |
       springboot-book-api-jvm |       9437ms |                   340.5MiB |             29s |                 426.7MiB |
       quarkus-book-api-native |        158ms |                   6.941MiB |             17s |                 257.1MiB |
     micronaut-book-api-native |            - |                          - |               - |                        - |
.............................. +  ........... + .......................... + ............... + ........................ |
      quarkus-producer-api-jvm |       5470ms |                   176.3MiB |             28s |                 232.4MiB |
    micronaut-producer-api-jvm |       3188ms |                   167.4MiB |             35s |                 341.4MiB |
   springboot-producer-api-jvm |       7172ms |                   226.4MiB |             27s |                 388.5MiB |
   quarkus-producer-api-native |        221ms |                   6.297MiB |             20s |                 267.9MiB |
 micronaut-producer-api-native |        183ms |                   11.81MiB |             21s |                 268.1MiB |
.............................. +  ........... + .......................... + ............... + ........................ |
      quarkus-consumer-api-jvm |       2769ms |                   144.1MiB |             23s |                 246.9MiB |
    micronaut-consumer-api-jvm |       3443ms |                   218.9MiB |              2s |                 267.5MiB |
   springboot-consumer-api-jvm |       5691ms |                   252.7MiB |              3s |                 277.1MiB |
   quarkus-consumer-api-native |        140ms |                   21.24MiB |             12s |                 252.3MiB |
 micronaut-consumer-api-native |        205ms |                   17.12MiB |              1s |                 145.3MiB |
.............................. +  ........... + .......................... + ............... + ........................ |
     quarkus-elasticsearch-jvm |       1987ms |                    99.6MiB |             26s |                 206.8MiB |
   micronaut-elasticsearch-jvm |       2848ms |                   157.2MiB |             27s |                 413.8MiB |
  springboot-elasticsearch-jvm |       7606ms |                   260.3MiB |             26s |                 419.1MiB |
  quarkus-elasticsearch-native |            - |                          - |               - |                        - |
micronaut-elasticsearch-native |            - |                          - |               - |                        - |
```

> **Note 1:** There is no results for `micronaut-book-api-native` due to a `MySQL` compatibility issue with `GraalVM`. For more details see [`micronaut-book-api` issues](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/book-api/micronaut-book-api#issues)

> **Note 2:** We can see that the performance of the `quarkus-consumer-api-jvm` and `quarkus-consumer-api-native` are really slow compared to other consumers. Checking the logs, it seems that the bottleneck is SmallRye Reactive Messaging. I have opened an issue related to it. For more information, see [Consumer reads 500 messages and stops a few seconds #290](https://github.com/smallrye/smallrye-reactive-messaging/issues/290)

> **Note 3:** There is no results for `quarkus-elasticsearch-native` because an exception is thrown when the application a request. For more details see [`quarkus-elasticsearch-native` issues](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/elasticsearch/quarkus-elasticsearch#issues)

> **Note 4:** There is no results for `micronaut-elasticsearch-native` because an exception is thrown when the application a request. For more details see [`micronaut-elasticsearch-native` issues](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/elasticsearch/micronaut-elasticsearch#issues)

`ab` tests used
```
                   Application | ab Test                                                                                     |
------------------------------ + ------------------------------------------------------------------------------------------- |
        quarkus-simple-api-jvm | ab -c 10 -n 7500 http://localhost:9080/api/greeting?name=Ivan                               |
      micronaut-simple-api-jvm | ab -c 10 -n 7500 http://localhost:9082/api/greeting?name=Ivan                               |
     springboot-simple-api-jvm | ab -c 10 -n 7500 http://localhost:9084/api/greeting?name=Ivan                               |
     quarkus-simple-api-native | ab -c 10 -n 7500 http://localhost:9081/api/greeting?name=Ivan                               |
   micronaut-simple-api-native | ab -c 10 -n 7500 http://localhost:9083/api/greeting?name=Ivan                               |
.............................. + ........................................................................................... |
          quarkus-book-api-jvm | ab -p test-books.json -T 'application/json' -c 5 -n 2500 http://localhost:9085/api/books    |
        micronaut-book-api-jvm | ab -p test-books.json -T 'application/json' -c 5 -n 2500 http://localhost:9087/api/books    |
       springboot-book-api-jvm | ab -p test-books.json -T 'application/json' -c 5 -n 2500 http://localhost:9089/api/books    |
       quarkus-book-api-native | ab -p test-books.json -T 'application/json' -c 5 -n 2500 http://localhost:9086/api/books    |
     micronaut-book-api-native | ab -p test-books.json -T 'application/json' -c 5 -n 2500 http://localhost:9088/api/books    |
.............................. + ........................................................................................... |
      quarkus-producer-api-jvm | ab -p test-news.json -T 'application/json' -c 5 -n 5000 http://localhost:9100/api/news      |
    micronaut-producer-api-jvm | ab -p test-news.json -T 'application/json' -c 5 -n 5000 http://localhost:9102/api/news      |
   springboot-producer-api-jvm | ab -p test-news.json -T 'application/json' -c 5 -n 5000 http://localhost:9104/api/news      |
   quarkus-producer-api-native | ab -p test-news.json -T 'application/json' -c 5 -n 5000 http://localhost:9101/api/news      |
 micronaut-producer-api-native | ab -p test-news.json -T 'application/json' -c 5 -n 5000 http://localhost:9103/api/news      |
.............................. + ........................................................................................... |
      quarkus-elasticsearch-jvm | ab -p test-movies.json -T 'application/json' -c 5 -n 2500 http://localhost:9105/api/movies |
    micronaut-elasticsearch-jvm | ab -p test-movies.json -T 'application/json' -c 5 -n 2500 http://localhost:9107/api/movies |
   springboot-elasticsearch-jvm | ab -p test-movies.json -T 'application/json' -c 5 -n 2500 http://localhost:9109/api/movies |
   quarkus-elasticsearch-native | ab -p test-movies.json -T 'application/json' -c 5 -n 2500 http://localhost:9106/api/movies |
 micronaut-elasticsearch-native | ab -p test-movies.json -T 'application/json' -c 5 -n 2500 http://localhost:9107/api/movies |
```
