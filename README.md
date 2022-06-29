# graalvm-quarkus-micronaut-springboot

The goal of this project is to compare some Java frameworks like: [`Quarkus`](https://quarkus.io/), [`Micronaut`](https://micronaut.io/) and [`Spring Boot`](https://docs.spring.io/spring-boot/docs/current/reference/htmlsingle/). For it, we will implement applications using those frameworks, build their JVM and Native Docker images and measure start-up times, memory footprint, etc.

## Examples

- ### [simple-api](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/simple-api#graalvm-quarkus-micronaut-springboot)
- ### [jpa-mysql](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/jpa-mysql#graalvm-quarkus-micronaut-springboot)
- ### [producer-consumer](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/producer-consumer#graalvm-quarkus-micronaut-springboot)
- ### [elasticsearch](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/elasticsearch#graalvm-quarkus-micronaut-springboot)

## Framework version

We are using the following Framework versions

| Framework   | Version      |
|-------------|--------------|
| Quarkus     | 2.10.0.Final |
| Micronaut   | 3.5.2        |
| Spring Boot | 2.7.1        |

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
        quarkus-simple-api-jvm |             6s |            16M |                4s |             452MB |
      micronaut-simple-api-jvm |             5s |            16M |               15s |             341MB |
     springboot-simple-api-jvm |            14s |            23M |               12s |             264MB |
.............................. + .............. + .............. + ................. + ................. |
         quarkus-jpa-mysql-jvm |            10s |            34M |                3s |             471MB |
       micronaut-jpa-mysql-jvm |            10s |            34M |               11s |             361MB |
      springboot-jpa-mysql-jvm |            18s |            43M |               12s |             288MB |
.............................. + .............. + .............. + ................. + ................. |
      quarkus-producer-api-jvm |             8s |            34M |                2s |             470MB |
    micronaut-producer-api-jvm |             8s |            29M |               11s |             355MB |
   springboot-producer-api-jvm |            14s |            39M |               11s |             283MB |
.............................. + .............. + .............. + ................. + ................. |
      quarkus-consumer-api-jvm |             7s |            32M |                2s |             468MB |
    micronaut-consumer-api-jvm |             7s |            29M |               10s |             355MB |
   springboot-consumer-api-jvm |            14s |            37M |               10s |             281MB |
.............................. + .............. + .............. + ................. + ................. |
     quarkus-elasticsearch-jvm |             8s |            42M |                2s |             478MB |
   micronaut-elasticsearch-jvm |            11s |            56M |               12s |             385MB |
  springboot-elasticsearch-jvm |            17s |            65M |               10s |             311MB |
```

Table below shows the results after running the script `collect-native-jar-docker-size-times.sh`
```
                    Application | Packaging Time | Packaging Size | Docker Build Time | Docker Image Size |
------------------------------- + -------------- + -------------- + ----------------- + ----------------- |
      quarkus-simple-api-native |           445s |            43M |                4s |             148MB |
    micronaut-simple-api-native |             6s |            15M |              462s |            77.1MB |
   springboot-simple-api-native |            16s |            23M |              449s |             101MB |
............................... + .............. + .............. + ................. + ................. |
       quarkus-jpa-mysql-native |           233s |            76M |                8s |             182MB |
     micronaut-jpa-mysql-native |            12s |            35M |              336s |             116MB |
    springboot-jpa-mysql-native |            23s |            43M |              721s |             145MB |
............................... + .............. + .............. + ................. + ................. |
    quarkus-producer-api-native |           210s |            61M |               12s |             167MB |
  micronaut-producer-api-native |            10s |            29M |              219s |            94.9MB |
 springboot-producer-api-native |            17s |            39M |              556s |             124MB |
............................... + .............. + .............. + ................. + ................. |
    quarkus-consumer-api-native |           186s |            57M |                3s |             162MB |
  micronaut-consumer-api-native |             8s |            29M |              209s |            94.7MB |
 springboot-consumer-api-native |            17s |            37M |              527s |             108MB |
............................... + .............. + .............. + ................. + ................. |
   quarkus-elasticsearch-native |           197s |            52M |                9s |             157MB |
 micronaut-elasticsearch-native |            12s |            57M |              247s |            97.7MB |
springboot-elasticsearch-native |            21s |            65M |              655s |             118MB |
```

Finally, the following table shows the results after running the script `collect-ab-times-memory-usage.sh`

> **Note:** in order to a better insight about the Docker container's CPU and Memory Usage, we can use [`cAdvisor`](https://github.com/google/cadvisor). In the section [Monitoring CPU and Memory with cAdvisor](#monitoring-cpu-and-memory-with-cadvisor), we explain how to start it.

```
                    Application | Startup Time |     Initial Memory Usage | Ab Testing Time | Ab Testing Time 2 |       Final Memory Usage | Shutdown Time |
------------------------------- + ------------ + ------------------------ + --------------- + ----------------- + ------------------------ + ------------- |
         quarkus-simple-api-jvm |        925ms |  102.6MiB/512MiB(20.04%) |              5s |                4s |  218.1MiB/512MiB(42.59%) |            0s |
       micronaut-simple-api-jvm |       6435ms |  81.84MiB/512MiB(15.98%) |              6s |                5s |  108.5MiB/512MiB(21.20%) |            1s |
      springboot-simple-api-jvm |       2912ms |  249.1MiB/512MiB(48.65%) |             11s |                5s |  431.8MiB/512MiB(84.33%) |            2s |
      quarkus-simple-api-native |         31ms |   6.496MiB/512MiB(1.27%) |              4s |                3s |   49.71MiB/512MiB(9.71%) |            0s |
    micronaut-simple-api-native |         39ms |   9.266MiB/512MiB(1.81%) |              3s |                5s |   27.39MiB/512MiB(5.35%) |            0s |
   springboot-simple-api-native |         71ms |   27.76MiB/512MiB(5.42%) |              4s |                5s |    48.8MiB/512MiB(9.53%) |            3s |
............................... + ............ + ........................ + ............... + ................. + ........................ + ............. |
          quarkus-jpa-mysql-jvm |       1769ms |  175.6MiB/512MiB(34.30%) |              6s |                4s |  250.8MiB/512MiB(48.98%) |            1s |
        micronaut-jpa-mysql-jvm |       8233ms |    106MiB/512MiB(20.71%) |              6s |                5s |  160.4MiB/512MiB(31.32%) |            1s |
       springboot-jpa-mysql-jvm |       4425ms |  341.3MiB/512MiB(66.67%) |              8s |                6s |  511.8MiB/512MiB(99.97%) |            2s |
       quarkus-jpa-mysql-native |         38ms |   9.133MiB/512MiB(1.78%) |              3s |                3s |  54.12MiB/512MiB(10.57%) |            0s |
     micronaut-jpa-mysql-native |        134ms |   21.01MiB/512MiB(4.10%) |              3s |                4s |   34.64MiB/512MiB(6.77%) |            0s |
    springboot-jpa-mysql-native |        183ms |  65.78MiB/512MiB(12.85%) |              3s |                4s |  106.2MiB/512MiB(20.74%) |            2s |
............................... + ............ + ........................ + ............... + ................. + ........................ + ............. |
       quarkus-producer-api-jvm |       1403ms |  140.7MiB/512MiB(27.47%) |              8s |                5s |  233.5MiB/512MiB(45.60%) |            0s |
     micronaut-producer-api-jvm |       6510ms |  87.61MiB/512MiB(17.11%) |             10s |                6s |  135.5MiB/512MiB(26.47%) |            0s |
    springboot-producer-api-jvm |       3367ms |    258MiB/512MiB(50.40%) |             12s |                8s |  493.8MiB/512MiB(96.45%) |            3s |
    quarkus-producer-api-native |         30ms |   9.375MiB/512MiB(1.83%) |              6s |                6s |  65.12MiB/512MiB(12.72%) |            0s |
  micronaut-producer-api-native |         38ms |    9.77MiB/512MiB(1.91%) |              6s |                6s |    26.7MiB/512MiB(5.21%) |            0s |
 springboot-producer-api-native |        179ms |   37.45MiB/512MiB(7.31%) |              4s |                5s |   34.26MiB/512MiB(6.69%) |            2s |
............................... + ............ + ........................ + ............... + ................. + ........................ + ............. |
       quarkus-consumer-api-jvm |       1136ms |  135.8MiB/512MiB(26.53%) |                                  5s |  193.8MiB/512MiB(37.86%) |            3s |
     micronaut-consumer-api-jvm |       2703ms |  85.05MiB/512MiB(16.61%) |                                  4s |  98.02MiB/512MiB(19.14%) |            1s |
    springboot-consumer-api-jvm |       3573ms |  262.5MiB/512MiB(51.27%) |                                  2s |  290.7MiB/512MiB(56.77%) |            2s |
    quarkus-consumer-api-native |         39ms |   11.11MiB/512MiB(2.17%) |                                  2s |  59.65MiB/512MiB(11.65%) |            3s |
  micronaut-consumer-api-native |         60ms |   12.77MiB/512MiB(2.49%) |                                  2s |  57.23MiB/512MiB(11.18%) |            0s |
 springboot-consumer-api-native |        101ms |  68.51MiB/512MiB(13.38%) |                                  0s |  70.65MiB/512MiB(13.80%) |            3s |
............................... + ............ + ........................ + ............... + ................. + ........................ + ............. |
      quarkus-elasticsearch-jvm |       1162ms |  127.5MiB/512MiB(24.90%) |              8s |                4s |  216.8MiB/512MiB(42.35%) |            0s |
    micronaut-elasticsearch-jvm |       6790ms |  72.11MiB/512MiB(14.08%) |              8s |                5s |  156.3MiB/512MiB(30.54%) |            0s |
   springboot-elasticsearch-jvm |       3528ms |  280.6MiB/512MiB(54.80%) |              8s |                6s |  486.7MiB/512MiB(95.06%) |            2s |
   quarkus-elasticsearch-native |         19ms |   6.676MiB/512MiB(1.30%) |              3s |                4s |  52.99MiB/512MiB(10.35%) |            0s |
 micronaut-elasticsearch-native |         89ms |   9.723MiB/512MiB(1.90%) |              5s |                6s |   32.45MiB/512MiB(6.34%) |            0s |
springboot-elasticsearch-native |         87ms |    35.7MiB/512MiB(6.97%) |              4s |                4s |  63.94MiB/512MiB(12.49%) |            2s |
```

**Comments**

- Comparing `Ab Testing Time` with `Ab Testing Time 2` columns, we can see that JVM was able to perform some runtime optimizations, making the JVM applications to perform faster on the second ab test run;

- `ab` tests used
  ```
                      Application | ab Test                                                                                      |
  ------------------------------- + -------------------------------------------------------------------------------------------- |
           quarkus-simple-api-jvm | ab -c 10 -n 4000 'http://localhost:9080/api/greeting?name=Ivan'                              |
         micronaut-simple-api-jvm | ab -c 10 -n 4000 'http://localhost:9082/api/greeting?name=Ivan'                              |
        springboot-simple-api-jvm | ab -c 10 -n 4000 'http://localhost:9084/api/greeting?name=Ivan'                              |
        quarkus-simple-api-native | ab -c 10 -n 4000 'http://localhost:9081/api/greeting?name=Ivan'                              |
      micronaut-simple-api-native | ab -c 10 -n 4000 'http://localhost:9083/api/greeting?name=Ivan'                              |
     springboot-simple-api-native | ab -c 10 -n 4000 'http://localhost:9085/api/greeting?name=Ivan'                              |
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