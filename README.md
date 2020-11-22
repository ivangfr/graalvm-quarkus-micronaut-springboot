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
| Quarkus     | 1.9.2.Final   |
| Micronaut   | 2.2.0         |
| Spring Boot | 2.4.0 (`simple-api` and `book-api` are using 2.4.0-RC1) |

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
        quarkus-simple-api-jvm |             6s |           391846 |                2s |             536MB |
      micronaut-simple-api-jvm |             5s |         15171039 |               19s |             358MB |
     springboot-simple-api-jvm |             4s |         21622925 |               11s |             219MB |
.............................. + .............. + ................ + ................. + ................. |
          quarkus-book-api-jvm |             9s |           586332 |                2s |             555MB |
        micronaut-book-api-jvm |             9s |         34500752 |               13s |             378MB |
       springboot-book-api-jvm |             5s |         42468175 |                9s |             240MB |
.............................. + .............. + ................ + ................. + ................. |
      quarkus-producer-api-jvm |             7s |           539362 |                2s |             555MB |
    micronaut-producer-api-jvm |             6s |         26122063 |               16s |             369MB |
   springboot-producer-api-jvm |             3s |         36900762 |                8s |             234MB |
.............................. + .............. + ................ + ................. + ................. |
      quarkus-consumer-api-jvm |             7s |           516534 |                1s |             555MB |
    micronaut-consumer-api-jvm |             6s |         26104015 |               11s |             369MB |
   springboot-consumer-api-jvm |             3s |         36898051 |                7s |             234MB |
.............................. + .............. + ................ + ................. + ................. |
     quarkus-elasticsearch-jvm |             7s |           440620 |                2s |             563MB |
   micronaut-elasticsearch-jvm |            10s |         44830064 |               16s |             388MB |
  springboot-elasticsearch-jvm |             5s |         54639399 |                8s |             252MB |
```

Table below shows the results after running the script `collect-native-jar-docker-size-times.sh`
```
                   Application | Packaging Time | Jar Size (bytes) | Docker Build Time | Docker Image Size |
------------------------------ + -------------- + ---------------- + ----------------- + ----------------- |
     quarkus-simple-api-native |           191s |         35930480 |                4s |             143MB |
   micronaut-simple-api-native |             5s |         15171039 |              268s |            87.4MB |
  springboot-simple-api-native |             4s |         21622925 |              603s |            86.2MB |
.............................. + .............. + ................ + ................. + ................. |
       quarkus-book-api-native |           312s |         75770200 |                4s |             183MB |
     micronaut-book-api-native |             8s |         34500743 |              391s |             123MB |
    springboot-book-api-native |             5s |         42468175 |              994s |             164MB |
.............................. + .............. + ................ + ................. + ................. |
   quarkus-producer-api-native |           266s |         60941480 |                4s |             168MB |
 micronaut-producer-api-native |             7s |         26122073 |              283s |            97.9MB |
.............................. + .............. + ................ + ................. + ................. |
   quarkus-consumer-api-native |           221s |         48563080 |                3s |             155MB |
 micronaut-consumer-api-native |             7s |         26104020 |              283s |            97.8MB |
.............................. + .............. + ................ + ................. + ................. |
  quarkus-elasticsearch-native |           263s |         55785352 |                3s |             163MB |
micronaut-elasticsearch-native |              - |                - |                 - |                 - |
```

Finally, the following table shows the results after running the script `collect-ab-times-memory-usage.sh`
```
                    Application | Startup Time |     Initial Memory Usage | Ab Testing Time | Ab Testing Time 2 |       Final Memory Usage | Shutdown Time |
 ------------------------------ + ------------ + ------------------------ + --------------- + ----------------- + ------------------------ + ------------- |
         quarkus-simple-api-jvm |       2643ms |  70.04MiB/256MiB(27.36%) |              8s |                5s |  115.6MiB/256MiB(45.15%) |            1s |
       micronaut-simple-api-jvm |       5068ms |  90.12MiB/256MiB(35.21%) |             11s |                6s |  246.3MiB/256MiB(96.22%) |            1s |
      springboot-simple-api-jvm |       3962ms |  100.9MiB/256MiB(39.41%) |              9s |                5s |  168.3MiB/256MiB(65.74%) |            2s |
      quarkus-simple-api-native |        121ms |   5.188MiB/256MiB(2.03%) |              5s |                5s |  32.85MiB/256MiB(12.83%) |            1s |
    micronaut-simple-api-native |        147ms |   9.816MiB/256MiB(3.83%) |              5s |                5s |  157.5MiB/256MiB(61.52%) |            1s |
   springboot-simple-api-native |        298ms |   32.7MiB/256MiB(12.77%) |              4s |                4s |  100.3MiB/256MiB(39.19%) |            3s |
 .............................. + ............ + ........................ + ............... + ................. + ........................ +  ............ |
           quarkus-book-api-jvm |       4779ms |    114MiB/256MiB(44.52%) |             15s |                9s |  168.8MiB/256MiB(65.94%) |            0s |
         micronaut-book-api-jvm |       7627ms |  151.5MiB/256MiB(59.17%) |             17s |               11s |  222.6MiB/256MiB(86.94%) |            1s |
        springboot-book-api-jvm |       6203ms |  168.4MiB/256MiB(65.80%) |             16s |               13s |  232.9MiB/256MiB(90.96%) |            3s |
        quarkus-book-api-native |        204ms |   7.613MiB/256MiB(2.97%) |             10s |                9s |   43.9MiB/256MiB(17.15%) |            1s |
      micronaut-book-api-native |        422ms |   20.76MiB/256MiB(8.11%) |              8s |                9s |  160.9MiB/256MiB(62.87%) |            0s |
     springboot-book-api-native |        601ms |  44.59MiB/256MiB(17.42%) |             10s |               11s |  116.5MiB/256MiB(45.49%) |            3s |
 .............................. + ............ + ........................ + ............... + ................. + ........................ +  ............ |
       quarkus-producer-api-jvm |       3487ms |  105.6MiB/256MiB(41.26%) |             14s |               10s |  163.5MiB/256MiB(63.88%) |            1s |
     micronaut-producer-api-jvm |       5011ms |  98.23MiB/256MiB(38.37%) |             16s |               13s |  231.2MiB/256MiB(90.32%) |            0s |
    springboot-producer-api-jvm |       5045ms |  158.3MiB/256MiB(61.84%) |             14s |               12s |  219.1MiB/256MiB(85.58%) |            3s |
    quarkus-producer-api-native |         68ms |   7.102MiB/256MiB(2.77%) |             10s |               10s |  45.78MiB/256MiB(17.88%) |            1s |
  micronaut-producer-api-native |       3072ms |   9.914MiB/256MiB(3.87%) |             10s |               11s |  159.2MiB/256MiB(62.20%) |            0s |
 .............................. + ............ + ........................ + ............... + ................. + ........................ +  ............ |
       quarkus-consumer-api-jvm |       3914ms |   84.3MiB/256MiB(32.93%) |                                 10s |  127.9MiB/256MiB(49.94%) |            0s |
     micronaut-consumer-api-jvm |       3243ms |  141.3MiB/256MiB(55.21%) |                                  5s |  165.7MiB/256MiB(64.72%) |            1s |
    springboot-consumer-api-jvm |       5479ms |  165.5MiB/256MiB(64.65%) |                                  4s |  166.7MiB/256MiB(65.13%) |            3s |
    quarkus-consumer-api-native |         67ms |   8.078MiB/256MiB(3.16%) |                                  7s |  39.91MiB/256MiB(15.59%) |            0s |
  micronaut-consumer-api-native |         77ms |   13.39MiB/256MiB(5.23%) |                                  6s |  32.06MiB/256MiB(12.52%) |            1s |
 .............................. + ............ + ........................ + ............... + ................. + ........................ +  ............ |
      quarkus-elasticsearch-jvm |       3015ms |  83.32MiB/256MiB(32.55%) |             14s |                9s |  160.2MiB/256MiB(62.59%) |            0s |
    micronaut-elasticsearch-jvm |       5145ms |  115.4MiB/256MiB(45.07%) |             15s |               11s |  238.6MiB/256MiB(93.20%) |            1s |
   springboot-elasticsearch-jvm |       6093ms |  184.7MiB/256MiB(72.14%) |             12s |                9s |  223.5MiB/256MiB(87.30%) |            2s |
   quarkus-elasticsearch-native |         34ms |   5.074MiB/256MiB(1.98%) |              9s |                9s |  43.64MiB/256MiB(17.05%) |            0s |
 micronaut-elasticsearch-native |            - |                        - |               - |                 - |                        - |             - |
```

Comments:

- Unable to build `micronaut-elasticsearch-native` using the Micronaut version `2.2.0`, that is why there is no results for it.

- Checking the Final Memory Usage column, `Quarkus` native apps have better memory utilization (after load tests) than `Micronaut` and `Spring Boot` ones; In this experiment, I set **256MiB** the container limit memory. If I reduce the container limit memmory to **128MiB**, all `Micronaut` native apps will have memory issues. For `Quarkus` native apps, I was able to reduce the container limit memmory to even **64MiB**. Below it, the apps performance will degrade.

- Comparing `Ab Testing Time` with `Ab Testing Time 2` columns, we can see that JVM was able to perform some runtime optimizations, making the JVM applications to perform faster on the second ab test run.

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
       quarkus-elasticsearch-jvm | ab -p test-movies.json -T 'application/json' -c 10 -n 2000 http://localhost:9105/api/movies  |
     micronaut-elasticsearch-jvm | ab -p test-movies.json -T 'application/json' -c 10 -n 2000 http://localhost:9107/api/movies  |
    springboot-elasticsearch-jvm | ab -p test-movies.json -T 'application/json' -c 10 -n 2000 http://localhost:9109/api/movies  |
    quarkus-elasticsearch-native | ab -p test-movies.json -T 'application/json' -c 10 -n 2000 http://localhost:9106/api/movies  |
  micronaut-elasticsearch-native | ab -p test-movies.json -T 'application/json' -c 10 -n 2000 http://localhost:9107/api/movies  |
  ```
