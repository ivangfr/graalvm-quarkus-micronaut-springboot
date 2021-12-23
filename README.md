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
|-------------|-------------|
| Quarkus     | 2.6.0.Final |
| Micronaut   | 3.2.3       |
| Spring Boot | 2.6.2       |

## Prerequisites

- [`Java 11+`](https://www.oracle.com/java/technologies/downloads/#java11)
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
        quarkus-simple-api-jvm |             5s |            16M |                3s |             383MB |
      micronaut-simple-api-jvm |             5s |            15M |               17s |             341MB |
     springboot-simple-api-jvm |            14s |            23M |               15s |             268MB |
.............................. + .............. + .............. + ................. + ................. |
         quarkus-jpa-mysql-jvm |             8s |            34M |                3s |             402MB |
       micronaut-jpa-mysql-jvm |            10s |            33M |               13s |             361MB |
      springboot-jpa-mysql-jvm |            26s |            43M |               16s |             291MB |
.............................. + .............. + .............. + ................. + ................. |
      quarkus-producer-api-jvm |             8s |            33M |                4s |             401MB |
    micronaut-producer-api-jvm |             9s |            28M |               13s |             355MB |
   springboot-producer-api-jvm |            16s |            38M |               14s |             286MB |
.............................. + .............. + .............. + ................. + ................. |
      quarkus-consumer-api-jvm |             8s |            32M |                2s |             399MB |
    micronaut-consumer-api-jvm |             9s |            28M |               12s |             355MB |
   springboot-consumer-api-jvm |            15s |            37M |               11s |             284MB |
.............................. + .............. + .............. + ................. + ................. |
     quarkus-elasticsearch-jvm |             7s |            41M |                4s |             410MB |
   micronaut-elasticsearch-jvm |            10s |            47M |               14s |             375MB |
  springboot-elasticsearch-jvm |            17s |            54M |               12s |             303MB |
```

Table below shows the results after running the script `collect-native-jar-docker-size-times.sh`
```
                    Application | Packaging Time | Packaging Size | Docker Build Time | Docker Image Size |
------------------------------- + -------------- + -------------- + ----------------- + ----------------- |
      quarkus-simple-api-native |           174s |            44M |                3s |            84.9MB |
    micronaut-simple-api-native |             5s |            15M |              174s |            79.3MB |
   springboot-simple-api-native |            15s |            23M |              257s |             108MB |
............................... + .............. + .............. + ................. + ................. |
       quarkus-jpa-mysql-native |           263s |            82M |                6s |             124MB |
     micronaut-jpa-mysql-native |             9s |            34M |              249s |             119MB |
    springboot-jpa-mysql-native |            21s |            43M |              409s |             160MB |
............................... + .............. + .............. + ................. + ................. |
    quarkus-producer-api-native |           178s |            63M |                4s |             105MB |
  micronaut-producer-api-native |             7s |            28M |              193s |            96.5MB |
 springboot-producer-api-native |            16s |            38M |              305s |             134MB |
............................... + .............. + .............. + ................. + ................. |
    quarkus-consumer-api-native |           177s |            60M |                4s |             101MB |
  micronaut-consumer-api-native |             7s |            28M |              184s |            96.4MB |
 springboot-consumer-api-native |            16s |            37M |              280s |             112MB |
............................... + .............. + .............. + ................. + ................. |
   quarkus-elasticsearch-native |           190s |            52M |                6s |            93.4MB |
 micronaut-elasticsearch-native |             9s |            47M |              222s |            98.8MB |
springboot-elasticsearch-native |            17s |            54M |              370s |             135MB |
```

Finally, the following table shows the results after running the script `collect-ab-times-memory-usage.sh`
```
                    Application | Startup Time |     Initial Memory Usage | Ab Testing Time | Ab Testing Time 2 |       Final Memory Usage | Shutdown Time |
------------------------------- + ------------ + ------------------------ + --------------- + ----------------- + ------------------------ + ------------- |
         quarkus-simple-api-jvm |       1669ms |  79.35MiB/512MiB(15.50%) |              8s |                6s |  255.1MiB/512MiB(49.82%) |            0s |
       micronaut-simple-api-jvm |       1784ms |  81.09MiB/512MiB(15.84%) |             11s |                6s |  106.9MiB/512MiB(20.88%) |            1s |
      springboot-simple-api-jvm |       4211ms |  234.1MiB/512MiB(45.72%) |             13s |                8s |  413.9MiB/512MiB(80.84%) |            3s |
      quarkus-simple-api-native |         67ms |   6.594MiB/512MiB(1.29%) |              5s |                7s |  265.8MiB/512MiB(51.91%) |            1s |
    micronaut-simple-api-native |        112ms |    8.02MiB/512MiB(1.57%) |              7s |                8s |    392MiB/512MiB(76.56%) |            3s |
   springboot-simple-api-native |        192ms |   30.57MiB/512MiB(5.97%) |              5s |                8s |    277MiB/512MiB(54.11%) |            3s |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
          quarkus-jpa-mysql-jvm |       2892ms |  133.6MiB/512MiB(26.09%) |              8s |                5s |  316.9MiB/512MiB(61.90%) |            1s |
        micronaut-jpa-mysql-jvm |       4132ms |  102.1MiB/512MiB(19.95%) |             10s |                6s |  154.4MiB/512MiB(30.15%) |            0s |
       springboot-jpa-mysql-jvm |       6481ms |  365.1MiB/512MiB(71.32%) |             10s |                8s |    510MiB/512MiB(99.60%) |            2s |
       quarkus-jpa-mysql-native |        113ms |   10.26MiB/512MiB(2.00%) |              6s |                8s |  269.6MiB/512MiB(52.67%) |            1s |
     micronaut-jpa-mysql-native |        228ms |   18.42MiB/512MiB(3.60%) |              5s |                7s |  395.3MiB/512MiB(77.20%) |            0s |
    springboot-jpa-mysql-native |        314ms |     67MiB/512MiB(13.09%) |              5s |                6s |    283MiB/512MiB(55.27%) |            2s |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
       quarkus-producer-api-jvm |       2234ms |  110.8MiB/512MiB(21.63%) |             13s |                9s |  298.7MiB/512MiB(58.34%) |            1s |
     micronaut-producer-api-jvm |       1664ms |  74.06MiB/512MiB(14.46%) |             12s |               11s |  130.1MiB/512MiB(25.40%) |            0s |
    springboot-producer-api-jvm |       4570ms |  270.1MiB/512MiB(52.75%) |             14s |               12s |  511.8MiB/512MiB(99.95%) |            2s |
    quarkus-producer-api-native |         74ms |   9.434MiB/512MiB(1.84%) |              8s |               11s |  269.4MiB/512MiB(52.61%) |            1s |
  micronaut-producer-api-native |         73ms |   8.395MiB/512MiB(1.64%) |              9s |               10s |  394.3MiB/512MiB(77.01%) |            1s |
 springboot-producer-api-native |            - |                        - |               - |                 - |                        - |             - |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
       quarkus-consumer-api-jvm |       1887ms |    110MiB/512MiB(21.49%) |                                  8s |  246.4MiB/512MiB(48.12%) |            2s |
     micronaut-consumer-api-jvm |       3018ms |  83.06MiB/512MiB(16.22%) |                                  6s |  96.43MiB/512MiB(18.83%) |            1s |
    springboot-consumer-api-jvm |       4631ms |  256.4MiB/512MiB(50.07%) |                                  6s |  310.8MiB/512MiB(60.70%) |            3s |
    quarkus-consumer-api-native |        122ms |   10.77MiB/512MiB(2.10%) |                                  6s |    267MiB/512MiB(52.14%) |            3s |
  micronaut-consumer-api-native |         94ms |   11.37MiB/512MiB(2.22%) |                                  5s |  260.8MiB/512MiB(50.93%) |            0s |
 springboot-consumer-api-native |            - |                        - |                                   - |                        - |             - |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
      quarkus-elasticsearch-jvm |       1767ms |   93.5MiB/512MiB(18.26%) |             11s |                6s |  298.6MiB/512MiB(58.32%) |            0s |
    micronaut-elasticsearch-jvm |       2226ms |  66.09MiB/512MiB(12.91%) |             11s |                7s |  142.9MiB/512MiB(27.91%) |            1s |
   springboot-elasticsearch-jvm |       5354ms |  300.5MiB/512MiB(58.69%) |             10s |                7s |  485.5MiB/512MiB(94.82%) |            2s |
   quarkus-elasticsearch-native |         58ms |   7.023MiB/512MiB(1.37%) |              5s |                6s |  266.5MiB/512MiB(52.04%) |            0s |
 micronaut-elasticsearch-native |         55ms |    8.25MiB/512MiB(1.61%) |              7s |                7s |  395.3MiB/512MiB(77.21%) |            0s |
springboot-elasticsearch-native |            - |                        - |               - |                 - |                        - |             - |
```

**Comments**

- Comparing `Ab Testing Time` with `Ab Testing Time 2` columns, we can see that JVM was able to perform some runtime optimizations, making the JVM applications to perform faster on the second ab test run;

- `springboot-consumer-api-native` is not working, see [`Issues`](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/producer-consumer/springboot-producer-consumer#issues)

- `springboot-elasticsearch-native` is not working, see [`Issues`](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/elasticsearch/springboot-elasticsearch#issues)

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
