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
    springboot-book-api-native |             8s |         44564217 |             1225s |             187MB |
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
         quarkus-simple-api-jvm |       2532ms |   56.1MiB/256MiB(21.91%) |             11s |  81.51MiB/256MiB(31.84%) |            1s |
       micronaut-simple-api-jvm |       4169ms |  82.35MiB/256MiB(32.17%) |             14s |  134.4MiB/256MiB(52.52%) |            1s |
      springboot-simple-api-jvm |       7177ms |  125.6MiB/256MiB(49.04%) |             12s |  159.2MiB/256MiB(62.18%) |            3s |
      quarkus-simple-api-native |        149ms |   4.816MiB/256MiB(1.88%) |              7s |  30.23MiB/256MiB(11.81%) |            0s |
    micronaut-simple-api-native |        289ms |   8.809MiB/256MiB(3.44%) |              8s |  157.2MiB/256MiB(61.43%) |           11s |
   springboot-simple-api-native |        491ms |  30.98MiB/256MiB(12.10%) |              7s |  99.04MiB/256MiB(38.69%) |            3s |
 .............................. + ............ + ........................ + ............... + ........................ +  ............ |
           quarkus-book-api-jvm |       6503ms |  115.7MiB/256MiB(45.21%) |             23s |  172.8MiB/256MiB(67.52%) |            1s |
         micronaut-book-api-jvm |       8952ms |  147.1MiB/256MiB(57.47%) |             22s |  199.2MiB/256MiB(77.80%) |            1s |
        springboot-book-api-jvm |      13136ms |  202.4MiB/256MiB(79.08%) |             24s |  239.5MiB/256MiB(93.54%) |            3s |
        quarkus-book-api-native |        288ms |    7.48MiB/256MiB(2.92%) |             14s |  45.11MiB/256MiB(17.62%) |            1s |
      micronaut-book-api-native |        784ms |  29.97MiB/256MiB(11.71%) |             14s |  166.2MiB/256MiB(64.94%) |           11s |
     springboot-book-api-native |            - |                        - |               - |                        - |             - |
 .............................. + ............ + ........................ + ............... + ........................ +  ............ |
       quarkus-producer-api-jvm |       6099ms |  109.5MiB/256MiB(42.78%) |             23s |  136.1MiB/256MiB(53.16%) |            1s |
     micronaut-producer-api-jvm |       4067ms |  109.8MiB/256MiB(42.91%) |             31s |  150.1MiB/256MiB(58.65%) |            1s |
    springboot-producer-api-jvm |       9576ms |  146.9MiB/256MiB(57.37%) |             22s |  191.9MiB/256MiB(74.94%) |            3s |
    quarkus-producer-api-native |        289ms |    6.98MiB/256MiB(2.73%) |             19s |  45.94MiB/256MiB(17.95%) |            1s |
  micronaut-producer-api-native |        500ms |   9.418MiB/256MiB(3.68%) |             19s |  159.4MiB/256MiB(62.25%) |           11s |
 .............................. + ............ + ........................ + ............... + ........................ +  ............ |
       quarkus-consumer-api-jvm |       5284ms |  92.27MiB/256MiB(36.04%) |              6s |  118.1MiB/256MiB(46.12%) |            1s |
     micronaut-consumer-api-jvm |       5927ms |  135.9MiB/256MiB(53.10%) |              4s |  141.7MiB/256MiB(55.35%) |            0s |
    springboot-consumer-api-jvm |       8519ms |  158.5MiB/256MiB(61.91%) |              4s |  158.1MiB/256MiB(61.76%) |            3s |
    quarkus-consumer-api-native |        343ms |   8.012MiB/256MiB(3.13%) |              3s |  29.42MiB/256MiB(11.49%) |            0s |
  micronaut-consumer-api-native |        487ms |   12.95MiB/256MiB(5.06%) |              3s |  27.77MiB/256MiB(10.85%) |           11s |
 .............................. + ............ + ........................ + ............... + ........................ +  ............ |
      quarkus-elasticsearch-jvm |       4020ms |  70.52MiB/256MiB(27.55%) |             26s |  136.4MiB/256MiB(53.27%) |            1s |
    micronaut-elasticsearch-jvm |       4157ms |  111.7MiB/256MiB(43.63%) |             26s |  173.2MiB/256MiB(67.67%) |            2s |
   springboot-elasticsearch-jvm |      10598ms |    172MiB/256MiB(67.18%) |             21s |  212.9MiB/256MiB(83.15%) |            3s |
   quarkus-elasticsearch-native |        177ms |   4.973MiB/256MiB(1.94%) |             19s |  44.59MiB/256MiB(17.42%) |            1s |
 micronaut-elasticsearch-native |        271ms |   8.891MiB/256MiB(3.47%) |             19s |    161MiB/256MiB(62.89%) |           11s |
```

Comments:

- There is no values for `springboot-book-api-native` because, in spite of the fact that the native Docker image builds successfully, an exception is thrown at runtime. See [issue](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/book-api/springboot-book-api#issues)

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
