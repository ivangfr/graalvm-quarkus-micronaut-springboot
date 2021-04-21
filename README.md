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
| Quarkus     | 1.13.2.Final |
| Micronaut   | 2.4.2        |
| Spring Boot | 2.4.5        |

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
                   Application | Packaging Time | Packaging Size | Docker Build Time | Docker Image Size |
------------------------------ + -------------- + -------------- + ----------------- + ----------------- |
        quarkus-simple-api-jvm |            11s |            14M |               50s |             417MB |
      micronaut-simple-api-jvm |            10s |            15M |               30s |             358MB |
     springboot-simple-api-jvm |             6s |            21M |               18s |             219MB |
.............................. + .............. + .............. + ................. + ................. |
          quarkus-book-api-jvm |            15s |            32M |                5s |             436MB |
        micronaut-book-api-jvm |            13s |            34M |               23s |             378MB |
       springboot-book-api-jvm |             9s |            39M |               15s |             240MB |
.............................. + .............. + .............. + ................. + ................. |
      quarkus-producer-api-jvm |            12s |            33M |                5s |             437MB |
    micronaut-producer-api-jvm |            11s |            25M |               24s |             369MB |
   springboot-producer-api-jvm |             7s |            32M |               13s |             233MB |
.............................. + .............. + .............. + ................. + ................. |
      quarkus-consumer-api-jvm |            11s |            31M |                4s |             435MB |
    micronaut-consumer-api-jvm |            11s |            25M |               24s |             369MB |
   springboot-consumer-api-jvm |             6s |            32M |               15s |             233MB |
.............................. + .............. + .............. + ................. + ................. |
     quarkus-elasticsearch-jvm |            13s |            40M |                5s |             445MB |
   micronaut-elasticsearch-jvm |            14s |            44M |               24s |             388MB |
  springboot-elasticsearch-jvm |             8s |            51M |               15s |             253MB |
```

Table below shows the results after running the script `collect-native-jar-docker-size-times.sh`
```
                    Application | Packaging Time | Packaging Size | Docker Build Time | Docker Image Size |
------------------------------- + -------------- + -------------- + ----------------- + ----------------- |
      quarkus-simple-api-native |           236s |            33M |                5s |             138MB |
    micronaut-simple-api-native |             9s |            15M |              504s |            86.8MB |
   springboot-simple-api-native |             6s |            21M |              540s |            90.1MB |
............................... + .............. + .............. + ................. + ................. |
        quarkus-book-api-native |           384s |            71M |                8s |             178MB |
      micronaut-book-api-native |            14s |            33M |              494s |             122MB |
     springboot-book-api-native |            12s |            39M |             1034s |             179MB |
............................... + .............. + .............. + ................. + ................. |
    quarkus-producer-api-native |           401s |            51M |                6s |             156MB |
  micronaut-producer-api-native |            12s |            25M |              360s |            97.4MB |
 springboot-producer-api-native |              - |              - |                 - |                 - |
............................... + .............. + .............. + ................. + ................. |
    quarkus-consumer-api-native |           265s |            48M |                6s |             153MB |
  micronaut-consumer-api-native |            11s |            25M |              335s |            97.3MB |
 springboot-consumer-api-native |              - |              - |                 - |                 - |
............................... + .............. + .............. + ................. + ................. |
   quarkus-elasticsearch-native |           293s |            53M |                7s |             158MB |
 micronaut-elasticsearch-native |              - |              - |                 - |                 - |
springboot-elasticsearch-native |             8s |            51M |              874s |             157MB |
```

Finally, the following table shows the results after running the script `collect-ab-times-memory-usage.sh`
```
                    Application | Startup Time |     Initial Memory Usage | Ab Testing Time | Ab Testing Time 2 |       Final Memory Usage | Shutdown Time |
------------------------------- + ------------ + ------------------------ + --------------- + ----------------- + ------------------------ + ------------- |
         quarkus-simple-api-jvm |       1653ms |  53.59MiB/256MiB(20.93%) |             10s |                7s |  104.7MiB/256MiB(40.91%) |            0s |
       micronaut-simple-api-jvm |       2650ms |  96.77MiB/256MiB(37.80%) |             13s |                6s |  244.4MiB/256MiB(95.47%) |            1s |
      springboot-simple-api-jvm |       4173ms |  115.2MiB/256MiB(45.02%) |             12s |                6s |  163.5MiB/256MiB(63.87%) |            3s |
      quarkus-simple-api-native |         37ms |   5.617MiB/256MiB(2.19%) |              7s |                8s |  32.04MiB/256MiB(12.52%) |            0s |
    micronaut-simple-api-native |         66ms |   9.043MiB/256MiB(3.53%) |              7s |                7s |    159MiB/256MiB(62.11%) |            1s |
   springboot-simple-api-native |        206ms |  29.21MiB/256MiB(11.41%) |              7s |                7s |    101MiB/256MiB(39.47%) |            2s |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
           quarkus-book-api-jvm |       3110ms |  95.13MiB/256MiB(37.16%) |             15s |                8s |  168.6MiB/256MiB(65.85%) |            1s |
         micronaut-book-api-jvm |       5501ms |  177.3MiB/256MiB(69.26%) |             19s |               10s |    246MiB/256MiB(96.08%) |            1s |
        springboot-book-api-jvm |       6789ms |  167.2MiB/256MiB(65.32%) |             16s |               10s |  241.5MiB/256MiB(94.34%) |            3s |
        quarkus-book-api-native |         78ms |   8.695MiB/256MiB(3.40%) |              8s |                7s |  41.43MiB/256MiB(16.18%) |            1s |
      micronaut-book-api-native |        116ms |   21.05MiB/256MiB(8.22%) |              7s |                7s |  169.8MiB/256MiB(66.33%) |            1s |
     springboot-book-api-native |        296ms |  47.01MiB/256MiB(18.36%) |             10s |                9s |  119.5MiB/256MiB(46.68%) |            3s |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
       quarkus-producer-api-jvm |       2502ms |  81.43MiB/256MiB(31.81%) |             21s |               15s |  143.2MiB/256MiB(55.94%) |            0s |
     micronaut-producer-api-jvm |       3425ms |  86.43MiB/256MiB(33.76%) |             22s |               14s |  240.9MiB/256MiB(94.11%) |            1s |
    springboot-producer-api-jvm |       5578ms |  157.2MiB/256MiB(61.41%) |             19s |               13s |  194.8MiB/256MiB(76.09%) |            3s |
    quarkus-producer-api-native |         53ms |   7.875MiB/256MiB(3.08%) |             18s |               16s |  38.95MiB/256MiB(15.21%) |            1s |
  micronaut-producer-api-native |         56ms |   9.574MiB/256MiB(3.74%) |             12s |               13s |  171.3MiB/256MiB(66.90%) |            0s |
 springboot-producer-api-native |            - |                        - |               - |                 - |                        - |             - |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
       quarkus-consumer-api-jvm |       2000ms |  80.36MiB/256MiB(31.39%) |                                 11s |  114.6MiB/256MiB(44.77%) |            1s |
     micronaut-consumer-api-jvm |       3372ms |  150.1MiB/256MiB(58.63%) |                                  5s |  161.8MiB/256MiB(63.21%) |            0s |
    springboot-consumer-api-jvm |       5037ms |  164.8MiB/256MiB(64.38%) |                                  3s |  171.4MiB/256MiB(66.93%) |            2s |
    quarkus-consumer-api-native |         69ms |   8.645MiB/256MiB(3.38%) |                                  6s |  40.38MiB/256MiB(15.77%) |            1s |
  micronaut-consumer-api-native |         91ms |   12.98MiB/256MiB(5.07%) |                                  3s |  34.27MiB/256MiB(13.39%) |            1s |
 springboot-consumer-api-native |            - |                        - |                                   - |                        - |             - |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
      quarkus-elasticsearch-jvm |       2365ms |  65.95MiB/256MiB(25.76%) |             20s |               12s |  146.3MiB/256MiB(57.16%) |            1s |
    micronaut-elasticsearch-jvm |       2677ms |  96.11MiB/256MiB(37.54%) |             20s |               13s |  228.3MiB/256MiB(89.18%) |            2s |
   springboot-elasticsearch-jvm |       6794ms |  203.6MiB/256MiB(79.55%) |             17s |               11s |  243.4MiB/256MiB(95.07%) |            3s |
   quarkus-elasticsearch-native |         42ms |   5.844MiB/256MiB(2.28%) |             11s |               10s |  42.07MiB/256MiB(16.43%) |            0s |
 micronaut-elasticsearch-native |            - |                        - |               - |                 - |                        - |             - |
springboot-elasticsearch-native |        255ms |  89.34MiB/256MiB(34.90%) |             12s |               11s |    122MiB/256MiB(47.65%) |            2s |
```

**Comments**

- Unable to run `springboot-consumer-api-jvm` and `springboot-consumer-api-native`. See [Issues](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/producer-consumer/springboot-producer-consumer#springboot-consumer-api-issues)

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
