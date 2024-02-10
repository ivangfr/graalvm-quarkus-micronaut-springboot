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
| Quarkus     | 3.7.2   |
| Micronaut   | 4.3.0   |
| Spring Boot | 3.2.2   |

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
        quarkus-simple-api-jvm |            14s |            20M |               13s |             471MB |
      micronaut-simple-api-jvm |            10s |            15M |               21s |             284MB |
     springboot-simple-api-jvm |             5s |            26M |               14s |             295MB |
.............................. + .............. + .............. + ................. + ................. |
         quarkus-jpa-mysql-jvm |            29s |            42M |                5s |             494MB |
       micronaut-jpa-mysql-jvm |            19s |            39M |               17s |             309MB |
      springboot-jpa-mysql-jvm |             8s |            51M |               13s |             324MB |
.............................. + .............. + .............. + ................. + ................. |
    quarkus-kafka-producer-jvm |            28s |            38M |                6s |             490MB |
  micronaut-kafka-producer-jvm |            21s |            30M |               15s |             299MB |
 springboot-kafka-producer-jvm |             4s |            41M |               10s |             312MB |
.............................. + .............. + .............. + ................. + ................. |
    quarkus-kafka-consumer-jvm |            22s |            36M |                4s |             488MB |
  micronaut-kafka-consumer-jvm |            12s |            29M |               10s |             299MB |
 springboot-kafka-consumer-jvm |             4s |            39M |               10s |             310MB |
.............................. + .............. + .............. + ................. + ................. |
     quarkus-elasticsearch-jvm |            23s |            34M |                5s |             486MB |
   micronaut-elasticsearch-jvm |            11s |            31M |               13s |             301MB |
  springboot-elasticsearch-jvm |             7s |            42M |               10s |             312MB |
```

Table below shows the results after running the script `collect-native-jar-docker-size-times.sh`
```
                     Application | Packaging Time | Packaging Size | Docker Build Time | Docker Image Size |
-------------------------------- + -------------- + -------------- + ----------------- + ----------------- |
       quarkus-simple-api-native |           134s |            55M |                3s |             150MB |
     micronaut-simple-api-native |             9s |            15M |              180s |            92.2MB |
    springboot-simple-api-native |             6s |            26M |              407s |             120MB |
................................ + .............. + .............. + ................. + ................. |
        quarkus-jpa-mysql-native |           387s |           102M |                8s |             201MB |
      micronaut-jpa-mysql-native |            18s |            39M |              289s |             154MB |
     springboot-jpa-mysql-native |             8s |            51M |              562s |             189MB |
................................ + .............. + .............. + ................. + ................. |
   quarkus-kafka-producer-native |           304s |            78M |                5s |             175MB |
 micronaut-kafka-producer-native |            15s |            29M |              209s |             124MB |
springboot-kafka-producer-native |             6s |            41M |              477s |             155MB |
................................ + .............. + .............. + ................. + ................. |
   quarkus-kafka-consumer-native |           278s |            74M |                7s |             171MB |
 micronaut-kafka-consumer-native |            13s |            29M |              206s |             122MB |
springboot-kafka-consumer-native |             5s |            39M |              447s |             148MB |
................................ + .............. + .............. + ................. + ................. |
    quarkus-elasticsearch-native |           327s |            63M |                4s |             159MB |
  micronaut-elasticsearch-native |            11s |            31M |              206s |             103MB |
 springboot-elasticsearch-native |             6s |            42M |              444s |             139MB |
```

Finally, the following table shows the results after running the script `collect-ab-times-memory-usage.sh`

> **Note**: in order to have a better insight about the Docker container's CPU and Memory Usage, we can use [`cAdvisor`](https://github.com/google/cadvisor). In the section [Monitoring CPU and Memory with cAdvisor](#monitoring-cpu-and-memory-with-cadvisor), we explain how to start it.

```
                     Application | Startup Time |     Initial Memory Usage | Ab Testing Time | Ab Testing Time 2 |       Final Memory Usage | Shutdown Time |
-------------------------------- + ------------ + ------------------------ + --------------- + ----------------- + ------------------------ + ------------- |
          quarkus-simple-api-jvm |       1196ms |  85.72MiB/512MiB(16.74%) |              3s |                2s |  150.1MiB/512MiB(29.32%) |            1s |
        micronaut-simple-api-jvm |       1086ms |  108.6MiB/512MiB(21.20%) |              6s |                3s |  149.3MiB/512MiB(29.16%) |            0s |
       springboot-simple-api-jvm |       2169ms |  156.3MiB/512MiB(30.53%) |              7s |                6s |  210.3MiB/512MiB(41.07%) |            2s |
       quarkus-simple-api-native |         26ms |   15.37MiB/512MiB(3.00%) |              2s |                2s |  65.41MiB/512MiB(12.77%) |            0s |
     micronaut-simple-api-native |         48ms |   24.16MiB/512MiB(4.72%) |              4s |                2s |  78.25MiB/512MiB(15.28%) |            0s |
    springboot-simple-api-native |         88ms |   45.93MiB/512MiB(8.97%) |              3s |                3s |  131.3MiB/512MiB(25.64%) |            3s |
................................ + ............ + ........................ + ............... + ................. + ........................ + ............. |
           quarkus-jpa-mysql-jvm |       2183ms |    142MiB/512MiB(27.73%) |              5s |                3s |  195.9MiB/512MiB(38.25%) |            0s |
         micronaut-jpa-mysql-jvm |       2219ms |  167.7MiB/512MiB(32.76%) |              5s |                3s |  208.4MiB/512MiB(40.71%) |            0s |
        springboot-jpa-mysql-jvm |       4234ms |  206.3MiB/512MiB(40.30%) |              5s |                4s |  272.9MiB/512MiB(53.29%) |            2s |
        quarkus-jpa-mysql-native |         46ms |   24.48MiB/512MiB(4.78%) |              3s |                2s |  70.09MiB/512MiB(13.69%) |            0s |
      micronaut-jpa-mysql-native |        113ms |  54.02MiB/512MiB(10.55%) |              3s |                2s |     81MiB/512MiB(15.82%) |            1s |
     springboot-jpa-mysql-native |        344ms |  111.7MiB/512MiB(21.81%) |              3s |                3s |  199.8MiB/512MiB(39.03%) |            3s |
................................ + ............ + ........................ + ............... + ................. + ........................ + ............. |
      quarkus-kafka-producer-jvm |       1643ms |  108.9MiB/512MiB(21.27%) |              6s |                4s |  170.4MiB/512MiB(33.28%) |            0s |
    micronaut-kafka-producer-jvm |       1148ms |    125MiB/512MiB(24.41%) |              8s |                4s |  191.5MiB/512MiB(37.40%) |            0s |
   springboot-kafka-producer-jvm |       2180ms |  138.6MiB/512MiB(27.08%) |              8s |                3s |  229.2MiB/512MiB(44.77%) |            2s |
   quarkus-kafka-producer-native |         42ms |   24.65MiB/512MiB(4.81%) |              4s |                2s |   44.66MiB/512MiB(8.72%) |            0s |
 micronaut-kafka-producer-native |         55ms |   32.52MiB/512MiB(6.35%) |              5s |                4s |  90.59MiB/512MiB(17.69%) |            1s |
springboot-kafka-producer-native |        119ms |  55.34MiB/512MiB(10.81%) |              4s |                2s |    107MiB/512MiB(20.90%) |            3s |
................................ + ............ + ........................ + ............... + ................. + ........................ + ............. |
      quarkus-kafka-consumer-jvm |       1341ms |  100.7MiB/512MiB(19.67%) |                                  4s |  136.2MiB/512MiB(26.60%) |            3s |
    micronaut-kafka-consumer-jvm |       1304ms |    130MiB/512MiB(25.39%) |                                  1s |  143.8MiB/512MiB(28.09%) |            1s |
   springboot-kafka-consumer-jvm |       2237ms |  166.6MiB/512MiB(32.53%) |                                  1s |    179MiB/512MiB(34.95%) |            3s |
   quarkus-kafka-consumer-native |         44ms |   21.59MiB/512MiB(4.22%) |                                  3s |  74.71MiB/512MiB(14.59%) |            3s |
 micronaut-kafka-consumer-native |         68ms |   40.94MiB/512MiB(8.00%) |                                  2s |  82.46MiB/512MiB(16.11%) |            0s |
springboot-kafka-consumer-native |        108ms |  81.04MiB/512MiB(15.83%) |                                  1s |  84.38MiB/512MiB(16.48%) |            2s |
................................ + ............ + ........................ + ............... + ................. + ........................ + ............. |
       quarkus-elasticsearch-jvm |       1453ms |  92.74MiB/512MiB(18.11%) |              5s |                3s |  169.5MiB/512MiB(33.11%) |            0s |
     micronaut-elasticsearch-jvm |       1113ms |  124.6MiB/512MiB(24.33%) |              6s |                5s |    174MiB/512MiB(33.98%) |            0s |
    springboot-elasticsearch-jvm |       2495ms |  170.8MiB/512MiB(33.36%) |              4s |                3s |  241.4MiB/512MiB(47.15%) |            2s |
    quarkus-elasticsearch-native |         28ms |   17.55MiB/512MiB(3.43%) |              2s |                2s |  75.05MiB/512MiB(14.66%) |            0s |
  micronaut-elasticsearch-native |         62ms |   28.89MiB/512MiB(5.64%) |              4s |                4s |  82.95MiB/512MiB(16.20%) |            0s |
 springboot-elasticsearch-native |        136ms |  75.83MiB/512MiB(14.81%) |              2s |                2s |  167.8MiB/512MiB(32.78%) |            2s |
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