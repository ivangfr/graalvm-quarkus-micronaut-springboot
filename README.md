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
| Quarkus     | 2.9.2.Final |
| Micronaut   | 3.4.4       |
| Spring Boot | 2.6.8       |

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
    micronaut-producer-api-jvm |             9s |            28M |               13s |             355MB |
   springboot-producer-api-jvm |            16s |            38M |               13s |             287MB |
.............................. + .............. + .............. + ................. + ................. |
      quarkus-consumer-api-jvm |             8s |            32M |                2s |             468MB |
    micronaut-consumer-api-jvm |             8s |            28M |               12s |             355MB |
   springboot-consumer-api-jvm |            17s |            37M |               10s |             285MB |
.............................. + .............. + .............. + ................. + ................. |
     quarkus-elasticsearch-jvm |             8s |            41M |                4s |             478MB |
   micronaut-elasticsearch-jvm |            11s |            57M |               14s |             384MB |
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
   quarkus-elasticsearch-native |           214s |            51M |                8s |             156MB |
 micronaut-elasticsearch-native |            10s |            57M |              271s |            94.4MB |
springboot-elasticsearch-native |            19s |            54M |              607s |             117MB |
```

Finally, the following table shows the results after running the script `collect-ab-times-memory-usage.sh`

> **Note:** in order to a better insight about the Docker container's CPU and Memory Usage, we can use [`cAdvisor`](https://github.com/google/cadvisor). In the section [Monitoring CPU and Memory with cAdvisor](#monitoring-cpu-and-memory-with-cadvisor), we explain how to start it.

```
                    Application | Startup Time |     Initial Memory Usage | Ab Testing Time | Ab Testing Time 2 |       Final Memory Usage | Shutdown Time |
------------------------------- + ------------ + ------------------------ + --------------- + ----------------- + ------------------------ + ------------- |
         quarkus-simple-api-jvm |        913ms |  98.95MiB/512MiB(19.33%) |              5s |                4s |  197.4MiB/512MiB(38.55%) |            1s |
       micronaut-simple-api-jvm |       1407ms |  81.03MiB/512MiB(15.83%) |              9s |                5s |  108.8MiB/512MiB(21.26%) |            1s |
      springboot-simple-api-jvm |       2545ms |    243MiB/512MiB(47.46%) |              9s |                4s |  408.5MiB/512MiB(79.79%) |            3s |
      quarkus-simple-api-native |         20ms |   5.457MiB/512MiB(1.07%) |              3s |                3s |  263.3MiB/512MiB(51.43%) |            0s |
    micronaut-simple-api-native |         31ms |   8.691MiB/512MiB(1.70%) |              3s |                4s |   33.34MiB/512MiB(6.51%) |            0s |
   springboot-simple-api-native |         59ms |    27.6MiB/512MiB(5.39%) |              3s |                4s |  51.58MiB/512MiB(10.07%) |            3s |
............................... + ............ + ........................ + ............... + ................. + ........................ + ............. |
          quarkus-jpa-mysql-jvm |       1641ms |  169.3MiB/512MiB(33.07%) |              8s |                3s |  241.6MiB/512MiB(47.20%) |            0s |
        micronaut-jpa-mysql-jvm |       2904ms |  102.2MiB/512MiB(19.97%) |              7s |                5s |  159.6MiB/512MiB(31.18%) |            1s |
       springboot-jpa-mysql-jvm |       3988ms |  373.5MiB/512MiB(72.94%) |              7s |                5s |  471.1MiB/512MiB(92.00%) |            2s |
       quarkus-jpa-mysql-native |         30ms |   7.848MiB/512MiB(1.53%) |              3s |                3s |  265.8MiB/512MiB(51.91%) |            1s |
     micronaut-jpa-mysql-native |         61ms |   18.66MiB/512MiB(3.65%) |              2s |                2s |   40.34MiB/512MiB(7.88%) |            0s |
    springboot-jpa-mysql-native |        158ms |  65.46MiB/512MiB(12.78%) |              3s |                4s |  97.48MiB/512MiB(19.04%) |            3s |
............................... + ............ + ........................ + ............... + ................. + ........................ + ............. |
       quarkus-producer-api-jvm |       1286ms |  139.2MiB/512MiB(27.19%) |              8s |                5s |    256MiB/512MiB(49.99%) |            1s |
     micronaut-producer-api-jvm |       1326ms |  86.84MiB/512MiB(16.96%) |             11s |                5s |  139.2MiB/512MiB(27.18%) |            0s |
    springboot-producer-api-jvm |       2805ms |  285.4MiB/512MiB(55.74%) |             12s |                6s |    442MiB/512MiB(86.34%) |            3s |
    quarkus-producer-api-native |         25ms |   8.098MiB/512MiB(1.58%) |              6s |                5s |  267.4MiB/512MiB(52.22%) |            0s |
  micronaut-producer-api-native |         40ms |   9.062MiB/512MiB(1.77%) |              6s |                5s |   30.29MiB/512MiB(5.92%) |            0s |
 springboot-producer-api-native |        128ms |   37.28MiB/512MiB(7.28%) |              6s |                5s |   33.34MiB/512MiB(6.51%) |            2s |
............................... + ............ + ........................ + ............... + ................. + ........................ + ............. |
       quarkus-consumer-api-jvm |       1065ms |  135.4MiB/512MiB(26.45%) |                                  4s |  186.8MiB/512MiB(36.48%) |            3s |
     micronaut-consumer-api-jvm |       1778ms |  104.6MiB/512MiB(20.44%) |                                  3s |  97.46MiB/512MiB(19.04%) |            1s |
    springboot-consumer-api-jvm |       2327ms |  272.8MiB/512MiB(53.29%) |                                  1s |  293.5MiB/512MiB(57.33%) |            2s |
    quarkus-consumer-api-native |         28ms |    9.75MiB/512MiB(1.90%) |                                  2s |  265.7MiB/512MiB(51.89%) |            2s |
  micronaut-consumer-api-native |         46ms |   12.17MiB/512MiB(2.38%) |                                  2s |  56.21MiB/512MiB(10.98%) |            0s |
 springboot-consumer-api-native |         87ms |  68.43MiB/512MiB(13.37%) |                                  0s |  70.53MiB/512MiB(13.78%) |            3s |
............................... + ............ + ........................ + ............... + ................. + ........................ + ............. |
      quarkus-elasticsearch-jvm |       1148ms |  125.8MiB/512MiB(24.57%) |              8s |                4s |  215.3MiB/512MiB(42.05%) |            1s |
    micronaut-elasticsearch-jvm |       1417ms |  82.48MiB/512MiB(16.11%) |              7s |                5s |  147.8MiB/512MiB(28.87%) |            0s |
   springboot-elasticsearch-jvm |       2735ms |  283.6MiB/512MiB(55.38%) |              7s |                6s |    512MiB/512MiB(99.99%) |            2s |
   quarkus-elasticsearch-native |         21ms |   5.605MiB/512MiB(1.09%) |              3s |                5s |  263.8MiB/512MiB(51.53%) |            1s |
 micronaut-elasticsearch-native |         32ms |   8.938MiB/512MiB(1.75%) |              4s |                4s |   25.87MiB/512MiB(5.05%) |            1s |
springboot-elasticsearch-native |         80ms |   35.39MiB/512MiB(6.91%) |              3s |                4s |     60MiB/512MiB(11.72%) |            3s |
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