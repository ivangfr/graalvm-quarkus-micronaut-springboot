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
| Micronaut   | 2.0.3         |
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
| collect-native-jar-docker-size-times.sh | it packages/assembles jar files and builds docker images of all Native applications, collecting data like: jar packaging Time, size of the jar, docker build time and docker image size. **Note** On Mac and Windows, it's recommended to increase the memory allocated to Docker to at least 8G (and potentially to add more CPUs as well) since native-image compiler is a heavy process. On Linux, Docker uses by default the resources available on the host so no configuration is needed. |
| collect-ab-times-memory-usage.sh        | it starts docker container of all applications (JVM and Native), collecting data like: startup time, initial memory usage, time spent to run some ab tests, final memory usage and shutdown time |

## Comparison

The following table shows the results after running the script `collect-jvm-jar-docker-size-times.sh`
```
                   Application | Packaging Time | Jar Size (bytes) | Docker Build Time | Docker Image Size |
------------------------------ + -------------- + ---------------- + ----------------- + ----------------- |
        quarkus-simple-api-jvm |            11s |           351952 |              113s |             504MB |
      micronaut-simple-api-jvm |            10s |         15985045 |               13s |             214MB |
     springboot-simple-api-jvm |             5s |         22027863 |               11s |             219MB |
.............................. + .............. + ................ + ................. + ................. |
          quarkus-book-api-jvm |            16s |           587135 |               20s |             527MB |
        micronaut-book-api-jvm |            16s |         34006172 |               10s |             232MB |
       springboot-book-api-jvm |             6s |         43338567 |               11s |             241MB |
.............................. + .............. + ................ + ................. + ................. |
      quarkus-producer-api-jvm |            14s |           503644 |               19s |             527MB |
    micronaut-producer-api-jvm |            13s |         26495716 |               10s |             224MB |
   springboot-producer-api-jvm |             6s |         35567917 |               16s |             233MB |
.............................. + .............. + ................ + ................. + ................. |
      quarkus-consumer-api-jvm |            13s |           480092 |               13s |             526MB |
    micronaut-consumer-api-jvm |            11s |         26475796 |                9s |             224MB |
   springboot-consumer-api-jvm |             6s |         35565210 |               11s |             233MB |
.............................. + .............. + ................ + ................. + ................. |
     quarkus-elasticsearch-jvm |            12s |           399138 |               15s |             537MB |
   micronaut-elasticsearch-jvm |            18s |         44941516 |               11s |             243MB |
  springboot-elasticsearch-jvm |             8s |         54455808 |               16s |             250MB |
```

Table below shows the results after running the script `collect-native-jar-docker-size-times.sh`
```
                   Application | Packaging Time | Jar Size (bytes) | Docker Build Time | Docker Image Size |
------------------------------ + -------------- + ---------------- + ----------------- + ----------------- |
     quarkus-simple-api-native |           213s |         33489272 |                5s |             140MB |
   micronaut-simple-api-native |            15s |         15985051 |              272s |             103MB |
.............................. + .............. + ................ + ................. + ................. |
       quarkus-book-api-native |           329s |         75467096 |                9s |             182MB |
     micronaut-book-api-native |            22s |         34006145 |              414s |             156MB |
.............................. + .............. + ................ + ................. + ................. |
   quarkus-producer-api-native |           291s |         60114088 |                7s |             167MB |
 micronaut-producer-api-native |            15s |         26495715 |              306s |             124MB |
.............................. + .............. + ................ + ................. + ................. |
   quarkus-consumer-api-native |           246s |         47850376 |                7s |             155MB |
 micronaut-consumer-api-native |            13s |         26475794 |              304s |             123MB |
.............................. + .............. + ................ + ................. + ................. |
  quarkus-elasticsearch-native |           273s |         53159816 |                9s |             160MB |
micronaut-elasticsearch-native |            24s |         44941525 |              365s |             148MB |
```

Finally, the following table shows the results after running the script `collect-ab-times-memory-usage.sh`
```
                   Application | Startup Time |     Initial Memory Usage | Ab Testing Time |       Final Memory Usage | Shutdown Time |
------------------------------ + ------------ + ------------------------ + --------------- + ------------------------ + ------------- |
        quarkus-simple-api-jvm |       1562ms |  59.01MiB/256MiB(23.05%) |             10s |  82.71MiB/256MiB(32.31%) |            0s |
      micronaut-simple-api-jvm |       5274ms |  83.15MiB/256MiB(32.48%) |             12s |  142.5MiB/256MiB(55.66%) |            1s |
     springboot-simple-api-jvm |       4122ms |    121MiB/256MiB(47.26%) |             11s |    168MiB/256MiB(65.61%) |            2s |
     quarkus-simple-api-native |         32ms |   4.387MiB/256MiB(1.71%) |              6s |  29.85MiB/256MiB(11.66%) |            1s |
   micronaut-simple-api-native |         45ms |   8.293MiB/256MiB(3.24%) |              7s |  156.8MiB/256MiB(61.24%) |           11s |
.............................. + ............ + ........................ + ............... + ........................ +  ............ |
          quarkus-book-api-jvm |       3187ms |  108.1MiB/256MiB(42.23%) |             19s |  173.6MiB/256MiB(67.81%) |            0s |
        micronaut-book-api-jvm |       7677ms |  156.5MiB/256MiB(61.13%) |             18s |  202.9MiB/256MiB(79.25%) |            1s |
       springboot-book-api-jvm |       7416ms |  189.4MiB/256MiB(73.99%) |             19s |  241.2MiB/256MiB(94.22%) |            3s |
       quarkus-book-api-native |         45ms |   7.098MiB/256MiB(2.77%) |             11s |  44.41MiB/256MiB(17.35%) |            0s |
     micronaut-book-api-native |        117ms |   28.6MiB/256MiB(11.17%) |             11s |  165.8MiB/256MiB(64.78%) |           10s |
.............................. + ............ + ........................ + ............... + ........................ +  ............ |
      quarkus-producer-api-jvm |       2585ms |  92.18MiB/256MiB(36.01%) |             19s |  129.5MiB/256MiB(50.59%) |            1s |
    micronaut-producer-api-jvm |       5227ms |  107.8MiB/256MiB(42.11%) |             24s |    178MiB/256MiB(69.54%) |            1s |
   springboot-producer-api-jvm |       5256ms |  151.8MiB/256MiB(59.29%) |             20s |  191.4MiB/256MiB(74.78%) |            3s |
   quarkus-producer-api-native |         44ms |   6.699MiB/256MiB(2.62%) |             14s |  44.93MiB/256MiB(17.55%) |            1s |
 micronaut-producer-api-native |         53ms |   8.996MiB/256MiB(3.51%) |             13s |    159MiB/256MiB(62.13%) |           10s |
.............................. + ............ + ........................ + ............... + ........................ +  ............ |
      quarkus-consumer-api-jvm |       2288ms |  111.7MiB/256MiB(43.63%) |              8s |  111.8MiB/256MiB(43.65%) |            1s |
    micronaut-consumer-api-jvm |       3338ms |  122.2MiB/256MiB(47.75%) |              2s |  136.3MiB/256MiB(53.26%) |            0s |
   springboot-consumer-api-jvm |       4916ms |  157.5MiB/256MiB(61.52%) |              2s |  168.4MiB/256MiB(65.80%) |            2s |
   quarkus-consumer-api-native |         68ms |   7.465MiB/256MiB(2.92%) |              3s |  28.93MiB/256MiB(11.30%) |            0s |
 micronaut-consumer-api-native |       3072ms |   12.46MiB/256MiB(4.87%) |              1s |  27.33MiB/256MiB(10.68%) |           11s |
.............................. + ............ + ........................ + ............... + ........................ +  ............ |
     quarkus-elasticsearch-jvm |       1799ms |  78.42MiB/256MiB(30.63%) |             20s |  132.7MiB/256MiB(51.82%) |            0s |
   micronaut-elasticsearch-jvm |       5183ms |   87.9MiB/256MiB(34.34%) |             21s |  171.3MiB/256MiB(66.91%) |            1s |
  springboot-elasticsearch-jvm |       5952ms |    168MiB/256MiB(65.62%) |             18s |  210.5MiB/256MiB(82.22%) |            3s |
  quarkus-elasticsearch-native |         30ms |    4.73MiB/256MiB(1.85%) |             12s |  44.21MiB/256MiB(17.27%) |            0s |
micronaut-elasticsearch-native |         50ms |   8.695MiB/256MiB(3.40%) |             16s |  160.5MiB/256MiB(62.71%) |           11s |
```

Comments:

- The shutdown of `Micronaut` native apps are taking around **10 seconds**;

- Seeing the Final Memory Usage column, `Quarkus` native apps have better memory utilization (after load tests) than `Micronaut` ones; In this experiment, I set **256MiB** the container limit memory. If I reduce the container limit memmory to **128MiB**, all `Micronaut` native apps will have memory issues. For `Quarkus` native apps, I was able to reduce the container limit memmory to even **64MiB**. Below it, the apps performance will degrade.

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
