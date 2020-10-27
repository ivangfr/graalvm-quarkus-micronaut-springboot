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
| Quarkus     | 1.9.0.Final   |
| Micronaut   | 2.1.2         |
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

  It starts docker container of all applications (JVM and Native), collecting data like: startup time, initial memory usage, time spent to run some ab tests for the first time and (after some warm up) for the second time, final memory usage and shutdown time.

## Comparison

The following table shows the results after running the script `collect-jvm-jar-docker-size-times.sh`
```
                   Application | Packaging Time | Jar Size (bytes) | Docker Build Time | Docker Image Size |
------------------------------ + -------------- + ---------------- + ----------------- + ----------------- |
        quarkus-simple-api-jvm |            11s |           389659 |               84s |             507MB |
      micronaut-simple-api-jvm |             9s |         15089367 |               19s |             213MB |
     springboot-simple-api-jvm |             6s |         21519413 |               13s |             219MB |
.............................. + .............. + ................ + ................. + ................. |
          quarkus-book-api-jvm |            18s |           582874 |               17s |             527MB |
        micronaut-book-api-jvm |            14s |         33247047 |               15s |             231MB |
       springboot-book-api-jvm |            10s |         42227196 |               16s |             238MB |
.............................. + .............. + ................ + ................. + ................. |
      quarkus-producer-api-jvm |            14s |           536268 |               16s |             526MB |
    micronaut-producer-api-jvm |            11s |         25636073 |               13s |             223MB |
   springboot-producer-api-jvm |             7s |         35567952 |               15s |             233MB |
.............................. + .............. + ................ + ................. + ................. |
      quarkus-consumer-api-jvm |            14s |           513561 |               16s |             526MB |
    micronaut-consumer-api-jvm |            10s |         25615851 |               13s |             223MB |
   springboot-consumer-api-jvm |             5s |         35565241 |               13s |             233MB |
.............................. + .............. + ................ + ................. + ................. |
     quarkus-elasticsearch-jvm |            13s |           438115 |               17s |             535MB |
   micronaut-elasticsearch-jvm |            15s |         44178890 |               17s |             242MB |
  springboot-elasticsearch-jvm |             8s |         52748039 |               16s |             248MB |
```

Table below shows the results after running the script `collect-native-jar-docker-size-times.sh`
```
                   Application | Packaging Time | Jar Size (bytes) | Docker Build Time | Docker Image Size |
------------------------------ + -------------- + ---------------- + ----------------- + ----------------- |
     quarkus-simple-api-native |           361s |         34988408 |                6s |             142MB |
   micronaut-simple-api-native |             9s |         15089368 |              372s |             102MB |
  springboot-simple-api-native |             6s |         21519413 |              510s |            81.3MB |
.............................. + .............. + ................ + ................. + ................. |
       quarkus-book-api-native |           534s |         92703064 |               10s |             200MB |
     micronaut-book-api-native |            15s |         33247052 |              550s |             155MB |
    springboot-book-api-native |            10s |         42227196 |             1013s |             169MB |
.............................. + .............. + ................ + ................. + ................. |
   quarkus-producer-api-native |           401s |         61420712 |                8s |             168MB |
 micronaut-producer-api-native |            10s |         25636073 |              392s |             122MB |
.............................. + .............. + ................ + ................. + ................. |
   quarkus-consumer-api-native |           317s |         49054600 |                9s |             156MB |
 micronaut-consumer-api-native |            10s |         25615845 |              391s |             122MB |
.............................. + .............. + ................ + ................. + ................. |
  quarkus-elasticsearch-native |           386s |         56264584 |                9s |             163MB |
micronaut-elasticsearch-native |            15s |         44178877 |              456s |             147MB |
```

Finally, the following table shows the results after running the script `collect-ab-times-memory-usage.sh`
```
                    Application | Startup Time |     Initial Memory Usage | Ab Testing Time | Ab Testing Time 2 |       Final Memory Usage | Shutdown Time |
 ------------------------------ + ------------ + ------------------------ + --------------- + ----------------- + ------------------------ + ------------- |
         quarkus-simple-api-jvm |       2876ms |  63.84MiB/256MiB(24.94%) |             10s |                7s |  124.7MiB/256MiB(48.72%) |            1s |
       micronaut-simple-api-jvm |       2347ms |  87.04MiB/256MiB(34.00%) |             12s |                5s |  152.5MiB/256MiB(59.57%) |            1s |
      springboot-simple-api-jvm |       3949ms |  119.4MiB/256MiB(46.64%) |             12s |                6s |  161.5MiB/256MiB(63.08%) |            3s |
      quarkus-simple-api-native |         59ms |   4.699MiB/256MiB(1.84%) |              7s |                5s |  31.92MiB/256MiB(12.47%) |            1s |
    micronaut-simple-api-native |         73ms |   8.438MiB/256MiB(3.30%) |              7s |                6s |  155.8MiB/256MiB(60.85%) |           11s |
   springboot-simple-api-native |        243ms |  28.27MiB/256MiB(11.04%) |              7s |                6s |   97.7MiB/256MiB(38.17%) |            3s |
 .............................. + ............ + ........................ + ............... + ................. + ........................ +  ............ |
           quarkus-book-api-jvm |       3316ms |  111.9MiB/256MiB(43.70%) |             16s |               11s |  167.6MiB/256MiB(65.46%) |            1s |
         micronaut-book-api-jvm |       4493ms |  137.2MiB/256MiB(53.61%) |             17s |               10s |  205.6MiB/256MiB(80.32%) |            1s |
        springboot-book-api-jvm |       6101ms |  171.3MiB/256MiB(66.93%) |             18s |               14s |    226MiB/256MiB(88.27%) |            3s |
        quarkus-book-api-native |         66ms |   7.305MiB/256MiB(2.85%) |             11s |               10s |  42.86MiB/256MiB(16.74%) |            0s |
      micronaut-book-api-native |        155ms |   19.36MiB/256MiB(7.56%) |             12s |                9s |  159.7MiB/256MiB(62.38%) |           11s |
     springboot-book-api-native |        433ms |  41.78MiB/256MiB(16.32%) |             15s |               12s |  110.8MiB/256MiB(43.28%) |            3s |
 .............................. + ............ + ........................ + ............... + ................. + ........................ +  ............ |
       quarkus-producer-api-jvm |       2850ms |  96.98MiB/256MiB(37.88%) |             18s |               15s |  156.5MiB/256MiB(61.15%) |            1s |
     micronaut-producer-api-jvm |       2469ms |  93.18MiB/256MiB(36.40%) |             20s |               12s |  173.7MiB/256MiB(67.85%) |            0s |
    springboot-producer-api-jvm |       5139ms |  162.5MiB/256MiB(63.46%) |             18s |               12s |  202.2MiB/256MiB(78.99%) |            3s |
    quarkus-producer-api-native |         54ms |   6.965MiB/256MiB(2.72%) |             13s |               14s |  45.65MiB/256MiB(17.83%) |            1s |
  micronaut-producer-api-native |         78ms |   8.898MiB/256MiB(3.48%) |             11s |               12s |    158MiB/256MiB(61.70%) |           10s |
 .............................. + ............ + ........................ + ............... + ................. + ........................ +  ............ |
       quarkus-consumer-api-jvm |       2606ms |  102.8MiB/256MiB(40.16%) |                                  9s |  128.9MiB/256MiB(50.36%) |            1s |
     micronaut-consumer-api-jvm |       2962ms |  118.6MiB/256MiB(46.32%) |                                  6s |  130.6MiB/256MiB(51.00%) |            1s |
    springboot-consumer-api-jvm |       4925ms |  157.1MiB/256MiB(61.38%) |                                  3s |  165.2MiB/256MiB(64.54%) |            2s |
    quarkus-consumer-api-native |         71ms |    8.02MiB/256MiB(3.13%) |                                  5s |  39.44MiB/256MiB(15.41%) |            0s |
  micronaut-consumer-api-native |         76ms |   12.52MiB/256MiB(4.89%) |                                  3s |  32.57MiB/256MiB(12.72%) |           11s |
 .............................. + ............ + ........................ + ............... + ................. + ........................ +  ............ |
      quarkus-elasticsearch-jvm |       2310ms |  86.04MiB/256MiB(33.61%) |             20s |               11s |  149.4MiB/256MiB(58.34%) |            0s |
    micronaut-elasticsearch-jvm |       2372ms |     95MiB/256MiB(37.11%) |             19s |               14s |  181.5MiB/256MiB(70.91%) |            1s |
   springboot-elasticsearch-jvm |       6162ms |  157.6MiB/256MiB(61.56%) |             16s |               12s |  208.3MiB/256MiB(81.37%) |            3s |
   quarkus-elasticsearch-native |         46ms |       5MiB/256MiB(1.95%) |             13s |               11s |  43.62MiB/256MiB(17.04%) |            1s |
 micronaut-elasticsearch-native |         77ms |   8.758MiB/256MiB(3.42%) |             12s |               11s |  159.6MiB/256MiB(62.36%) |           10s |
```

Comments:

- The shutdown of `Micronaut` native apps are taking around **10 seconds**;

- Checking the Final Memory Usage column, `Quarkus` native apps have better memory utilization (after load tests) than `Micronaut` ones; In this experiment, I set **256MiB** the container limit memory. If I reduce the container limit memmory to **128MiB**, all `Micronaut` native apps will have memory issues. For `Quarkus` native apps, I was able to reduce the container limit memmory to even **64MiB**. Below it, the apps performance will degrade.

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
