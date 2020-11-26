# graalvm-quarkus-micronaut-springboot

The goal of this project is to compare some Java frameworks like: [`Quarkus`](https://quarkus.io/), [`Micronaut`](https://micronaut.io/) and [`Spring Boot`](https://docs.spring.io/spring-boot/docs/current/reference/htmlsingle/). For it, we will implement applications using those frameworks, build their JVM and Native Docker images and measure their start-up times, memory footprint, etc.

## Examples

- ### [simple-api](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/simple-api#graalvm-quarkus-micronaut-springboot)
- ### [book-api](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/book-api#graalvm-quarkus-micronaut-springboot)
- ### [producer-consumer](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/producer-consumer#graalvm-quarkus-micronaut-springboot)
- ### [elasticsearch](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/elasticsearch#graalvm-quarkus-micronaut-springboot)

## Framework version

We are using the following Framework versions

| Framework   | Version     |
| ----------- | ----------- |
| Quarkus     | 1.9.2.Final |
| Micronaut   | 2.2.0       |
| Spring Boot | 2.4.0       |

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

  It starts docker container of all applications (JVM and Native), collecting data like: startup time, initial memory usage, time spent to run some ab tests for the first time and (after some warm up) for the second time, final memory usage and shutdown time.

## Comparison

The following table shows the results after running the script `collect-jvm-jar-docker-size-times.sh`
```
                   Application | Packaging Time | Jar Size (bytes) | Docker Build Time | Docker Image Size |
------------------------------ + -------------- + ---------------- + ----------------- + ----------------- |
        quarkus-simple-api-jvm |             6s |           391844 |                5s |             536MB |
      micronaut-simple-api-jvm |             4s |         15171039 |               19s |             358MB |
     springboot-simple-api-jvm |             3s |         21673215 |               10s |             219MB |
.............................. + .............. + ................ + ................. + ................. |
          quarkus-book-api-jvm |             8s |           586381 |                2s |             555MB |
        micronaut-book-api-jvm |             9s |         34500750 |               13s |             378MB |
       springboot-book-api-jvm |             5s |         42534751 |                9s |             240MB |
.............................. + .............. + ................ + ................. + ................. |
      quarkus-producer-api-jvm |             7s |           539380 |                2s |             555MB |
    micronaut-producer-api-jvm |             7s |         26122069 |               16s |             369MB |
   springboot-producer-api-jvm |             4s |         36900716 |                7s |             234MB |
.............................. + .............. + ................ + ................. + ................. |
      quarkus-consumer-api-jvm |             7s |           516552 |                2s |             555MB |
    micronaut-consumer-api-jvm |             7s |         26104015 |               11s |             369MB |
   springboot-consumer-api-jvm |             3s |         36898004 |                7s |             234MB |
.............................. + .............. + ................ + ................. + ................. |
     quarkus-elasticsearch-jvm |             8s |           440567 |                2s |             563MB |
   micronaut-elasticsearch-jvm |             9s |         44829923 |               16s |             388MB |
  springboot-elasticsearch-jvm |             5s |         54639346 |               10s |             252MB |
```

Table below shows the results after running the script `collect-native-jar-docker-size-times.sh`
```
                   Application | Packaging Time | Jar Size (bytes) | Docker Build Time | Docker Image Size |
------------------------------ + -------------- + ---------------- + ----------------- + ----------------- |
     quarkus-simple-api-native |           519s |         35930480 |                3s |             143MB |
   micronaut-simple-api-native |             6s |         15171039 |              264s |            87.4MB |
  springboot-simple-api-native |             3s |         21673215 |              671s |            89.2MB |
.............................. + .............. + ................ + ................. + ................. |
       quarkus-book-api-native |           302s |         75766104 |                4s |             183MB |
     micronaut-book-api-native |             9s |         34500761 |              396s |             123MB |
    springboot-book-api-native |             5s |         42534751 |              961s |             166MB |
.............................. + .............. + ................ + ................. + ................. |
   quarkus-producer-api-native |           266s |         60941480 |                3s |             168MB |
 micronaut-producer-api-native |             7s |         26122073 |              293s |            97.9MB |
.............................. + .............. + ................ + ................. + ................. |
   quarkus-consumer-api-native |           227s |         48563080 |                2s |             155MB |
 micronaut-consumer-api-native |             7s |         26104020 |              290s |            97.8MB |
.............................. + .............. + ................ + ................. + ................. |
  quarkus-elasticsearch-native |           262s |         55789448 |                2s |             163MB |
micronaut-elasticsearch-native |              - |                - |                 - |                 - |
```

Finally, the following table shows the results after running the script `collect-ab-times-memory-usage.sh`
```
                    Application | Startup Time |     Initial Memory Usage | Ab Testing Time | Ab Testing Time 2 |       Final Memory Usage | Shutdown Time |
 ------------------------------ + ------------ + ------------------------ + --------------- + ----------------- + ------------------------ + ------------- |
         quarkus-simple-api-jvm |       2281ms |  61.39MiB/256MiB(23.98%) |              9s |                7s |  120.9MiB/256MiB(47.23%) |            1s |
       micronaut-simple-api-jvm |       5143ms |    107MiB/256MiB(41.80%) |             11s |                5s |  248.5MiB/256MiB(97.08%) |            1s |
      springboot-simple-api-jvm |       3920ms |  104.5MiB/256MiB(40.83%) |              9s |                5s |  174.2MiB/256MiB(68.03%) |            3s |
      quarkus-simple-api-native |         26ms |   4.793MiB/256MiB(1.87%) |              5s |                5s |  31.34MiB/256MiB(12.24%) |            0s |
    micronaut-simple-api-native |         34ms |   9.309MiB/256MiB(3.64%) |              4s |                5s |    157MiB/256MiB(61.34%) |            1s |
   springboot-simple-api-native |        162ms |  32.69MiB/256MiB(12.77%) |              4s |                4s |  100.3MiB/256MiB(39.19%) |            2s |
 .............................. + ............ + ........................ + ............... + ................. + ........................ +  ............ |
           quarkus-book-api-jvm |       4004ms |  112.8MiB/256MiB(44.06%) |             11s |                7s |  156.6MiB/256MiB(61.16%) |            0s |
         micronaut-book-api-jvm |       7292ms |  172.8MiB/256MiB(67.49%) |             13s |                7s |  234.4MiB/256MiB(91.57%) |            1s |
        springboot-book-api-jvm |       5672ms |  166.9MiB/256MiB(65.21%) |             12s |               10s |  238.9MiB/256MiB(93.32%) |            3s |
        quarkus-book-api-native |         44ms |   7.234MiB/256MiB(2.83%) |              7s |                8s |  42.99MiB/256MiB(16.79%) |            0s |
      micronaut-book-api-native |         90ms |   20.36MiB/256MiB(7.95%) |              6s |                7s |  161.6MiB/256MiB(63.11%) |            1s |
     springboot-book-api-native |        292ms |  45.59MiB/256MiB(17.81%) |              8s |                7s |  115.3MiB/256MiB(45.02%) |            3s |
 .............................. + ............ + ........................ + ............... + ................. + ........................ +  ............ |
       quarkus-producer-api-jvm |       3083ms |  96.12MiB/256MiB(37.55%) |             14s |               11s |  162.7MiB/256MiB(63.55%) |            1s |
     micronaut-producer-api-jvm |       5115ms |   98.1MiB/256MiB(38.32%) |             16s |               12s |  221.9MiB/256MiB(86.68%) |            1s |
    springboot-producer-api-jvm |       4988ms |  158.5MiB/256MiB(61.90%) |             14s |               11s |  204.9MiB/256MiB(80.05%) |            3s |
    quarkus-producer-api-native |         47ms |   7.137MiB/256MiB(2.79%) |             10s |               11s |  46.83MiB/256MiB(18.29%) |            1s |
  micronaut-producer-api-native |       3061ms |   9.898MiB/256MiB(3.87%) |             10s |               10s |  159.2MiB/256MiB(62.19%) |            1s |
 .............................. + ............ + ........................ + ............... + ................. + ........................ +  ............ |
       quarkus-consumer-api-jvm |       2948ms |  86.61MiB/256MiB(33.83%) |                                 10s |    129MiB/256MiB(50.38%) |            1s |
     micronaut-consumer-api-jvm |       2866ms |  146.3MiB/256MiB(57.15%) |                                  6s |  168.8MiB/256MiB(65.93%) |            0s |
    springboot-consumer-api-jvm |       4555ms |    152MiB/256MiB(59.37%) |                                  5s |  164.8MiB/256MiB(64.36%) |            2s |
    quarkus-consumer-api-native |         53ms |    8.16MiB/256MiB(3.19%) |                                  6s |  39.96MiB/256MiB(15.61%) |            0s |
  micronaut-consumer-api-native |         67ms |   13.52MiB/256MiB(5.28%) |                                  7s |  31.64MiB/256MiB(12.36%) |            1s |
 .............................. + ............ + ........................ + ............... + ................. + ........................ +  ............ |
      quarkus-elasticsearch-jvm |       2533ms |   98.8MiB/256MiB(38.59%) |             14s |                8s |  146.2MiB/256MiB(57.12%) |            0s |
    micronaut-elasticsearch-jvm |       5095ms |  94.06MiB/256MiB(36.74%) |             14s |               10s |  213.3MiB/256MiB(83.32%) |            1s |
   springboot-elasticsearch-jvm |       5666ms |  187.5MiB/256MiB(73.25%) |             12s |                9s |    222MiB/256MiB(86.71%) |            3s |
   quarkus-elasticsearch-native |         28ms |   5.047MiB/256MiB(1.97%) |              9s |                9s |  44.61MiB/256MiB(17.43%) |            0s |
 micronaut-elasticsearch-native |            - |                        - |               - |                 - |                        - |             - |
```

Comments:

- Unable to build `micronaut-elasticsearch-native` using the Micronaut version `2.2.0`, that is why there is no results for it.

- Checking the Final Memory Usage column, `Quarkus` native apps have better memory utilization (after load tests) than `Micronaut` and `Spring Boot` ones; In this experiment, I set **256MiB** the container limit memory. If I reduce the container limit memmory to **128MiB**, all `Micronaut` native apps will have memory issues. For `Quarkus` native apps, I was able to reduce the container limit memmory to even **64MiB**. Below it, the apps performance will degrade.

- Comparing `Ab Testing Time` with `Ab Testing Time 2` columns, we can see that JVM was able to perform some runtime optimizations, making the JVM applications to perform faster on the second ab test run.

- `ab` tests used
  ```
                      Application | ab Test                                                                                      |
  ------------------------------- + -------------------------------------------------------------------------------------------- |
           quarkus-simple-api-jvm | ab -c 10 -n 3000 http://localhost:9080/api/greeting?name=Ivan                                |
         micronaut-simple-api-jvm | ab -c 10 -n 3000 http://localhost:9082/api/greeting?name=Ivan                                |
        springboot-simple-api-jvm | ab -c 10 -n 3000 http://localhost:9084/api/greeting?name=Ivan                                |
        quarkus-simple-api-native | ab -c 10 -n 3000 http://localhost:9081/api/greeting?name=Ivan                                |
      micronaut-simple-api-native | ab -c 10 -n 3000 http://localhost:9083/api/greeting?name=Ivan                                |
     springboot-simple-api-native | ab -c 10 -n 3000 http://localhost:9085/api/greeting?name=Ivan                                |
  ............................... + ............................................................................................ |
             quarkus-book-api-jvm | ab -p test-books.json -T 'application/json' -c 10 -n 2000 http://localhost:9086/api/books    |
           micronaut-book-api-jvm | ab -p test-books.json -T 'application/json' -c 10 -n 2000 http://localhost:9088/api/books    |
          springboot-book-api-jvm | ab -p test-books.json -T 'application/json' -c 10 -n 2000 http://localhost:9090/api/books    |
          quarkus-book-api-native | ab -p test-books.json -T 'application/json' -c 10 -n 2000 http://localhost:9087/api/books    |
        micronaut-book-api-native | ab -p test-books.json -T 'application/json' -c 10 -n 2000 http://localhost:9089/api/books    |
       springboot-book-api-native | ab -p test-books.json -T 'application/json' -c 10 -n 2000 http://localhost:9091/api/books    |       
  ............................... + ............................................................................................ |
         quarkus-producer-api-jvm | ab -p test-news.json -T 'application/json' -c 10 -n 4000 http://localhost:9100/api/news      |
       micronaut-producer-api-jvm | ab -p test-news.json -T 'application/json' -c 10 -n 4000 http://localhost:9102/api/news      |
      springboot-producer-api-jvm | ab -p test-news.json -T 'application/json' -c 10 -n 4000 http://localhost:9104/api/news      |
      quarkus-producer-api-native | ab -p test-news.json -T 'application/json' -c 10 -n 4000 http://localhost:9101/api/news      |
    micronaut-producer-api-native | ab -p test-news.json -T 'application/json' -c 10 -n 4000 http://localhost:9103/api/news      |
   springboot-producer-api-native | ab -p test-news.json -T 'application/json' -c 10 -n 4000 http://localhost:9105/api/news      |
  ............................... + ............................................................................................ |
        quarkus-elasticsearch-jvm | ab -p test-movies.json -T 'application/json' -c 10 -n 2000 http://localhost:9112/api/movies  |
      micronaut-elasticsearch-jvm | ab -p test-movies.json -T 'application/json' -c 10 -n 2000 http://localhost:9114/api/movies  |
     springboot-elasticsearch-jvm | ab -p test-movies.json -T 'application/json' -c 10 -n 2000 http://localhost:9116/api/movies  |
     quarkus-elasticsearch-native | ab -p test-movies.json -T 'application/json' -c 10 -n 2000 http://localhost:9113/api/movies  |
   micronaut-elasticsearch-native | ab -p test-movies.json -T 'application/json' -c 10 -n 2000 http://localhost:9115/api/movies  |
  springboot-elasticsearch-native | ab -p test-movies.json -T 'application/json' -c 10 -n 2000 http://localhost:9117/api/movies  |
  ```
