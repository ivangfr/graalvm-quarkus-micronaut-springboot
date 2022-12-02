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
| Quarkus     | 2.14.2.Final |
| Micronaut   | 3.7.4        |
| Spring Boot | 3.0.0        |

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
        quarkus-simple-api-jvm |             7s |            17M |               26s |             414MB |
      micronaut-simple-api-jvm |             7s |            15M |               14s |             342MB |
     springboot-simple-api-jvm |             4s |            24M |               14s |             292MB |
.............................. + .............. + .............. + ................. + ................. |
         quarkus-jpa-mysql-jvm |            11s |            35M |                5s |             433MB |
       micronaut-jpa-mysql-jvm |            14s |            35M |               12s |             362MB |
      springboot-jpa-mysql-jvm |             6s |            47M |               10s |             317MB |
.............................. + .............. + .............. + ................. + ................. |
    quarkus-kafka-producer-jvm |             8s |            34M |                4s |             431MB |
  micronaut-kafka-producer-jvm |             9s |            29M |               11s |             356MB |
 springboot-kafka-producer-jvm |             4s |            39M |                9s |             307MB |
.............................. + .............. + .............. + ................. + ................. |
    quarkus-kafka-consumer-jvm |             8s |            32M |                3s |             430MB |
  micronaut-kafka-consumer-jvm |             8s |            29M |               11s |             356MB |
 springboot-kafka-consumer-jvm |             3s |            37M |                8s |             305MB |
.............................. + .............. + .............. + ................. + ................. |
     quarkus-elasticsearch-jvm |             7s |            42M |                4s |             440MB |
   micronaut-elasticsearch-jvm |            11s |            57M |               13s |             385MB |
  springboot-elasticsearch-jvm |             4s |            39M |                9s |             307MB |
```

Table below shows the results after running the script `collect-native-jar-docker-size-times.sh`
```
                     Application | Packaging Time | Packaging Size | Docker Build Time | Docker Image Size |
-------------------------------- + -------------- + -------------- + ----------------- + ----------------- |
       quarkus-simple-api-native |           178s |            45M |                6s |             141MB |
     micronaut-simple-api-native |             6s |            16M |              173s |            79.8MB |
    springboot-simple-api-native |             4s |            24M |              299s |             107MB |
................................ + .............. + .............. + ................. + ................. |
        quarkus-jpa-mysql-native |           270s |            79M |               16s |             185MB |
      micronaut-jpa-mysql-native |            13s |            35M |              255s |             116MB |
     springboot-jpa-mysql-native |             6s |            47M |              601s |             169MB |
................................ + .............. + .............. + ................. + ................. |
   quarkus-kafka-producer-native |           239s |            63M |                9s |             169MB |
 micronaut-kafka-producer-native |             9s |            29M |              220s |            96.4MB |
springboot-kafka-producer-native |             4s |            39M |              414s |             125MB |
................................ + .............. + .............. + ................. + ................. |
   quarkus-kafka-consumer-native |           221s |            59M |                4s |             164MB |
 micronaut-kafka-consumer-native |             9s |            29M |              193s |            96.3MB |
springboot-kafka-consumer-native |             4s |            37M |              392s |             114MB |
................................ + .............. + .............. + ................. + ................. |
    quarkus-elasticsearch-native |           230s |            53M |                8s |             158MB |
  micronaut-elasticsearch-native |            12s |            57M |              252s |             103MB |
 springboot-elasticsearch-native |             4s |            39M |              413s |             117MB |
```

Finally, the following table shows the results after running the script `collect-ab-times-memory-usage.sh`

> **Note**: in order to have a better insight about the Docker container's CPU and Memory Usage, we can use [`cAdvisor`](https://github.com/google/cadvisor). In the section [Monitoring CPU and Memory with cAdvisor](#monitoring-cpu-and-memory-with-cadvisor), we explain how to start it.

```
                     Application | Startup Time |     Initial Memory Usage | Ab Testing Time | Ab Testing Time 2 |       Final Memory Usage | Shutdown Time |
-------------------------------- + ------------ + ------------------------ + --------------- + ----------------- + ------------------------ + ------------- |
          quarkus-simple-api-jvm |       1687ms |  74.33MiB/512MiB(14.52%) |              8s |                3s |  120.2MiB/512MiB(23.48%) |            1s |
        micronaut-simple-api-jvm |       2241ms |  62.64MiB/512MiB(12.23%) |             11s |                4s |  112.8MiB/512MiB(22.04%) |            0s |
       springboot-simple-api-jvm |       3448ms |  133.6MiB/512MiB(26.10%) |             12s |                5s |  186.6MiB/512MiB(36.44%) |            2s |
       quarkus-simple-api-native |         44ms |   7.457MiB/512MiB(1.46%) |              4s |                5s |   47.52MiB/512MiB(9.28%) |            0s |
     micronaut-simple-api-native |         42ms |   8.891MiB/512MiB(1.74%) |              6s |                5s |   22.35MiB/512MiB(4.37%) |            0s |
    springboot-simple-api-native |        125ms |   33.12MiB/512MiB(6.47%) |              5s |                6s |   42.11MiB/512MiB(8.22%) |            3s |
................................ + ............ + ........................ + ............... + ................. + ........................ + ............. |
           quarkus-jpa-mysql-jvm |       2639ms |  107.2MiB/512MiB(20.93%) |              9s |                5s |    161MiB/512MiB(31.45%) |            1s |
         micronaut-jpa-mysql-jvm |       4704ms |  113.9MiB/512MiB(22.24%) |              9s |                5s |  165.6MiB/512MiB(32.35%) |            0s |
        springboot-jpa-mysql-jvm |       5585ms |  208.5MiB/512MiB(40.72%) |             10s |                5s |  254.8MiB/512MiB(49.76%) |            2s |
        quarkus-jpa-mysql-native |         75ms |   10.47MiB/512MiB(2.04%) |              4s |                4s |   45.25MiB/512MiB(8.84%) |            0s |
      micronaut-jpa-mysql-native |        148ms |   21.91MiB/512MiB(4.28%) |              4s |                4s |   30.36MiB/512MiB(5.93%) |            0s |
     springboot-jpa-mysql-native |        314ms |  68.47MiB/512MiB(13.37%) |              4s |                4s |    106MiB/512MiB(20.70%) |            2s |
................................ + ............ + ........................ + ............... + ................. + ........................ + ............. |
      quarkus-kafka-producer-jvm |       2298ms |  89.99MiB/512MiB(17.58%) |             14s |                8s |  177.5MiB/512MiB(34.66%) |            1s |
    micronaut-kafka-producer-jvm |       2034ms |  65.12MiB/512MiB(12.72%) |             14s |                7s |  137.1MiB/512MiB(26.77%) |            1s |
   springboot-kafka-producer-jvm |       4349ms |    146MiB/512MiB(28.52%) |             15s |                8s |  214.1MiB/512MiB(41.82%) |            3s |
   quarkus-kafka-producer-native |         57ms |   10.76MiB/512MiB(2.10%) |              7s |                6s |   49.14MiB/512MiB(9.60%) |            1s |
 micronaut-kafka-producer-native |         57ms |   9.402MiB/512MiB(1.84%) |              8s |                6s |   36.27MiB/512MiB(7.08%) |            0s |
springboot-kafka-producer-native |        224ms |    42.4MiB/512MiB(8.28%) |              6s |                6s |   35.32MiB/512MiB(6.90%) |            2s |
................................ + ............ + ........................ + ............... + ................. + ........................ + ............. |
      quarkus-kafka-consumer-jvm |       1783ms |   77.7MiB/512MiB(15.18%) |                                  8s |  125.6MiB/512MiB(24.54%) |            3s |
    micronaut-kafka-consumer-jvm |       3116ms |  86.38MiB/512MiB(16.87%) |                                  3s |  98.79MiB/512MiB(19.29%) |            0s |
   springboot-kafka-consumer-jvm |       3636ms |  148.2MiB/512MiB(28.94%) |                                  4s |  161.3MiB/512MiB(31.51%) |            2s |
   quarkus-kafka-consumer-native |         92ms |   12.12MiB/512MiB(2.37%) |                                  4s |  51.55MiB/512MiB(10.07%) |            2s |
 micronaut-kafka-consumer-native |         70ms |   12.36MiB/512MiB(2.41%) |                                  2s |  56.02MiB/512MiB(10.94%) |            0s |
springboot-kafka-consumer-native |        148ms |  67.39MiB/512MiB(13.16%) |                                  2s |  71.04MiB/512MiB(13.88%) |            3s |
................................ + ............ + ........................ + ............... + ................. + ........................ + ............. |
       quarkus-elasticsearch-jvm |       1834ms |  82.56MiB/512MiB(16.12%) |             12s |                6s |  144.3MiB/512MiB(28.18%) |            1s |
     micronaut-elasticsearch-jvm |       2091ms |  98.62MiB/512MiB(19.26%) |             11s |                7s |  146.5MiB/512MiB(28.61%) |            1s |
    springboot-elasticsearch-jvm |       3847ms |  167.4MiB/512MiB(32.69%) |             11s |                6s |  225.9MiB/512MiB(44.13%) |            2s |
    quarkus-elasticsearch-native |         40ms |   7.762MiB/512MiB(1.52%) |              5s |                4s |   47.16MiB/512MiB(9.21%) |            0s |
  micronaut-elasticsearch-native |         52ms |   9.344MiB/512MiB(1.82%) |              6s |                7s |   28.65MiB/512MiB(5.60%) |            0s |
 springboot-elasticsearch-native |        152ms |   41.55MiB/512MiB(8.12%) |              5s |                5s |   37.85MiB/512MiB(7.39%) |            3s |
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
    gcr.io/cadvisor/cadvisor:v0.46.0
  ```

- In a browser, access
  - http://localhost:8080/docker/ to explore the running containers;
  - http://localhost:8080/docker/container-name to go directly to the info of a specific container.

- To stop it, run
  ```
  docker stop cadvisor
  ```