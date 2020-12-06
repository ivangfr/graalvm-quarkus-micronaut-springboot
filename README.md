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
| Quarkus     | 1.10.2.Final |
| Micronaut   | 2.2.1        |
| Spring Boot | 2.4.0        |

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
  
  > Note: On Mac and Windows, it's recommended to increase the memory allocated to Docker to at least 8G (and potentially to add more CPUs as well) since native-image compiler is a heavy process. On Linux, Docker uses by default the resources available on the host so no configuration is needed.

- **collect-ab-times-memory-usage.sh**

  It starts docker container of all applications (JVM and Native), collecting data like: startup time, initial memory usage, time spent to run ab tests for the first time and (after some warm up) for the second time, final memory usage and shutdown time.

## Comparison

The following table shows the results after running the script `collect-jvm-jar-docker-size-times.sh`
```
                   Application | Packaging Time | Jar Size (bytes) | Docker Build Time | Docker Image Size |
------------------------------ + -------------- + ---------------- + ----------------- + ----------------- |
        quarkus-simple-api-jvm |            10s |           391370 |               37s |             331MB |
      micronaut-simple-api-jvm |            10s |         15177280 |               20s |             358MB |
     springboot-simple-api-jvm |             7s |         21673214 |               16s |             219MB |
.............................. + .............. + ................ + ................. + ................. |
          quarkus-book-api-jvm |            13s |           597231 |               12s |             350MB |
        micronaut-book-api-jvm |            14s |         34492324 |               20s |             378MB |
       springboot-book-api-jvm |             9s |         42534746 |               13s |             240MB |
.............................. + .............. + ................ + ................. + ................. |
      quarkus-producer-api-jvm |            12s |           572210 |               11s |             352MB |
    micronaut-producer-api-jvm |             9s |         26128282 |               18s |             369MB |
   springboot-producer-api-jvm |             7s |         35793868 |               13s |             233MB |
.............................. + .............. + ................ + ................. + ................. |
      quarkus-consumer-api-jvm |            11s |           518653 |               10s |             350MB |
    micronaut-consumer-api-jvm |             9s |         26110244 |               21s |             369MB |
   springboot-consumer-api-jvm |             8s |         35791204 |               11s |             233MB |
.............................. + .............. + ................ + ................. + ................. |
     quarkus-elasticsearch-jvm |            12s |           438923 |               16s |             358MB |
   micronaut-elasticsearch-jvm |            13s |         44836244 |               22s |             388MB |
  springboot-elasticsearch-jvm |             8s |         55297410 |               14s |             253MB |
```

Table below shows the results after running the script `collect-native-jar-docker-size-times.sh`
```
                    Application | Packaging Time | Jar Size (bytes) | Docker Build Time | Docker Image Size |
------------------------------- + -------------- + ---------------- + ----------------- + ----------------- |
      quarkus-simple-api-native |           197s |         34328768 |                4s |             137MB |
    micronaut-simple-api-native |             8s |         15177280 |              325s |            87.4MB |
   springboot-simple-api-native |             6s |         21673214 |              430s |            87.1MB |
............................... + .............. + ................ + ................. + ................. |
        quarkus-book-api-native |           350s |         76064976 |                6s |             179MB |
      micronaut-book-api-native |            16s |         34492323 |              468s |             123MB |
     springboot-book-api-native |             9s |         42534746 |              802s |             167MB |
............................... + .............. + ................ + ................. + ................. |
    quarkus-producer-api-native |           292s |         53576584 |                6s |             156MB |
  micronaut-producer-api-native |            10s |         26128289 |              334s |            97.9MB |
 springboot-producer-api-native |             7s |         35793868 |              697s |             112MB |
............................... + .............. + ................ + ................. + ................. |
    quarkus-consumer-api-native |           251s |         49271688 |                5s |             152MB |
  micronaut-consumer-api-native |            11s |         26110232 |              329s |            97.8MB |
 springboot-consumer-api-native |             8s |         35791204 |              715s |             113MB |
............................... + .............. + ................ + ................. + ................. |
   quarkus-elasticsearch-native |           322s |         55801736 |                6s |             159MB |
 micronaut-elasticsearch-native |              - |                - |                 - |                 - |
springboot-elasticsearch-native |             7s |         55297410 |              784s |             148MB |
```

Finally, the following table shows the results after running the script `collect-ab-times-memory-usage.sh`
```
                    Application | Startup Time |     Initial Memory Usage | Ab Testing Time | Ab Testing Time 2 |       Final Memory Usage | Shutdown Time |
------------------------------- + ------------ + ------------------------ + --------------- + ----------------- + ------------------------ + ------------- |
         quarkus-simple-api-jvm |       2048ms |  68.76MiB/256MiB(26.86%) |             10s |                6s |  116.1MiB/256MiB(45.37%) |            0s |
       micronaut-simple-api-jvm |       2903ms |  83.73MiB/256MiB(32.71%) |             13s |                6s |    227MiB/256MiB(88.67%) |            1s |
      springboot-simple-api-jvm |       4166ms |  119.9MiB/256MiB(46.85%) |             12s |                6s |  168.5MiB/256MiB(65.81%) |            3s |
      quarkus-simple-api-native |         40ms |    4.77MiB/256MiB(1.86%) |              6s |                6s |  32.26MiB/256MiB(12.60%) |            1s |
    micronaut-simple-api-native |         60ms |   9.484MiB/256MiB(3.70%) |              6s |                6s |    157MiB/256MiB(61.33%) |            1s |
   springboot-simple-api-native |        271ms |   32.6MiB/256MiB(12.73%) |              7s |                8s |  100.2MiB/256MiB(39.12%) |            2s |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
           quarkus-book-api-jvm |       3698ms |  113.1MiB/256MiB(44.19%) |             15s |                9s |    165MiB/256MiB(64.46%) |            1s |
         micronaut-book-api-jvm |       5235ms |  184.4MiB/256MiB(72.03%) |             19s |                8s |  246.7MiB/256MiB(96.39%) |            1s |
        springboot-book-api-jvm |       6460ms |  163.7MiB/256MiB(63.95%) |             16s |               10s |  250.5MiB/256MiB(97.85%) |            3s |
        quarkus-book-api-native |         70ms |   7.164MiB/256MiB(2.80%) |              8s |                8s |  42.57MiB/256MiB(16.63%) |            1s |
      micronaut-book-api-native |        115ms |   21.38MiB/256MiB(8.35%) |              9s |                7s |  160.6MiB/256MiB(62.72%) |            1s |
     springboot-book-api-native |        345ms |  45.77MiB/256MiB(17.88%) |              8s |                8s |  115.5MiB/256MiB(45.13%) |            3s |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
       quarkus-producer-api-jvm |       3038ms |  94.61MiB/256MiB(36.96%) |             19s |               14s |  152.6MiB/256MiB(59.60%) |            1s |
     micronaut-producer-api-jvm |       2674ms |  97.84MiB/256MiB(38.22%) |             23s |               14s |  236.9MiB/256MiB(92.54%) |            1s |
    springboot-producer-api-jvm |       7280ms |  168.3MiB/256MiB(65.74%) |             17s |               13s |  212.4MiB/256MiB(82.98%) |            3s |
    quarkus-producer-api-native |         67ms |   7.207MiB/256MiB(2.82%) |             18s |               18s |  44.57MiB/256MiB(17.41%) |            0s |
  micronaut-producer-api-native |         51ms |   9.871MiB/256MiB(3.86%) |             13s |               12s |  159.3MiB/256MiB(62.21%) |            0s |
 springboot-producer-api-native |            - |                        - |               - |                 - |                        - |             - |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
       quarkus-consumer-api-jvm |       2768ms |  87.74MiB/256MiB(34.27%) |                                 11s |  129.1MiB/256MiB(50.44%) |            0s |
     micronaut-consumer-api-jvm |       3413ms |  163.7MiB/256MiB(63.94%) |                                  3s |  244.2MiB/256MiB(95.37%) |            0s |
    springboot-consumer-api-jvm |       8081ms |  175.3MiB/256MiB(68.47%) |                                  8s |    198MiB/256MiB(77.34%) |            3s |
    quarkus-consumer-api-native |         54ms |   8.203MiB/256MiB(3.20%) |                                  8s |  40.68MiB/256MiB(15.89%) |            1s |
  micronaut-consumer-api-native |         82ms |   13.32MiB/256MiB(5.20%) |                                  3s |   32.7MiB/256MiB(12.77%) |            1s |
 springboot-consumer-api-native |            - |                        - |                                   - |                        - |             - |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
      quarkus-elasticsearch-jvm |       2367ms |  83.07MiB/256MiB(32.45%) |             19s |               10s |  163.7MiB/256MiB(63.94%) |            1s |
    micronaut-elasticsearch-jvm |       2602ms |  92.31MiB/256MiB(36.06%) |             20s |               13s |  231.3MiB/256MiB(90.37%) |            1s |
   springboot-elasticsearch-jvm |       6749ms |  207.7MiB/256MiB(81.15%) |             16s |               11s |  234.4MiB/256MiB(91.55%) |            3s |
   quarkus-elasticsearch-native |         45ms |   5.047MiB/256MiB(1.97%) |             12s |               10s |  44.57MiB/256MiB(17.41%) |            0s |
 micronaut-elasticsearch-native |            - |                        - |               - |                 - |                        - |             - |
springboot-elasticsearch-native |        313ms |     88MiB/256MiB(34.38%) |             10s |               10s |  123.2MiB/256MiB(48.14%) |            3s |
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
