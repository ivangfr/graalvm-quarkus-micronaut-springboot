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
| Quarkus     | 1.8.3.Final   |
| Micronaut   | 2.1.1         |
| Spring Boot | 2.3.4.RELEASE (`simple-api` and `book-api` are using 2.4.0-M3) |

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
        quarkus-simple-api-jvm |            12s |           379332 |              119s |             506MB |
      micronaut-simple-api-jvm |             9s |         15089195 |               18s |             213MB |
     springboot-simple-api-jvm |             5s |         21492338 |               13s |             219MB |
.............................. + .............. + ................ + ................. + ................. |
          quarkus-book-api-jvm |            18s |           587880 |               13s |             525MB |
        micronaut-book-api-jvm |            14s |         33217622 |               15s |             231MB |
       springboot-book-api-jvm |            10s |         42217712 |               17s |             238MB |
.............................. + .............. + ................ + ................. + ................. |
      quarkus-producer-api-jvm |            12s |           504057 |               13s |             525MB |
    micronaut-producer-api-jvm |            11s |         25635880 |               13s |             223MB |
   springboot-producer-api-jvm |             6s |         35567952 |               14s |             233MB |
.............................. + .............. + ................ + ................. + ................. |
      quarkus-consumer-api-jvm |            13s |           480572 |               18s |             524MB |
    micronaut-consumer-api-jvm |             9s |         25615671 |               13s |             223MB |
   springboot-consumer-api-jvm |             5s |         35565241 |               14s |             233MB |
.............................. + .............. + ................ + ................. + ................. |
     quarkus-elasticsearch-jvm |            13s |           427767 |               15s |             537MB |
   micronaut-elasticsearch-jvm |            14s |         44178704 |               16s |             242MB |
  springboot-elasticsearch-jvm |             8s |         52748039 |               15s |             248MB |
```

Table below shows the results after running the script `collect-native-jar-docker-size-times.sh`
```
                   Application | Packaging Time | Jar Size (bytes) | Docker Build Time | Docker Image Size |
------------------------------ + -------------- + ---------------- + ----------------- + ----------------- |
     quarkus-simple-api-native |           603s |         33964224 |                5s |             141MB |
   micronaut-simple-api-native |             8s |         15089192 |              297s |             102MB |
  springboot-simple-api-native |             6s |         21492338 |              723s |            86.2MB |
.............................. + .............. + ................ + ................. + ................. |
       quarkus-book-api-native |           341s |         75475288 |                7s |             182MB |
     micronaut-book-api-native |            13s |         33217612 |              410s |             154MB |
    springboot-book-api-native |            10s |         42217712 |             1039s |             169MB |
.............................. + .............. + ................ + ................. + ................. |
   quarkus-producer-api-native |           324s |         60118184 |                7s |             167MB |
 micronaut-producer-api-native |            11s |         25635894 |              311s |             122MB |
.............................. + .............. + ................ + ................. + ................. |
   quarkus-consumer-api-native |           252s |         47850376 |                5s |             155MB |
 micronaut-consumer-api-native |            11s |         25615671 |              305s |             122MB |
.............................. + .............. + ................ + ................. + ................. |
  quarkus-elasticsearch-native |           297s |         55351176 |                7s |             162MB |
micronaut-elasticsearch-native |            14s |         44178704 |              363s |             147MB |
```

Finally, the following table shows the results after running the script `collect-ab-times-memory-usage.sh`
```
                    Application | Startup Time |     Initial Memory Usage | Ab Testing Time |       Final Memory Usage | Shutdown Time |
 ------------------------------ + ------------ + ------------------------ + --------------- + ------------------------ + ------------- |
         quarkus-simple-api-jvm |       3022ms |  60.56MiB/256MiB(23.66%) |             14s |  108.2MiB/256MiB(42.28%) |            0s |
       micronaut-simple-api-jvm |       6213ms |  109.3MiB/256MiB(42.68%) |             15s |  142.2MiB/256MiB(55.55%) |            1s |
      springboot-simple-api-jvm |       5952ms |  111.2MiB/256MiB(43.46%) |             12s |    153MiB/256MiB(59.77%) |            3s |
      quarkus-simple-api-native |         55ms |   4.543MiB/256MiB(1.77%) |              8s |   30.9MiB/256MiB(12.07%) |            1s |
    micronaut-simple-api-native |        150ms |   8.438MiB/256MiB(3.30%) |              7s |  155.8MiB/256MiB(60.84%) |           10s |
   springboot-simple-api-native |        321ms |   28.6MiB/256MiB(11.17%) |              7s |     98MiB/256MiB(38.28%) |            2s |
 .............................. + ............ + ........................ + ............... + ........................ +  ............ |
           quarkus-book-api-jvm |       5551ms |  117.1MiB/256MiB(45.75%) |             21s |  154.6MiB/256MiB(60.37%) |            1s |
         micronaut-book-api-jvm |       9403ms |  135.9MiB/256MiB(53.10%) |             21s |  188.3MiB/256MiB(73.56%) |            0s |
        springboot-book-api-jvm |       9282ms |  164.6MiB/256MiB(64.31%) |             25s |  216.4MiB/256MiB(84.54%) |            3s |
        quarkus-book-api-native |         69ms |   7.117MiB/256MiB(2.78%) |             13s |     37MiB/256MiB(14.45%) |            1s |
      micronaut-book-api-native |        205ms |   20.08MiB/256MiB(7.84%) |             12s |  159.7MiB/256MiB(62.39%) |           11s |
     springboot-book-api-native |        403ms |  42.21MiB/256MiB(16.49%) |             17s |  109.8MiB/256MiB(42.88%) |            2s |
 .............................. + ............ + ........................ + ............... + ........................ +  ............ |
       quarkus-producer-api-jvm |       4520ms |  86.26MiB/256MiB(33.69%) |             24s |  147.1MiB/256MiB(57.45%) |            1s |
     micronaut-producer-api-jvm |       6500ms |  83.89MiB/256MiB(32.77%) |             26s |  179.2MiB/256MiB(70.01%) |            1s |
    springboot-producer-api-jvm |       7417ms |  150.2MiB/256MiB(58.69%) |             26s |  197.6MiB/256MiB(77.19%) |            3s |
    quarkus-producer-api-native |        164ms |   6.707MiB/256MiB(2.62%) |             17s |  44.56MiB/256MiB(17.41%) |            1s |
  micronaut-producer-api-native |        159ms |   8.898MiB/256MiB(3.48%) |             16s |  157.9MiB/256MiB(61.69%) |           11s |
 .............................. + ............ + ........................ + ............... + ........................ +  ............ |
       quarkus-consumer-api-jvm |       4094ms |  84.02MiB/256MiB(32.82%) |              8s |  105.1MiB/256MiB(41.07%) |            1s |
     micronaut-consumer-api-jvm |       4780ms |  125.4MiB/256MiB(48.99%) |              2s |  138.1MiB/256MiB(53.95%) |            1s |
    springboot-consumer-api-jvm |       7282ms |  142.4MiB/256MiB(55.63%) |              2s |  157.5MiB/256MiB(61.51%) |            3s |
    quarkus-consumer-api-native |        149ms |   7.391MiB/256MiB(2.89%) |              4s |  28.98MiB/256MiB(11.32%) |            0s |
  micronaut-consumer-api-native |       3150ms |   13.54MiB/256MiB(5.29%) |              2s |  27.29MiB/256MiB(10.66%) |           10s |
 .............................. + ............ + ........................ + ............... + ........................ +  ............ |
      quarkus-elasticsearch-jvm |       3682ms |  80.67MiB/256MiB(31.51%) |             24s |  129.2MiB/256MiB(50.46%) |            0s |
    micronaut-elasticsearch-jvm |       6520ms |  113.9MiB/256MiB(44.50%) |             24s |  158.5MiB/256MiB(61.90%) |            1s |
   springboot-elasticsearch-jvm |       8519ms |  158.4MiB/256MiB(61.87%) |             21s |  216.2MiB/256MiB(84.47%) |            2s |
   quarkus-elasticsearch-native |        145ms |   4.797MiB/256MiB(1.87%) |             15s |  44.25MiB/256MiB(17.29%) |            1s |
 micronaut-elasticsearch-native |        120ms |    8.73MiB/256MiB(3.41%) |             18s |  159.5MiB/256MiB(62.31%) |           10s |
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
       quarkus-elasticsearch-jvm | ab -p test-movies.json -T 'application/json' -c 10 -n 2000 http://localhost:9105/api/movies  |
     micronaut-elasticsearch-jvm | ab -p test-movies.json -T 'application/json' -c 10 -n 2000 http://localhost:9107/api/movies  |
    springboot-elasticsearch-jvm | ab -p test-movies.json -T 'application/json' -c 10 -n 2000 http://localhost:9109/api/movies  |
    quarkus-elasticsearch-native | ab -p test-movies.json -T 'application/json' -c 10 -n 2000 http://localhost:9106/api/movies  |
  micronaut-elasticsearch-native | ab -p test-movies.json -T 'application/json' -c 10 -n 2000 http://localhost:9107/api/movies  |
  ```
