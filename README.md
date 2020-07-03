# graalvm-quarkus-micronaut-springboot

The goal of this project is to compare some Java frameworks like: [`Quarkus`](https://quarkus.io/), [`Micronaut`](https://micronaut.io/) and [`Spring Boot`](https://docs.spring.io/spring-boot/docs/current/reference/htmlsingle/). For it, we will implement applications using those frameworks, measure their start-up times, memory footprint, etc.

Besides, as `Quarkus` and `Micronaut` support [`GraalVM`](https://www.graalvm.org/) out-of-the-box, we will use `GraalVM`’s `native-image` tool to build `Quarkus` and `Micronaut` native applications.

> **Note:** Spring team is working on supporting for `GraalVM` native images, https://github.com/spring-projects/spring-framework/wiki/GraalVM-native-image-support

## Examples

- ### [simple-api](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/simple-api#graalvm-quarkus-micronaut-springboot)
- ### [book-api](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/book-api#graalvm-quarkus-micronaut-springboot)
- ### [producer-consumer](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/producer-consumer#graalvm-quarkus-micronaut-springboot)
- ### [elasticsearch](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/elasticsearch#graalvm-quarkus-micronaut-springboot)

## Framework version

We are using the following Framework versions

| Framework   | Version       |
| ----------- | ------------- |
| Quarkus     | 1.5.2.Final   |
| Micronaut   | 2.0.0         |
| Spring Boot | 2.3.1.RELEASE |

## Prerequisites

- [`Java 11+`](https://www.oracle.com/java/technologies/javase-jdk11-downloads.html)
- [`Docker`](https://www.docker.com/)
- [`Docker-Compose`](https://docs.docker.com/compose/install/)

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
        quarkus-simple-api-jvm |            10s |           307124 |               14s |             512MB |
      micronaut-simple-api-jvm |            11s |         15961372 |               12s |             212MB |
     springboot-simple-api-jvm |             4s |         21953979 |               11s |             218MB |
.............................. + .............. + ................ + ................. + ................. |
          quarkus-book-api-jvm |            13s |           520577 |               14s |             534MB |
        micronaut-book-api-jvm |            18s |         35134293 |               12s |             232MB |
       springboot-book-api-jvm |             6s |         43213039 |               13s |             239MB |
.............................. + .............. + ................ + ................. + ................. |
      quarkus-producer-api-jvm |            11s |           419862 |               14s |             534MB |
    micronaut-producer-api-jvm |            13s |         27253515 |               10s |             223MB |
   springboot-producer-api-jvm |             7s |         35474718 |               12s |             231MB |
.............................. + .............. + ................ + ................. + ................. |
      quarkus-consumer-api-jvm |            11s |           396332 |               13s |             534MB |
    micronaut-consumer-api-jvm |            12s |         27233595 |               10s |             223MB |
   springboot-consumer-api-jvm |             5s |         35472009 |               12s |             231MB |
.............................. + .............. + ................ + ................. + ................. |
     quarkus-elasticsearch-jvm |            10s |           337517 |               96s |             542MB |
   micronaut-elasticsearch-jvm |            23s |         44921748 |               16s |             241MB |
  springboot-elasticsearch-jvm |             9s |         54381935 |               16s |             248MB |
```

Table below shows the results after running the script `collect-native-jar-docker-size-times.sh`
```
                   Application | Packaging Time | Jar Size (bytes) | Docker Build Time | Docker Image Size |
------------------------------ + -------------- + ---------------- + ----------------- + ----------------- |
     quarkus-simple-api-native |           267s |         32238760 |                6s |             139MB |
   micronaut-simple-api-native |            11s |         15961361 |              398s |              96MB |
.............................. + .............. + ................ + ................. + ................. |
       quarkus-book-api-native |           650s |         75265448 |                7s |             182MB |
     micronaut-book-api-native |            20s |         35134276 |              826s |             159MB |
.............................. + .............. + ................ + ................. + ................. |
   quarkus-producer-api-native |           402s |         53247608 |                6s |             160MB |
 micronaut-producer-api-native |            16s |         27253512 |              469s |             119MB |
.............................. + .............. + ................ + ................. + ................. |
   quarkus-consumer-api-native |           364s |         47229912 |                6s |             154MB |
 micronaut-consumer-api-native |            15s |         27233595 |              442s |             118MB |
.............................. + .............. + ................ + ................. + ................. |
  quarkus-elasticsearch-native |           325s |         39279960 |                5s |             146MB |
micronaut-elasticsearch-native |            22s |         44921747 |              630s |             144MB |
```

Finally, the following table shows the results after running the script `collect-startup-ab-times.sh`
```
                   Application | Startup Time | Initial Memory Consumption | Ab Testing Time | Final Memory Consumption |
------------------------------ + ------------ + -------------------------- + --------------- + ------------------------ |
        quarkus-simple-api-jvm |       2579ms |                   98.53MiB |             28s |                   260MiB |
      micronaut-simple-api-jvm |       3591ms |                   151.8MiB |             28s |                 410.5MiB |
     springboot-simple-api-jvm |       6854ms |                   246.4MiB |             28s |                   458MiB |
     quarkus-simple-api-native |         96ms |                   4.129MiB |             20s |                 260.8MiB |
   micronaut-simple-api-native |         87ms |                   9.812MiB |             19s |                 394.5MiB |
.............................. +  ........... + .......................... + ............... + ........................ |
          quarkus-book-api-jvm |       5610ms |                   226.6MiB |             31s |                 371.7MiB |
        micronaut-book-api-jvm |       8221ms |                   288.9MiB |             30s |                 586.2MiB |
       springboot-book-api-jvm |      12664ms |                   419.7MiB |             32s |                 594.4MiB |
       quarkus-book-api-native |         46ms |                    6.48MiB |             22s |                   262MiB |
     micronaut-book-api-native |            - |                          - |               - |                        - |
.............................. +  ........... + .......................... + ............... + ........................ |
      quarkus-producer-api-jvm |       4340ms |                   162.5MiB |             35s |                 274.4MiB |
    micronaut-producer-api-jvm |       4507ms |                   153.3MiB |             44s |                 512.8MiB |
   springboot-producer-api-jvm |       9393ms |                   271.8MiB |             36s |                   458MiB |
   quarkus-producer-api-native |         76ms |                   6.023MiB |             22s |                   265MiB |
 micronaut-producer-api-native |        162ms |                   12.88MiB |             28s |                 400.9MiB |
.............................. +  ........... + .......................... + ............... + ........................ |
      quarkus-consumer-api-jvm |       3381ms |                   123.7MiB |             30s |                 279.9MiB |
    micronaut-consumer-api-jvm |       5230ms |                   223.7MiB |              4s |                 248.6MiB |
   springboot-consumer-api-jvm |       8608ms |                   278.4MiB |              4s |                 313.8MiB |
   quarkus-consumer-api-native |        110ms |                   23.08MiB |             18s |                 252.1MiB |
 micronaut-consumer-api-native |        202ms |                   55.13MiB |              2s |                   130MiB |
.............................. +  ........... + .......................... + ............... + ........................ |
     quarkus-elasticsearch-jvm |       2414ms |                   113.5MiB |             33s |                   210MiB |
   micronaut-elasticsearch-jvm |       3759ms |                   176.5MiB |             33s |                 452.5MiB |
  springboot-elasticsearch-jvm |       9766ms |                   276.9MiB |             28s |                 441.9MiB |
  quarkus-elasticsearch-native |            - |                          - |               - |                        - |
micronaut-elasticsearch-native |        150ms |                   10.41MiB |             23s |                 396.1MiB |
```

> **Note 1:** There is no results for `micronaut-book-api-native` because of an exception during the application startup. For more details see [`micronaut-book-api` issues](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/book-api/micronaut-book-api#issues)

> **Note 2:** We can see that the performance of the `quarkus-consumer-api-jvm` and `quarkus-consumer-api-native` are really slow compared to other consumers. Checking the logs, it seems that the bottleneck is SmallRye Reactive Messaging. I have opened an issue related to it. For more information, see [Consumer reads 500 messages and stops a few seconds #290](https://github.com/smallrye/smallrye-reactive-messaging/issues/290)

> **Note 3:** There is no results for `quarkus-elasticsearch-native` because of an exception is thrown when the application receives a request. For more details see [`quarkus-elasticsearch-native` issues](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/elasticsearch/quarkus-elasticsearch#issues)

> **Note 4:** There is no results for `micronaut-elasticsearch-native` because of an exception is thrown when the application receives a request. For more details see [`micronaut-elasticsearch-native` issues](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/elasticsearch/micronaut-elasticsearch#issues)

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
