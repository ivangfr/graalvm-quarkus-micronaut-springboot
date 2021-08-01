# graalvm-quarkus-micronaut-springboot

The goal of this project is to compare some Java frameworks like: [`Quarkus`](https://quarkus.io/), [`Micronaut`](https://micronaut.io/) and [`Spring Boot`](https://docs.spring.io/spring-boot/docs/current/reference/htmlsingle/). For it, we will implement applications using those frameworks, build their JVM and Native Docker images and measure start-up times, memory footprint, etc.

## Examples

- ### [simple-api](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/simple-api#graalvm-quarkus-micronaut-springboot)
- ### [jpa-mysql](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/jpa-mysql#graalvm-quarkus-micronaut-springboot)
- ### [producer-consumer](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/producer-consumer#graalvm-quarkus-micronaut-springboot)
- ### [elasticsearch](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/elasticsearch#graalvm-quarkus-micronaut-springboot)

## Framework version

We are using the following Framework versions

| Framework   | Version     |
| ----------- | ----------- |
| Quarkus     | 2.1.0.Final |
| Micronaut   | 2.5.11      |
| Spring Boot | 2.5.3       |

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
        quarkus-simple-api-jvm |             5s |            15M |                4s |             385MB |
      micronaut-simple-api-jvm |             5s |            15M |               15s |             340MB |
     springboot-simple-api-jvm |            15s |            23M |               13s |             268MB |
.............................. + .............. + .............. + ................. + ................. |
         quarkus-jpa-mysql-jvm |             9s |            33M |                3s |             404MB |
       micronaut-jpa-mysql-jvm |             9s |            34M |               12s |             360MB |
      springboot-jpa-mysql-jvm |            20s |            42M |               11s |             290MB |
.............................. + .............. + .............. + ................. + ................. |
      quarkus-producer-api-jvm |             8s |            33M |                2s |             404MB |
    micronaut-producer-api-jvm |             9s |            29M |               12s |             354MB |
   springboot-producer-api-jvm |            18s |            34M |               10s |             282MB |
.............................. + .............. + .............. + ................. + ................. |
      quarkus-consumer-api-jvm |             7s |            31M |                3s |             402MB |
    micronaut-consumer-api-jvm |             7s |            29M |               11s |             354MB |
   springboot-consumer-api-jvm |            18s |            34M |               10s |             282MB |
.............................. + .............. + .............. + ................. + ................. |
     quarkus-elasticsearch-jvm |             8s |            40M |                3s |             412MB |
   micronaut-elasticsearch-jvm |            10s |            45M |               13s |             371MB |
  springboot-elasticsearch-jvm |            21s |            52M |               11s |             301MB |
```

Table below shows the results after running the script `collect-native-jar-docker-size-times.sh`
```
                    Application | Packaging Time | Packaging Size | Docker Build Time | Docker Image Size |
------------------------------- + -------------- + -------------- + ----------------- + ----------------- |
      quarkus-simple-api-native |           170s |            45M |                3s |             150MB |
    micronaut-simple-api-native |             6s |            16M |              224s |            86.8MB |
   springboot-simple-api-native |            16s |            23M |              604s |             129MB |
............................... + .............. + .............. + ................. + ................. |
       quarkus-jpa-mysql-native |           245s |            73M |                3s |             179MB |
     micronaut-jpa-mysql-native |             9s |            34M |              305s |             122MB |
    springboot-jpa-mysql-native |            23s |            42M |              766s |             170MB |
............................... + .............. + .............. + ................. + ................. |
    quarkus-producer-api-native |           219s |            65M |                4s |             171MB |
  micronaut-producer-api-native |             7s |            28M |              216s |             100MB |
 springboot-producer-api-native |            19s |            34M |              623s |             137MB |
............................... + .............. + .............. + ................. + ................. |
    quarkus-consumer-api-native |           205s |            61M |                4s |             167MB |
  micronaut-consumer-api-native |             7s |            29M |              215s |            99.9MB |
 springboot-consumer-api-native |            17s |            34M |              625s |             137MB |
............................... + .............. + .............. + ................. + ................. |
   quarkus-elasticsearch-native |           213s |            53M |                3s |             159MB |
 micronaut-elasticsearch-native |             9s |            44M |              295s |             103MB |
springboot-elasticsearch-native |            23s |            52M |             1021s |             177MB |
```

Finally, the following table shows the results after running the script `collect-ab-times-memory-usage.sh`
```
                    Application | Startup Time |     Initial Memory Usage | Ab Testing Time | Ab Testing Time 2 |       Final Memory Usage | Shutdown Time |
------------------------------- + ------------ + ------------------------ + --------------- + ----------------- + ------------------------ + ------------- |
         quarkus-simple-api-jvm |       1777ms |  64.45MiB/256MiB(25.17%) |              8s |                7s |  139.3MiB/256MiB(54.41%) |            1s |
       micronaut-simple-api-jvm |       6594ms |   79.8MiB/256MiB(31.17%) |             10s |                7s |  107.4MiB/256MiB(41.96%) |            1s |
      springboot-simple-api-jvm |       3916ms |    117MiB/256MiB(45.72%) |             11s |                7s |  189.9MiB/256MiB(74.17%) |            3s |
      quarkus-simple-api-native |         19ms |   5.277MiB/256MiB(2.06%) |              6s |                9s |  31.43MiB/256MiB(12.28%) |            1s |
    micronaut-simple-api-native |         24ms |   8.184MiB/256MiB(3.20%) |              4s |                5s |  157.7MiB/256MiB(61.59%) |            0s |
   springboot-simple-api-native |        123ms |   34.5MiB/256MiB(13.48%) |              5s |                5s |  105.8MiB/256MiB(41.34%) |            3s |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
          quarkus-jpa-mysql-jvm |       2737ms |    102MiB/256MiB(39.83%) |              9s |                5s |    158MiB/256MiB(61.71%) |            1s |
        micronaut-jpa-mysql-jvm |       8447ms |  106.7MiB/256MiB(41.69%) |              9s |                6s |    156MiB/256MiB(60.92%) |            1s |
       springboot-jpa-mysql-jvm |       5690ms |  194.9MiB/256MiB(76.13%) |              8s |                6s |  248.4MiB/256MiB(97.04%) |            3s |
       quarkus-jpa-mysql-native |         33ms |   7.375MiB/256MiB(2.88%) |              5s |                5s |  41.11MiB/256MiB(16.06%) |            0s |
     micronaut-jpa-mysql-native |         82ms |   20.14MiB/256MiB(7.87%) |              4s |                6s |  168.2MiB/256MiB(65.69%) |            1s |
    springboot-jpa-mysql-native |        221ms |     44MiB/256MiB(17.19%) |              5s |                5s |  115.2MiB/256MiB(45.00%) |            3s |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
       quarkus-producer-api-jvm |       2162ms |  88.39MiB/256MiB(34.53%) |             13s |               10s |  148.4MiB/256MiB(57.95%) |            1s |
     micronaut-producer-api-jvm |       6578ms |  83.14MiB/256MiB(32.48%) |             13s |               10s |    128MiB/256MiB(49.98%) |            1s |
    springboot-producer-api-jvm |       3699ms |  143.8MiB/256MiB(56.18%) |             11s |               10s |  201.5MiB/256MiB(78.70%) |            2s |
    quarkus-producer-api-native |         26ms |   7.621MiB/256MiB(2.98%) |              9s |                9s |  43.32MiB/256MiB(16.92%) |            0s |
  micronaut-producer-api-native |         37ms |   8.492MiB/256MiB(3.32%) |              9s |                9s |  171.2MiB/256MiB(66.86%) |            1s |
 springboot-producer-api-native |        194ms |  38.54MiB/256MiB(15.06%) |              7s |                8s |  111.1MiB/256MiB(43.38%) |            2s |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
       quarkus-consumer-api-jvm |       1732ms |  81.52MiB/256MiB(31.84%) |                                 17s |  107.1MiB/256MiB(41.85%) |            3s |
     micronaut-consumer-api-jvm |       2452ms |  84.48MiB/256MiB(33.00%) |                                  5s |  96.51MiB/256MiB(37.70%) |            1s |
    springboot-consumer-api-jvm |       3332ms |    144MiB/256MiB(56.26%) |                                  5s |  160.5MiB/256MiB(62.71%) |            3s |
    quarkus-consumer-api-native |         31ms |   8.824MiB/256MiB(3.45%) |                                 18s |  39.37MiB/256MiB(15.38%) |            3s |
  micronaut-consumer-api-native |      10050ms |   11.94MiB/256MiB(4.66%) |                                  4s |  35.04MiB/256MiB(13.69%) |            0s |
 springboot-consumer-api-native |        146ms |  38.74MiB/256MiB(15.13%) |                                  4s |  47.18MiB/256MiB(18.43%) |            3s |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
      quarkus-elasticsearch-jvm |       1816ms |  75.48MiB/256MiB(29.48%) |             10s |                7s |  140.2MiB/256MiB(54.78%) |            1s |
    micronaut-elasticsearch-jvm |       6648ms |  86.04MiB/256MiB(33.61%) |             10s |                7s |  136.9MiB/256MiB(53.47%) |            1s |
   springboot-elasticsearch-jvm |       4565ms |  205.2MiB/256MiB(80.17%) |             10s |                6s |  237.1MiB/256MiB(92.62%) |            3s |
   quarkus-elasticsearch-native |         23ms |   5.434MiB/256MiB(2.12%) |              6s |                6s |  41.93MiB/256MiB(16.38%) |            0s |
 micronaut-elasticsearch-native |            - |                          |               - |                 - |                        - |             - |
springboot-elasticsearch-native |        185ms |  90.85MiB/256MiB(35.49%) |              6s |                6s |  122.8MiB/256MiB(47.96%) |            2s |
```

**Comments**

- Comparing `Ab Testing Time` with `Ab Testing Time 2` columns, we can see that JVM was able to perform some runtime optimizations, making the JVM applications to perform faster on the second ab test run;

- Unable to collect running statistics for `micronaut-elasticsearch-native` See [Issues](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/elasticsearch/micronaut-elasticsearch#issues);

- `micronaut-producer-api-native` or `micronaut-consumer-api-native` has very slow startup time, 10s. See [Micronaut Core, issue #5206](https://github.com/micronaut-projects/micronaut-core/issues/5206);

- `quarkus-consumer-api-jvm` and `quarkus-consumer-api-native` are very slow consuming the messages compared to `Micronaut` and `Spring Boot` consumers;

- Checking the Final Memory Usage column, `Quarkus` native apps have better memory utilization (after load tests) than `Micronaut` and `Spring Boot` ones; In this experiment, we set **256MiB** the container limit memory. If we reduce the container limit memmory to **128MiB**, all `Micronaut` native apps will have memory issues. For `Quarkus` native apps, I was able to reduce the container limit memmory to even **64MiB**. Below it, the apps performance will degrade.

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
