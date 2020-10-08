# graalvm-quarkus-micronaut-springboot

The goal of this project is to compare some Java frameworks like: [`Quarkus`](https://quarkus.io/), [`Micronaut`](https://micronaut.io/) and [`Spring Boot`](https://docs.spring.io/spring-boot/docs/current/reference/htmlsingle/). For it, we will implement applications using those frameworks, build their JVM and Native Docker images and measure their start-up times, memory footprint, etc.

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
| Micronaut   | 2.0.3         |
| Spring Boot | 2.3.4.RELEASE (`simple-api` is using 2.4.0-M3) |

## Prerequisites

- [`Java 11+`](https://www.oracle.com/java/technologies/javase-jdk11-downloads.html)
- [`Docker`](https://www.docker.com/)
- [`Docker-Compose`](https://docs.docker.com/compose/install/)

## Bash scripts

In order to make it easier to collect data that will be used for comparing the frameworks, we've implemented some bash scripts.

- **collect-jvm-jar-docker-size-times.sh**
  
  It packages/assembles jar files and builds docker images of all JVM applications, collecting data like: jar packaging Time, size of the jar, docker build time and docker image size.

- **collect-native-jar-docker-size-times.sh**

  It packages/assembles jar files and builds docker images of all Native applications, collecting data like: jar packaging Time, size of the jar, docker build time and docker image size.
  
  > Note: On Mac and Windows, it's recommended to increase the memory allocated to Docker to at least 8G (and potentially to add more CPUs as well) since native-image compiler is a heavy process. On Linux, Docker uses by default the resources available on the host so no configuration is needed.

- **collect-ab-times-memory-usage.sh**

  It starts docker container of all applications (JVM and Native), collecting data like: startup time, initial memory usage, time spent to run some ab tests, final memory usage and shutdown time.

## Comparison

The following table shows the results after running the script `collect-jvm-jar-docker-size-times.sh`
```
                   Application | Packaging Time | Jar Size (bytes) | Docker Build Time | Docker Image Size |
------------------------------ + -------------- + ---------------- + ----------------- + ----------------- |
        quarkus-simple-api-jvm |            12s |           351978 |               76s |             504MB |
      micronaut-simple-api-jvm |            10s |         15985059 |               14s |             214MB |
     springboot-simple-api-jvm |             4s |         21487605 |               11s |             219MB |
.............................. + .............. + ................ + ................. + ................. |
          quarkus-book-api-jvm |            15s |           587137 |               18s |             527MB |
        micronaut-book-api-jvm |            18s |         34006173 |               13s |             232MB |
       springboot-book-api-jvm |             5s |         43338567 |               16s |             241MB |
.............................. + .............. + ................ + ................. + ................. |
      quarkus-producer-api-jvm |            13s |           503597 |               16s |             527MB |
    micronaut-producer-api-jvm |            12s |         26495716 |               11s |             224MB |
   springboot-producer-api-jvm |             6s |         35567917 |               20s |             233MB |
.............................. + .............. + ................ + ................. + ................. |
      quarkus-consumer-api-jvm |            13s |           480095 |               15s |             526MB |
    micronaut-consumer-api-jvm |            11s |         26475792 |               16s |             224MB |
   springboot-consumer-api-jvm |             7s |         35565210 |               15s |             233MB |
.............................. + .............. + ................ + ................. + ................. |
     quarkus-elasticsearch-jvm |            15s |           399137 |               18s |             537MB |
   micronaut-elasticsearch-jvm |            18s |         44941527 |               12s |             243MB |
  springboot-elasticsearch-jvm |             8s |         54455808 |               17s |             250MB |
```

Table below shows the results after running the script `collect-native-jar-docker-size-times.sh`
```
                   Application | Packaging Time | Jar Size (bytes) | Docker Build Time | Docker Image Size |
------------------------------ + -------------- + ---------------- + ----------------- + ----------------- |
     quarkus-simple-api-native |           249s |         31809728 |                6s |             139MB |
   micronaut-simple-api-native |             9s |         15985058 |              369s |             103MB |
  springboot-simple-api-native |             5s |         21487605 |              650s |            99.4MB |
.............................. + .............. + ................ + ................. + ................. |
       quarkus-book-api-native |           462s |         75467096 |               12s |             182MB |
     micronaut-book-api-native |            22s |         34006180 |              558s |             156MB |
    springboot-book-api-native |            14s |         44565842 |             1130s |             189MB |
.............................. + .............. + ................ + ................. + ................. |
   quarkus-producer-api-native |           433s |         60114088 |               11s |             167MB |
 micronaut-producer-api-native |            18s |         26495721 |              399s |             124MB |
.............................. + .............. + ................ + ................. + ................. |
   quarkus-consumer-api-native |           363s |         47850376 |               11s |             155MB |
 micronaut-consumer-api-native |            14s |         26475792 |              396s |             123MB |
.............................. + .............. + ................ + ................. + ................. |
  quarkus-elasticsearch-native |           361s |         53159816 |               10s |             160MB |
micronaut-elasticsearch-native |            25s |         44941550 |              474s |             148MB |
```

Finally, the following table shows the results after running the script `collect-ab-times-memory-usage.sh`
```
                    Application | Startup Time |     Initial Memory Usage | Ab Testing Time |       Final Memory Usage | Shutdown Time |
 ------------------------------ + ------------ + ------------------------ + --------------- + ------------------------ + ------------- |
         quarkus-simple-api-jvm |       2603ms |  55.11MiB/256MiB(21.53%) |             12s |  80.86MiB/256MiB(31.59%) |            1s |
       micronaut-simple-api-jvm |       4214ms |  81.85MiB/256MiB(31.97%) |             13s |  140.1MiB/256MiB(54.73%) |            1s |
      springboot-simple-api-jvm |       6513ms |  124.8MiB/256MiB(48.75%) |             12s |  159.7MiB/256MiB(62.40%) |            3s |
      quarkus-simple-api-native |         70ms |   4.375MiB/256MiB(1.71%) |              7s |  30.06MiB/256MiB(11.74%) |            1s |
    micronaut-simple-api-native |         82ms |   8.285MiB/256MiB(3.24%) |              6s |  156.8MiB/256MiB(61.24%) |           11s |
   springboot-simple-api-native |        248ms |  30.47MiB/256MiB(11.90%) |              6s |   98.7MiB/256MiB(38.55%) |            3s |
 .............................. + ............ + ........................ + ............... + ........................ +  ............ |
           quarkus-book-api-jvm |       5988ms |  116.6MiB/256MiB(45.54%) |             23s |  171.9MiB/256MiB(67.15%) |            1s |
         micronaut-book-api-jvm |       8359ms |  148.3MiB/256MiB(57.92%) |             21s |  204.9MiB/256MiB(80.04%) |            1s |
        springboot-book-api-jvm |      11286ms |  190.9MiB/256MiB(74.57%) |             23s |  243.1MiB/256MiB(94.97%) |            3s |
        quarkus-book-api-native |         65ms |   7.125MiB/256MiB(2.78%) |             15s |  44.64MiB/256MiB(17.44%) |            1s |
      micronaut-book-api-native |        199ms |  28.59MiB/256MiB(11.17%) |             13s |  165.9MiB/256MiB(64.79%) |           11s |
     springboot-book-api-native |        513ms |  42.68MiB/256MiB(16.67%) |             17s |  112.4MiB/256MiB(43.89%) |            3s |
 .............................. + ............ + ........................ + ............... + ........................ +  ............ |
       quarkus-producer-api-jvm |       5108ms |  109.9MiB/256MiB(42.91%) |             23s |  143.2MiB/256MiB(55.96%) |            1s |
     micronaut-producer-api-jvm |       4318ms |  103.4MiB/256MiB(40.41%) |             29s |    167MiB/256MiB(65.22%) |            1s |
    springboot-producer-api-jvm |       9361ms |  158.5MiB/256MiB(61.90%) |             23s |  198.8MiB/256MiB(77.66%) |            3s |
    quarkus-producer-api-native |        436ms |   7.062MiB/256MiB(2.76%) |             17s |  45.84MiB/256MiB(17.90%) |            1s |
  micronaut-producer-api-native |        298ms |   9.238MiB/256MiB(3.61%) |             19s |  159.5MiB/256MiB(62.31%) |           11s |
 .............................. + ............ + ........................ + ............... + ........................ +  ............ |
       quarkus-consumer-api-jvm |       4959ms |    114MiB/256MiB(44.53%) |              9s |  113.7MiB/256MiB(44.40%) |            1s |
     micronaut-consumer-api-jvm |       5509ms |  120.7MiB/256MiB(47.14%) |              3s |  134.5MiB/256MiB(52.54%) |            1s |
    springboot-consumer-api-jvm |       8031ms |  150.3MiB/256MiB(58.72%) |              2s |  162.3MiB/256MiB(63.40%) |            3s |
    quarkus-consumer-api-native |        276ms |    7.91MiB/256MiB(3.09%) |              3s |  29.43MiB/256MiB(11.49%) |            1s |
  micronaut-consumer-api-native |        508ms |   12.84MiB/256MiB(5.02%) |              3s |  27.71MiB/256MiB(10.83%) |           10s |
 .............................. + ............ + ........................ + ............... + ........................ +  ............ |
      quarkus-elasticsearch-jvm |       3790ms |  68.74MiB/256MiB(26.85%) |             25s |  139.4MiB/256MiB(54.47%) |            1s |
    micronaut-elasticsearch-jvm |       4016ms |  87.98MiB/256MiB(34.37%) |             25s |  164.7MiB/256MiB(64.34%) |            1s |
   springboot-elasticsearch-jvm |      10750ms |    162MiB/256MiB(63.28%) |             21s |  202.8MiB/256MiB(79.23%) |            3s |
   quarkus-elasticsearch-native |        175ms |   4.953MiB/256MiB(1.93%) |             16s |  44.52MiB/256MiB(17.39%) |            1s |
 micronaut-elasticsearch-native |        484ms |    9.02MiB/256MiB(3.52%) |             19s |  160.8MiB/256MiB(62.80%) |           11s |
```

Comments:

- The shutdown of `Micronaut` native apps are taking around **11 seconds**;

- Checking the Final Memory Usage column, `Quarkus` native apps have better memory utilization (after load tests) than `Micronaut` ones; In this experiment, I set **256MiB** the container limit memory. If I reduce the container limit memmory to **128MiB**, all `Micronaut` native apps will have memory issues. For `Quarkus` native apps, I was able to reduce the container limit memmory to even **64MiB**. Below it, the apps performance will degrade.

- `ab` tests used
  ```
                     Application | ab Test                                                                                      |
  ------------------------------ + -------------------------------------------------------------------------------------------- |
          quarkus-simple-api-jvm | ab -c 10 -n 3000 http://localhost:9080/api/greeting?name=Ivan                                |
        micronaut-simple-api-jvm | ab -c 10 -n 3000 http://localhost:9082/api/greeting?name=Ivan                                |
       springboot-simple-api-jvm | ab -c 10 -n 3000 http://localhost:9084/api/greeting?name=Ivan                                |
       quarkus-simple-api-native | ab -c 10 -n 3000 http://localhost:9081/api/greeting?name=Ivan                                |
     micronaut-simple-api-native | ab -c 10 -n 3000 http://localhost:9083/api/greeting?name=Ivan                                |
    springboot-simple-api-native | ab -c 10 -n 3000 http://localhost:9085/api/greeting?name=Ivan                                |
  .............................. + ............................................................................................ |
            quarkus-book-api-jvm | ab -p test-books.json -T 'application/json' -c 10 -n 2000 http://localhost:9085/api/books    |
          micronaut-book-api-jvm | ab -p test-books.json -T 'application/json' -c 10 -n 2000 http://localhost:9087/api/books    |
         springboot-book-api-jvm | ab -p test-books.json -T 'application/json' -c 10 -n 2000 http://localhost:9089/api/books    |
         quarkus-book-api-native | ab -p test-books.json -T 'application/json' -c 10 -n 2000 http://localhost:9086/api/books    |
       micronaut-book-api-native | ab -p test-books.json -T 'application/json' -c 10 -n 2000 http://localhost:9088/api/books    |
      springboot-book-api-native | ab -p test-books.json -T 'application/json' -c 10 -n 2000 http://localhost:9090/api/books    |       
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
