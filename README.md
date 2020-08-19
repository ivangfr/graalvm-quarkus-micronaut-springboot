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
| Quarkus     | 1.7.0.Final   |
| Micronaut   | 2.0.1         |
| Spring Boot | 2.3.3.RELEASE |

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
        quarkus-simple-api-jvm |            10s |           341218 |                9s |             504MB |
      micronaut-simple-api-jvm |             9s |         15975313 |               13s |             214MB |
     springboot-simple-api-jvm |             5s |         21994322 |               11s |             219MB |
.............................. + .............. + ................ + ................. + ................. |
          quarkus-book-api-jvm |            16s |           551459 |               14s |             527MB |
        micronaut-book-api-jvm |            18s |         35016321 |               10s |             233MB |
       springboot-book-api-jvm |             5s |         43293043 |               12s |             241MB |
.............................. + .............. + ................ + ................. + ................. |
      quarkus-producer-api-jvm |            12s |           479138 |               14s |             527MB |
    micronaut-producer-api-jvm |            12s |         26485829 |               13s |             224MB |
   springboot-producer-api-jvm |             7s |         35530654 |               14s |             233MB |
.............................. + .............. + ................ + ................. + ................. |
      quarkus-consumer-api-jvm |            12s |           454319 |               13s |             526MB |
    micronaut-consumer-api-jvm |            11s |         26465907 |                9s |             224MB |
   springboot-consumer-api-jvm |             6s |         35527945 |               13s |             233MB |
.............................. + .............. + ................ + ................. + ................. |
     quarkus-elasticsearch-jvm |            12s |           371650 |               14s |             534MB |
   micronaut-elasticsearch-jvm |            20s |         44932043 |               11s |             243MB |
  springboot-elasticsearch-jvm |             8s |         54420286 |               14s |             250MB |
```

Table below shows the results after running the script `collect-native-jar-docker-size-times.sh`
```
                   Application | Packaging Time | Jar Size (bytes) | Docker Build Time | Docker Image Size |
------------------------------ + -------------- + ---------------- + ----------------- + ----------------- |
     quarkus-simple-api-native |           236s |         30607464 |                5s |             137MB |
   micronaut-simple-api-native |            15s |         15975314 |              308s |            96.1MB |
.............................. + .............. + ................ + ................. + ................. |
       quarkus-book-api-native |           399s |         73036000 |                7s |             180MB |
     micronaut-book-api-native |            23s |         35016279 |              597s |             159MB |
.............................. + .............. + ................ + ................. + ................. |
   quarkus-producer-api-native |           311s |         59298672 |                7s |             166MB |
 micronaut-producer-api-native |            14s |         26485829 |              327s |             116MB |
.............................. + .............. + ................ + ................. + ................. |
   quarkus-consumer-api-native |           263s |         46903896 |                7s |             154MB |
 micronaut-consumer-api-native |            17s |         26465910 |              330s |             116MB |
.............................. + .............. + ................ + ................. + ................. |
  quarkus-elasticsearch-native |           240s |         36997224 |                6s |             144MB |
micronaut-elasticsearch-native |            21s |         44932046 |              438s |             144MB |
```

Finally, the following table shows the results after running the script `collect-ab-times-memory-usage.sh`
```
                   Application | Startup Time |     Initial Memory Usage | Ab Testing Time |       Final Memory Usage | Shutdown Time |
------------------------------ + ------------ + ------------------------ + --------------- + ------------------------ + ------------- |
        quarkus-simple-api-jvm |       1904ms |  62.02MiB/256MiB(24.22%) |              5s |  80.86MiB/256MiB(31.59%) |            1s |
      micronaut-simple-api-jvm |       5275ms |   84.5MiB/256MiB(33.01%) |              6s |  140.4MiB/256MiB(54.84%) |            0s |
     springboot-simple-api-jvm |       4116ms |  125.1MiB/256MiB(48.88%) |              5s |  160.2MiB/256MiB(62.58%) |            3s |
     quarkus-simple-api-native |         70ms |   5.309MiB/256MiB(2.07%) |              2s |  31.75MiB/256MiB(12.40%) |            1s |
   micronaut-simple-api-native |         72ms |   8.805MiB/256MiB(3.44%) |              2s |  157.9MiB/256MiB(61.67%) |           10s |
.............................. + ............ + ........................ + ............... + ........................ +  ............ |
          quarkus-book-api-jvm |       3428ms |  109.8MiB/256MiB(42.88%) |              6s |  161.8MiB/256MiB(63.19%) |            0s |
        micronaut-book-api-jvm |       7941ms |    157MiB/256MiB(61.31%) |              6s |  204.4MiB/256MiB(79.86%) |            0s |
       springboot-book-api-jvm |       7142ms |  186.7MiB/256MiB(72.91%) |              6s |  225.3MiB/256MiB(87.99%) |            2s |
       quarkus-book-api-native |         61ms |   10.33MiB/256MiB(4.04%) |              3s |  43.28MiB/256MiB(16.91%) |            0s |
     micronaut-book-api-native |            - |                        - |               - |                        - |             - |
.............................. + ............ + ........................ + ............... + ........................ +  ............ |
      quarkus-producer-api-jvm |       2446ms |  90.35MiB/256MiB(35.29%) |             11s |    119MiB/256MiB(46.50%) |            1s |
    micronaut-producer-api-jvm |       5549ms |   88.2MiB/256MiB(34.45%) |             14s |  161.8MiB/256MiB(63.21%) |            1s |
   springboot-producer-api-jvm |       6413ms |  149.8MiB/256MiB(58.52%) |             16s |  188.7MiB/256MiB(73.72%) |            2s |
   quarkus-producer-api-native |         70ms |   8.754MiB/256MiB(3.42%) |              7s |  46.71MiB/256MiB(18.25%) |            0s |
 micronaut-producer-api-native |         83ms |   10.15MiB/256MiB(3.96%) |              7s |  161.5MiB/256MiB(63.07%) |           11s |
.............................. + ............ + ........................ + ............... + ........................ +  ............ |
      quarkus-consumer-api-jvm |       2343ms |  96.67MiB/256MiB(37.76%) |             13s |  113.1MiB/256MiB(44.20%) |            1s |
    micronaut-consumer-api-jvm |       3015ms |  114.4MiB/256MiB(44.70%) |              1s |  127.5MiB/256MiB(49.82%) |            0s |
   springboot-consumer-api-jvm |       4761ms |  156.6MiB/256MiB(61.17%) |              3s |  163.1MiB/256MiB(63.70%) |            3s |
   quarkus-consumer-api-native |         70ms |   9.148MiB/256MiB(3.57%) |              6s |  28.61MiB/256MiB(11.18%) |            1s |
 micronaut-consumer-api-native |        195ms |  27.81MiB/256MiB(10.86%) |              1s |   27.8MiB/256MiB(10.86%) |           10s |
.............................. + ............ + ........................ + ............... + ........................ +  ............ |
     quarkus-elasticsearch-jvm |       1624ms |  70.92MiB/256MiB(27.70%) |              7s |  125.6MiB/256MiB(49.05%) |            0s |
   micronaut-elasticsearch-jvm |       5126ms |  90.62MiB/256MiB(35.40%) |              8s |  163.4MiB/256MiB(63.82%) |            1s |
  springboot-elasticsearch-jvm |       5741ms |    163MiB/256MiB(63.68%) |              6s |  203.2MiB/256MiB(79.38%) |            2s |
  quarkus-elasticsearch-native |            - |                        - |               - |                        - |               |
micronaut-elasticsearch-native |         84ms |   9.273MiB/256MiB(3.62%) |              4s |  162.1MiB/256MiB(63.32%) |           10s |
```

Comments:

- The performance of `quarkus-consumer-api-jvm` and `quarkus-consumer-api-native` are really slow compared to other consumers. Checking the logs, it seems that the bottleneck is **SmallRye Reactive Messaging**. I have opened an issue related to it. For more information, see [Consumer reads 500 messages and stops a few seconds #290](https://github.com/smallrye/smallrye-reactive-messaging/issues/290);

- The shutdown of `Micronaut` native apps are taking around **10 seconds**;

- Seeing the Final Memory Usage column, `Quarkus` native apps have better memory utilization (after load tests) than `Micronaut` ones; In this experiment, I set **256MiB** the container limit memory. If I reduce the container limit memmory to **128MiB**, all `Micronaut` native apps will have memory issues. For `Quarkus` native apps, I was able to reduce the container limit memmory to even **64MiB**. Below it, the apps performance will degrade.

- There is no results for `micronaut-book-api-native` because of an exception during the application startup. For more details see [`micronaut-book-api` issues](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/book-api/micronaut-book-api#issues);

- There is no results for `quarkus-elasticsearch-native` because of an exception is thrown when the application receives a request. For more details see [`quarkus-elasticsearch-native` issues](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/elasticsearch/quarkus-elasticsearch#issues);

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
