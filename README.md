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
| Quarkus     | 1.13.6.Final |
| Micronaut   | 2.5.4        |
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
      micronaut-simple-api-jvm |             5s |            16M |               16s |             340MB |
     springboot-simple-api-jvm |             8s |            20M |               21s |             267MB |
.............................. + .............. + .............. + ................. + ................. |
         quarkus-jpa-mysql-jvm |             8s |            32M |                2s |             403MB |
       micronaut-jpa-mysql-jvm |            10s |            34M |               16s |             360MB |
      springboot-jpa-mysql-jvm |            11s |            41M |               19s |             291MB |
.............................. + .............. + .............. + ................. + ................. |
      quarkus-producer-api-jvm |             8s |            35M |                2s |             405MB |
    micronaut-producer-api-jvm |             8s |            28M |               13s |             354MB |
   springboot-producer-api-jvm |             9s |            32M |               18s |             282MB |
.............................. + .............. + .............. + ................. + ................. |
      quarkus-consumer-api-jvm |             7s |            33M |                2s |             403MB |
    micronaut-consumer-api-jvm |             8s |            28M |               12s |             354MB |
   springboot-consumer-api-jvm |            10s |            32M |               17s |             282MB |
.............................. + .............. + .............. + ................. + ................. |
     quarkus-elasticsearch-jvm |             8s |            41M |                3s |             411MB |
   micronaut-elasticsearch-jvm |            13s |            44M |               15s |             371MB |
  springboot-elasticsearch-jvm |            10s |            51M |               19s |             301MB |
```

Table below shows the results after running the script `collect-native-jar-docker-size-times.sh`
```
                    Application | Packaging Time | Packaging Size | Docker Build Time | Docker Image Size |
------------------------------- + -------------- + -------------- + ----------------- + ----------------- |
      quarkus-simple-api-native |           130s |            33M |                4s |             137MB |
    micronaut-simple-api-native |             6s |            15M |              244s |            86.7MB |
   springboot-simple-api-native |             8s |            20M |              638s |              84MB |
............................... + .............. + .............. + ................. + ................. |
       quarkus-jpa-mysql-native |           239s |            71M |                4s |             178MB |
     micronaut-jpa-mysql-native |             9s |            33M |                9s |             122MB |
    springboot-jpa-mysql-native |            10s |            41M |              711s |             162MB |
............................... + .............. + .............. + ................. + ................. |
    quarkus-producer-api-native |           189s |            54M |                5s |             160MB |
  micronaut-producer-api-native |             8s |            29M |              272s |             100MB |
 springboot-producer-api-native |            10s |            32M |             1099s |             118MB |
............................... + .............. + .............. + ................. + ................. |
    quarkus-consumer-api-native |           187s |            51M |                4s |             156MB |
  micronaut-consumer-api-native |             7s |            28M |              265s |            99.8MB |
 springboot-consumer-api-native |             9s |            32M |              588s |             118MB |
............................... + .............. + .............. + ................. + ................. |
   quarkus-elasticsearch-native |           202s |            53M |                4s |             158MB |
 micronaut-elasticsearch-native |            10s |            44M |              315s |             103MB |
springboot-elasticsearch-native |            12s |            51M |              852s |             165MB |
```

Finally, the following table shows the results after running the script `collect-ab-times-memory-usage.sh`
```
                    Application | Startup Time |     Initial Memory Usage | Ab Testing Time | Ab Testing Time 2 |       Final Memory Usage | Shutdown Time |
------------------------------- + ------------ + ------------------------ + --------------- + ----------------- + ------------------------ + ------------- |
         quarkus-simple-api-jvm |       1486ms |  53.18MiB/256MiB(20.77%) |              8s |                6s |  102.7MiB/256MiB(40.13%) |            1s |
       micronaut-simple-api-jvm |       6687ms |  70.21MiB/256MiB(27.42%) |             10s |                7s |  103.2MiB/256MiB(40.33%) |            2s |
      springboot-simple-api-jvm |       3006ms |  120.5MiB/256MiB(47.07%) |             11s |                5s |  162.3MiB/256MiB(63.39%) |            3s |
      quarkus-simple-api-native |         25ms |   4.512MiB/256MiB(1.76%) |              7s |                8s |  31.66MiB/256MiB(12.37%) |            1s |
    micronaut-simple-api-native |         25ms |   8.125MiB/256MiB(3.17%) |              5s |                9s |  158.6MiB/256MiB(61.96%) |            2s |
   springboot-simple-api-native |        106ms |  28.75MiB/256MiB(11.23%) |              6s |                6s |  100.9MiB/256MiB(39.41%) |            4s |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
          quarkus-jpa-mysql-jvm |       2746ms |  107.5MiB/256MiB(41.98%) |              8s |                5s |  163.7MiB/256MiB(63.96%) |            2s |
        micronaut-jpa-mysql-jvm |       8477ms |  106.6MiB/256MiB(41.62%) |              8s |                6s |  154.5MiB/256MiB(60.35%) |            2s |
       springboot-jpa-mysql-jvm |       5092ms |  167.8MiB/256MiB(65.53%) |              8s |                6s |  222.6MiB/256MiB(86.96%) |            3s |
       quarkus-jpa-mysql-native |         34ms |   7.215MiB/256MiB(2.82%) |              4s |                5s |   41.2MiB/256MiB(16.09%) |            2s |
     micronaut-jpa-mysql-native |         59ms |   19.95MiB/256MiB(7.79%) |              4s |                6s |  168.6MiB/256MiB(65.87%) |            2s |
    springboot-jpa-mysql-native |        191ms |  44.25MiB/256MiB(17.28%) |              6s |                6s |  114.3MiB/256MiB(44.63%) |            4s |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
       quarkus-producer-api-jvm |       2053ms |  87.05MiB/256MiB(34.00%) |             15s |               11s |  158.2MiB/256MiB(61.78%) |            1s |
     micronaut-producer-api-jvm |       6757ms |  64.25MiB/256MiB(25.10%) |             13s |               10s |  131.3MiB/256MiB(51.31%) |            1s |
    springboot-producer-api-jvm |       3872ms |  144.9MiB/256MiB(56.59%) |             12s |               10s |  187.9MiB/256MiB(73.40%) |            3s |
    quarkus-producer-api-native |         30ms |   6.645MiB/256MiB(2.60%) |             11s |               12s |  41.03MiB/256MiB(16.03%) |            2s |
  micronaut-producer-api-native |       9992ms |   8.441MiB/256MiB(3.30%) |              9s |                9s |  170.9MiB/256MiB(66.77%) |            1s |
 springboot-producer-api-native |        187ms |  36.33MiB/256MiB(14.19%) |              8s |                8s |  109.3MiB/256MiB(42.69%) |            4s |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
       quarkus-consumer-api-jvm |       1737ms |   79.5MiB/256MiB(31.05%) |                                  7s |  119.4MiB/256MiB(46.63%) |            5s |
     micronaut-consumer-api-jvm |       2319ms |  84.11MiB/256MiB(32.86%) |                                  4s |   95.8MiB/256MiB(37.42%) |            2s |
    springboot-consumer-api-jvm |       3722ms |  145.6MiB/256MiB(56.88%) |                                  3s |  155.9MiB/256MiB(60.89%) |            4s |
    quarkus-consumer-api-native |         27ms |   7.434MiB/256MiB(2.90%) |                                  5s |  39.05MiB/256MiB(15.25%) |            4s |
  micronaut-consumer-api-native |         40ms |   11.81MiB/256MiB(4.61%) |                                  4s |  35.19MiB/256MiB(13.75%) |            1s |
 springboot-consumer-api-native |        139ms |  42.53MiB/256MiB(16.61%) |                                  3s |  44.36MiB/256MiB(17.33%) |            4s |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
      quarkus-elasticsearch-jvm |       1727ms |  66.61MiB/256MiB(26.02%) |             11s |                7s |  136.7MiB/256MiB(53.40%) |            1s |
    micronaut-elasticsearch-jvm |       6685ms |  67.16MiB/256MiB(26.23%) |             10s |                7s |  137.3MiB/256MiB(53.62%) |            2s |
   springboot-elasticsearch-jvm |       4605ms |  195.3MiB/256MiB(76.31%) |              9s |                7s |  230.9MiB/256MiB(90.21%) |            4s |
   quarkus-elasticsearch-native |         18ms |   4.809MiB/256MiB(1.88%) |              6s |                6s |  39.46MiB/256MiB(15.41%) |            1s |
 micronaut-elasticsearch-native |            - |                          |               - |                 - |                        - |             - |
springboot-elasticsearch-native |        159ms |  90.16MiB/256MiB(35.22%) |              6s |                6s |  122.9MiB/256MiB(48.03%) |            3s |
```

**Comments**

- Unable to collect running statistics for `micronaut-elasticsearch-native` See [Issues](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/elasticsearch/micronaut-elasticsearch#issues)

- `micronaut-producer-api-native` or `micronaut-consumer-api-native` has very slow startup time, 10s. See [Micronaut Core, issue #5206](https://github.com/micronaut-projects/micronaut-core/issues/5206)

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
