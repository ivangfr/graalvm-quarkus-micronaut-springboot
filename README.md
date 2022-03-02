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
| Quarkus     | 2.7.2.Final |
| Micronaut   | 3.2.7       |
| Spring Boot | 2.6.4       |

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
        quarkus-simple-api-jvm |             5s |            16M |                3s |             383MB |
      micronaut-simple-api-jvm |             5s |            16M |               17s |             341MB |
     springboot-simple-api-jvm |            14s |            23M |               15s |             294MB |
.............................. + .............. + .............. + ................. + ................. |
         quarkus-jpa-mysql-jvm |             8s |            34M |                3s |             402MB |
       micronaut-jpa-mysql-jvm |            10s |            34M |               13s |             361MB |
      springboot-jpa-mysql-jvm |            26s |            43M |               16s |             318MB |
.............................. + .............. + .............. + ................. + ................. |
      quarkus-producer-api-jvm |             8s |            33M |                4s |             401MB |
    micronaut-producer-api-jvm |             9s |            29M |               13s |             355MB |
   springboot-producer-api-jvm |            16s |            38M |               14s |             313MB |
.............................. + .............. + .............. + ................. + ................. |
      quarkus-consumer-api-jvm |             8s |            32M |                2s |             400MB |
    micronaut-consumer-api-jvm |             9s |            29M |               12s |             355MB |
   springboot-consumer-api-jvm |            15s |            37M |               11s |             311MB |
.............................. + .............. + .............. + ................. + ................. |
     quarkus-elasticsearch-jvm |             7s |            41M |                4s |             410MB |
   micronaut-elasticsearch-jvm |            10s |            57M |               14s |             384MB |
  springboot-elasticsearch-jvm |            17s |            54M |               12s |             329MB |
```

Table below shows the results after running the script `collect-native-jar-docker-size-times.sh`
```
                    Application | Packaging Time | Packaging Size | Docker Build Time | Docker Image Size |
------------------------------- + -------------- + -------------- + ----------------- + ----------------- |
      quarkus-simple-api-native |           174s |            44M |                3s |            84.7MB |
    micronaut-simple-api-native |             5s |            15M |              174s |            76.5MB |
   springboot-simple-api-native |            15s |            23M |              257s |             106MB |
............................... + .............. + .............. + ................. + ................. |
       quarkus-jpa-mysql-native |           263s |            81M |                6s |             124MB |
     micronaut-jpa-mysql-native |             9s |            34M |              249s |             114MB |
    springboot-jpa-mysql-native |            21s |            43M |              409s |             155MB |
............................... + .............. + .............. + ................. + ................. |
    quarkus-producer-api-native |           178s |            63M |                4s |             105MB |
  micronaut-producer-api-native |             7s |            29M |              193s |            92.4MB |
 springboot-producer-api-native |            16s |            38M |              305s |             130MB |
............................... + .............. + .............. + ................. + ................. |
    quarkus-consumer-api-native |           177s |            59M |                4s |            99.9MB |
  micronaut-consumer-api-native |             7s |            29M |              184s |            92.2MB |
 springboot-consumer-api-native |            16s |            37M |              280s |             109MB |
............................... + .............. + .............. + ................. + ................. |
   quarkus-elasticsearch-native |           190s |            52M |                6s |            93.2MB |
 micronaut-elasticsearch-native |             9s |            57M |              222s |            94.9MB |
springboot-elasticsearch-native |            17s |            54M |              370s |             121MB |
```

Finally, the following table shows the results after running the script `collect-ab-times-memory-usage.sh`
```
                    Application | Startup Time |     Initial Memory Usage | Ab Testing Time | Ab Testing Time 2 |       Final Memory Usage | Shutdown Time |
------------------------------- + ------------ + ------------------------ + --------------- + ----------------- + ------------------------ + ------------- |
         quarkus-simple-api-jvm |       1733ms |  92.19MiB/512MiB(18.01%) |              7s |                5s |  276.5MiB/512MiB(54.00%) |            1s |
       micronaut-simple-api-jvm |       1718ms |     81MiB/512MiB(15.82%) |              9s |                5s |    108MiB/512MiB(21.09%) |            0s |
      springboot-simple-api-jvm |       3384ms |  244.5MiB/512MiB(47.75%) |             11s |                7s |  444.3MiB/512MiB(86.78%) |            3s |
      quarkus-simple-api-native |         25ms |       5MiB/512MiB(0.98%) |              5s |                5s |  263.5MiB/512MiB(51.46%) |            0s |
    micronaut-simple-api-native |         39ms |   8.414MiB/512MiB(1.64%) |              5s |                8s |    26.7MiB/512MiB(5.22%) |            0s |
   springboot-simple-api-native |         74ms |   25.59MiB/512MiB(5.00%) |              4s |                6s |   44.07MiB/512MiB(8.61%) |            3s |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
          quarkus-jpa-mysql-jvm |       2798ms |  138.3MiB/512MiB(27.01%) |              9s |                5s |  371.2MiB/512MiB(72.50%) |            1s |
        micronaut-jpa-mysql-jvm |       3647ms |  102.9MiB/512MiB(20.09%) |              8s |                7s |  154.9MiB/512MiB(30.25%) |            0s |
       springboot-jpa-mysql-jvm |       5823ms |  375.1MiB/512MiB(73.27%) |              9s |                6s |  511.8MiB/512MiB(99.96%) |            3s |
       quarkus-jpa-mysql-native |         38ms |   7.387MiB/512MiB(1.44%) |              4s |                5s |  265.3MiB/512MiB(51.82%) |            0s |
     micronaut-jpa-mysql-native |         80ms |   18.22MiB/512MiB(3.56%) |              4s |                6s |   37.86MiB/512MiB(7.40%) |            1s |
    springboot-jpa-mysql-native |        216ms |  65.72MiB/512MiB(12.84%) |              4s |                5s |  84.77MiB/512MiB(16.56%) |            3s |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
       quarkus-producer-api-jvm |       2170ms |  119.5MiB/512MiB(23.35%) |             13s |                9s |  354.7MiB/512MiB(69.27%) |            1s |
     micronaut-producer-api-jvm |       1760ms |  63.42MiB/512MiB(12.39%) |             12s |                9s |  129.1MiB/512MiB(25.21%) |            0s |
    springboot-producer-api-jvm |       4149ms |    274MiB/512MiB(53.51%) |             13s |                9s |  503.7MiB/512MiB(98.37%) |            3s |
    quarkus-producer-api-native |         27ms |   7.496MiB/512MiB(1.46%) |              8s |                9s |  266.3MiB/512MiB(52.00%) |            1s |
  micronaut-producer-api-native |         41ms |   8.734MiB/512MiB(1.71%) |              9s |                8s |    25.2MiB/512MiB(4.92%) |            1s |
 springboot-producer-api-native |        165ms |    34.3MiB/512MiB(6.70%) |              6s |                7s |   34.67MiB/512MiB(6.77%) |            2s |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
       quarkus-consumer-api-jvm |       1806ms |  107.3MiB/512MiB(20.96%) |                                  7s |  350.8MiB/512MiB(68.52%) |            3s |
     micronaut-consumer-api-jvm |       2332ms |  83.27MiB/512MiB(16.26%) |                                  5s |  96.27MiB/512MiB(18.80%) |            1s |
    springboot-consumer-api-jvm |       4130ms |  279.2MiB/512MiB(54.53%) |                                  4s |  306.5MiB/512MiB(59.87%) |            2s |
    quarkus-consumer-api-native |         33ms |    8.73MiB/512MiB(1.71%) |                                  5s |  265.5MiB/512MiB(51.86%) |            2s |
  micronaut-consumer-api-native |         68ms |   11.75MiB/512MiB(2.29%) |                                  5s |  57.77MiB/512MiB(11.28%) |            0s |
 springboot-consumer-api-native |        100ms |   31.88MiB/512MiB(6.23%) |                                  4s |  69.07MiB/512MiB(13.49%) |            4s |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
      quarkus-elasticsearch-jvm |       1856ms |  121.5MiB/512MiB(23.74%) |             11s |                6s |  295.6MiB/512MiB(57.73%) |            1s |
    micronaut-elasticsearch-jvm |       1602ms |  80.41MiB/512MiB(15.70%) |              9s |                7s |  145.5MiB/512MiB(28.41%) |            1s |
   springboot-elasticsearch-jvm |       4410ms |  279.2MiB/512MiB(54.54%) |              9s |                6s |  506.2MiB/512MiB(98.87%) |            3s |
   quarkus-elasticsearch-native |         20ms |   5.141MiB/512MiB(1.00%) |              5s |                5s |  263.4MiB/512MiB(51.44%) |            0s |
 micronaut-elasticsearch-native |         40ms |   8.633MiB/512MiB(1.69%) |              6s |                7s |   27.55MiB/512MiB(5.38%) |            0s |
springboot-elasticsearch-native |        102ms |   32.45MiB/512MiB(6.34%) |              6s |                6s |  59.36MiB/512MiB(11.59%) |            2s |
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
