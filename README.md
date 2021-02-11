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
| Quarkus     | 1.11.2.Final |
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
        quarkus-simple-api-jvm |            11s |           401992 |               40s |             385MB |
      micronaut-simple-api-jvm |            11s |         15252784 |               35s |             358MB |
     springboot-simple-api-jvm |             6s |         21753004 |               21s |             219MB |
.............................. + .............. + ................ + ................. + ................. |
          quarkus-book-api-jvm |            19s |           611243 |               18s |             404MB |
        micronaut-book-api-jvm |            15s |         34579309 |               26s |             378MB |
       springboot-book-api-jvm |            10s |         40679501 |               16s |             240MB |
.............................. + .............. + ................ + ................. + ................. |
      quarkus-producer-api-jvm |            15s |           591549 |               19s |             407MB |
    micronaut-producer-api-jvm |            11s |         26204408 |               24s |             369MB |
   springboot-producer-api-jvm |             8s |         33965619 |               14s |             233MB |
.............................. + .............. + ................ + ................. + ................. |
      quarkus-consumer-api-jvm |            13s |           537489 |               17s |             405MB |
    micronaut-consumer-api-jvm |            11s |         26185555 |               21s |             369MB |
   springboot-consumer-api-jvm |             7s |         33962954 |               15s |             233MB |
.............................. + .............. + ................ + ................. + ................. |
     quarkus-elasticsearch-jvm |            15s |           453900 |               19s |             413MB |
   micronaut-elasticsearch-jvm |            16s |         44912952 |               27s |             388MB |
  springboot-elasticsearch-jvm |            10s |         53456170 |               17s |             253MB |
```

Table below shows the results after running the script `collect-native-jar-docker-size-times.sh`
```
                    Application | Packaging Time | Jar Size (bytes) | Docker Build Time | Docker Image Size |
------------------------------- + -------------- + ---------------- + ----------------- + ----------------- |
      quarkus-simple-api-native |           219s |         35021040 |                5s |             138MB |
    micronaut-simple-api-native |            11s |         15252784 |              316s |            86.8MB |
   springboot-simple-api-native |             7s |         21753004 |              421s |            88.1MB |
............................... + .............. + ................ + ................. + ................. |
        quarkus-book-api-native |           349s |         74103024 |                7s |             177MB |
      micronaut-book-api-native |            16s |         34579309 |              496s |             122MB |
     springboot-book-api-native |            12s |         40679501 |              908s |             175MB |
............................... + .............. + ................ + ................. + ................. |
    quarkus-producer-api-native |           324s |         52802488 |                9s |             156MB |
  micronaut-producer-api-native |            13s |         26204411 |              353s |            97.4MB |
 springboot-producer-api-native |             9s |         33965619 |              578s |             114MB |
............................... + .............. + ................ + ................. + ................. |
    quarkus-consumer-api-native |           278s |         49247160 |                6s |             152MB |
  micronaut-consumer-api-native |            16s |         26185555 |              358s |            97.3MB |
 springboot-consumer-api-native |             8s |         33962954 |              552s |             110MB |
............................... + .............. + ................ + ................. + ................. |
   quarkus-elasticsearch-native |           318s |         54749168 |                7s |             158MB |
 micronaut-elasticsearch-native |              - |                - |                 - |                 - |
springboot-elasticsearch-native |            11s |         53456170 |              834s |             155MB |
```

Finally, the following table shows the results after running the script `collect-ab-times-memory-usage.sh`
```
                    Application | Startup Time |     Initial Memory Usage | Ab Testing Time | Ab Testing Time 2 |       Final Memory Usage | Shutdown Time |
------------------------------- + ------------ + ------------------------ + --------------- + ----------------- + ------------------------ + ------------- |
         quarkus-simple-api-jvm |       2217ms |  69.08MiB/256MiB(26.98%) |             10s |                7s |  118.8MiB/256MiB(46.39%) |            1s |
       micronaut-simple-api-jvm |       2424ms |  84.36MiB/256MiB(32.95%) |             15s |                6s |  240.5MiB/256MiB(93.94%) |            1s |
      springboot-simple-api-jvm |       4513ms |  124.6MiB/256MiB(48.68%) |             12s |                6s |  172.5MiB/256MiB(67.37%) |            3s |
      quarkus-simple-api-native |         37ms |   5.602MiB/256MiB(2.19%) |              6s |                6s |  32.59MiB/256MiB(12.73%) |            1s |
    micronaut-simple-api-native |         56ms |   9.164MiB/256MiB(3.58%) |              6s |                5s |  158.7MiB/256MiB(62.01%) |            1s |
   springboot-simple-api-native |        235ms |  29.16MiB/256MiB(11.39%) |              8s |                6s |  101.5MiB/256MiB(39.63%) |            3s |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
           quarkus-book-api-jvm |       3919ms |  123.2MiB/256MiB(48.11%) |             14s |                7s |  176.7MiB/256MiB(69.01%) |            1s |
         micronaut-book-api-jvm |       4840ms |  180.6MiB/256MiB(70.55%) |             19s |                9s |  232.4MiB/256MiB(90.78%) |            1s |
        springboot-book-api-jvm |       6648ms |  166.7MiB/256MiB(65.11%) |             16s |               11s |    237MiB/256MiB(92.59%) |            3s |
        quarkus-book-api-native |         65ms |    8.68MiB/256MiB(3.39%) |              7s |                7s |  41.28MiB/256MiB(16.13%) |            1s |
      micronaut-book-api-native |        126ms |   21.17MiB/256MiB(8.27%) |              7s |                7s |  169.2MiB/256MiB(66.11%) |            0s |
     springboot-book-api-native |        302ms |  46.82MiB/256MiB(18.29%) |              8s |                8s |  119.3MiB/256MiB(46.60%) |            3s |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
       quarkus-producer-api-jvm |       3003ms |  107.8MiB/256MiB(42.10%) |             19s |               13s |  155.4MiB/256MiB(60.71%) |            1s |
     micronaut-producer-api-jvm |       2330ms |  99.73MiB/256MiB(38.96%) |             22s |               14s |  242.7MiB/256MiB(94.82%) |            1s |
    springboot-producer-api-jvm |       5427ms |  152.5MiB/256MiB(59.55%) |             17s |               13s |  200.7MiB/256MiB(78.40%) |            3s |
    quarkus-producer-api-native |         63ms |   8.109MiB/256MiB(3.17%) |             17s |               16s |  43.62MiB/256MiB(17.04%) |            1s |
  micronaut-producer-api-native |         53ms |   9.434MiB/256MiB(3.68%) |             11s |               11s |  171.9MiB/256MiB(67.13%) |            0s |
 springboot-producer-api-native |            - |                        - |               - |                 - |                        - |             - |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
       quarkus-consumer-api-jvm |       2766ms |  96.64MiB/256MiB(37.75%) |                                 12s |  122.8MiB/256MiB(47.98%) |            1s |
     micronaut-consumer-api-jvm |       3316ms |  141.3MiB/256MiB(55.20%) |                                  5s |  204.1MiB/256MiB(79.73%) |            1s |
    springboot-consumer-api-jvm |       5050ms |  160.3MiB/256MiB(62.62%) |                                  2s |  168.4MiB/256MiB(65.78%) |            3s |
    quarkus-consumer-api-native |         63ms |   9.812MiB/256MiB(3.83%) |                                  6s |  39.45MiB/256MiB(15.41%) |            1s |
  micronaut-consumer-api-native |        102ms |      13MiB/256MiB(5.08%) |                                  3s |  34.76MiB/256MiB(13.58%) |            1s |
 springboot-consumer-api-native |            - |                        - |                                   - |                        - |             - |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
      quarkus-elasticsearch-jvm |       2237ms |  74.43MiB/256MiB(29.07%) |             19s |               11s |  153.1MiB/256MiB(59.80%) |            0s |
    micronaut-elasticsearch-jvm |       2315ms |  96.41MiB/256MiB(37.66%) |             19s |               12s |  240.2MiB/256MiB(93.81%) |            1s |
   springboot-elasticsearch-jvm |       5988ms |  206.7MiB/256MiB(80.73%) |             17s |               11s |  241.8MiB/256MiB(94.43%) |            2s |
   quarkus-elasticsearch-native |         45ms |   5.926MiB/256MiB(2.31%) |             10s |                9s |  44.21MiB/256MiB(17.27%) |            0s |
 micronaut-elasticsearch-native |            - |                        - |               - |                 - |                        - |             - |
springboot-elasticsearch-native |        306ms |  92.25MiB/256MiB(36.04%) |              9s |                9s |  122.1MiB/256MiB(47.69%) |            3s |
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
