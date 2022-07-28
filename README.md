# graalvm-quarkus-micronaut-springboot

The goal of this project is to compare some Java frameworks like: [`Quarkus`](https://quarkus.io/), [`Micronaut`](https://micronaut.io/) and [`Spring Boot`](https://docs.spring.io/spring-boot/docs/current/reference/htmlsingle/). For it, we will implement applications using those frameworks, build their JVM and Native Docker images and measure start-up times, memory footprint, etc.

## Examples

- ### [simple-api](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/simple-api#graalvm-quarkus-micronaut-springboot)
- ### [jpa-mysql](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/jpa-mysql#graalvm-quarkus-micronaut-springboot)
- ### [kafka](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/kafka#graalvm-quarkus-micronaut-springboot)
- ### [elasticsearch](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/elasticsearch#graalvm-quarkus-micronaut-springboot)

## Framework version

We are using the following Framework versions

| Framework   | Version      |
|-------------|--------------|
| Quarkus     | 2.10.2.Final |
| Micronaut   | 3.5.3        |
| Spring Boot | 2.7.1        |

## Prerequisites

- [`Java 17+`](https://www.oracle.com/java/technologies/downloads/#java17)
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
        quarkus-simple-api-jvm |             7s |            16M |               70s |             420MB |
      micronaut-simple-api-jvm |             6s |            16M |               16s |             341MB |
     springboot-simple-api-jvm |            14s |            23M |               40s |             290MB |
.............................. + .............. + .............. + ................. + ................. |
         quarkus-jpa-mysql-jvm |             9s |            34M |                3s |             439MB |
       micronaut-jpa-mysql-jvm |            10s |            34M |               11s |             361MB |
      springboot-jpa-mysql-jvm |            17s |            43M |               11s |             313MB |
.............................. + .............. + .............. + ................. + ................. |
    quarkus-kafka-producer-jvm |             8s |            34M |                3s |             439MB |
  micronaut-kafka-producer-jvm |             9s |            28M |               12s |             355MB |
 springboot-kafka-producer-jvm |            14s |            39M |               10s |             306MB |
.............................. + .............. + .............. + ................. + ................. |
    quarkus-kafka-consumer-jvm |             7s |            32M |                2s |             437MB |
  micronaut-kafka-consumer-jvm |             7s |            28M |               10s |             355MB |
 springboot-kafka-consumer-jvm |            14s |            37M |               11s |             304MB |
.............................. + .............. + .............. + ................. + ................. |
     quarkus-elasticsearch-jvm |             7s |            42M |                2s |             447MB |
   micronaut-elasticsearch-jvm |            11s |            57M |               12s |             385MB |
  springboot-elasticsearch-jvm |            16s |            65M |               11s |             334MB |
```

Table below shows the results after running the script `collect-native-jar-docker-size-times.sh`
```
                     Application | Packaging Time | Packaging Size | Docker Build Time | Docker Image Size |
-------------------------------- + -------------- + -------------- + ----------------- + ----------------- |
       quarkus-simple-api-native |           144s |            46M |                4s |             151MB |
     micronaut-simple-api-native |             6s |            15M |              160s |            79.9MB |
    springboot-simple-api-native |            15s |            23M |              413s |             104MB |
................................ + .............. + .............. + ................. + ................. |
        quarkus-jpa-mysql-native |           209s |            79M |                4s |             186MB |
      micronaut-jpa-mysql-native |             9s |            34M |              247s |             119MB |
     springboot-jpa-mysql-native |            20s |            43M |              565s |             146MB |
................................ + .............. + .............. + ................. + ................. |
   quarkus-kafka-producer-native |           190s |            63M |                8s |             169MB |
 micronaut-kafka-producer-native |             7s |            28M |              199s |            97.8MB |
springboot-kafka-producer-native |            16s |            39M |              471s |             124MB |
................................ + .............. + .............. + ................. + ................. |
   quarkus-kafka-consumer-native |           173s |            60M |                5s |             165MB |
 micronaut-kafka-consumer-native |             7s |            29M |              197s |            97.6MB |
springboot-kafka-consumer-native |            15s |            37M |              474s |             108MB |
................................ + .............. + .............. + ................. + ................. |
    quarkus-elasticsearch-native |           167s |            54M |                8s |             159MB |
  micronaut-elasticsearch-native |            10s |            57M |              244s |             101MB |
 springboot-elasticsearch-native |            17s |            65M |              494s |             120MB |
```

Finally, the following table shows the results after running the script `collect-ab-times-memory-usage.sh`

> **Note**: in order to a better insight about the Docker container's CPU and Memory Usage, we can use [`cAdvisor`](https://github.com/google/cadvisor). In the section [Monitoring CPU and Memory with cAdvisor](#monitoring-cpu-and-memory-with-cadvisor), we explain how to start it.

```
                     Application | Startup Time |     Initial Memory Usage | Ab Testing Time | Ab Testing Time 2 |       Final Memory Usage | Shutdown Time |
-------------------------------- + ------------ + ------------------------ + --------------- + ----------------- + ------------------------ + ------------- |
          quarkus-simple-api-jvm |        954ms |  73.73MiB/512MiB(14.40%) |              5s |                3s |  118.4MiB/512MiB(23.13%) |            0s |
        micronaut-simple-api-jvm |       6344ms |  87.94MiB/512MiB(17.18%) |              7s |                5s |  113.4MiB/512MiB(22.16%) |            0s |
       springboot-simple-api-jvm |       2026ms |  137.9MiB/512MiB(26.93%) |              8s |                6s |    186MiB/512MiB(36.32%) |            3s |
       quarkus-simple-api-native |         23ms |   6.305MiB/512MiB(1.23%) |              4s |                3s |   49.32MiB/512MiB(9.63%) |            0s |
     micronaut-simple-api-native |         40ms |   9.012MiB/512MiB(1.76%) |              3s |                4s |   27.34MiB/512MiB(5.34%) |            0s |
    springboot-simple-api-native |         63ms |   27.66MiB/512MiB(5.40%) |              3s |                4s |   50.92MiB/512MiB(9.95%) |            2s |
................................ + ............ + ........................ + ............... + ................. + ........................ + ............. |
           quarkus-jpa-mysql-jvm |       1628ms |  102.9MiB/512MiB(20.09%) |              7s |                4s |    153MiB/512MiB(29.88%) |            0s |
         micronaut-jpa-mysql-jvm |       8404ms |  132.8MiB/512MiB(25.94%) |              5s |                4s |  160.2MiB/512MiB(31.29%) |            0s |
        springboot-jpa-mysql-jvm |       3443ms |  190.4MiB/512MiB(37.18%) |              6s |                4s |  239.7MiB/512MiB(46.81%) |            3s |
        quarkus-jpa-mysql-native |         32ms |   8.992MiB/512MiB(1.76%) |              3s |                3s |     54MiB/512MiB(10.55%) |            0s |
      micronaut-jpa-mysql-native |         67ms |    20.8MiB/512MiB(4.06%) |              3s |                3s |   37.54MiB/512MiB(7.33%) |            0s |
     springboot-jpa-mysql-native |        156ms |  64.81MiB/512MiB(12.66%) |              3s |                4s |  98.44MiB/512MiB(19.23%) |            2s |
................................ + ............ + ........................ + ............... + ................. + ........................ + ............. |
      quarkus-kafka-producer-jvm |       1341ms |  91.38MiB/512MiB(17.85%) |             10s |                5s |    162MiB/512MiB(31.64%) |            0s |
    micronaut-kafka-producer-jvm |       6445ms |  64.59MiB/512MiB(12.62%) |              8s |                6s |  134.7MiB/512MiB(26.30%) |            1s |
   springboot-kafka-producer-jvm |       2833ms |  151.8MiB/512MiB(29.66%) |             10s |                6s |    200MiB/512MiB(39.06%) |            3s |
   quarkus-kafka-producer-native |         47ms |   9.164MiB/512MiB(1.79%) |              6s |                5s |  66.25MiB/512MiB(12.94%) |            0s |
 micronaut-kafka-producer-native |         30ms |    9.52MiB/512MiB(1.86%) |              6s |                5s |   26.91MiB/512MiB(5.26%) |            0s |
springboot-kafka-producer-native |        115ms |   37.26MiB/512MiB(7.28%) |              6s |                5s |   34.32MiB/512MiB(6.70%) |            3s |
................................ + ............ + ........................ + ............... + ................. + ........................ + ............. |
      quarkus-kafka-consumer-jvm |       1076ms |   76.1MiB/512MiB(14.86%) |                                  5s |  145.3MiB/512MiB(28.37%) |            3s |
    micronaut-kafka-consumer-jvm |       1957ms |  92.55MiB/512MiB(18.08%) |                                  3s |  97.75MiB/512MiB(19.09%) |            0s |
   springboot-kafka-consumer-jvm |       2192ms |  142.6MiB/512MiB(27.86%) |                                  3s |  156.3MiB/512MiB(30.52%) |            2s |
   quarkus-kafka-consumer-native |         32ms |   11.12MiB/512MiB(2.17%) |                                  4s |     60MiB/512MiB(11.72%) |            4s |
 micronaut-kafka-consumer-native |         57ms |    12.5MiB/512MiB(2.44%) |                                  2s |  52.84MiB/512MiB(10.32%) |            0s |
springboot-kafka-consumer-native |         91ms |  67.57MiB/512MiB(13.20%) |                                  1s |  69.95MiB/512MiB(13.66%) |            2s |
................................ + ............ + ........................ + ............... + ................. + ........................ + ............. |
       quarkus-elasticsearch-jvm |       1204ms |  82.23MiB/512MiB(16.06%) |              8s |                4s |  152.1MiB/512MiB(29.70%) |            0s |
     micronaut-elasticsearch-jvm |       6327ms |  87.77MiB/512MiB(17.14%) |              7s |                5s |  151.8MiB/512MiB(29.65%) |            0s |
    springboot-elasticsearch-jvm |       2599ms |  165.7MiB/512MiB(32.37%) |              5s |                5s |  200.5MiB/512MiB(39.17%) |            3s |
    quarkus-elasticsearch-native |         22ms |   6.488MiB/512MiB(1.27%) |              4s |                4s |   53.2MiB/512MiB(10.39%) |            1s |
  micronaut-elasticsearch-native |         39ms |   9.441MiB/512MiB(1.84%) |              4s |                4s |   27.64MiB/512MiB(5.40%) |            0s |
 springboot-elasticsearch-native |        100ms |   35.77MiB/512MiB(6.99%) |              4s |                4s |  63.26MiB/512MiB(12.36%) |            3s |
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
    gcr.io/cadvisor/cadvisor:v0.39.3
  ```

- In a browser, access
  - http://localhost:8080/docker/ to explore the running containers;
  - http://localhost:8080/docker/container-name to go directly to the info of a specific container.

- To stop it, run
  ```
  docker stop cadvisor
  ```