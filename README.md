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
| Micronaut   | 2.2.0        |
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
      micronaut-simple-api-jvm |             9s |         15171055 |               28s |             358MB |
     springboot-simple-api-jvm |             7s |         21673214 |               16s |             219MB |
.............................. + .............. + ................ + ................. + ................. |
          quarkus-book-api-jvm |            13s |           597231 |               12s |             350MB |
        micronaut-book-api-jvm |            13s |         34500773 |               20s |             378MB |
       springboot-book-api-jvm |             9s |         42534746 |               13s |             240MB |
.............................. + .............. + ................ + ................. + ................. |
      quarkus-producer-api-jvm |            12s |           542086 |               11s |             350MB |
    micronaut-producer-api-jvm |            10s |         26122066 |               20s |             369MB |
   springboot-producer-api-jvm |             7s |         35793868 |               13s |             233MB |
.............................. + .............. + ................ + ................. + ................. |
      quarkus-consumer-api-jvm |            11s |           518653 |               10s |             350MB |
    micronaut-consumer-api-jvm |            10s |         26104021 |               20s |             369MB |
   springboot-consumer-api-jvm |             8s |         35791204 |               11s |             233MB |
.............................. + .............. + ................ + ................. + ................. |
     quarkus-elasticsearch-jvm |            12s |           438923 |               16s |             358MB |
   micronaut-elasticsearch-jvm |            14s |         44830040 |               22s |             388MB |
  springboot-elasticsearch-jvm |             8s |         55297410 |               14s |             253MB |
```

Table below shows the results after running the script `collect-native-jar-docker-size-times.sh`
```
                    Application | Packaging Time | Jar Size (bytes) | Docker Build Time | Docker Image Size |
------------------------------- + -------------- + ---------------- + ----------------- + ----------------- |
      quarkus-simple-api-native |           197s |         34328768 |                4s |             137MB |
    micronaut-simple-api-native |             9s |         15171055 |              428s |            87.4MB |
   springboot-simple-api-native |             6s |         21673214 |              430s |            87.1MB |
............................... + .............. + ................ + ................. + ................. |
        quarkus-book-api-native |           350s |         76064976 |                6s |             179MB |
      micronaut-book-api-native |            15s |         34500773 |              474s |             123MB |
     springboot-book-api-native |             9s |         42534746 |              802s |             167MB |
............................... + .............. + ................ + ................. + ................. |
    quarkus-producer-api-native |           278s |         51356552 |                6s |             154MB |
  micronaut-producer-api-native |            10s |         26122066 |              350s |            97.9MB |
 springboot-producer-api-native |             7s |         35793868 |              697s |             112MB |
............................... + .............. + ................ + ................. + ................. |
    quarkus-consumer-api-native |           251s |         49271688 |                5s |             152MB |
  micronaut-consumer-api-native |            11s |         26104020 |              333s |            97.8MB |
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
         quarkus-simple-api-jvm |       2033ms |  61.36MiB/256MiB(23.97%) |             10s |                7s |  131.3MiB/256MiB(51.30%) |            1s |
       micronaut-simple-api-jvm |       2745ms |  89.72MiB/256MiB(35.05%) |             13s |                6s |  244.8MiB/256MiB(95.63%) |            1s |
      springboot-simple-api-jvm |       7842ms |  121.2MiB/256MiB(47.33%) |             12s |                7s |  157.5MiB/256MiB(61.51%) |            3s |
      quarkus-simple-api-native |         40ms |   4.777MiB/256MiB(1.87%) |              8s |                7s |  32.04MiB/256MiB(12.52%) |            1s |
    micronaut-simple-api-native |         49ms |   9.469MiB/256MiB(3.70%) |              7s |                5s |    157MiB/256MiB(61.33%) |            1s |
   springboot-simple-api-native |        215ms |   32.6MiB/256MiB(12.73%) |              7s |                5s |  100.2MiB/256MiB(39.12%) |            3s |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
           quarkus-book-api-jvm |       3446ms |  109.8MiB/256MiB(42.87%) |             15s |                9s |    165MiB/256MiB(64.45%) |            0s |
         micronaut-book-api-jvm |       6100ms |  179.8MiB/256MiB(70.25%) |             20s |               10s |  245.4MiB/256MiB(95.85%) |            1s |
        springboot-book-api-jvm |       9246ms |  175.5MiB/256MiB(68.54%) |             17s |               11s |  235.9MiB/256MiB(92.14%) |            2s |
        quarkus-book-api-native |         43ms |   7.184MiB/256MiB(2.81%) |              8s |                8s |   42.3MiB/256MiB(16.53%) |            1s |
      micronaut-book-api-native |        138ms |   21.65MiB/256MiB(8.46%) |              8s |                8s |  160.6MiB/256MiB(62.73%) |            1s |
     springboot-book-api-native |        384ms |  45.72MiB/256MiB(17.86%) |              9s |                9s |  115.4MiB/256MiB(45.08%) |            2s |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
       quarkus-producer-api-jvm |       4130ms |  102.4MiB/256MiB(40.01%) |             22s |               14s |  145.1MiB/256MiB(56.69%) |            1s |
     micronaut-producer-api-jvm |       2723ms |  91.25MiB/256MiB(35.64%) |             24s |               14s |  235.4MiB/256MiB(91.95%) |            0s |
    springboot-producer-api-jvm |       6381ms |  156.1MiB/256MiB(60.98%) |             20s |               15s |  214.2MiB/256MiB(83.67%) |            3s |
    quarkus-producer-api-native |         45ms |   7.008MiB/256MiB(2.74%) |             19s |               19s |   44.4MiB/256MiB(17.34%) |            0s |
  micronaut-producer-api-native |         73ms |   9.754MiB/256MiB(3.81%) |             14s |               11s |  159.2MiB/256MiB(62.20%) |            1s |
 springboot-producer-api-native |            - |                        - |               - |                 - |                        - |             - |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
       quarkus-consumer-api-jvm |       2741ms |  84.07MiB/256MiB(32.84%) |                                 11s |  128.6MiB/256MiB(50.22%) |            1s |
     micronaut-consumer-api-jvm |       3563ms |  145.3MiB/256MiB(56.76%) |                                  5s |  153.8MiB/256MiB(60.08%) |            1s |
    springboot-consumer-api-jvm |       7232ms |  152.3MiB/256MiB(59.49%) |                                  4s |  167.4MiB/256MiB(65.39%) |            3s |
    quarkus-consumer-api-native |         69ms |   8.203MiB/256MiB(3.20%) |                                  8s |  39.81MiB/256MiB(15.55%) |            1s |
  micronaut-consumer-api-native |         72ms |   13.57MiB/256MiB(5.30%) |                                  3s |  32.61MiB/256MiB(12.74%) |            0s |
 springboot-consumer-api-native |            - |                        - |               - |                 - |                        - |             - |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
      quarkus-elasticsearch-jvm |       2396ms |  82.95MiB/256MiB(32.40%) |             21s |               11s |  158.1MiB/256MiB(61.77%) |            1s |
    micronaut-elasticsearch-jvm |       2601ms |  87.15MiB/256MiB(34.04%) |             20s |               13s |  221.3MiB/256MiB(86.43%) |            1s |
   springboot-elasticsearch-jvm |       6395ms |  205.5MiB/256MiB(80.27%) |             17s |               12s |  232.2MiB/256MiB(90.70%) |            3s |
   quarkus-elasticsearch-native |         53ms |   5.113MiB/256MiB(2.00%) |             11s |               10s |  43.71MiB/256MiB(17.07%) |            0s |
 micronaut-elasticsearch-native |            - |                        - |               - |                 - |                        - |             - |
springboot-elasticsearch-native |        290ms |  87.62MiB/256MiB(34.23%) |             11s |               11s |  120.3MiB/256MiB(46.98%) |            2s |
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
