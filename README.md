# graalvm-quarkus-micronaut-springboot

The goal of this project is to compare some Java frameworks like: [`Quarkus`](https://quarkus.io/), [`Micronaut`](https://micronaut.io/) and [`Spring Boot`](https://docs.spring.io/spring-boot/docs/current/reference/htmlsingle/). For it, we will implement applications using those frameworks, build their JVM and Native Docker images and measure start-up times, memory footprint, etc.

## Examples

- ### [simple-api](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/simple-api#graalvm-quarkus-micronaut-springboot)
- ### [jpa-mysql](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/jpa-mysql#graalvm-quarkus-micronaut-springboot)
- ### [kafka](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/kafka#graalvm-quarkus-micronaut-springboot)
- ### [elasticsearch](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/elasticsearch#graalvm-quarkus-micronaut-springboot)

## Framework version

We are using the following Framework versions

| Framework   | Version     |
|-------------|-------------|
| Quarkus     | 3.0.1.Final |
| Micronaut   | 3.9.0       |
| Spring Boot | 3.0.6       |

## Prerequisites

- [`Java 17+`](https://www.oracle.com/java/technologies/downloads/#java17)
- [`Docker`](https://www.docker.com/)
- [`Docker-Compose`](https://docs.docker.com/compose/install/)

## Bash scripts

We've implemented three bash scripts that collect data used in the frameworks comparison.

- **collect-jvm-jar-docker-size-times.sh**
  
  It packages jar files and builds docker images of all JVM applications, collecting data like: jar packaging time, jar size, docker build time and docker image size.

- **collect-native-jar-docker-size-times.sh**

  It packages jar files and builds docker images of all Native applications, collecting data like: jar packaging time, jar size, docker build time and docker image size.
  
  > **Note**: On Mac and Windows, it's recommended to increase the memory allocated to Docker to at least 8G (and potentially to add more CPUs as well) since native-image compiler is a heavy process. On Linux, Docker uses by default the resources available on the host so no configuration is needed.

- **collect-ab-times-memory-usage.sh**

  It starts docker container of all applications (JVM and Native), collecting data like: startup time, initial memory usage, time spent to run ab tests for the first time and (after some warm up) for the second time, final memory usage and shutdown time.

## Comparison

The following table shows the results after running the script `collect-jvm-jar-docker-size-times.sh`
```
                   Application | Packaging Time | Packaging Size | Docker Build Time | Docker Image Size |
------------------------------ + -------------- + -------------- + ----------------- + ----------------- |
        quarkus-simple-api-jvm |            11s |            18M |                5s |             419MB |
      micronaut-simple-api-jvm |             6s |            16M |               15s |             342MB |
     springboot-simple-api-jvm |             4s |            24M |               14s |             292MB |
.............................. + .............. + .............. + ................. + ................. |
         quarkus-jpa-mysql-jvm |            10s |            39M |                1s |             442MB |
       micronaut-jpa-mysql-jvm |            14s |            36M |               12s |             363MB |
      springboot-jpa-mysql-jvm |             9s |            47M |               14s |             317MB |
.............................. + .............. + .............. + ................. + ................. |
    quarkus-kafka-producer-jvm |            12s |            35M |                3s |             437MB |
  micronaut-kafka-producer-jvm |            11s |            30M |               12s |             356MB |
 springboot-kafka-producer-jvm |             5s |            39M |               10s |             307MB |
.............................. + .............. + .............. + ................. + ................. |
    quarkus-kafka-consumer-jvm |            12s |            33M |                2s |             436MB |
  micronaut-kafka-consumer-jvm |            11s |            30M |               10s |             356MB |
 springboot-kafka-consumer-jvm |             3s |            37M |               10s |             306MB |
.............................. + .............. + .............. + ................. + ................. |
     quarkus-elasticsearch-jvm |            12s |            32M |                4s |             434MB |
   micronaut-elasticsearch-jvm |            10s |            58M |               13s |             386MB |
  springboot-elasticsearch-jvm |             3s |            40M |               10s |             308MB |
```

Table below shows the results after running the script `collect-native-jar-docker-size-times.sh`
```
                     Application | Packaging Time | Packaging Size | Docker Build Time | Docker Image Size |
-------------------------------- + -------------- + -------------- + ----------------- + ----------------- |
       quarkus-simple-api-native |           223s |            46M |               22s |             142MB |
     micronaut-simple-api-native |             7s |            17M |              166s |            86.2MB |
    springboot-simple-api-native |             4s |            24M |              581s |             106MB |
................................ + .............. + .............. + ................. + ................. |
        quarkus-jpa-mysql-native |           327s |            87M |                3s |             185MB |
      micronaut-jpa-mysql-native |            16s |            35M |              234s |             118MB |
     springboot-jpa-mysql-native |             7s |            47M |              689s |             169MB |
................................ + .............. + .............. + ................. + ................. |
   quarkus-kafka-producer-native |           252s |            65M |                2s |             162MB |
 micronaut-kafka-producer-native |            12s |            29M |              186s |            98.8MB |
springboot-kafka-producer-native |             5s |            39M |              495s |             137MB |
................................ + .............. + .............. + ................. + ................. |
   quarkus-kafka-consumer-native |           201s |            61M |                3s |             158MB |
 micronaut-kafka-consumer-native |            11s |            29M |              183s |            98.6MB |
springboot-kafka-consumer-native |             5s |            37M |              651s |             129MB |
................................ + .............. + .............. + ................. + ................. |
    quarkus-elasticsearch-native |           322s |            52M |                4s |             148MB |
  micronaut-elasticsearch-native |            12s |            58M |              227s |             106MB |
 springboot-elasticsearch-native |             4s |            40M |              592s |             123MB |
```

Finally, the following table shows the results after running the script `collect-ab-times-memory-usage.sh`

> **Note**: in order to have a better insight about the Docker container's CPU and Memory Usage, we can use [`cAdvisor`](https://github.com/google/cadvisor). In the section [Monitoring CPU and Memory with cAdvisor](#monitoring-cpu-and-memory-with-cadvisor), we explain how to start it.

```
                     Application | Startup Time |     Initial Memory Usage | Ab Testing Time | Ab Testing Time 2 |       Final Memory Usage | Shutdown Time |
-------------------------------- + ------------ + ------------------------ + --------------- + ----------------- + ------------------------ + ------------- |
          quarkus-simple-api-jvm |       1043ms |  72.76MiB/512MiB(14.21%) |              5s |                3s |  139.7MiB/512MiB(27.29%) |            0s |
        micronaut-simple-api-jvm |       6365ms |  80.53MiB/512MiB(15.73%) |              7s |                4s |    112MiB/512MiB(21.88%) |            1s |
       springboot-simple-api-jvm |       2453ms |  129.2MiB/512MiB(25.23%) |              8s |                5s |  178.9MiB/512MiB(34.94%) |            2s |
       quarkus-simple-api-native |         27ms |   6.918MiB/512MiB(1.35%) |              3s |                2s |  51.73MiB/512MiB(10.10%) |            0s |
     micronaut-simple-api-native |         37ms |   8.496MiB/512MiB(1.66%) |              2s |                4s |   23.16MiB/512MiB(4.52%) |            0s |
    springboot-simple-api-native |        111ms |   33.72MiB/512MiB(6.59%) |              4s |                4s |   40.28MiB/512MiB(7.87%) |            3s |
................................ + ............ + ........................ + ............... + ................. + ........................ + ............. |
           quarkus-jpa-mysql-jvm |       1668ms |  100.2MiB/512MiB(19.56%) |              7s |                3s |  175.2MiB/512MiB(34.22%) |            0s |
         micronaut-jpa-mysql-jvm |       8128ms |  108.8MiB/512MiB(21.25%) |              6s |                4s |  167.5MiB/512MiB(32.72%) |            1s |
        springboot-jpa-mysql-jvm |       3970ms |  198.2MiB/512MiB(38.70%) |              7s |                4s |  250.8MiB/512MiB(48.98%) |            2s |
        quarkus-jpa-mysql-native |         38ms |   9.672MiB/512MiB(1.89%) |              3s |                2s |   47.72MiB/512MiB(9.32%) |            0s |
      micronaut-jpa-mysql-native |         73ms |   21.44MiB/512MiB(4.19%) |              2s |                3s |   33.12MiB/512MiB(6.47%) |            1s |
     springboot-jpa-mysql-native |        182ms |  69.68MiB/512MiB(13.61%) |              2s |                3s |  104.3MiB/512MiB(20.37%) |            2s |
................................ + ............ + ........................ + ............... + ................. + ........................ + ............. |
      quarkus-kafka-producer-jvm |       1403ms |  95.18MiB/512MiB(18.59%) |             10s |                5s |  172.4MiB/512MiB(33.67%) |            1s |
    micronaut-kafka-producer-jvm |       6363ms |  83.84MiB/512MiB(16.38%) |              9s |                5s |  139.4MiB/512MiB(27.23%) |            1s |
   springboot-kafka-producer-jvm |       2679ms |  152.7MiB/512MiB(29.82%) |             11s |                5s |  209.4MiB/512MiB(40.89%) |            3s |
   quarkus-kafka-producer-native |         38ms |   10.26MiB/512MiB(2.00%) |              5s |                4s |   30.54MiB/512MiB(5.96%) |            1s |
 micronaut-kafka-producer-native |         40ms |   8.988MiB/512MiB(1.76%) |              6s |                4s |   32.53MiB/512MiB(6.35%) |            0s |
springboot-kafka-producer-native |        176ms |   42.75MiB/512MiB(8.35%) |              5s |                3s |   34.34MiB/512MiB(6.71%) |            3s |
................................ + ............ + ........................ + ............... + ................. + ........................ + ............. |
      quarkus-kafka-consumer-jvm |       1172ms |  76.51MiB/512MiB(14.94%) |                                  4s |  128.1MiB/512MiB(25.01%) |            3s |
    micronaut-kafka-consumer-jvm |       1999ms |  90.65MiB/512MiB(17.70%) |                                  2s |    111MiB/512MiB(21.68%) |            0s |
   springboot-kafka-consumer-jvm |       2353ms |  151.8MiB/512MiB(29.65%) |                                  2s |  162.8MiB/512MiB(31.81%) |            2s |
   quarkus-kafka-consumer-native |         40ms |   12.29MiB/512MiB(2.40%) |                                  3s |  74.84MiB/512MiB(14.62%) |            2s |
 micronaut-kafka-consumer-native |         53ms |   12.28MiB/512MiB(2.40%) |                                  1s |   58.3MiB/512MiB(11.39%) |            1s |
springboot-kafka-consumer-native |        100ms |  67.37MiB/512MiB(13.16%) |                                  1s |  69.11MiB/512MiB(13.50%) |            2s |
................................ + ............ + ........................ + ............... + ................. + ........................ + ............. |
       quarkus-elasticsearch-jvm |       1539ms |  85.18MiB/512MiB(16.64%) |              7s |                4s |  161.7MiB/512MiB(31.58%) |            0s |
     micronaut-elasticsearch-jvm |       6328ms |  79.77MiB/512MiB(15.58%) |              7s |                5s |  144.3MiB/512MiB(28.19%) |            0s |
    springboot-elasticsearch-jvm |       2699ms |  162.6MiB/512MiB(31.76%) |              7s |                5s |  228.1MiB/512MiB(44.56%) |            2s |
    quarkus-elasticsearch-native |         24ms |   7.094MiB/512MiB(1.39%) |              3s |                2s |   50.59MiB/512MiB(9.88%) |            0s |
  micronaut-elasticsearch-native |         39ms |   8.891MiB/512MiB(1.74%) |              4s |                5s |   31.85MiB/512MiB(6.22%) |            1s |
 springboot-elasticsearch-native |        107ms |   43.23MiB/512MiB(8.44%) |              4s |                3s |   44.76MiB/512MiB(8.74%) |            2s |
```

**Comments**

- Comparing `Ab Testing Time` with `Ab Testing Time 2` columns, we can see that JVM was able to perform some runtime optimizations, making the JVM applications to perform faster on the second ab test run;

- `ab` tests used
  ```
                       Application | ab Test                                                                                      |
  -------------------------------- + -------------------------------------------------------------------------------------------- |
            quarkus-simple-api-jvm | ab -c 10 -n 4000 'http://localhost:9080/api/greeting?name=Ivan'                              |
          micronaut-simple-api-jvm | ab -c 10 -n 4000 'http://localhost:9082/api/greeting?name=Ivan'                              |
         springboot-simple-api-jvm | ab -c 10 -n 4000 'http://localhost:9084/api/greeting?name=Ivan'                              |
         quarkus-simple-api-native | ab -c 10 -n 4000 'http://localhost:9081/api/greeting?name=Ivan'                              |
       micronaut-simple-api-native | ab -c 10 -n 4000 'http://localhost:9083/api/greeting?name=Ivan'                              |
      springboot-simple-api-native | ab -c 10 -n 4000 'http://localhost:9085/api/greeting?name=Ivan'                              |
  ................................ + ............................................................................................ |
             quarkus-jpa-mysql-jvm | ab -p test-book.json -T 'application/json' -c 10 -n 2000 http://localhost:9086/api/books     |
           micronaut-jpa-mysql-jvm | ab -p test-book.json -T 'application/json' -c 10 -n 2000 http://localhost:9088/api/books     |
          springboot-jpa-mysql-jvm | ab -p test-book.json -T 'application/json' -c 10 -n 2000 http://localhost:9090/api/books     |
          quarkus-jpa-mysql-native | ab -p test-book.json -T 'application/json' -c 10 -n 2000 http://localhost:9087/api/books     |
        micronaut-jpa-mysql-native | ab -p test-book.json -T 'application/json' -c 10 -n 2000 http://localhost:9089/api/books     |
       springboot-jpa-mysql-native | ab -p test-book.json -T 'application/json' -c 10 -n 2000 http://localhost:9091/api/books     |       
  ................................ + ............................................................................................ |
        quarkus-kafka-producer-jvm | ab -p test-news.json -T 'application/json' -c 10 -n 5000 http://localhost:9100/api/news      |
      micronaut-kafka-producer-jvm | ab -p test-news.json -T 'application/json' -c 10 -n 5000 http://localhost:9102/api/news      |
     springboot-kafka-producer-jvm | ab -p test-news.json -T 'application/json' -c 10 -n 5000 http://localhost:9104/api/news      |
     quarkus-kafka-producer-native | ab -p test-news.json -T 'application/json' -c 10 -n 5000 http://localhost:9101/api/news      |
   micronaut-kafka-producer-native | ab -p test-news.json -T 'application/json' -c 10 -n 5000 http://localhost:9103/api/news      |
  springboot-kafka-producer-native | ab -p test-news.json -T 'application/json' -c 10 -n 5000 http://localhost:9105/api/news      |
  ................................ + ............................................................................................ |
         quarkus-elasticsearch-jvm | ab -p test-movies.json -T 'application/json' -c 10 -n 2000 http://localhost:9112/api/movies  |
       micronaut-elasticsearch-jvm | ab -p test-movies.json -T 'application/json' -c 10 -n 2000 http://localhost:9114/api/movies  |
      springboot-elasticsearch-jvm | ab -p test-movies.json -T 'application/json' -c 10 -n 2000 http://localhost:9116/api/movies  |
      quarkus-elasticsearch-native | ab -p test-movies.json -T 'application/json' -c 10 -n 2000 http://localhost:9113/api/movies  |
    micronaut-elasticsearch-native | ab -p test-movies.json -T 'application/json' -c 10 -n 2000 http://localhost:9115/api/movies  |
   springboot-elasticsearch-native | ab -p test-movies.json -T 'application/json' -c 10 -n 2000 http://localhost:9117/api/movies  |
  ```

## Monitoring CPU and Memory with cAdvisor

- In a terminal, run the following command
  ```
  docker run -d --rm --name=cadvisor -p 8080:8080 \
    -v /:/rootfs:ro \
    -v /var/run:/var/run:ro \
    -v /sys:/sys:ro \
    -v /var/lib/docker/:/var/lib/docker:ro \
    -v /dev/disk/:/dev/disk:ro \
    -v /var/run/docker.sock:/var/run/docker.sock \
    --privileged \
    --device=/dev/kmsg \
    gcr.io/cadvisor/cadvisor:v0.47.1
  ```

- In a browser, access
  - http://localhost:8080/docker/ to explore the running containers;
  - http://localhost:8080/docker/container-name to go directly to the info of a specific container.

- To stop it, run
  ```
  docker stop cadvisor
  ```