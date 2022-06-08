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
| Micronaut   | 3.5.1       |
| Spring Boot | 2.7.0       |

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
     springboot-simple-api-jvm |            15s |            23M |               13s |             270MB |
.............................. + .............. + .............. + ................. + ................. |
         quarkus-jpa-mysql-jvm |             9s |            34M |                3s |             471MB |
       micronaut-jpa-mysql-jvm |            10s |            34M |               13s |             361MB |
      springboot-jpa-mysql-jvm |            20s |            43M |               10s |             293MB |
.............................. + .............. + .............. + ................. + ................. |
      quarkus-producer-api-jvm |             7s |            34M |                3s |             470MB |
    micronaut-producer-api-jvm |             9s |            29M |               13s |             355MB |
   springboot-producer-api-jvm |            16s |            39M |               13s |             288MB |
.............................. + .............. + .............. + ................. + ................. |
      quarkus-consumer-api-jvm |             8s |            32M |                2s |             468MB |
    micronaut-consumer-api-jvm |             8s |            29M |               12s |             355MB |
   springboot-consumer-api-jvm |            17s |            37M |               10s |             286MB |
.............................. + .............. + .............. + ................. + ................. |
     quarkus-elasticsearch-jvm |             8s |            41M |                4s |             478MB |
   micronaut-elasticsearch-jvm |            11s |            57M |               14s |             385MB |
  springboot-elasticsearch-jvm |            18s |            65M |               12s |             316MB |
```

Table below shows the results after running the script `collect-native-jar-docker-size-times.sh`
```
                    Application | Packaging Time | Packaging Size | Docker Build Time | Docker Image Size |
------------------------------- + -------------- + -------------- + ----------------- + ----------------- |
      quarkus-simple-api-native |           170s |            42M |                6s |             147MB |
    micronaut-simple-api-native |             6s |            15M |               12s |            77.1MB |
   springboot-simple-api-native |            15s |            23M |              302s |             101MB |
............................... + .............. + .............. + ................. + ................. |
       quarkus-jpa-mysql-native |           271s |            78M |                6s |             184MB |
     micronaut-jpa-mysql-native |            12s |            35M |              325s |             116MB |
    springboot-jpa-mysql-native |            24s |            43M |              749s |             145MB |
............................... + .............. + .............. + ................. + ................. |
    quarkus-producer-api-native |           224s |            60M |               10s |             165MB |
  micronaut-producer-api-native |             8s |            29M |              238s |            94.9MB |
 springboot-producer-api-native |            17s |            39M |              561s |             124MB |
............................... + .............. + .............. + ................. + ................. |
    quarkus-consumer-api-native |           208s |            57M |                4s |             162MB |
  micronaut-consumer-api-native |             8s |            29M |              227s |            94.7MB |
 springboot-consumer-api-native |            17s |            37M |              483s |             108MB |
............................... + .............. + .............. + ................. + ................. |
   quarkus-elasticsearch-native |           214s |            51M |                8s |             156MB |
 micronaut-elasticsearch-native |            10s |            57M |              271s |            97.7MB |
springboot-elasticsearch-native |            19s |            65M |              607s |             118MB |
```

Finally, the following table shows the results after running the script `collect-ab-times-memory-usage.sh`

> **Note:** in order to a better insight about the Docker container's CPU and Memory Usage, we can use [`cAdvisor`](https://github.com/google/cadvisor). In the section [Monitoring CPU and Memory with cAdvisor](#monitoring-cpu-and-memory-with-cadvisor), we explain how to start it.

```
                    Application | Startup Time |     Initial Memory Usage | Ab Testing Time | Ab Testing Time 2 |       Final Memory Usage | Shutdown Time |
------------------------------- + ------------ + ------------------------ + --------------- + ----------------- + ------------------------ + ------------- |
         quarkus-simple-api-jvm |        978ms |  98.23MiB/512MiB(19.19%) |              5s |                3s |  191.1MiB/512MiB(37.33%) |            1s |
       micronaut-simple-api-jvm |       1298ms |  92.79MiB/512MiB(18.12%) |              9s |                5s |  110.4MiB/512MiB(21.56%) |            0s |
      springboot-simple-api-jvm |       2387ms |  277.5MiB/512MiB(54.20%) |              8s |                5s |  400.3MiB/512MiB(78.18%) |            3s |
      quarkus-simple-api-native |         25ms |   5.445MiB/512MiB(1.06%) |              4s |                3s |  262.9MiB/512MiB(51.35%) |            0s |
    micronaut-simple-api-native |         39ms |   9.238MiB/512MiB(1.80%) |              3s |                5s |   24.41MiB/512MiB(4.77%) |            0s |
   springboot-simple-api-native |         75ms |   27.89MiB/512MiB(5.45%) |              5s |                4s |   49.97MiB/512MiB(9.76%) |            3s |
............................... + ............ + ........................ + ............... + ................. + ........................ + ............. |
          quarkus-jpa-mysql-jvm |       1545ms |  174.7MiB/512MiB(34.12%) |              6s |                3s |  247.1MiB/512MiB(48.26%) |            1s |
        micronaut-jpa-mysql-jvm |       3097ms |  106.2MiB/512MiB(20.74%) |              6s |                4s |    168MiB/512MiB(32.81%) |            0s |
       springboot-jpa-mysql-jvm |       3913ms |  368.9MiB/512MiB(72.06%) |              7s |                4s |  481.8MiB/512MiB(94.10%) |            3s |
       quarkus-jpa-mysql-native |         43ms |    7.82MiB/512MiB(1.53%) |              2s |                3s |    266MiB/512MiB(51.96%) |            0s |
     micronaut-jpa-mysql-native |         82ms |   20.95MiB/512MiB(4.09%) |              3s |                2s |   29.52MiB/512MiB(5.76%) |            0s |
    springboot-jpa-mysql-native |        161ms |  65.81MiB/512MiB(12.85%) |              3s |                3s |  94.49MiB/512MiB(18.45%) |            2s |
............................... + ............ + ........................ + ............... + ................. + ........................ + ............. |
       quarkus-producer-api-jvm |       1261ms |    139MiB/512MiB(27.15%) |              8s |                5s |  232.7MiB/512MiB(45.46%) |            0s |
     micronaut-producer-api-jvm |       1327ms |  87.23MiB/512MiB(17.04%) |             10s |                5s |  135.1MiB/512MiB(26.38%) |            1s |
    springboot-producer-api-jvm |       2766ms |  275.5MiB/512MiB(53.81%) |             11s |                6s |  511.9MiB/512MiB(99.99%) |            2s |
    quarkus-producer-api-native |         30ms |   8.098MiB/512MiB(1.58%) |              5s |                4s |  267.1MiB/512MiB(52.16%) |            0s |
  micronaut-producer-api-native |         43ms |   9.762MiB/512MiB(1.91%) |              6s |                5s |   36.48MiB/512MiB(7.12%) |            0s |
 springboot-producer-api-native |        131ms |   37.43MiB/512MiB(7.31%) |              5s |                5s |   34.35MiB/512MiB(6.71%) |            3s |
............................... + ............ + ........................ + ............... + ................. + ........................ + ............. |
       quarkus-consumer-api-jvm |       1108ms |    135MiB/512MiB(26.36%) |                                  3s |  173.6MiB/512MiB(33.91%) |            3s |
     micronaut-consumer-api-jvm |       1795ms |  106.1MiB/512MiB(20.73%) |                                  4s |  97.71MiB/512MiB(19.08%) |            0s |
    springboot-consumer-api-jvm |       2338ms |  285.9MiB/512MiB(55.83%) |                                  2s |  299.6MiB/512MiB(58.51%) |            3s |
    quarkus-consumer-api-native |         44ms |   9.715MiB/512MiB(1.90%) |                                  4s |  265.8MiB/512MiB(51.92%) |            3s |
  micronaut-consumer-api-native |         58ms |   12.71MiB/512MiB(2.48%) |                                  3s |  57.27MiB/512MiB(11.18%) |            1s |
 springboot-consumer-api-native |         97ms |  67.95MiB/512MiB(13.27%) |                                  1s |  70.69MiB/512MiB(13.81%) |            2s |
............................... + ............ + ........................ + ............... + ................. + ........................ + ............. |
      quarkus-elasticsearch-jvm |       1187ms |  131.2MiB/512MiB(25.63%) |              8s |                4s |  225.4MiB/512MiB(44.02%) |            1s |
    micronaut-elasticsearch-jvm |       1316ms |  100.6MiB/512MiB(19.66%) |              7s |                5s |  149.7MiB/512MiB(29.24%) |            0s |
   springboot-elasticsearch-jvm |       3248ms |  316.3MiB/512MiB(61.77%) |              7s |                4s |  484.3MiB/512MiB(94.58%) |            3s |
   quarkus-elasticsearch-native |         21ms |   5.594MiB/512MiB(1.09%) |              3s |                4s |  263.4MiB/512MiB(51.45%) |            1s |
 micronaut-elasticsearch-native |         35ms |   9.711MiB/512MiB(1.90%) |              4s |                4s |   35.68MiB/512MiB(6.97%) |            0s |
springboot-elasticsearch-native |         84ms |   35.68MiB/512MiB(6.97%) |              3s |                3s |  60.92MiB/512MiB(11.90%) |            2s |
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