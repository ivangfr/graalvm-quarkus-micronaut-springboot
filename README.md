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
| Quarkus     | 2.9.0.Final |
| Micronaut   | 3.4.3       |
| Spring Boot | 2.6.7       |

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
        quarkus-simple-api-jvm |             6s |            16M |                3s |             452MB |
      micronaut-simple-api-jvm |             6s |            15M |               17s |             341MB |
     springboot-simple-api-jvm |            15s |            23M |               13s |             269MB |
.............................. + .............. + .............. + ................. + ................. |
         quarkus-jpa-mysql-jvm |             9s |            34M |                3s |             471MB |
       micronaut-jpa-mysql-jvm |            10s |            34M |               13s |             361MB |
      springboot-jpa-mysql-jvm |            20s |            43M |               10s |             292MB |
.............................. + .............. + .............. + ................. + ................. |
      quarkus-producer-api-jvm |             7s |            34M |                3s |             470MB |
    micronaut-producer-api-jvm |             9s |            29M |               13s |             355MB |
   springboot-producer-api-jvm |            16s |            38M |               13s |             287MB |
.............................. + .............. + .............. + ................. + ................. |
      quarkus-consumer-api-jvm |             8s |            32M |                2s |             468MB |
    micronaut-consumer-api-jvm |             8s |            28M |               12s |             355MB |
   springboot-consumer-api-jvm |            17s |            37M |               10s |             285MB |
.............................. + .............. + .............. + ................. + ................. |
     quarkus-elasticsearch-jvm |             8s |            41M |                4s |             478MB |
   micronaut-elasticsearch-jvm |            11s |            56M |               14s |             384MB |
  springboot-elasticsearch-jvm |            18s |            54M |               12s |             303MB |
```

Table below shows the results after running the script `collect-native-jar-docker-size-times.sh`
```
                    Application | Packaging Time | Packaging Size | Docker Build Time | Docker Image Size |
------------------------------- + -------------- + -------------- + ----------------- + ----------------- |
      quarkus-simple-api-native |           170s |            42M |                6s |             147MB |
    micronaut-simple-api-native |             6s |            16M |               12s |              76MB |
   springboot-simple-api-native |            15s |            23M |              302s |             100MB |
............................... + .............. + .............. + ................. + ................. |
       quarkus-jpa-mysql-native |           271s |            78M |                6s |             184MB |
     micronaut-jpa-mysql-native |            12s |            34M |              325s |             113MB |
    springboot-jpa-mysql-native |            24s |            43M |              749s |             144MB |
............................... + .............. + .............. + ................. + ................. |
    quarkus-producer-api-native |           224s |            60M |               10s |             165MB |
  micronaut-producer-api-native |             8s |            28M |              238s |              92MB |
 springboot-producer-api-native |            17s |            38M |              561s |             123MB |
............................... + .............. + .............. + ................. + ................. |
    quarkus-consumer-api-native |           208s |            57M |                4s |             162MB |
  micronaut-consumer-api-native |             8s |            29M |              227s |            91.8MB |
 springboot-consumer-api-native |            17s |            37M |              483s |             107MB |
............................... + .............. + .............. + ................. + ................. |
   quarkus-elasticsearch-native |           214s |            50M |                8s |             155MB |
 micronaut-elasticsearch-native |            10s |            57M |              271s |            94.4MB |
springboot-elasticsearch-native |            19s |            54M |              607s |             117MB |
```

Finally, the following table shows the results after running the script `collect-ab-times-memory-usage.sh`

> **Note:** in order to a better insight about the Docker container's CPU and Memory Usage, we can use [`cAdvisor`](https://github.com/google/cadvisor). In the section [Monitoring CPU and Memory with cAdvisor](#monitoring-cpu-and-memory-with-cadvisor), we explain how to start it.

```
                    Application | Startup Time |     Initial Memory Usage | Ab Testing Time | Ab Testing Time 2 |       Final Memory Usage | Shutdown Time |
------------------------------- + ------------ + ------------------------ + --------------- + ----------------- + ------------------------ + ------------- |
         quarkus-simple-api-jvm |       1576ms |  98.92MiB/512MiB(19.32%) |              9s |                6s |  228.5MiB/512MiB(44.63%) |            1s |
       micronaut-simple-api-jvm |       6645ms |  80.32MiB/512MiB(15.69%) |             10s |                8s |  109.6MiB/512MiB(21.40%) |            0s |
      springboot-simple-api-jvm |       3332ms |  244.2MiB/512MiB(47.69%) |             12s |                6s |    388MiB/512MiB(75.78%) |            3s |
      quarkus-simple-api-native |         23ms |   5.387MiB/512MiB(1.05%) |              8s |                8s |  263.1MiB/512MiB(51.38%) |            0s |
    micronaut-simple-api-native |         40ms |   8.688MiB/512MiB(1.70%) |              8s |                6s |   22.95MiB/512MiB(4.48%) |            0s |
   springboot-simple-api-native |         93ms |   25.61MiB/512MiB(5.00%) |              8s |                9s |   50.05MiB/512MiB(9.78%) |            2s |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
          quarkus-jpa-mysql-jvm |       2801ms |  154.7MiB/512MiB(30.21%) |              9s |                6s |  250.3MiB/512MiB(48.89%) |            0s |
        micronaut-jpa-mysql-jvm |       8609ms |  102.4MiB/512MiB(20.00%) |              9s |                5s |  159.6MiB/512MiB(31.17%) |            0s |
       springboot-jpa-mysql-jvm |       5673ms |  367.5MiB/512MiB(71.77%) |             10s |                7s |  502.4MiB/512MiB(98.13%) |            3s |
       quarkus-jpa-mysql-native |         31ms |   7.707MiB/512MiB(1.51%) |              5s |                6s |  265.6MiB/512MiB(51.88%) |            1s |
     micronaut-jpa-mysql-native |         73ms |   18.66MiB/512MiB(3.64%) |              4s |                5s |   34.93MiB/512MiB(6.82%) |            1s |
    springboot-jpa-mysql-native |        199ms |  66.26MiB/512MiB(12.94%) |              5s |                5s |  83.01MiB/512MiB(16.21%) |            2s |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
       quarkus-producer-api-jvm |       2153ms |  138.3MiB/512MiB(27.02%) |             14s |               11s |  238.4MiB/512MiB(46.56%) |            1s |
     micronaut-producer-api-jvm |       6734ms |  86.58MiB/512MiB(16.91%) |             13s |               11s |    138MiB/512MiB(26.96%) |            1s |
    springboot-producer-api-jvm |       4739ms |  298.7MiB/512MiB(58.35%) |             14s |               10s |  426.6MiB/512MiB(83.31%) |            2s |
    quarkus-producer-api-native |         33ms |   8.027MiB/512MiB(1.57%) |              8s |               10s |  266.5MiB/512MiB(52.05%) |            1s |
  micronaut-producer-api-native |      10055ms |   9.035MiB/512MiB(1.76%) |              9s |                9s |   32.34MiB/512MiB(6.32%) |            0s |
 springboot-producer-api-native |        159ms |   34.28MiB/512MiB(6.70%) |              7s |                8s |   33.66MiB/512MiB(6.57%) |            3s |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
       quarkus-consumer-api-jvm |       1785ms |  136.8MiB/512MiB(26.71%) |                                  8s |  182.6MiB/512MiB(35.66%) |            3s |
     micronaut-consumer-api-jvm |       2376ms |  111.8MiB/512MiB(21.83%) |                                  4s |  95.77MiB/512MiB(18.70%) |            0s |
    springboot-consumer-api-jvm |       4043ms |  270.7MiB/512MiB(52.87%) |                                  6s |  353.5MiB/512MiB(69.05%) |            3s |
    quarkus-consumer-api-native |         33ms |   9.691MiB/512MiB(1.89%) |                                  7s |  266.8MiB/512MiB(52.11%) |            3s |
  micronaut-consumer-api-native |         52ms |   12.11MiB/512MiB(2.37%) |                                  7s |  57.77MiB/512MiB(11.28%) |            0s |
 springboot-consumer-api-native |         80ms |   31.93MiB/512MiB(6.24%) |                                  5s |  68.97MiB/512MiB(13.47%) |            2s |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
      quarkus-elasticsearch-jvm |       1936ms |  126.9MiB/512MiB(24.79%) |             12s |                7s |  226.1MiB/512MiB(44.16%) |            1s |
    micronaut-elasticsearch-jvm |       6726ms |   86.1MiB/512MiB(16.82%) |             11s |                7s |    160MiB/512MiB(31.25%) |            1s |
   springboot-elasticsearch-jvm |       4943ms |  292.3MiB/512MiB(57.09%) |             11s |                7s |  479.3MiB/512MiB(93.62%) |            3s |
   quarkus-elasticsearch-native |         22ms |   5.574MiB/512MiB(1.09%) |              6s |                6s |  264.4MiB/512MiB(51.64%) |            0s |
 micronaut-elasticsearch-native |         41ms |   8.918MiB/512MiB(1.74%) |              7s |                6s |   28.85MiB/512MiB(5.63%) |            1s |
springboot-elasticsearch-native |         88ms |   32.47MiB/512MiB(6.34%) |              6s |                6s |  62.21MiB/512MiB(12.15%) |            3s |
```

**Comments**

- Comparing `Ab Testing Time` with `Ab Testing Time 2` columns, we can see that JVM was able to perform some runtime optimizations, making the JVM applications to perform faster on the second ab test run;

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