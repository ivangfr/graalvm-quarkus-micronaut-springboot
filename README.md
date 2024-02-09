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

| Framework   | Version |
|-------------|---------|
| Quarkus     | 3.6.5   |
| Micronaut   | 4.3.0   |
| Spring Boot | 3.2.1   |

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
        quarkus-simple-api-jvm |            14s |            19M |               13s |             462MB |
      micronaut-simple-api-jvm |            10s |            15M |               21s |             284MB |
     springboot-simple-api-jvm |             5s |            26M |               14s |             295MB |
.............................. + .............. + .............. + ................. + ................. |
         quarkus-jpa-mysql-jvm |            29s |            41M |                5s |             485MB |
       micronaut-jpa-mysql-jvm |            19s |            39M |               17s |             309MB |
      springboot-jpa-mysql-jvm |             8s |            51M |               13s |             324MB |
.............................. + .............. + .............. + ................. + ................. |
    quarkus-kafka-producer-jvm |            28s |            37M |                6s |             481MB |
  micronaut-kafka-producer-jvm |            21s |            30M |               15s |             299MB |
 springboot-kafka-producer-jvm |             4s |            41M |               10s |             311MB |
.............................. + .............. + .............. + ................. + ................. |
    quarkus-kafka-consumer-jvm |            22s |            36M |                4s |             479MB |
  micronaut-kafka-consumer-jvm |            12s |            29M |               10s |             299MB |
 springboot-kafka-consumer-jvm |             4s |            39M |               10s |             310MB |
.............................. + .............. + .............. + ................. + ................. |
     quarkus-elasticsearch-jvm |            23s |            34M |                5s |             477MB |
   micronaut-elasticsearch-jvm |            11s |            31M |               13s |             301MB |
  springboot-elasticsearch-jvm |             7s |            41M |               10s |             312MB |
```

Table below shows the results after running the script `collect-native-jar-docker-size-times.sh`
```
                     Application | Packaging Time | Packaging Size | Docker Build Time | Docker Image Size |
-------------------------------- + -------------- + -------------- + ----------------- + ----------------- |
       quarkus-simple-api-native |           134s |            54M |                3s |             150MB |
     micronaut-simple-api-native |             9s |            15M |              180s |            92.2MB |
    springboot-simple-api-native |             6s |            26M |              407s |             119MB |
................................ + .............. + .............. + ................. + ................. |
        quarkus-jpa-mysql-native |           387s |           102M |                8s |             200MB |
      micronaut-jpa-mysql-native |            18s |            39M |              289s |             154MB |
     springboot-jpa-mysql-native |             8s |            51M |              562s |             188MB |
................................ + .............. + .............. + ................. + ................. |
   quarkus-kafka-producer-native |           304s |            77M |                5s |             174MB |
 micronaut-kafka-producer-native |            15s |            29M |              209s |             124MB |
springboot-kafka-producer-native |             6s |            41M |              477s |             154MB |
................................ + .............. + .............. + ................. + ................. |
   quarkus-kafka-consumer-native |           278s |            72M |                7s |             169MB |
 micronaut-kafka-consumer-native |            13s |            29M |              206s |             122MB |
springboot-kafka-consumer-native |             5s |            39M |              447s |             148MB |
................................ + .............. + .............. + ................. + ................. |
    quarkus-elasticsearch-native |           327s |            62M |                4s |             159MB |
  micronaut-elasticsearch-native |            11s |            31M |              206s |             103MB |
 springboot-elasticsearch-native |             6s |            41M |              444s |             139MB |
```

Finally, the following table shows the results after running the script `collect-ab-times-memory-usage.sh`

> **Note**: in order to have a better insight about the Docker container's CPU and Memory Usage, we can use [`cAdvisor`](https://github.com/google/cadvisor). In the section [Monitoring CPU and Memory with cAdvisor](#monitoring-cpu-and-memory-with-cadvisor), we explain how to start it.

```
                     Application | Startup Time |     Initial Memory Usage | Ab Testing Time | Ab Testing Time 2 |       Final Memory Usage | Shutdown Time |
-------------------------------- + ------------ + ------------------------ + --------------- + ----------------- + ------------------------ + ------------- |
          quarkus-simple-api-jvm |       1115ms |  79.07MiB/512MiB(15.44%) |              3s |                2s |  165.5MiB/512MiB(32.33%) |            1s |
        micronaut-simple-api-jvm |       1732ms |    104MiB/512MiB(20.32%) |              5s |                3s |  124.1MiB/512MiB(24.23%) |            1s |
       springboot-simple-api-jvm |       2354ms |  141.2MiB/512MiB(27.59%) |              7s |                6s |  194.9MiB/512MiB(38.07%) |            2s |
       quarkus-simple-api-native |         30ms |   6.652MiB/512MiB(1.30%) |              2s |                2s |   54.2MiB/512MiB(10.59%) |            0s |
     micronaut-simple-api-native |         55ms |   14.45MiB/512MiB(2.82%) |              4s |                3s |   46.56MiB/512MiB(9.09%) |            0s |
    springboot-simple-api-native |         92ms |   36.49MiB/512MiB(7.13%) |              2s |                3s |  83.29MiB/512MiB(16.27%) |            2s |
................................ + ............ + ........................ + ............... + ................. + ........................ + ............. |
           quarkus-jpa-mysql-jvm |       2126ms |  125.5MiB/512MiB(24.52%) |              6s |                2s |  185.9MiB/512MiB(36.31%) |            1s |
         micronaut-jpa-mysql-jvm |       2916ms |  144.8MiB/512MiB(28.29%) |              4s |                2s |  186.4MiB/512MiB(36.41%) |            0s |
        springboot-jpa-mysql-jvm |       3782ms |    205MiB/512MiB(40.05%) |              4s |                2s |  266.6MiB/512MiB(52.08%) |            2s |
        quarkus-jpa-mysql-native |         43ms |    9.82MiB/512MiB(1.92%) |              2s |                1s |  52.07MiB/512MiB(10.17%) |            0s |
      micronaut-jpa-mysql-native |        104ms |   31.69MiB/512MiB(6.19%) |              3s |                2s |  58.55MiB/512MiB(11.43%) |            0s |
     springboot-jpa-mysql-native |        204ms |  71.22MiB/512MiB(13.91%) |              2s |                1s |  137.9MiB/512MiB(26.93%) |            2s |
................................ + ............ + ........................ + ............... + ................. + ........................ + ............. |
      quarkus-kafka-producer-jvm |       1447ms |  99.58MiB/512MiB(19.45%) |              6s |                3s |  183.5MiB/512MiB(35.83%) |            0s |
    micronaut-kafka-producer-jvm |       1450ms |  109.4MiB/512MiB(21.36%) |              9s |                3s |  153.8MiB/512MiB(30.03%) |            0s |
   springboot-kafka-producer-jvm |       2254ms |  133.2MiB/512MiB(26.03%) |              7s |                3s |    227MiB/512MiB(44.34%) |            3s |
   quarkus-kafka-producer-native |         40ms |   8.559MiB/512MiB(1.67%) |              5s |                2s |   28.32MiB/512MiB(5.53%) |            0s |
 micronaut-kafka-producer-native |         54ms |   14.75MiB/512MiB(2.88%) |              6s |                3s |   47.04MiB/512MiB(9.19%) |            0s |
springboot-kafka-producer-native |        127ms |   45.42MiB/512MiB(8.87%) |              5s |                2s |  79.18MiB/512MiB(15.47%) |            3s |
................................ + ............ + ........................ + ............... + ................. + ........................ + ............. |
      quarkus-kafka-consumer-jvm |       1193ms |  95.35MiB/512MiB(18.62%) |                                  4s |  135.2MiB/512MiB(26.40%) |            3s |
    micronaut-kafka-consumer-jvm |       1804ms |  108.6MiB/512MiB(21.21%) |                                  2s |  132.3MiB/512MiB(25.83%) |            0s |
   springboot-kafka-consumer-jvm |       2297ms |  178.2MiB/512MiB(34.81%) |                                  1s |  188.3MiB/512MiB(36.77%) |            2s |
   quarkus-kafka-consumer-native |         37ms |   9.699MiB/512MiB(1.89%) |                                  3s |  76.48MiB/512MiB(14.94%) |            3s |
 micronaut-kafka-consumer-native |         66ms |    19.2MiB/512MiB(3.75%) |                                  2s |   62.3MiB/512MiB(12.17%) |            1s |
springboot-kafka-consumer-native |        107ms |  70.47MiB/512MiB(13.76%) |                                  1s |  74.13MiB/512MiB(14.48%) |            2s |
................................ + ............ + ........................ + ............... + ................. + ........................ + ............. |
       quarkus-elasticsearch-jvm |       1228ms |  88.81MiB/512MiB(17.35%) |              5s |                3s |  154.7MiB/512MiB(30.21%) |            1s |
     micronaut-elasticsearch-jvm |       1524ms |  109.6MiB/512MiB(21.41%) |              6s |                4s |  153.2MiB/512MiB(29.91%) |            0s |
    springboot-elasticsearch-jvm |       2496ms |  163.7MiB/512MiB(31.96%) |              4s |                3s |  247.1MiB/512MiB(48.25%) |            2s |
    quarkus-elasticsearch-native |         30ms |   6.953MiB/512MiB(1.36%) |              2s |                2s |  58.05MiB/512MiB(11.34%) |            0s |
  micronaut-elasticsearch-native |         49ms |    15.2MiB/512MiB(2.97%) |              4s |                4s |   43.26MiB/512MiB(8.45%) |            0s |
 springboot-elasticsearch-native |        103ms |  65.07MiB/512MiB(12.71%) |              3s |                2s |  140.7MiB/512MiB(27.48%) |            2s |
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
    gcr.io/cadvisor/cadvisor:v0.47.2
  ```

- In a browser, access
  - http://localhost:8080/docker/ to explore the running containers;
  - http://localhost:8080/docker/container-name to go directly to the info of a specific container.

- To stop it, run
  ```
  docker stop cadvisor
  ```