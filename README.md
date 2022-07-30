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
| Quarkus     | 2.11.1.Final |
| Micronaut   | 3.5.3        |
| Spring Boot | 2.7.2        |

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
        quarkus-simple-api-jvm |             6s |            17M |                3s |             421MB |
      micronaut-simple-api-jvm |             6s |            16M |               16s |             341MB |
     springboot-simple-api-jvm |            14s |            23M |               40s |             290MB |
.............................. + .............. + .............. + ................. + ................. |
         quarkus-jpa-mysql-jvm |             9s |            35M |                2s |             440MB |
       micronaut-jpa-mysql-jvm |            10s |            34M |               11s |             361MB |
      springboot-jpa-mysql-jvm |            17s |            43M |               11s |             313MB |
.............................. + .............. + .............. + ................. + ................. |
    quarkus-kafka-producer-jvm |             8s |            34M |                3s |             439MB |
  micronaut-kafka-producer-jvm |             9s |            28M |               12s |             355MB |
 springboot-kafka-producer-jvm |            14s |            39M |               10s |             306MB |
.............................. + .............. + .............. + ................. + ................. |
    quarkus-kafka-consumer-jvm |             9s |            33M |                2s |             438MB |
  micronaut-kafka-consumer-jvm |             7s |            28M |               10s |             355MB |
 springboot-kafka-consumer-jvm |            14s |            37M |               11s |             304MB |
.............................. + .............. + .............. + ................. + ................. |
     quarkus-elasticsearch-jvm |             7s |            42M |                2s |             448MB |
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
        quarkus-jpa-mysql-native |           203s |            80M |                7s |             187MB |
      micronaut-jpa-mysql-native |             9s |            34M |              247s |             119MB |
     springboot-jpa-mysql-native |            20s |            43M |              565s |             146MB |
................................ + .............. + .............. + ................. + ................. |
   quarkus-kafka-producer-native |           190s |            63M |                8s |             169MB |
 micronaut-kafka-producer-native |             7s |            28M |              199s |            97.8MB |
springboot-kafka-producer-native |            16s |            39M |              471s |             124MB |
................................ + .............. + .............. + ................. + ................. |
   quarkus-kafka-consumer-native |           165s |            60M |                5s |             166MB |
 micronaut-kafka-consumer-native |             7s |            29M |              197s |            97.6MB |
springboot-kafka-consumer-native |            15s |            37M |              474s |             108MB |
................................ + .............. + .............. + ................. + ................. |
    quarkus-elasticsearch-native |           154s |            55M |                6s |             160MB |
  micronaut-elasticsearch-native |            10s |            57M |              244s |             101MB |
 springboot-elasticsearch-native |            17s |            65M |              494s |             120MB |
```

Finally, the following table shows the results after running the script `collect-ab-times-memory-usage.sh`

> **Note**: in order to a better insight about the Docker container's CPU and Memory Usage, we can use [`cAdvisor`](https://github.com/google/cadvisor). In the section [Monitoring CPU and Memory with cAdvisor](#monitoring-cpu-and-memory-with-cadvisor), we explain how to start it.

```
                     Application | Startup Time |     Initial Memory Usage | Ab Testing Time | Ab Testing Time 2 |       Final Memory Usage | Shutdown Time |
-------------------------------- + ------------ + ------------------------ + --------------- + ----------------- + ------------------------ + ------------- |
          quarkus-simple-api-jvm |        981ms |  73.44MiB/512MiB(14.34%) |              6s |                4s |  127.5MiB/512MiB(24.90%) |            0s |
        micronaut-simple-api-jvm |       6519ms |  80.36MiB/512MiB(15.69%) |              8s |                4s |  112.4MiB/512MiB(21.95%) |            1s |
       springboot-simple-api-jvm |       2471ms |  120.4MiB/512MiB(23.53%) |              8s |                6s |  177.7MiB/512MiB(34.70%) |            3s |
       quarkus-simple-api-native |         22ms |   6.383MiB/512MiB(1.25%) |              4s |                4s |   49.52MiB/512MiB(9.67%) |            1s |
     micronaut-simple-api-native |         40ms |   8.988MiB/512MiB(1.76%) |              3s |                5s |   29.02MiB/512MiB(5.67%) |            0s |
    springboot-simple-api-native |         59ms |   27.92MiB/512MiB(5.45%) |              4s |                4s |      50MiB/512MiB(9.76%) |            2s |
................................ + ............ + ........................ + ............... + ................. + ........................ + ............. |
           quarkus-jpa-mysql-jvm |       1629ms |    102MiB/512MiB(19.93%) |              7s |                3s |  169.2MiB/512MiB(33.05%) |            0s |
         micronaut-jpa-mysql-jvm |       7941ms |  129.1MiB/512MiB(25.21%) |              6s |                4s |  162.1MiB/512MiB(31.67%) |            0s |
        springboot-jpa-mysql-jvm |       3549ms |  185.7MiB/512MiB(36.27%) |              6s |                4s |  233.2MiB/512MiB(45.54%) |            2s |
        quarkus-jpa-mysql-native |         30ms |   9.062MiB/512MiB(1.77%) |              3s |                3s |  54.02MiB/512MiB(10.55%) |            0s |
      micronaut-jpa-mysql-native |         58ms |   20.81MiB/512MiB(4.06%) |              3s |                3s |   38.84MiB/512MiB(7.59%) |            0s |
     springboot-jpa-mysql-native |        143ms |   64.8MiB/512MiB(12.66%) |              3s |                3s |   98.9MiB/512MiB(19.32%) |            2s |
................................ + ............ + ........................ + ............... + ................. + ........................ + ............. |
      quarkus-kafka-producer-jvm |       1358ms |  93.27MiB/512MiB(18.22%) |              9s |                5s |  151.8MiB/512MiB(29.64%) |            0s |
    micronaut-kafka-producer-jvm |       6335ms |  81.84MiB/512MiB(15.99%) |              9s |                5s |  136.7MiB/512MiB(26.69%) |            1s |
   springboot-kafka-producer-jvm |       2551ms |  159.1MiB/512MiB(31.07%) |             11s |                6s |    204MiB/512MiB(39.84%) |            2s |
   quarkus-kafka-producer-native |         30ms |   9.234MiB/512MiB(1.80%) |              6s |                6s |  66.18MiB/512MiB(12.93%) |            0s |
 micronaut-kafka-producer-native |         36ms |   9.523MiB/512MiB(1.86%) |              7s |                5s |   24.71MiB/512MiB(4.83%) |            1s |
springboot-kafka-producer-native |        127ms |   37.38MiB/512MiB(7.30%) |              6s |                4s |   34.41MiB/512MiB(6.72%) |            2s |
................................ + ............ + ........................ + ............... + ................. + ........................ + ............. |
      quarkus-kafka-consumer-jvm |       1029ms |   75.5MiB/512MiB(14.75%) |                                  6s |  133.8MiB/512MiB(26.13%) |            3s |
    micronaut-kafka-consumer-jvm |       1948ms |  90.86MiB/512MiB(17.75%) |                                  3s |  97.73MiB/512MiB(19.09%) |            0s |
   springboot-kafka-consumer-jvm |       2178ms |  150.2MiB/512MiB(29.34%) |                                  2s |  160.4MiB/512MiB(31.33%) |            3s |
   quarkus-kafka-consumer-native |         34ms |   11.22MiB/512MiB(2.19%) |                                  3s |  59.98MiB/512MiB(11.71%) |            2s |
 micronaut-kafka-consumer-native |         45ms |   12.47MiB/512MiB(2.44%) |                                  2s |  52.97MiB/512MiB(10.35%) |            0s |
springboot-kafka-consumer-native |         71ms |   35.38MiB/512MiB(6.91%) |                                  2s |   67.5MiB/512MiB(13.18%) |            2s |
................................ + ............ + ........................ + ............... + ................. + ........................ + ............. |
       quarkus-elasticsearch-jvm |       1180ms |  82.97MiB/512MiB(16.21%) |              7s |                4s |  145.1MiB/512MiB(28.35%) |            0s |
     micronaut-elasticsearch-jvm |       6544ms |  80.25MiB/512MiB(15.67%) |              7s |                5s |  151.5MiB/512MiB(29.60%) |            0s |
    springboot-elasticsearch-jvm |       2473ms |  154.3MiB/512MiB(30.13%) |              5s |                5s |  223.5MiB/512MiB(43.65%) |            3s |
    quarkus-elasticsearch-native |         30ms |   6.582MiB/512MiB(1.29%) |              3s |                4s |  53.29MiB/512MiB(10.41%) |            0s |
  micronaut-elasticsearch-native |         34ms |   9.457MiB/512MiB(1.85%) |              4s |                4s |   25.35MiB/512MiB(4.95%) |            0s |
 springboot-elasticsearch-native |         74ms |   35.77MiB/512MiB(6.99%) |              3s |                4s |  66.08MiB/512MiB(12.91%) |            2s |
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