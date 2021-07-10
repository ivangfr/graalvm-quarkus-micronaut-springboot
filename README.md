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
| Quarkus     | 2.0.1.Final |
| Micronaut   | 2.5.8       |
| Spring Boot | 2.5.2       |

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
        quarkus-simple-api-jvm |             6s |            15M |                2s |             384MB |
      micronaut-simple-api-jvm |             5s |            16M |               10s |             340MB |
     springboot-simple-api-jvm |            14s |            23M |               13s |             268MB |
.............................. + .............. + .............. + ................. + ................. |
         quarkus-jpa-mysql-jvm |             9s |            33M |                3s |             403MB |
       micronaut-jpa-mysql-jvm |             8s |            34M |               10s |             360MB |
      springboot-jpa-mysql-jvm |            19s |            41M |               10s |             289MB |
.............................. + .............. + .............. + ................. + ................. |
      quarkus-producer-api-jvm |             8s |            34M |                2s |             404MB |
    micronaut-producer-api-jvm |             7s |            29M |               11s |             354MB |
   springboot-producer-api-jvm |            17s |            36M |                9s |             284MB |
.............................. + .............. + .............. + ................. + ................. |
      quarkus-consumer-api-jvm |             7s |            32M |                3s |             402MB |
    micronaut-consumer-api-jvm |             7s |            29M |               10s |             354MB |
   springboot-consumer-api-jvm |            16s |            36M |                9s |             284MB |
.............................. + .............. + .............. + ................. + ................. |
     quarkus-elasticsearch-jvm |             8s |            40M |                3s |             411MB |
   micronaut-elasticsearch-jvm |             9s |            44M |               10s |             371MB |
  springboot-elasticsearch-jvm |            17s |            52M |               11s |             300MB |
```

Table below shows the results after running the script `collect-native-jar-docker-size-times.sh`
```
                    Application | Packaging Time | Packaging Size | Docker Build Time | Docker Image Size |
------------------------------- + -------------- + -------------- + ----------------- + ----------------- |
      quarkus-simple-api-native |           172s |            44M |                4s |             150MB |
    micronaut-simple-api-native |             5s |            15M |              228s |            86.7MB |
   springboot-simple-api-native |            13s |            23M |              603s |             129MB |
............................... + .............. + .............. + ................. + ................. |
       quarkus-jpa-mysql-native |           254s |            73M |                3s |             179MB |
     micronaut-jpa-mysql-native |             8s |            34M |              313s |             122MB |
    springboot-jpa-mysql-native |            19s |            41M |              758s |             169MB |
............................... + .............. + .............. + ................. + ................. |
    quarkus-producer-api-native |           230s |            65M |                3s |             171MB |
  micronaut-producer-api-native |             7s |            29M |              223s |             100MB |
 springboot-producer-api-native |            17s |            36M |              651s |             136MB |
............................... + .............. + .............. + ................. + ................. |
    quarkus-consumer-api-native |           217s |            61M |                4s |             167MB |
  micronaut-consumer-api-native |             7s |            29M |              222s |            99.9MB |
 springboot-consumer-api-native |            16s |            36M |              639s |             136MB |
............................... + .............. + .............. + ................. + ................. |
   quarkus-elasticsearch-native |           215s |            53M |                3s |             159MB |
 micronaut-elasticsearch-native |             8s |            45M |              280s |             103MB |
springboot-elasticsearch-native |            21s |            52M |              782s |             177MB |
```

Finally, the following table shows the results after running the script `collect-ab-times-memory-usage.sh`
```
                    Application | Startup Time |     Initial Memory Usage | Ab Testing Time | Ab Testing Time 2 |       Final Memory Usage | Shutdown Time |
------------------------------- + ------------ + ------------------------ + --------------- + ----------------- + ------------------------ + ------------- |
         quarkus-simple-api-jvm |       1604ms |  63.73MiB/256MiB(24.89%) |              8s |                6s |    117MiB/256MiB(45.71%) |            1s |
       micronaut-simple-api-jvm |       6587ms |  70.48MiB/256MiB(27.53%) |             10s |                8s |  102.6MiB/256MiB(40.06%) |            1s |
      springboot-simple-api-jvm |       2909ms |  125.9MiB/256MiB(49.19%) |             10s |                7s |  178.7MiB/256MiB(69.82%) |            2s |
      quarkus-simple-api-native |         20ms |   5.328MiB/256MiB(2.08%) |              6s |                7s |  31.91MiB/256MiB(12.46%) |            0s |
    micronaut-simple-api-native |         29ms |   8.031MiB/256MiB(3.14%) |              5s |                6s |  157.5MiB/256MiB(61.54%) |            1s |
   springboot-simple-api-native |        129ms |  34.39MiB/256MiB(13.43%) |              6s |                4s |  105.7MiB/256MiB(41.29%) |            2s |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
          quarkus-jpa-mysql-jvm |       2759ms |  104.7MiB/256MiB(40.89%) |              8s |                5s |    165MiB/256MiB(64.44%) |            1s |
        micronaut-jpa-mysql-jvm |       8434ms |  106.4MiB/256MiB(41.57%) |              9s |                6s |  157.4MiB/256MiB(61.47%) |            1s |
       springboot-jpa-mysql-jvm |       4827ms |  168.1MiB/256MiB(65.66%) |              8s |                6s |  229.4MiB/256MiB(89.61%) |            2s |
       quarkus-jpa-mysql-native |         37ms |   7.395MiB/256MiB(2.89%) |              5s |                5s |  40.86MiB/256MiB(15.96%) |            0s |
     micronaut-jpa-mysql-native |         75ms |   19.99MiB/256MiB(7.81%) |              4s |                5s |    168MiB/256MiB(65.61%) |            0s |
    springboot-jpa-mysql-native |        208ms |  44.67MiB/256MiB(17.45%) |              5s |                6s |    115MiB/256MiB(44.94%) |            3s |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
       quarkus-producer-api-jvm |       2169ms |  88.42MiB/256MiB(34.54%) |             13s |               10s |  148.9MiB/256MiB(58.18%) |            1s |
     micronaut-producer-api-jvm |       6594ms |  82.45MiB/256MiB(32.21%) |             13s |               10s |  128.5MiB/256MiB(50.19%) |            1s |
    springboot-producer-api-jvm |       3670ms |  140.5MiB/256MiB(54.89%) |             11s |                9s |    201MiB/256MiB(78.52%) |            3s |
    quarkus-producer-api-native |         32ms |   7.598MiB/256MiB(2.97%) |              8s |                8s |  44.28MiB/256MiB(17.30%) |            1s |
  micronaut-producer-api-native |         33ms |    8.34MiB/256MiB(3.26%) |              9s |                8s |  170.5MiB/256MiB(66.61%) |            0s |
 springboot-producer-api-native |        209ms |  38.47MiB/256MiB(15.03%) |              8s |                9s |  111.2MiB/256MiB(43.44%) |            2s |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
       quarkus-consumer-api-jvm |       1724ms |  82.93MiB/256MiB(32.39%) |                                 17s |  118.6MiB/256MiB(46.33%) |            3s |
     micronaut-consumer-api-jvm |       2219ms |  90.47MiB/256MiB(35.34%) |                                  2s |  95.84MiB/256MiB(37.44%) |            0s |
    springboot-consumer-api-jvm |       3305ms |  150.1MiB/256MiB(58.62%) |                                  6s |  159.4MiB/256MiB(62.25%) |            2s |
    quarkus-consumer-api-native |         32ms |   8.773MiB/256MiB(3.43%) |                                 17s |  40.38MiB/256MiB(15.77%) |            3s |
  micronaut-consumer-api-native |      10064ms |   11.82MiB/256MiB(4.62%) |                                  3s |     35MiB/256MiB(13.67%) |            1s |
 springboot-consumer-api-native |        140ms |  38.71MiB/256MiB(15.12%) |                                  4s |  47.35MiB/256MiB(18.50%) |            4s |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
      quarkus-elasticsearch-jvm |       1811ms |  75.83MiB/256MiB(29.62%) |             10s |                6s |  141.4MiB/256MiB(55.23%) |            0s |
    micronaut-elasticsearch-jvm |       6564ms |  86.97MiB/256MiB(33.97%) |             10s |                7s |  135.9MiB/256MiB(53.09%) |            1s |
   springboot-elasticsearch-jvm |       4033ms |  194.2MiB/256MiB(75.84%) |             10s |                6s |  235.3MiB/256MiB(91.91%) |            2s |
   quarkus-elasticsearch-native |         18ms |   5.484MiB/256MiB(2.14%) |              6s |                6s |  42.05MiB/256MiB(16.43%) |            0s |
 micronaut-elasticsearch-native |            - |                        - |               - |                 - |                        - |             - |
springboot-elasticsearch-native |        176ms |  90.65MiB/256MiB(35.41%) |              6s |                5s |  123.5MiB/256MiB(48.26%) |            3s |
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
