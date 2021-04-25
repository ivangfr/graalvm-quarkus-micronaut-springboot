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
        quarkus-simple-api-jvm |             6s |            14M |                2s |             383MB |
      micronaut-simple-api-jvm |             5s |            16M |               17s |             359MB |
     springboot-simple-api-jvm |             8s |            20M |               15s |             268MB |
.............................. + .............. + .............. + ................. + ................. |
         quarkus-jpa-mysql-jvm |             9s |            32M |                2s |             402MB |
       micronaut-jpa-mysql-jvm |             9s |            34M |               13s |             378MB |
      springboot-jpa-mysql-jvm |            10s |            43M |               21s |             293MB |
.............................. + .............. + .............. + ................. + ................. |
      quarkus-producer-api-jvm |             7s |            35M |                3s |             405MB |
    micronaut-producer-api-jvm |             7s |            28M |               13s |             372MB |
   springboot-producer-api-jvm |             9s |            32M |               17s |             282MB |
.............................. + .............. + .............. + ................. + ................. |
      quarkus-consumer-api-jvm |             7s |            33M |                2s |             403MB |
    micronaut-consumer-api-jvm |             7s |            28M |               12s |             371MB |
   springboot-consumer-api-jvm |              - |              - |                 - |                 - |
.............................. + .............. + .............. + ................. + ................. |
     quarkus-elasticsearch-jvm |             7s |            41M |                4s |             411MB |
   micronaut-elasticsearch-jvm |             9s |            44M |               13s |             389MB |
  springboot-elasticsearch-jvm |            12s |            51M |               22s |             301MB |
```

Table below shows the results after running the script `collect-native-jar-docker-size-times.sh`
```
                    Application | Packaging Time | Packaging Size | Docker Build Time | Docker Image Size |
------------------------------- + -------------- + -------------- + ----------------- + ----------------- |
      quarkus-simple-api-native |           467s |            33M |                3s |             137MB |
    micronaut-simple-api-native |             5s |            15M |              223s |            87.2MB |
   springboot-simple-api-native |             7s |            20M |              625s |              84MB |
............................... + .............. + .............. + ................. + ................. |
       quarkus-jpa-mysql-native |           248s |            71M |                4s |             178MB |
     micronaut-jpa-mysql-native |             9s |            34M |              333s |             124MB |
    springboot-jpa-mysql-native |            10s |            43M |              788s |             190MB |
............................... + .............. + .............. + ................. + ................. |
    quarkus-producer-api-native |           214s |            55M |                3s |             160MB |
  micronaut-producer-api-native |             8s |            28M |              241s |            98.6MB |
 springboot-producer-api-native |             9s |            32M |              606s |             118MB |
............................... + .............. + .............. + ................. + ................. |
    quarkus-consumer-api-native |           197s |            51M |                2s |             156MB |
  micronaut-consumer-api-native |             7s |            27M |              240s |            98.4MB |
 springboot-consumer-api-native |              - |              - |                 - |                 - |
............................... + .............. + .............. + ................. + ................. |
   quarkus-elasticsearch-native |           205s |            53M |                2s |             158MB |
 micronaut-elasticsearch-native |              - |              - |                 - |                 - |
springboot-elasticsearch-native |            10s |            51M |              674s |             164MB |
```

Finally, the following table shows the results after running the script `collect-ab-times-memory-usage.sh`
```
                    Application | Startup Time |     Initial Memory Usage | Ab Testing Time | Ab Testing Time 2 |       Final Memory Usage | Shutdown Time |
------------------------------- + ------------ + ------------------------ + --------------- + ----------------- + ------------------------ + ------------- |
         quarkus-simple-api-jvm |       1525ms |  53.52MiB/256MiB(20.90%) |              9s |                7s |  96.16MiB/256MiB(37.56%) |            1s |
       micronaut-simple-api-jvm |       6590ms |  80.44MiB/256MiB(31.42%) |             10s |                6s |  204.3MiB/256MiB(79.82%) |            0s |
      springboot-simple-api-jvm |       3348ms |  116.4MiB/256MiB(45.47%) |             10s |                7s |    170MiB/256MiB(66.40%) |            2s |
      quarkus-simple-api-native |         22ms |   4.312MiB/256MiB(1.68%) |              5s |                6s |  30.28MiB/256MiB(11.83%) |            0s |
    micronaut-simple-api-native |         27ms |   8.516MiB/256MiB(3.33%) |              5s |                6s |  94.43MiB/256MiB(36.89%) |            0s |
   springboot-simple-api-native |        129ms |  29.86MiB/256MiB(11.66%) |              5s |                5s |  100.5MiB/256MiB(39.28%) |            2s |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
          quarkus-jpa-mysql-jvm |       2855ms |    101MiB/256MiB(39.45%) |             11s |                6s |  157.9MiB/256MiB(61.69%) |            1s |
        micronaut-jpa-mysql-jvm |       9083ms |  157.7MiB/256MiB(61.61%) |             12s |                7s |  250.5MiB/256MiB(97.84%) |            0s |
       springboot-jpa-mysql-jvm |       5986ms |    166MiB/256MiB(64.85%) |             13s |                8s |  225.5MiB/256MiB(88.10%) |            2s |
       quarkus-jpa-mysql-native |         29ms |   6.977MiB/256MiB(2.73%) |              7s |                6s |  39.47MiB/256MiB(15.42%) |            0s |
     micronaut-jpa-mysql-native |         72ms |   20.56MiB/256MiB(8.03%) |              6s |                7s |    103MiB/256MiB(40.23%) |            1s |
    springboot-jpa-mysql-native |        176ms |  47.23MiB/256MiB(18.45%) |              7s |                7s |  118.7MiB/256MiB(46.37%) |            2s |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
       quarkus-producer-api-jvm |       2595ms |  89.04MiB/256MiB(34.78%) |             18s |               11s |  158.4MiB/256MiB(61.87%) |            1s |
     micronaut-producer-api-jvm |       6800ms |  88.54MiB/256MiB(34.59%) |             17s |               13s |  213.4MiB/256MiB(83.37%) |            1s |
    springboot-producer-api-jvm |       4382ms |  142.2MiB/256MiB(55.56%) |             16s |               12s |  185.6MiB/256MiB(72.49%) |            2s |
    quarkus-producer-api-native |         37ms |    6.43MiB/256MiB(2.51%) |             13s |               13s |  40.82MiB/256MiB(15.95%) |            0s |
  micronaut-producer-api-native |      10056ms |   8.809MiB/256MiB(3.44%) |             10s |               11s |  106.6MiB/256MiB(41.63%) |            0s |
 springboot-producer-api-native |        184ms |  37.08MiB/256MiB(14.49%) |             11s |                9s |  108.1MiB/256MiB(42.24%) |            3s |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
       quarkus-consumer-api-jvm |       1879ms |  79.75MiB/256MiB(31.15%) |                                  7s |  122.3MiB/256MiB(47.76%) |            4s |
     micronaut-consumer-api-jvm |       2498ms |    131MiB/256MiB(51.16%) |                                  4s |  144.2MiB/256MiB(56.33%) |            0s |
    springboot-consumer-api-jvm |            - |                        - |                                   - |                        - |             - |
    quarkus-consumer-api-native |         39ms |   7.219MiB/256MiB(2.82%) |                                  4s |  39.15MiB/256MiB(15.29%) |            4s |
  micronaut-consumer-api-native |         43ms |   12.17MiB/256MiB(4.75%) |                                  3s |  34.05MiB/256MiB(13.30%) |            1s |
 springboot-consumer-api-native |            - |                        - |                                   - |                        - |             - |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
      quarkus-elasticsearch-jvm |       1767ms |  64.08MiB/256MiB(25.03%) |             15s |                9s |  128.6MiB/256MiB(50.23%) |            1s |
    micronaut-elasticsearch-jvm |       6711ms |  87.47MiB/256MiB(34.17%) |             14s |                9s |  228.5MiB/256MiB(89.26%) |            1s |
   springboot-elasticsearch-jvm |       5443ms |    204MiB/256MiB(79.70%) |             13s |                9s |  243.7MiB/256MiB(95.20%) |            2s |
   quarkus-elasticsearch-native |         19ms |    4.57MiB/256MiB(1.79%) |              8s |                8s |  38.28MiB/256MiB(14.95%) |            1s |
 micronaut-elasticsearch-native |            - |                          |               - |                 - |                        - |             - |
springboot-elasticsearch-native |        168ms |  91.31MiB/256MiB(35.67%) |              8s |                7s |  121.6MiB/256MiB(47.51%) |            2s |

```

**Comments**

- Unable to run `springboot-consumer-api-jvm` and `springboot-consumer-api-native`. See [Issues](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/producer-consumer/springboot-producer-consumer#springboot-consumer-api-issues)

- Unable to build `micronaut-elasticsearch-native`. See [Issues](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/elasticsearch/micronaut-elasticsearch#issues)

- `micronaut-producer-api-native` or `micronaut-consumer-api-native` has very slow startup time, 10s [Micronaut Core, issue #5206](https://github.com/micronaut-projects/micronaut-core/issues/5206)

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
            quarkus-jpa-mysql-jvm | ab -p test-book.json -T 'application/json' -c 10 -n 2000 http://localhost:9086/api/books     |
          micronaut-jpa-mysql-jvm | ab -p test-book.json -T 'application/json' -c 10 -n 2000 http://localhost:9088/api/books     |
         springboot-jpa-mysql-jvm | ab -p test-book.json -T 'application/json' -c 10 -n 2000 http://localhost:9090/api/books     |
         quarkus-jpa-mysql-native | ab -p test-book.json -T 'application/json' -c 10 -n 2000 http://localhost:9087/api/books     |
       micronaut-jpa-mysql-native | ab -p test-book.json -T 'application/json' -c 10 -n 2000 http://localhost:9089/api/books     |
      springboot-jpa-mysql-native | ab -p test-book.json -T 'application/json' -c 10 -n 2000 http://localhost:9091/api/books     |       
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
