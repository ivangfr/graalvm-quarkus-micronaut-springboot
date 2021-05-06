# graalvm-quarkus-micronaut-springboot

The goal of this project is to compare some Java frameworks like: [`Quarkus`](https://quarkus.io/), [`Micronaut`](https://micronaut.io/) and [`Spring Boot`](https://docs.spring.io/spring-boot/docs/current/reference/htmlsingle/). For it, we will implement applications using those frameworks, build their JVM and Native Docker images and measure start-up times, memory footprint, etc.

## Examples

- ### [simple-api](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/simple-api#graalvm-quarkus-micronaut-springboot)
- ### [jpa-mysql](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/jpa-mysql#graalvm-quarkus-micronaut-springboot)
- ### [producer-consumer](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/producer-consumer#graalvm-quarkus-micronaut-springboot)
- ### [elasticsearch](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/elasticsearch#graalvm-quarkus-micronaut-springboot)

## Framework version

We are using the following Framework versions

| Framework   | Version      |
| ----------- | ------------ |
| Quarkus     | 1.13.3.Final |
| Micronaut   | 2.5.1        |
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
        quarkus-simple-api-jvm |             6s |            14M |                2s |             383MB |
      micronaut-simple-api-jvm |             5s |            16M |               16s |             359MB |
     springboot-simple-api-jvm |             8s |            20M |               21s |             267MB |
.............................. + .............. + .............. + ................. + ................. |
         quarkus-jpa-mysql-jvm |             8s |            32M |                2s |             403MB |
       micronaut-jpa-mysql-jvm |             9s |            34M |               11s |             378MB |
      springboot-jpa-mysql-jvm |            11s |            41M |               19s |             291MB |
.............................. + .............. + .............. + ................. + ................. |
      quarkus-producer-api-jvm |             8s |            35M |                2s |             405MB |
    micronaut-producer-api-jvm |             7s |            27M |               12s |             372MB |
   springboot-producer-api-jvm |             9s |            32M |               18s |             282MB |
.............................. + .............. + .............. + ................. + ................. |
      quarkus-consumer-api-jvm |             7s |            33M |                2s |             403MB |
    micronaut-consumer-api-jvm |             6s |            28M |               10s |             371MB |
   springboot-consumer-api-jvm |            10s |            32M |               17s |             282MB |
.............................. + .............. + .............. + ................. + ................. |
     quarkus-elasticsearch-jvm |             8s |            41M |                3s |             411MB |
   micronaut-elasticsearch-jvm |            11s |            45M |               12s |             389MB |
  springboot-elasticsearch-jvm |            10s |            51M |               19s |             301MB |
```

Table below shows the results after running the script `collect-native-jar-docker-size-times.sh`
```
                    Application | Packaging Time | Packaging Size | Docker Build Time | Docker Image Size |
------------------------------- + -------------- + -------------- + ----------------- + ----------------- |
      quarkus-simple-api-native |           130s |            33M |                4s |             137MB |
    micronaut-simple-api-native |             6s |            16M |              197s |            87.2MB |
   springboot-simple-api-native |             8s |            20M |              638s |              84MB |
............................... + .............. + .............. + ................. + ................. |
       quarkus-jpa-mysql-native |           239s |            71M |                4s |             178MB |
     micronaut-jpa-mysql-native |             9s |            34M |              309s |             124MB |
    springboot-jpa-mysql-native |            10s |            41M |              711s |             162MB |
............................... + .............. + .............. + ................. + ................. |
    quarkus-producer-api-native |           189s |            54M |                5s |             160MB |
  micronaut-producer-api-native |             7s |            28M |              216s |            98.6MB |
 springboot-producer-api-native |            10s |            32M |             1099s |             118MB |
............................... + .............. + .............. + ................. + ................. |
    quarkus-consumer-api-native |           187s |            51M |                4s |             156MB |
  micronaut-consumer-api-native |             7s |            27M |              213s |            98.4MB |
 springboot-consumer-api-native |             9s |            32M |              588s |             118MB |
............................... + .............. + .............. + ................. + ................. |
   quarkus-elasticsearch-native |           202s |            53M |                4s |             158MB |
 micronaut-elasticsearch-native |              - |              - |                 - |                 - |
springboot-elasticsearch-native |            12s |            51M |              852s |             165MB |
```

Finally, the following table shows the results after running the script `collect-ab-times-memory-usage.sh`
```
                    Application | Startup Time |     Initial Memory Usage | Ab Testing Time | Ab Testing Time 2 |       Final Memory Usage | Shutdown Time |
------------------------------- + ------------ + ------------------------ + --------------- + ----------------- + ------------------------ + ------------- |
         quarkus-simple-api-jvm |       1450ms |  53.12MiB/256MiB(20.75%) |              7s |                6s |  99.25MiB/256MiB(38.77%) |            2s |
       micronaut-simple-api-jvm |       6661ms |  102.9MiB/256MiB(40.21%) |             10s |                7s |  247.1MiB/256MiB(96.53%) |            2s |
      springboot-simple-api-jvm |       3225ms |  115.4MiB/256MiB(45.09%) |              8s |                8s |  170.1MiB/256MiB(66.46%) |            4s |
      quarkus-simple-api-native |         20ms |    4.52MiB/256MiB(1.77%) |              5s |                9s |  31.29MiB/256MiB(12.22%) |            2s |
    micronaut-simple-api-native |         26ms |   8.895MiB/256MiB(3.47%) |              5s |                6s |  160.8MiB/256MiB(62.80%) |            1s |
   springboot-simple-api-native |        104ms |  28.75MiB/256MiB(11.23%) |              5s |                5s |  101.1MiB/256MiB(39.48%) |            3s |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
          quarkus-jpa-mysql-jvm |       2731ms |  95.91MiB/256MiB(37.46%) |              8s |                5s |  165.3MiB/256MiB(64.59%) |            1s |
        micronaut-jpa-mysql-jvm |       8720ms |  167.9MiB/256MiB(65.58%) |              9s |                6s |    246MiB/256MiB(96.10%) |            1s |
       springboot-jpa-mysql-jvm |       4993ms |  160.9MiB/256MiB(62.86%) |              8s |                5s |  208.6MiB/256MiB(81.48%) |            4s |
       quarkus-jpa-mysql-native |         34ms |   7.223MiB/256MiB(2.82%) |              5s |                6s |  41.32MiB/256MiB(16.14%) |            1s |
     micronaut-jpa-mysql-native |         75ms |   21.09MiB/256MiB(8.24%) |              5s |                5s |  169.7MiB/256MiB(66.28%) |            2s |
    springboot-jpa-mysql-native |        189ms |  44.25MiB/256MiB(17.29%) |              5s |                5s |  114.3MiB/256MiB(44.63%) |            3s |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
       quarkus-producer-api-jvm |       2044ms |  87.13MiB/256MiB(34.04%) |             14s |               10s |  152.7MiB/256MiB(59.65%) |            2s |
     micronaut-producer-api-jvm |       6504ms |  91.48MiB/256MiB(35.73%) |             14s |               11s |  229.7MiB/256MiB(89.74%) |            1s |
    springboot-producer-api-jvm |       3801ms |    134MiB/256MiB(52.35%) |             12s |               10s |  199.4MiB/256MiB(77.89%) |            4s |
    quarkus-producer-api-native |         25ms |   6.656MiB/256MiB(2.60%) |             10s |               11s |  41.22MiB/256MiB(16.10%) |            2s |
  micronaut-producer-api-native |      10047ms |   9.227MiB/256MiB(3.60%) |              9s |                9s |  170.9MiB/256MiB(66.76%) |            1s |
 springboot-producer-api-native |        189ms |  36.86MiB/256MiB(14.40%) |              8s |                8s |  109.6MiB/256MiB(42.80%) |            4s |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
       quarkus-consumer-api-jvm |       1749ms |   79.3MiB/256MiB(30.98%) |                                  7s |  103.5MiB/256MiB(40.42%) |            4s |
     micronaut-consumer-api-jvm |       1977ms |  138.1MiB/256MiB(53.93%) |                                  2s |  159.4MiB/256MiB(62.28%) |            2s |
    springboot-consumer-api-jvm |       3659ms |  147.5MiB/256MiB(57.60%) |                                  4s |  157.4MiB/256MiB(61.48%) |            3s |
    quarkus-consumer-api-native |         30ms |   7.395MiB/256MiB(2.89%) |                                  5s |  40.05MiB/256MiB(15.64%) |            4s |
  micronaut-consumer-api-native |         42ms |   12.61MiB/256MiB(4.92%) |                                  4s |  34.92MiB/256MiB(13.64%) |            1s |
 springboot-consumer-api-native |        142ms |  44.01MiB/256MiB(17.19%) |                                  2s |  45.27MiB/256MiB(17.68%) |            3s |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
      quarkus-elasticsearch-jvm |       1702ms |  66.47MiB/256MiB(25.97%) |             11s |                6s |  127.5MiB/256MiB(49.80%) |            2s |
    micronaut-elasticsearch-jvm |       6661ms |  102.1MiB/256MiB(39.89%) |             12s |                7s |  221.5MiB/256MiB(86.52%) |            2s |
   springboot-elasticsearch-jvm |       4456ms |  201.5MiB/256MiB(78.71%) |              9s |                7s |  248.2MiB/256MiB(96.94%) |            4s |
   quarkus-elasticsearch-native |         18ms |   4.781MiB/256MiB(1.87%) |              7s |                6s |  42.17MiB/256MiB(16.47%) |            1s |
 micronaut-elasticsearch-native |            - |                          |               - |                 - |                        - |             - |
springboot-elasticsearch-native |        143ms |  90.16MiB/256MiB(35.22%) |              6s |                5s |  124.6MiB/256MiB(48.69%) |            4s |

```

**Comments**

- Unable to build `micronaut-elasticsearch-native`. See [Issues](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/elasticsearch/micronaut-elasticsearch#issues)

- `micronaut-producer-api-native` or `micronaut-consumer-api-native` has very slow startup time, 10s [Micronaut Core, issue #5206](https://github.com/micronaut-projects/micronaut-core/issues/5206)

- Checking the Final Memory Usage column, `Quarkus` native apps have better memory utilization (after load tests) than `Micronaut` and `Spring Boot` ones; In this experiment, we set **256MiB** the container limit memory. If we reduce the container limit memmory to **128MiB**, all `Micronaut` native apps will have memory issues. For `Quarkus` native apps, I was able to reduce the container limit memmory to even **64MiB**. Below it, the apps performance will degrade.

- Comparing `Ab Testing Time` with `Ab Testing Time 2` columns, we can see that JVM was able to perform some runtime optimizations, making the JVM applications to perform faster on the second ab test run.

- `ab` tests used
  ```
                      Application | ab Test                                                                                      |
  ------------------------------- + -------------------------------------------------------------------------------------------- |
           quarkus-simple-api-jvm | ab -c 10 -n 4000 http://localhost:9080/api/greeting?name=Ivan                                |
         micronaut-simple-api-jvm | ab -c 10 -n 4000 http://localhost:9082/api/greeting?name=Ivan                                |
        springboot-simple-api-jvm | ab -c 10 -n 4000 http://localhost:9084/api/greeting?name=Ivan                                |
        quarkus-simple-api-native | ab -c 10 -n 4000 http://localhost:9081/api/greeting?name=Ivan                                |
      micronaut-simple-api-native | ab -c 10 -n 4000 http://localhost:9083/api/greeting?name=Ivan                                |
     springboot-simple-api-native | ab -c 10 -n 4000 http://localhost:9085/api/greeting?name=Ivan                                |
  ............................... + ............................................................................................ |
            quarkus-jpa-mysql-jvm | ab -p test-book.json -T 'application/json' -c 10 -n 2000 http://localhost:9086/api/books     |
          micronaut-jpa-mysql-jvm | ab -p test-book.json -T 'application/json' -c 10 -n 2000 http://localhost:9088/api/books     |
         springboot-jpa-mysql-jvm | ab -p test-book.json -T 'application/json' -c 10 -n 2000 http://localhost:9090/api/books     |
         quarkus-jpa-mysql-native | ab -p test-book.json -T 'application/json' -c 10 -n 2000 http://localhost:9087/api/books     |
       micronaut-jpa-mysql-native | ab -p test-book.json -T 'application/json' -c 10 -n 2000 http://localhost:9089/api/books     |
      springboot-jpa-mysql-native | ab -p test-book.json -T 'application/json' -c 10 -n 2000 http://localhost:9091/api/books     |       
  ............................... + ............................................................................................ |
         quarkus-producer-api-jvm | ab -p test-news.json -T 'application/json' -c 10 -n 5000 http://localhost:9100/api/news      |
       micronaut-producer-api-jvm | ab -p test-news.json -T 'application/json' -c 10 -n 5000 http://localhost:9102/api/news      |
      springboot-producer-api-jvm | ab -p test-news.json -T 'application/json' -c 10 -n 5000 http://localhost:9104/api/news      |
      quarkus-producer-api-native | ab -p test-news.json -T 'application/json' -c 10 -n 5000 http://localhost:9101/api/news      |
    micronaut-producer-api-native | ab -p test-news.json -T 'application/json' -c 10 -n 5000 http://localhost:9103/api/news      |
   springboot-producer-api-native | ab -p test-news.json -T 'application/json' -c 10 -n 5000 http://localhost:9105/api/news      |
  ............................... + ............................................................................................ |
        quarkus-elasticsearch-jvm | ab -p test-movies.json -T 'application/json' -c 10 -n 2000 http://localhost:9112/api/movies  |
      micronaut-elasticsearch-jvm | ab -p test-movies.json -T 'application/json' -c 10 -n 2000 http://localhost:9114/api/movies  |
     springboot-elasticsearch-jvm | ab -p test-movies.json -T 'application/json' -c 10 -n 2000 http://localhost:9116/api/movies  |
     quarkus-elasticsearch-native | ab -p test-movies.json -T 'application/json' -c 10 -n 2000 http://localhost:9113/api/movies  |
   micronaut-elasticsearch-native | ab -p test-movies.json -T 'application/json' -c 10 -n 2000 http://localhost:9115/api/movies  |
  springboot-elasticsearch-native | ab -p test-movies.json -T 'application/json' -c 10 -n 2000 http://localhost:9117/api/movies  |
  ```
