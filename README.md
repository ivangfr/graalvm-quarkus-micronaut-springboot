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
        quarkus-simple-api-jvm |             6s |            16M |               68s |             420MB |
      micronaut-simple-api-jvm |             6s |            15M |               14s |             341MB |
     springboot-simple-api-jvm |            12s |            23M |               13s |             290MB |
.............................. + .............. + .............. + ................. + ................. |
         quarkus-jpa-mysql-jvm |            10s |            34M |                3s |             439MB |
       micronaut-jpa-mysql-jvm |            10s |            35M |               12s |             361MB |
      springboot-jpa-mysql-jvm |            17s |            43M |               11s |             313MB |
.............................. + .............. + .............. + ................. + ................. |
    quarkus-kafka-producer-jvm |             8s |            34M |                2s |             439MB |
  micronaut-kafka-producer-jvm |             8s |            29M |               12s |             355MB |
 springboot-kafka-producer-jvm |            14s |            39M |               10s |             308MB |
.............................. + .............. + .............. + ................. + ................. |
    quarkus-kafka-consumer-jvm |             6s |            32M |                3s |             437MB |
  micronaut-kafka-consumer-jvm |             6s |            29M |               11s |             355MB |
 springboot-kafka-consumer-jvm |            14s |            37M |               10s |             306MB |
.............................. + .............. + .............. + ................. + ................. |
     quarkus-elasticsearch-jvm |             8s |            42M |                3s |             447MB |
   micronaut-elasticsearch-jvm |            11s |            57M |               13s |             385MB |
  springboot-elasticsearch-jvm |            15s |            65M |               11s |             336MB |
```

Table below shows the results after running the script `collect-native-jar-docker-size-times.sh`
```
                     Application | Packaging Time | Packaging Size | Docker Build Time | Docker Image Size |
-------------------------------- + -------------- + -------------- + ----------------- + ----------------- |
       quarkus-simple-api-native |           147s |            46M |                3s |             151MB |
     micronaut-simple-api-native |             6s |            15M |              151s |            79.9MB |
    springboot-simple-api-native |            16s |            23M |              376s |             104MB |
................................ + .............. + .............. + ................. + ................. |
        quarkus-jpa-mysql-native |           195s |            79M |                5s |             186MB |
      micronaut-jpa-mysql-native |             9s |            35M |              227s |             119MB |
     springboot-jpa-mysql-native |            19s |            43M |              523s |             146MB |
................................ + .............. + .............. + ................. + ................. |
   quarkus-kafka-producer-native |           193s |            64M |                6s |             170MB |
 micronaut-kafka-producer-native |             7s |            29M |              182s |            97.7MB |
springboot-kafka-producer-native |            16s |            39M |              412s |             124MB |
................................ + .............. + .............. + ................. + ................. |
   quarkus-kafka-consumer-native |           159s |            60M |                4s |             165MB |
 micronaut-kafka-consumer-native |             7s |            29M |              184s |            97.6MB |
springboot-kafka-consumer-native |            15s |            37M |              394s |             108MB |
................................ + .............. + .............. + ................. + ................. |
    quarkus-elasticsearch-native |           166s |            55M |                7s |             160MB |
  micronaut-elasticsearch-native |            10s |            57M |              204s |             101MB |
 springboot-elasticsearch-native |            18s |            65M |              442s |             120MB |
```

Finally, the following table shows the results after running the script `collect-ab-times-memory-usage.sh`

> **Note**: in order to a better insight about the Docker container's CPU and Memory Usage, we can use [`cAdvisor`](https://github.com/google/cadvisor). In the section [Monitoring CPU and Memory with cAdvisor](#monitoring-cpu-and-memory-with-cadvisor), we explain how to start it.

```
                     Application | Startup Time |     Initial Memory Usage | Ab Testing Time | Ab Testing Time 2 |       Final Memory Usage | Shutdown Time |
-------------------------------- + ------------ + ------------------------ + --------------- + ----------------- + ------------------------ + ------------- |
          quarkus-simple-api-jvm |        948ms |  74.02MiB/512MiB(14.46%) |              5s |                4s |  126.7MiB/512MiB(24.75%) |            1s |
        micronaut-simple-api-jvm |       6457ms |  79.39MiB/512MiB(15.51%) |              6s |                4s |  108.4MiB/512MiB(21.18%) |            0s |
       springboot-simple-api-jvm |       2104ms |  129.6MiB/512MiB(25.32%) |              8s |                6s |  171.9MiB/512MiB(33.58%) |            2s |
       quarkus-simple-api-native |         25ms |   6.289MiB/512MiB(1.23%) |              3s |                3s |   49.35MiB/512MiB(9.64%) |            1s |
     micronaut-simple-api-native |         30ms |   8.965MiB/512MiB(1.75%) |              3s |                4s |   24.24MiB/512MiB(4.73%) |            0s |
    springboot-simple-api-native |         56ms |   27.85MiB/512MiB(5.44%) |              3s |                4s |   47.96MiB/512MiB(9.37%) |            3s |
................................ + ............ + ........................ + ............... + ................. + ........................ + ............. |
           quarkus-jpa-mysql-jvm |       1557ms |  108.8MiB/512MiB(21.26%) |              7s |                3s |  153.1MiB/512MiB(29.91%) |            1s |
         micronaut-jpa-mysql-jvm |       7902ms |  105.9MiB/512MiB(20.68%) |              6s |                4s |  160.8MiB/512MiB(31.40%) |            1s |
        springboot-jpa-mysql-jvm |       3266ms |  182.5MiB/512MiB(35.65%) |              6s |                4s |  231.9MiB/512MiB(45.30%) |            2s |
        quarkus-jpa-mysql-native |         32ms |   8.992MiB/512MiB(1.76%) |              3s |                2s |   53.9MiB/512MiB(10.53%) |            0s |
      micronaut-jpa-mysql-native |         61ms |   20.79MiB/512MiB(4.06%) |              3s |                2s |   33.39MiB/512MiB(6.52%) |            0s |
     springboot-jpa-mysql-native |        152ms |  65.86MiB/512MiB(12.86%) |              3s |                3s |  103.4MiB/512MiB(20.19%) |            2s |
................................ + ............ + ........................ + ............... + ................. + ........................ + ............. |
      quarkus-kafka-producer-jvm |       1353ms |  93.45MiB/512MiB(18.25%) |              9s |                6s |  150.9MiB/512MiB(29.48%) |            0s |
    micronaut-kafka-producer-jvm |       6350ms |  81.83MiB/512MiB(15.98%) |              8s |                5s |  135.2MiB/512MiB(26.40%) |            1s |
   springboot-kafka-producer-jvm |       2511ms |  154.4MiB/512MiB(30.15%) |             10s |                6s |  192.2MiB/512MiB(37.55%) |            2s |
   quarkus-kafka-producer-native |         29ms |   9.156MiB/512MiB(1.79%) |              5s |                5s |  65.49MiB/512MiB(12.79%) |            0s |
 micronaut-kafka-producer-native |         32ms |   9.492MiB/512MiB(1.85%) |              5s |                5s |    36.2MiB/512MiB(7.07%) |            1s |
springboot-kafka-producer-native |        125ms |   37.23MiB/512MiB(7.27%) |              5s |                5s |   34.24MiB/512MiB(6.69%) |            3s |
................................ + ............ + ........................ + ............... + ................. + ........................ + ............. |
      quarkus-kafka-consumer-jvm |       1066ms |  75.74MiB/512MiB(14.79%) |                                  4s |  144.1MiB/512MiB(28.14%) |            3s |
    micronaut-kafka-consumer-jvm |       1905ms |  106.1MiB/512MiB(20.73%) |                                  3s |  97.31MiB/512MiB(19.01%) |            0s |
   springboot-kafka-consumer-jvm |       2165ms |  147.3MiB/512MiB(28.76%) |                                  2s |  156.5MiB/512MiB(30.57%) |            3s |
   quarkus-kafka-consumer-native |         35ms |   11.05MiB/512MiB(2.16%) |                                  3s |   59.3MiB/512MiB(11.58%) |            3s |
 micronaut-kafka-consumer-native |         52ms |   12.49MiB/512MiB(2.44%) |                                  2s |  57.21MiB/512MiB(11.17%) |            0s |
springboot-kafka-consumer-native |         74ms |   35.43MiB/512MiB(6.92%) |                                  2s |  70.54MiB/512MiB(13.78%) |            2s |
................................ + ............ + ........................ + ............... + ................. + ........................ + ............. |
       quarkus-elasticsearch-jvm |       1241ms |  82.21MiB/512MiB(16.06%) |              8s |                5s |  145.3MiB/512MiB(28.37%) |            1s |
     micronaut-elasticsearch-jvm |       6318ms |  81.07MiB/512MiB(15.83%) |              7s |                5s |  153.5MiB/512MiB(29.97%) |            0s |
    springboot-elasticsearch-jvm |       2490ms |  153.9MiB/512MiB(30.07%) |              6s |                5s |  223.6MiB/512MiB(43.67%) |            3s |
    quarkus-elasticsearch-native |         20ms |   6.477MiB/512MiB(1.26%) |              3s |                4s |   52.5MiB/512MiB(10.25%) |            1s |
  micronaut-elasticsearch-native |         35ms |   9.445MiB/512MiB(1.84%) |              4s |                6s |   25.05MiB/512MiB(4.89%) |            1s |
 springboot-elasticsearch-native |         70ms |   35.64MiB/512MiB(6.96%) |              4s |                4s |  61.18MiB/512MiB(11.95%) |            2s |
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