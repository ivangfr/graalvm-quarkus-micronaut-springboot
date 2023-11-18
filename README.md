# graalvm-quarkus-micronaut-springboot

The goal of this project is to compare some Java frameworks like: [`Quarkus`](https://quarkus.io/), [`Micronaut`](https://micronaut.io/) and [`Spring Boot`](https://docs.spring.io/spring-boot/docs/current/reference/htmlsingle/). For it, we will implement applications using those frameworks, build their JVM and Native Docker images and measure start-up times, memory footprint, etc.

## Proof-of-Concepts & Articles

On [ivangfr.github.io](https://ivangfr.github.io), I have compiled my Proof-of-Concepts (PoCs) and articles. You can easily search for the technology you are interested in by using the filter. Who knows, perhaps I have already implemented a PoC or written an article about what you are looking for.

## Examples

- ### [simple-api](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/simple-api#graalvm-quarkus-micronaut-springboot)
- ### [jpa-mysql](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/jpa-mysql#graalvm-quarkus-micronaut-springboot)
- ### [kafka](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/kafka#graalvm-quarkus-micronaut-springboot)
- ### [elasticsearch](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/elasticsearch#graalvm-quarkus-micronaut-springboot)

## Framework version

We are using the following Framework versions

| Framework   | Version     |
|-------------|-------------|
| Quarkus     | 3.2.1.Final |
| Micronaut   | 4.2.0       |
| Spring Boot | 3.1.5       |

## Prerequisites

- [`Java 17+`](https://www.oracle.com/java/technologies/downloads/#java17)
- [`Docker`](https://www.docker.com/)

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
        quarkus-simple-api-jvm |            11s |            18M |                5s |             422MB |
      micronaut-simple-api-jvm |             6s |            16M |               15s |             342MB |
     springboot-simple-api-jvm |             4s |            25M |               14s |             293MB |
.............................. + .............. + .............. + ................. + ................. |
         quarkus-jpa-mysql-jvm |            10s |            40M |                1s |             444MB |
       micronaut-jpa-mysql-jvm |            14s |            36M |               12s |             363MB |
      springboot-jpa-mysql-jvm |             9s |            49M |               14s |             320MB |
.............................. + .............. + .............. + ................. + ................. |
    quarkus-kafka-producer-jvm |            12s |            35M |                3s |             440MB |
  micronaut-kafka-producer-jvm |            11s |            30M |               12s |             356MB |
 springboot-kafka-producer-jvm |             5s |            40M |               10s |             308MB |
.............................. + .............. + .............. + ................. + ................. |
    quarkus-kafka-consumer-jvm |            12s |            34M |                2s |             438MB |
  micronaut-kafka-consumer-jvm |            11s |            30M |               10s |             356MB |
 springboot-kafka-consumer-jvm |             3s |            38M |               10s |             306MB |
.............................. + .............. + .............. + ................. + ................. |
     quarkus-elasticsearch-jvm |            12s |            32M |                4s |             437MB |
   micronaut-elasticsearch-jvm |            10s |            58M |               13s |             386MB |
  springboot-elasticsearch-jvm |             3s |            40M |               10s |             309MB |
```

Table below shows the results after running the script `collect-native-jar-docker-size-times.sh`
```
                     Application | Packaging Time | Packaging Size | Docker Build Time | Docker Image Size |
-------------------------------- + -------------- + -------------- + ----------------- + ----------------- |
       quarkus-simple-api-native |           223s |            49M |               22s |             145MB |
     micronaut-simple-api-native |             7s |            17M |              166s |            86.2MB |
    springboot-simple-api-native |             4s |            25M |              581s |             113MB |
................................ + .............. + .............. + ................. + ................. |
        quarkus-jpa-mysql-native |           327s |            93M |                3s |             191MB |
      micronaut-jpa-mysql-native |            16s |            35M |              234s |             118MB |
     springboot-jpa-mysql-native |             7s |            49M |              689s |             181MB |
................................ + .............. + .............. + ................. + ................. |
   quarkus-kafka-producer-native |           252s |            69M |                2s |             166MB |
 micronaut-kafka-producer-native |            12s |            29M |              186s |            98.8MB |
springboot-kafka-producer-native |             5s |            40M |              495s |             145MB |
................................ + .............. + .............. + ................. + ................. |
   quarkus-kafka-consumer-native |           201s |            65M |                3s |             162MB |
 micronaut-kafka-consumer-native |            11s |            29M |              183s |            98.6MB |
springboot-kafka-consumer-native |             5s |            38M |              651s |             137MB |
................................ + .............. + .............. + ................. + ................. |
    quarkus-elasticsearch-native |           322s |            56M |                4s |             152MB |
  micronaut-elasticsearch-native |            12s |            58M |              227s |             106MB |
 springboot-elasticsearch-native |             4s |            40M |              592s |             131MB |
```

Finally, the following table shows the results after running the script `collect-ab-times-memory-usage.sh`

> **Note**: in order to have a better insight about the Docker container's CPU and Memory Usage, we can use [`cAdvisor`](https://github.com/google/cadvisor). In the section [Monitoring CPU and Memory with cAdvisor](#monitoring-cpu-and-memory-with-cadvisor), we explain how to start it.

```
                     Application | Startup Time |     Initial Memory Usage | Ab Testing Time | Ab Testing Time 2 |       Final Memory Usage | Shutdown Time |
-------------------------------- + ------------ + ------------------------ + --------------- + ----------------- + ------------------------ + ------------- |
          quarkus-simple-api-jvm |       1373ms |  72.78MiB/512MiB(14.21%) |              5s |                3s |  151.1MiB/512MiB(29.51%) |            1s |
        micronaut-simple-api-jvm |       6543ms |  89.32MiB/512MiB(17.45%) |              7s |                5s |  111.7MiB/512MiB(21.82%) |            1s |
       springboot-simple-api-jvm |       2729ms |  143.8MiB/512MiB(28.08%) |              8s |                6s |  183.4MiB/512MiB(35.83%) |            2s |
       quarkus-simple-api-native |        123ms |    8.27MiB/512MiB(1.62%) |              2s |                3s |  51.55MiB/512MiB(10.07%) |            0s |
     micronaut-simple-api-native |         51ms |   8.434MiB/512MiB(1.65%) |              3s |                3s |   28.36MiB/512MiB(5.54%) |            1s |
    springboot-simple-api-native |        170ms |   34.93MiB/512MiB(6.82%) |              4s |                4s |   48.43MiB/512MiB(9.46%) |            2s |
................................ + ............ + ........................ + ............... + ................. + ........................ + ............. |
           quarkus-jpa-mysql-jvm |       2299ms |  127.9MiB/512MiB(24.98%) |              7s |                4s |  173.1MiB/512MiB(33.82%) |            1s |
         micronaut-jpa-mysql-jvm |       8210ms |  126.8MiB/512MiB(24.77%) |              6s |                4s |  164.9MiB/512MiB(32.20%) |            0s |
        springboot-jpa-mysql-jvm |       4046ms |  193.4MiB/512MiB(37.77%) |              6s |                4s |  255.7MiB/512MiB(49.95%) |            2s |
        quarkus-jpa-mysql-native |         48ms |   10.67MiB/512MiB(2.08%) |              2s |                2s |   29.77MiB/512MiB(5.82%) |            0s |
      micronaut-jpa-mysql-native |         72ms |   21.38MiB/512MiB(4.17%) |              2s |                2s |   28.09MiB/512MiB(5.49%) |            0s |
     springboot-jpa-mysql-native |        314ms |  69.61MiB/512MiB(13.60%) |              3s |                3s |   46.88MiB/512MiB(9.16%) |            2s |
................................ + ............ + ........................ + ............... + ................. + ........................ + ............. |
      quarkus-kafka-producer-jvm |       1531ms |  93.31MiB/512MiB(18.23%) |              9s |                6s |  188.5MiB/512MiB(36.81%) |            0s |
    micronaut-kafka-producer-jvm |       6577ms |  87.31MiB/512MiB(17.05%) |              9s |                5s |  137.8MiB/512MiB(26.91%) |            1s |
   springboot-kafka-producer-jvm |       2375ms |  153.2MiB/512MiB(29.93%) |             12s |                5s |  214.1MiB/512MiB(41.82%) |            3s |
   quarkus-kafka-producer-native |         67ms |   11.85MiB/512MiB(2.31%) |              5s |                4s |   39.33MiB/512MiB(7.68%) |            1s |
 micronaut-kafka-producer-native |         82ms |   8.926MiB/512MiB(1.74%) |              6s |                5s |   26.46MiB/512MiB(5.17%) |            1s |
springboot-kafka-producer-native |        136ms |   46.34MiB/512MiB(9.05%) |              5s |                3s |   34.62MiB/512MiB(6.76%) |            3s |
................................ + ............ + ........................ + ............... + ................. + ........................ + ............. |
      quarkus-kafka-consumer-jvm |       1311ms |  80.41MiB/512MiB(15.71%) |                                  4s |  131.2MiB/512MiB(25.63%) |            2s |
    micronaut-kafka-consumer-jvm |       1973ms |  107.5MiB/512MiB(21.01%) |                                  2s |  113.2MiB/512MiB(22.11%) |            0s |
   springboot-kafka-consumer-jvm |       2433ms |  140.5MiB/512MiB(27.45%) |                                  2s |    157MiB/512MiB(30.65%) |            2s |
   quarkus-kafka-consumer-native |         53ms |   13.49MiB/512MiB(2.63%) |                                  3s |  87.75MiB/512MiB(17.14%) |            3s |
 micronaut-kafka-consumer-native |         66ms |   12.19MiB/512MiB(2.38%) |                                  2s |   50.83MiB/512MiB(9.93%) |            0s |
springboot-kafka-consumer-native |        136ms |   46.55MiB/512MiB(9.09%) |                                  1s |  71.56MiB/512MiB(13.98%) |            2s |
................................ + ............ + ........................ + ............... + ................. + ........................ + ............. |
       quarkus-elasticsearch-jvm |       1365ms |  81.78MiB/512MiB(15.97%) |              7s |                4s |  158.7MiB/512MiB(31.00%) |            0s |
     micronaut-elasticsearch-jvm |       6426ms |  97.21MiB/512MiB(18.99%) |              7s |                5s |  145.1MiB/512MiB(28.35%) |            1s |
    springboot-elasticsearch-jvm |       2701ms |  147.8MiB/512MiB(28.86%) |              6s |                4s |    252MiB/512MiB(49.22%) |            2s |
    quarkus-elasticsearch-native |         42ms |   8.465MiB/512MiB(1.65%) |              3s |                3s |  53.23MiB/512MiB(10.40%) |            1s |
  micronaut-elasticsearch-native |         49ms |   8.855MiB/512MiB(1.73%) |              3s |                5s |   25.17MiB/512MiB(4.92%) |            0s |
 springboot-elasticsearch-native |        203ms |   47.53MiB/512MiB(9.28%) |              4s |                4s |  61.42MiB/512MiB(12.00%) |            2s |
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