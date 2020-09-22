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
| Quarkus     | 1.8.1.Final   |
| Micronaut   | 2.0.2         |
| Spring Boot | 2.3.4.RELEASE |

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
| collect-ab-times-memory-usage.sh        | it starts docker container of all applications (JVM and Native), collecting data like: startup time, initial memory usage, time spent to run some ab tests, final memory usage and shutdown time |

## Comparison

The following table shows the results after running the script `collect-jvm-jar-docker-size-times.sh`
```
                   Application | Packaging Time | Jar Size (bytes) | Docker Build Time | Docker Image Size |
------------------------------ + -------------- + ---------------- + ----------------- + ----------------- |
        quarkus-simple-api-jvm |            11s |           351957 |              111s |             504MB |
      micronaut-simple-api-jvm |            10s |         15985240 |               13s |             214MB |
     springboot-simple-api-jvm |             6s |         22027863 |               11s |             219MB |
.............................. + .............. + ................ + ................. + ................. |
          quarkus-book-api-jvm |            17s |           587165 |               16s |             527MB |
        micronaut-book-api-jvm |            18s |         35036394 |               10s |             233MB |
       springboot-book-api-jvm |             6s |         43338567 |               11s |             241MB |
.............................. + .............. + ................ + ................. + ................. |
      quarkus-producer-api-jvm |            12s |           503625 |               19s |             527MB |
    micronaut-producer-api-jvm |            13s |         26495965 |               10s |             224MB |
   springboot-producer-api-jvm |             6s |         35567917 |               13s |             233MB |
.............................. + .............. + ................ + ................. + ................. |
      quarkus-consumer-api-jvm |            13s |           480058 |               12s |             526MB |
    micronaut-consumer-api-jvm |            11s |         26476039 |               10s |             224MB |
   springboot-consumer-api-jvm |             6s |         35565210 |               12s |             233MB |
.............................. + .............. + ................ + ................. + ................. |
     quarkus-elasticsearch-jvm |            12s |           383345 |               14s |             534MB |
   micronaut-elasticsearch-jvm |            19s |         44941803 |               12s |             243MB |
  springboot-elasticsearch-jvm |             8s |         54455808 |               15s |             250MB |
```

Table below shows the results after running the script `collect-native-jar-docker-size-times.sh`
```
                   Application | Packaging Time | Jar Size (bytes) | Docker Build Time | Docker Image Size |
------------------------------ + -------------- + ---------------- + ----------------- + ----------------- |
     quarkus-simple-api-native |           328s |         33099968 |                5s |             140MB |
   micronaut-simple-api-native |            12s |         15985237 |              295s |             104MB |
.............................. + .............. + ................ + ................. + ................. |
       quarkus-book-api-native |           331s |         75467096 |               10s |             182MB |
     micronaut-book-api-native |            19s |         35036381 |              419s |             159MB |
.............................. + .............. + ................ + ................. + ................. |
   quarkus-producer-api-native |           289s |         60114088 |                8s |             167MB |
 micronaut-producer-api-native |            14s |         26495948 |              311s |             124MB |
.............................. + .............. + ................ + ................. + ................. |
   quarkus-consumer-api-native |           243s |         47850376 |                7s |             155MB |
 micronaut-consumer-api-native |            13s |         26476045 |              300s |             123MB |
.............................. + .............. + ................ + ................. + ................. |
  quarkus-elasticsearch-native |           231s |         39883192 |                7s |             147MB |
micronaut-elasticsearch-native |            23s |         44941800 |              367s |             148MB |
```

Finally, the following table shows the results after running the script `collect-ab-times-memory-usage.sh`
```
                   Application | Startup Time |     Initial Memory Usage | Ab Testing Time |       Final Memory Usage | Shutdown Time |
------------------------------ + ------------ + ------------------------ + --------------- + ------------------------ + ------------- |
        quarkus-simple-api-jvm |       2825ms |  62.79MiB/256MiB(24.53%) |             12s |  88.83MiB/256MiB(34.70%) |            1s |
      micronaut-simple-api-jvm |       6254ms |  110.2MiB/256MiB(43.06%) |             14s |    137MiB/256MiB(53.53%) |            1s |
     springboot-simple-api-jvm |       6542ms |    118MiB/256MiB(46.10%) |             14s |  159.4MiB/256MiB(62.26%) |            3s |
     quarkus-simple-api-native |         36ms |   4.371MiB/256MiB(1.71%) |              7s |  30.73MiB/256MiB(12.00%) |            1s |
   micronaut-simple-api-native |         71ms |   8.316MiB/256MiB(3.25%) |              8s |  156.8MiB/256MiB(61.25%) |           11s |
.............................. + ............ + ........................ + ............... + ........................ +  ............ |
          quarkus-book-api-jvm |       4582ms |  114.1MiB/256MiB(44.58%) |             20s |  178.7MiB/256MiB(69.79%) |            1s |
        micronaut-book-api-jvm |       7733ms |  153.1MiB/256MiB(59.81%) |             20s |    212MiB/256MiB(82.81%) |            0s |
       springboot-book-api-jvm |       9354ms |  195.5MiB/256MiB(76.35%) |             23s |  255.8MiB/256MiB(99.94%) |            2s |
       quarkus-book-api-native |         96ms |   7.078MiB/256MiB(2.76%) |             15s |   44.2MiB/256MiB(17.26%) |            1s |
     micronaut-book-api-native |            - |                        - |               - |                        - |             - |
.............................. + ............ + ........................ + ............... + ........................ +  ............ |
      quarkus-producer-api-jvm |       2705ms |  96.34MiB/256MiB(37.63%) |             20s |    141MiB/256MiB(55.08%) |            1s |
    micronaut-producer-api-jvm |       7151ms |  86.11MiB/256MiB(33.64%) |             29s |    168MiB/256MiB(65.63%) |            1s |
   springboot-producer-api-jvm |       8601ms |  147.8MiB/256MiB(57.74%) |             31s |  199.7MiB/256MiB(78.02%) |            3s |
   quarkus-producer-api-native |         99ms |   6.711MiB/256MiB(2.62%) |             15s |  45.41MiB/256MiB(17.74%) |            0s |
 micronaut-producer-api-native |         79ms |   8.949MiB/256MiB(3.50%) |             16s |  158.9MiB/256MiB(62.08%) |           11s |
.............................. + ............ + ........................ + ............... + ........................ +  ............ |
      quarkus-consumer-api-jvm |       2546ms |  100.1MiB/256MiB(39.10%) |              6s |  112.6MiB/256MiB(43.98%) |            1s |
    micronaut-consumer-api-jvm |       3090ms |  112.9MiB/256MiB(44.08%) |              2s |  119.6MiB/256MiB(46.72%) |            1s |
   springboot-consumer-api-jvm |      11361ms |  154.2MiB/256MiB(60.22%) |              2s |  159.2MiB/256MiB(62.20%) |            3s |
   quarkus-consumer-api-native |         51ms |   7.418MiB/256MiB(2.90%) |              4s |  28.92MiB/256MiB(11.30%) |            1s |
 micronaut-consumer-api-native |         66ms |  27.31MiB/256MiB(10.67%) |              1s |   27.3MiB/256MiB(10.66%) |           11s |
.............................. + ............ + ........................ + ............... + ........................ +  ............ |
     quarkus-elasticsearch-jvm |       2188ms |  70.97MiB/256MiB(27.72%) |             25s |  136.9MiB/256MiB(53.47%) |            1s |
   micronaut-elasticsearch-jvm |       5553ms |  87.63MiB/256MiB(34.23%) |             24s |  171.2MiB/256MiB(66.87%) |            1s |
  springboot-elasticsearch-jvm |       8310ms |  155.3MiB/256MiB(60.66%) |             22s |  200.3MiB/256MiB(78.23%) |            3s |
  quarkus-elasticsearch-native |            - |                        - |               - |                        - |               |
micronaut-elasticsearch-native |         51ms |   8.625MiB/256MiB(3.37%) |             20s |  160.5MiB/256MiB(62.69%) |           11s |
```

Comments:

- The shutdown of `Micronaut` native apps are taking around **10 seconds**;

- Seeing the Final Memory Usage column, `Quarkus` native apps have better memory utilization (after load tests) than `Micronaut` ones; In this experiment, I set **256MiB** the container limit memory. If I reduce the container limit memmory to **128MiB**, all `Micronaut` native apps will have memory issues. For `Quarkus` native apps, I was able to reduce the container limit memmory to even **64MiB**. Below it, the apps performance will degrade.

- There is no results for `micronaut-book-api-native` because of an exception during the application startup. For more details see [`micronaut-book-api` issues](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/book-api/micronaut-book-api#issues);

- There is no results for `quarkus-elasticsearch-native` because of an exception is thrown when the application receives a request. For more details see [`quarkus-elasticsearch-native` issues](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/elasticsearch/quarkus-elasticsearch#issues);

- `ab` tests used
  ```
                     Application | ab Test                                                                                      |
  ------------------------------ + -------------------------------------------------------------------------------------------- |
          quarkus-simple-api-jvm | ab -c 10 -n 3000 http://localhost:9080/api/greeting?name=Ivan                                |
        micronaut-simple-api-jvm | ab -c 10 -n 3000 http://localhost:9082/api/greeting?name=Ivan                                |
       springboot-simple-api-jvm | ab -c 10 -n 3000 http://localhost:9084/api/greeting?name=Ivan                                |
       quarkus-simple-api-native | ab -c 10 -n 3000 http://localhost:9081/api/greeting?name=Ivan                                |
     micronaut-simple-api-native | ab -c 10 -n 3000 http://localhost:9083/api/greeting?name=Ivan                                |
  .............................. + ............................................................................................ |
            quarkus-book-api-jvm | ab -p test-books.json -T 'application/json' -c 10 -n 2000 http://localhost:9085/api/books    |
          micronaut-book-api-jvm | ab -p test-books.json -T 'application/json' -c 10 -n 2000 http://localhost:9087/api/books    |
         springboot-book-api-jvm | ab -p test-books.json -T 'application/json' -c 10 -n 2000 http://localhost:9089/api/books    |
         quarkus-book-api-native | ab -p test-books.json -T 'application/json' -c 10 -n 2000 http://localhost:9086/api/books    |
       micronaut-book-api-native | ab -p test-books.json -T 'application/json' -c 10 -n 2000 http://localhost:9088/api/books    |
  .............................. + ............................................................................................ |
        quarkus-producer-api-jvm | ab -p test-news.json -T 'application/json' -c 10 -n 4000 http://localhost:9100/api/news      |
      micronaut-producer-api-jvm | ab -p test-news.json -T 'application/json' -c 10 -n 4000 http://localhost:9102/api/news      |
     springboot-producer-api-jvm | ab -p test-news.json -T 'application/json' -c 10 -n 4000 http://localhost:9104/api/news      |
     quarkus-producer-api-native | ab -p test-news.json -T 'application/json' -c 10 -n 4000 http://localhost:9101/api/news      |
   micronaut-producer-api-native | ab -p test-news.json -T 'application/json' -c 10 -n 4000 http://localhost:9103/api/news      |
  .............................. + ............................................................................................ |
        quarkus-elasticsearch-jvm | ab -p test-movies.json -T 'application/json' -c 10 -n 2000 http://localhost:9105/api/movies |
      micronaut-elasticsearch-jvm | ab -p test-movies.json -T 'application/json' -c 10 -n 2000 http://localhost:9107/api/movies |
     springboot-elasticsearch-jvm | ab -p test-movies.json -T 'application/json' -c 10 -n 2000 http://localhost:9109/api/movies |
     quarkus-elasticsearch-native | ab -p test-movies.json -T 'application/json' -c 10 -n 2000 http://localhost:9106/api/movies |
   micronaut-elasticsearch-native | ab -p test-movies.json -T 'application/json' -c 10 -n 2000 http://localhost:9107/api/movies |
  ```
