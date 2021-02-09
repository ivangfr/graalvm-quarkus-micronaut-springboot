# graalvm-quarkus-micronaut-springboot

The goal of this project is to compare some Java frameworks like: [`Quarkus`](https://quarkus.io/), [`Micronaut`](https://micronaut.io/) and [`Spring Boot`](https://docs.spring.io/spring-boot/docs/current/reference/htmlsingle/). For it, we will implement applications using those frameworks, build their JVM and Native Docker images and measure start-up times, memory footprint, etc.

## Examples

- ### [simple-api](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/simple-api#graalvm-quarkus-micronaut-springboot)
- ### [book-api](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/book-api#graalvm-quarkus-micronaut-springboot)
- ### [producer-consumer](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/producer-consumer#graalvm-quarkus-micronaut-springboot)
- ### [elasticsearch](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/elasticsearch#graalvm-quarkus-micronaut-springboot)

## Framework version

We are using the following Framework versions

| Framework   | Version      |
| ----------- | ------------ |
| Quarkus     | 1.11.1.Final |
| Micronaut   | 2.3.1        |
| Spring Boot | 2.4.2        |

## Prerequisites

- [`Java 11+`](https://www.oracle.com/java/technologies/javase-jdk11-downloads.html)
- [`Docker`](https://www.docker.com/)
- [`Docker-Compose`](https://docs.docker.com/compose/install/)

## Bash scripts

We've implemented three bash scripts that collect data used in the frameworks comparison.

- **collect-jvm-jar-docker-size-times.sh**
  
  It packages jar files and builds docker images of all JVM applications, collecting data like: jar packaging Time, jar size, docker build time and docker image size.

- **collect-native-jar-docker-size-times.sh**

  It packages jar files and builds docker images of all Native applications, collecting data like: jar packaging Time, jar size, docker build time and docker image size.
  
  > **Note**: On Mac and Windows, it's recommended to increase the memory allocated to Docker to at least 8G (and potentially to add more CPUs as well) since native-image compiler is a heavy process. On Linux, Docker uses by default the resources available on the host so no configuration is needed.

- **collect-ab-times-memory-usage.sh**

  It starts docker container of all applications (JVM and Native), collecting data like: startup time, initial memory usage, time spent to run ab tests for the first time and (after some warm up) for the second time, final memory usage and shutdown time.

## Comparison

The following table shows the results after running the script `collect-jvm-jar-docker-size-times.sh`
```
                   Application | Packaging Time | Jar Size (bytes) | Docker Build Time | Docker Image Size |
------------------------------ + -------------- + ---------------- + ----------------- + ----------------- |
        quarkus-simple-api-jvm |             9s |           391349 |               34s |             331MB |
      micronaut-simple-api-jvm |             8s |         15181623 |               27s |             358MB |
     springboot-simple-api-jvm |             8s |         21705777 |               16s |             219MB |
.............................. + .............. + ................ + ................. + ................. |
          quarkus-book-api-jvm |            13s |           597157 |               19s |             350MB |
        micronaut-book-api-jvm |            14s |         34502550 |               22s |             378MB |
       springboot-book-api-jvm |             9s |         42564898 |               15s |             240MB |
.............................. + .............. + ................ + ................. + ................. |
      quarkus-producer-api-jvm |            11s |           572218 |               19s |             352MB |
    micronaut-producer-api-jvm |            12s |         26132612 |               22s |             369MB |
   springboot-producer-api-jvm |             7s |         35828948 |               14s |             233MB |
.............................. + .............. + ................ + ................. + ................. |
      quarkus-consumer-api-jvm |            11s |           518604 |               17s |             350MB |
    micronaut-consumer-api-jvm |             9s |         26114597 |               22s |             369MB |
   springboot-consumer-api-jvm |             7s |         35826283 |               13s |             233MB |
.............................. + .............. + ................ + ................. + ................. |
     quarkus-elasticsearch-jvm |            13s |           438926 |               15s |             358MB |
   micronaut-elasticsearch-jvm |            15s |         44840538 |               23s |             388MB |
  springboot-elasticsearch-jvm |             7s |         55332067 |               16s |             253MB |
```

Table below shows the results after running the script `collect-native-jar-docker-size-times.sh`
```
                    Application | Packaging Time | Jar Size (bytes) | Docker Build Time | Docker Image Size |
------------------------------- + -------------- + ---------------- + ----------------- + ----------------- |
      quarkus-simple-api-native |           295s |         35569856 |                7s |             138MB |
    micronaut-simple-api-native |            10s |         15181621 |              429s |            87.4MB |
   springboot-simple-api-native |             6s |         21705777 |              498s |            88.3MB |
............................... + .............. + ................ + ................. + ................. |
        quarkus-book-api-native |           377s |         76101840 |                8s |             179MB |
      micronaut-book-api-native |            19s |         34502551 |              513s |             123MB |
     springboot-book-api-native |            12s |         42564903 |              867s |             171MB |
............................... + .............. + ................ + ................. + ................. |
    quarkus-producer-api-native |           311s |         53588872 |                6s |             156MB |
  micronaut-producer-api-native |            15s |         26132612 |              340s |            97.9MB |
 springboot-producer-api-native |             7s |         35828948 |              602s |             111MB |
............................... + .............. + ................ + ................. + ................. |
    quarkus-consumer-api-native |           262s |         49283976 |                6s |             152MB |
  micronaut-consumer-api-native |            11s |         26114597 |              345s |            97.8MB |
 springboot-consumer-api-native |             9s |         35826283 |              565s |             112MB |
............................... + .............. + ................ + ................. + ................. |
   quarkus-elasticsearch-native |           428s |         55805832 |               10s |             159MB |
 micronaut-elasticsearch-native |              - |                - |                 - |                 - |
springboot-elasticsearch-native |            13s |         55332067 |              830s |             153MB |
```

Finally, the following table shows the results after running the script `collect-ab-times-memory-usage.sh`
```
                    Application | Startup Time |     Initial Memory Usage | Ab Testing Time | Ab Testing Time 2 |       Final Memory Usage | Shutdown Time |
------------------------------- + ------------ + ------------------------ + --------------- + ----------------- + ------------------------ + ------------- |
         quarkus-simple-api-jvm |       3078ms |  61.45MiB/256MiB(24.01%) |             17s |                8s |  119.5MiB/256MiB(46.66%) |            1s |
       micronaut-simple-api-jvm |       4235ms |  95.67MiB/256MiB(37.37%) |             18s |                8s |  225.3MiB/256MiB(88.02%) |            1s |
      springboot-simple-api-jvm |       7817ms |  119.5MiB/256MiB(46.69%) |             16s |                9s |  169.5MiB/256MiB(66.23%) |            3s |
      quarkus-simple-api-native |         57ms |   4.809MiB/256MiB(1.88%) |             11s |               10s |  33.07MiB/256MiB(12.92%) |            1s |
    micronaut-simple-api-native |        113ms |   9.273MiB/256MiB(3.62%) |              8s |                7s |    157MiB/256MiB(61.32%) |            1s |
   springboot-simple-api-native |        453ms |  33.04MiB/256MiB(12.90%) |              7s |                6s |  100.1MiB/256MiB(39.09%) |            3s |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
           quarkus-book-api-jvm |       5471ms |    111MiB/256MiB(43.38%) |             19s |               12s |  169.9MiB/256MiB(66.36%) |            1s |
         micronaut-book-api-jvm |       7187ms |  187.7MiB/256MiB(73.30%) |             25s |               12s |  232.1MiB/256MiB(90.66%) |            1s |
        springboot-book-api-jvm |      10374ms |    175MiB/256MiB(68.35%) |             20s |               12s |  237.2MiB/256MiB(92.66%) |            3s |
        quarkus-book-api-native |         52ms |   7.207MiB/256MiB(2.82%) |             11s |               10s |  43.43MiB/256MiB(16.96%) |            1s |
      micronaut-book-api-native |        225ms |   21.59MiB/256MiB(8.44%) |             10s |                9s |  160.5MiB/256MiB(62.71%) |            1s |
     springboot-book-api-native |        477ms |  46.49MiB/256MiB(18.16%) |             14s |               12s |  115.8MiB/256MiB(45.24%) |            3s |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
       quarkus-producer-api-jvm |       4846ms |  115.1MiB/256MiB(44.94%) |             26s |               16s |  155.2MiB/256MiB(60.64%) |            1s |
     micronaut-producer-api-jvm |       3275ms |  97.11MiB/256MiB(37.93%) |             29s |               17s |  231.6MiB/256MiB(90.46%) |            1s |
    springboot-producer-api-jvm |       7913ms |  136.6MiB/256MiB(53.35%) |             21s |               15s |  202.5MiB/256MiB(79.10%) |            2s |
    quarkus-producer-api-native |         89ms |   7.172MiB/256MiB(2.80%) |             23s |               24s |   44.7MiB/256MiB(17.46%) |            1s |
  micronaut-producer-api-native |        141ms |   9.926MiB/256MiB(3.88%) |             15s |               15s |  159.3MiB/256MiB(62.22%) |            0s |
 springboot-producer-api-native |            - |                        - |               - |                 - |                        - |             - |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
       quarkus-consumer-api-jvm |       4179ms |  82.72MiB/256MiB(32.31%) |                                 16s |  132.3MiB/256MiB(51.68%) |            0s |
     micronaut-consumer-api-jvm |       4608ms |  142.7MiB/256MiB(55.73%) |                                  8s |  175.5MiB/256MiB(68.56%) |            1s |
    springboot-consumer-api-jvm |       7677ms |  143.7MiB/256MiB(56.14%) |                                  8s |  161.6MiB/256MiB(63.12%) |            3s |
    quarkus-consumer-api-native |         84ms |   8.113MiB/256MiB(3.17%) |                                  8s |  39.34MiB/256MiB(15.37%) |            1s |
  micronaut-consumer-api-native |        120ms |   13.39MiB/256MiB(5.23%) |                                  5s |   31.6MiB/256MiB(12.34%) |            1s |
 springboot-consumer-api-native |            - |                        - |                                   - |                        - |             - |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
      quarkus-elasticsearch-jvm |       3600ms |  77.88MiB/256MiB(30.42%) |             25s |               14s |    158MiB/256MiB(61.71%) |            0s |
    micronaut-elasticsearch-jvm |       3413ms |  92.07MiB/256MiB(35.96%) |             24s |               16s |  243.8MiB/256MiB(95.25%) |            1s |
   springboot-elasticsearch-jvm |       9885ms |  218.5MiB/256MiB(85.34%) |             20s |               14s |  244.3MiB/256MiB(95.42%) |            3s |
   quarkus-elasticsearch-native |         62ms |   5.082MiB/256MiB(1.99%) |             15s |               13s |  44.46MiB/256MiB(17.37%) |            1s |
 micronaut-elasticsearch-native |            - |                        - |               - |                 - |                        - |             - |
springboot-elasticsearch-native |        339ms |  88.78MiB/256MiB(34.68%) |             13s |               12s |  121.2MiB/256MiB(47.33%) |            3s |
```

Comments:

- Unable to run `springboot-producer-api-native` and `springboot-consumer-api-native`. See [Issues](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/producer-consumer/springboot-producer-consumer#issues)

- Unable to build `micronaut-elasticsearch-native`. See [Issues](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/elasticsearch/micronaut-elasticsearch#issues)

- Checking the Final Memory Usage column, `Quarkus` native apps have better memory utilization (after load tests) than `Micronaut` and `Spring Boot` ones; In this experiment, we set **256MiB** the container limit memory. If we reduce the container limit memmory to **128MiB**, all `Micronaut` native apps will have memory issues. For `Quarkus` native apps, I was able to reduce the container limit memmory to even **64MiB**. Below it, the apps performance will degrade.

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
