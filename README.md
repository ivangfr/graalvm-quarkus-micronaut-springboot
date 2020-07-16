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
| Quarkus     | 1.6.0.Final   |
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
| collect-ab-times-memory-usage.sh        | it starts docker container of all applications (JVM and Native), collecting data like: startup time, initial memory usage, time spent to run some ab tests, final memory usage and shutdown time |

## Comparison

The following table shows the results after running the script `collect-jvm-jar-docker-size-times.sh`
```
                   Application | Packaging Time | Jar Size (bytes) | Docker Build Time | Docker Image Size |
------------------------------ + -------------- + ---------------- + ----------------- + ----------------- |
        quarkus-simple-api-jvm |             9s |           307132 |                8s |             512MB |
      micronaut-simple-api-jvm |            13s |         15961374 |               11s |             212MB |
     springboot-simple-api-jvm |             5s |         21953979 |               12s |             218MB |
.............................. + .............. + ................ + ................. + ................. |
          quarkus-book-api-jvm |            12s |           520615 |               14s |             534MB |
        micronaut-book-api-jvm |            18s |         35134255 |               12s |             232MB |
       springboot-book-api-jvm |             6s |         43213039 |               13s |             239MB |
.............................. + .............. + ................ + ................. + ................. |
      quarkus-producer-api-jvm |            10s |           419862 |               13s |             534MB |
    micronaut-producer-api-jvm |            13s |         26471878 |               12s |             223MB |
   springboot-producer-api-jvm |             7s |         35474458 |               15s |             231MB |
.............................. + .............. + ................ + ................. + ................. |
      quarkus-consumer-api-jvm |            11s |           396318 |               11s |             534MB |
    micronaut-consumer-api-jvm |            12s |         26451969 |               10s |             222MB |
   springboot-consumer-api-jvm |             6s |         35471750 |               14s |             231MB |
.............................. + .............. + ................ + ................. + ................. |
     quarkus-elasticsearch-jvm |            11s |           337498 |               76s |             542MB |
   micronaut-elasticsearch-jvm |            20s |         44921754 |               13s |             241MB |
  springboot-elasticsearch-jvm |             8s |         54381935 |               19s |             248MB |
```

Table below shows the results after running the script `collect-native-jar-docker-size-times.sh`
```
                   Application | Packaging Time | Jar Size (bytes) | Docker Build Time | Docker Image Size |
------------------------------ + -------------- + ---------------- + ----------------- + ----------------- |
     quarkus-simple-api-native |           228s |         30862504 |                4s |             138MB |
   micronaut-simple-api-native |            15s |         15961365 |              295s |              96MB |
.............................. + .............. + ................ + ................. + ................. |
       quarkus-book-api-native |           519s |         75265448 |                6s |             182MB |
     micronaut-book-api-native |            21s |         35134296 |              605s |             159MB |
.............................. + .............. + ................ + ................. + ................. |
   quarkus-producer-api-native |           367s |         53243512 |                4s |             160MB |
 micronaut-producer-api-native |            15s |         26471897 |              325s |             116MB |
.............................. + .............. + ................ + ................. + ................. |
   quarkus-consumer-api-native |           290s |         47225816 |                5s |             154MB |
 micronaut-consumer-api-native |            13s |         26451971 |              325s |             116MB |
.............................. + .............. + ................ + ................. + ................. |
  quarkus-elasticsearch-native |           277s |         38870184 |                4s |             146MB |
micronaut-elasticsearch-native |            21s |         44921753 |              442s |             144MB |
```

Finally, the following table shows the results after running the script `collect-ab-times-memory-usage.sh`
```
                   Application | Startup Time |     Initial Memory Usage | Ab Testing Time |       Final Memory Usage | Shutdown Time |
------------------------------ + ------------ + ------------------------ + --------------- + ------------------------ + ------------- |
        quarkus-simple-api-jvm |       1934ms |  59.59MiB/256MiB(23.28%) |              4s |  80.29MiB/256MiB(31.36%) |            0s |
      micronaut-simple-api-jvm |       2765ms |  83.43MiB/256MiB(32.59%) |              5s |    142MiB/256MiB(55.45%) |            1s |
     springboot-simple-api-jvm |       5142ms |  128.9MiB/256MiB(50.34%) |              5s |  157.8MiB/256MiB(61.65%) |            2s |
     quarkus-simple-api-native |        161ms |    4.34MiB/256MiB(1.70%) |              2s |  27.12MiB/256MiB(10.59%) |            0s |
   micronaut-simple-api-native |        192ms |   9.812MiB/256MiB(3.83%) |              2s |  158.7MiB/256MiB(61.99%) |           10s |
.............................. + ............ + ........................ + ............... + ........................ +  ............ |
          quarkus-book-api-jvm |       3971ms |  110.6MiB/256MiB(43.22%) |              7s |  163.7MiB/256MiB(63.93%) |            0s |
        micronaut-book-api-jvm |       5958ms |  163.1MiB/256MiB(63.71%) |              6s |  213.7MiB/256MiB(83.47%) |            1s |
       springboot-book-api-jvm |       8882ms |  194.7MiB/256MiB(76.05%) |              6s |  225.8MiB/256MiB(88.20%) |            3s |
       quarkus-book-api-native |         90ms |   6.609MiB/256MiB(2.58%) |              3s |   38.8MiB/256MiB(15.16%) |            1s |
     micronaut-book-api-native |            - |                        - |               - |                        - |             - |
.............................. + ............ + ........................ + ............... + ........................ +  ............ |
      quarkus-producer-api-jvm |       3059ms |  82.76MiB/256MiB(32.33%) |             11s |  111.3MiB/256MiB(43.49%) |            0s |
    micronaut-producer-api-jvm |       2721ms |  93.19MiB/256MiB(36.40%) |             14s |  156.8MiB/256MiB(61.25%) |            1s |
   springboot-producer-api-jvm |       6057ms |  149.5MiB/256MiB(58.38%) |             12s |  186.1MiB/256MiB(72.71%) |            2s |
   quarkus-producer-api-native |         94ms |   6.086MiB/256MiB(2.38%) |              7s |  39.18MiB/256MiB(15.31%) |            1s |
 micronaut-producer-api-native |        148ms |   11.23MiB/256MiB(4.39%) |              8s |    161MiB/256MiB(62.88%) |           11s |
.............................. + ............ + ........................ + ............... + ........................ +  ............ |
      quarkus-consumer-api-jvm |       2804ms |  78.69MiB/256MiB(30.74%) |             11s |  135.6MiB/256MiB(52.97%) |            1s |
    micronaut-consumer-api-jvm |       3171ms |  112.5MiB/256MiB(43.96%) |              2s |  124.3MiB/256MiB(48.55%) |            0s |
   springboot-consumer-api-jvm |       5484ms |  160.8MiB/256MiB(62.81%) |              1s |  169.6MiB/256MiB(66.23%) |            3s |
   quarkus-consumer-api-native |         89ms |   6.352MiB/256MiB(2.48%) |              7s |  26.28MiB/256MiB(10.26%) |            0s |
 micronaut-consumer-api-native |        148ms |  28.79MiB/256MiB(11.24%) |              0s |  28.68MiB/256MiB(11.20%) |           10s |
.............................. + ............ + ........................ + ............... + ........................ +  ............ |
     quarkus-elasticsearch-jvm |       1662ms |  51.37MiB/256MiB(20.07%) |              7s |  87.21MiB/256MiB(34.07%) |            1s |
   micronaut-elasticsearch-jvm |       2502ms |  84.45MiB/256MiB(32.99%) |              8s |    165MiB/256MiB(64.47%) |            1s |
  springboot-elasticsearch-jvm |       6647ms |  163.7MiB/256MiB(63.94%) |              7s |  192.4MiB/256MiB(75.14%) |            2s |
  quarkus-elasticsearch-native |            - |                        - |               - |                        - |               |
micronaut-elasticsearch-native |        138ms |   10.26MiB/256MiB(4.01%) |              5s |  162.6MiB/256MiB(63.50%) |           11s |
```

Some comments:

- The performance of `quarkus-consumer-api-jvm` and `quarkus-consumer-api-native` are really slow compared to other consumers. Checking the logs, it seems that the bottleneck is **SmallRye Reactive Messaging**. I have opened an issue related to it. For more information, see [Consumer reads 500 messages and stops a few seconds #290](https://github.com/smallrye/smallrye-reactive-messaging/issues/290);

- The shutdown of `Micronaut` native apps are taking around **10.5 seconds**;

- Seeing the Final Memory Usage column, `Quarkus` native apps have better memory utilization (after load tests) than `Micronaut` ones; In this experiment, I set **256MiB** the container limit memory. If I reduce the container limit memmory to **128MiB**, all `Micronaut` native apps will have memory issues. For `Quarkus` native apps, I as able to reduce the container limit memmory to even **64MiB**. Below it, the apps performance will degrade.

- There is no results for `micronaut-book-api-native` because of an exception during the application startup. For more details see [`micronaut-book-api` issues](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/book-api/micronaut-book-api#issues);

- There is no results for `quarkus-elasticsearch-native` because of an exception is thrown when the application receives a request. For more details see [`quarkus-elasticsearch-native` issues](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/elasticsearch/quarkus-elasticsearch#issues);

- There is no results for `micronaut-elasticsearch-native` because of an exception is thrown when the application receives a request. For more details see [`micronaut-elasticsearch-native` issues](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/elasticsearch/micronaut-elasticsearch#issues);

- `ab` tests used
  ```
                     Application | ab Test                                                                                     |
  ------------------------------ + ------------------------------------------------------------------------------------------- |
          quarkus-simple-api-jvm | ab -c 10 -n 1000 http://localhost:9080/api/greeting?name=Ivan                               |
        micronaut-simple-api-jvm | ab -c 10 -n 1000 http://localhost:9082/api/greeting?name=Ivan                               |
       springboot-simple-api-jvm | ab -c 10 -n 1000 http://localhost:9084/api/greeting?name=Ivan                               |
       quarkus-simple-api-native | ab -c 10 -n 1000 http://localhost:9081/api/greeting?name=Ivan                               |
     micronaut-simple-api-native | ab -c 10 -n 1000 http://localhost:9083/api/greeting?name=Ivan                               |
  .............................. + ........................................................................................... |
            quarkus-book-api-jvm | ab -p test-books.json -T 'application/json' -c 10 -n 500 http://localhost:9085/api/books    |
          micronaut-book-api-jvm | ab -p test-books.json -T 'application/json' -c 10 -n 500 http://localhost:9087/api/books    |
         springboot-book-api-jvm | ab -p test-books.json -T 'application/json' -c 10 -n 500 http://localhost:9089/api/books    |
         quarkus-book-api-native | ab -p test-books.json -T 'application/json' -c 10 -n 500 http://localhost:9086/api/books    |
       micronaut-book-api-native | ab -p test-books.json -T 'application/json' -c 10 -n 500 http://localhost:9088/api/books    |
  .............................. + ........................................................................................... |
        quarkus-producer-api-jvm | ab -p test-news.json -T 'application/json' -c 10 -n 2000 http://localhost:9100/api/news     |
      micronaut-producer-api-jvm | ab -p test-news.json -T 'application/json' -c 10 -n 2000 http://localhost:9102/api/news     |
     springboot-producer-api-jvm | ab -p test-news.json -T 'application/json' -c 10 -n 2000 http://localhost:9104/api/news     |
     quarkus-producer-api-native | ab -p test-news.json -T 'application/json' -c 10 -n 2000 http://localhost:9101/api/news     |
   micronaut-producer-api-native | ab -p test-news.json -T 'application/json' -c 10 -n 2000 http://localhost:9103/api/news     |
  .............................. + ........................................................................................... |
        quarkus-elasticsearch-jvm | ab -p test-movies.json -T 'application/json' -c 10 -n 500 http://localhost:9105/api/movies |
      micronaut-elasticsearch-jvm | ab -p test-movies.json -T 'application/json' -c 10 -n 500 http://localhost:9107/api/movies |
     springboot-elasticsearch-jvm | ab -p test-movies.json -T 'application/json' -c 10 -n 500 http://localhost:9109/api/movies |
     quarkus-elasticsearch-native | ab -p test-movies.json -T 'application/json' -c 10 -n 500 http://localhost:9106/api/movies |
   micronaut-elasticsearch-native | ab -p test-movies.json -T 'application/json' -c 10 -n 500 http://localhost:9107/api/movies |
  ```
