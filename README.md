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
| ----------- | ------------ |
| Quarkus     | 1.13.7.Final |
| Micronaut   | 2.5.5        |
| Spring Boot | 2.5.1        |

## Prerequisites

- [`Java 11+`](https://www.oracle.com/java/technologies/javase-jdk11-downloads.html)
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
        quarkus-simple-api-jvm |             5s |            14M |                1s |             384MB |
      micronaut-simple-api-jvm |             6s |            15M |               16s |             340MB |
     springboot-simple-api-jvm |            14s |            21M |               23s |             266MB |
.............................. + .............. + .............. + ................. + ................. |
         quarkus-jpa-mysql-jvm |             9s |            32M |                2s |             403MB |
       micronaut-jpa-mysql-jvm |             9s |            34M |               11s |             360MB |
      springboot-jpa-mysql-jvm |            18s |            41M |               26s |             289MB |
.............................. + .............. + .............. + ................. + ................. |
      quarkus-producer-api-jvm |             8s |            35M |                3s |             406MB |
    micronaut-producer-api-jvm |             8s |            29M |               12s |             354MB |
   springboot-producer-api-jvm |            16s |            36M |               24s |             284MB |
.............................. + .............. + .............. + ................. + ................. |
      quarkus-consumer-api-jvm |             6s |            33M |                2s |             404MB |
    micronaut-consumer-api-jvm |             7s |            28M |               11s |             354MB |
   springboot-consumer-api-jvm |            16s |            36M |               25s |             284MB |
.............................. + .............. + .............. + ................. + ................. |
     quarkus-elasticsearch-jvm |             7s |            39M |                2s |             410MB |
   micronaut-elasticsearch-jvm |             9s |            45M |               14s |             371MB |
  springboot-elasticsearch-jvm |            16s |            52M |               27s |             300MB |
```

Table below shows the results after running the script `collect-native-jar-docker-size-times.sh`
```
                    Application | Packaging Time | Packaging Size | Docker Build Time | Docker Image Size |
------------------------------- + -------------- + -------------- + ----------------- + ----------------- |
      quarkus-simple-api-native |           124s |            34M |                3s |             138MB |
    micronaut-simple-api-native |             6s |            16M |              227s |            86.7MB |
   springboot-simple-api-native |            15s |            22M |              534s |             127MB |
............................... + .............. + .............. + ................. + ................. |
       quarkus-jpa-mysql-native |           229s |            71M |                4s |             178MB |
     micronaut-jpa-mysql-native |            10s |            34M |              304s |             122MB |
    springboot-jpa-mysql-native |            20s |            41M |              755s |             169MB |
............................... + .............. + .............. + ................. + ................. |
    quarkus-producer-api-native |           191s |            54M |                6s |             160MB |
  micronaut-producer-api-native |             8s |            29M |              229s |             100MB |
 springboot-producer-api-native |            18s |            36M |              687s |             136MB |
............................... + .............. + .............. + ................. + ................. |
    quarkus-consumer-api-native |           179s |            51M |                3s |             156MB |
  micronaut-consumer-api-native |             6s |            29M |              226s |            99.9MB |
 springboot-consumer-api-native |            15s |            36M |              680s |             136MB |
............................... + .............. + .............. + ................. + ................. |
   quarkus-elasticsearch-native |           196s |            53M |                3s |             158MB |
 micronaut-elasticsearch-native |             8s |            45M |              286s |             103MB |
springboot-elasticsearch-native |            19s |            52M |              830s |             175MB |
```

Finally, the following table shows the results after running the script `collect-ab-times-memory-usage.sh`
```
                    Application | Startup Time |     Initial Memory Usage | Ab Testing Time | Ab Testing Time 2 |       Final Memory Usage | Shutdown Time |
------------------------------- + ------------ + ------------------------ + --------------- + ----------------- + ------------------------ + ------------- |
         quarkus-simple-api-jvm |       1464ms |  53.41MiB/256MiB(20.86%) |              9s |                7s |    115MiB/256MiB(44.92%) |            1s |
       micronaut-simple-api-jvm |       6660ms |  70.39MiB/256MiB(27.50%) |             11s |                6s |  102.8MiB/256MiB(40.14%) |            1s |
      springboot-simple-api-jvm |       2920ms |  117.3MiB/256MiB(45.81%) |             11s |                7s |  193.6MiB/256MiB(75.61%) |            3s |
      quarkus-simple-api-native |         20ms |   4.555MiB/256MiB(1.78%) |              6s |                7s |  33.18MiB/256MiB(12.96%) |            1s |
    micronaut-simple-api-native |         27ms |   8.023MiB/256MiB(3.13%) |              5s |                4s |  157.9MiB/256MiB(61.66%) |            1s |
   springboot-simple-api-native |        145ms |  36.32MiB/256MiB(14.19%) |              5s |                9s |  106.1MiB/256MiB(41.44%) |            4s |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
          quarkus-jpa-mysql-jvm |       2902ms |  104.5MiB/256MiB(40.82%) |              8s |                5s |  157.2MiB/256MiB(61.41%) |            2s |
        micronaut-jpa-mysql-jvm |       8555ms |  106.7MiB/256MiB(41.67%) |              9s |                5s |  156.1MiB/256MiB(60.96%) |            2s |
       springboot-jpa-mysql-jvm |       5013ms |  180.2MiB/256MiB(70.39%) |              9s |                6s |  238.1MiB/256MiB(93.03%) |            3s |
       quarkus-jpa-mysql-native |         89ms |   8.359MiB/256MiB(3.27%) |              5s |                5s |  43.18MiB/256MiB(16.87%) |            2s |
     micronaut-jpa-mysql-native |        164ms |   21.12MiB/256MiB(8.25%) |              5s |                5s |  169.4MiB/256MiB(66.16%) |            1s |
    springboot-jpa-mysql-native |        356ms |   46.6MiB/256MiB(18.20%) |              5s |                5s |  117.4MiB/256MiB(45.86%) |            3s |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
       quarkus-producer-api-jvm |       2165ms |  89.38MiB/256MiB(34.92%) |             14s |               10s |  162.1MiB/256MiB(63.31%) |            2s |
     micronaut-producer-api-jvm |       6665ms |   73.4MiB/256MiB(28.67%) |             13s |                9s |  128.7MiB/256MiB(50.26%) |            2s |
    springboot-producer-api-jvm |       3784ms |  140.3MiB/256MiB(54.81%) |             12s |                9s |  194.9MiB/256MiB(76.15%) |            4s |
    quarkus-producer-api-native |        220ms |   7.527MiB/256MiB(2.94%) |             10s |               10s |  41.86MiB/256MiB(16.35%) |            2s |
  micronaut-producer-api-native |      10069ms |   9.422MiB/256MiB(3.68%) |              9s |                9s |  171.9MiB/256MiB(67.16%) |            2s |
 springboot-producer-api-native |        280ms |  41.22MiB/256MiB(16.10%) |              8s |                8s |  114.2MiB/256MiB(44.61%) |            4s |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
       quarkus-consumer-api-jvm |       1729ms |  81.42MiB/256MiB(31.80%) |                                  6s |  127.1MiB/256MiB(49.65%) |            5s |
     micronaut-consumer-api-jvm |       2366ms |  105.2MiB/256MiB(41.11%) |                                  4s |  96.39MiB/256MiB(37.65%) |            1s |
    springboot-consumer-api-jvm |       3504ms |  151.3MiB/256MiB(59.10%) |                                  2s |  160.8MiB/256MiB(62.81%) |            4s |
    quarkus-consumer-api-native |         62ms |   8.891MiB/256MiB(3.47%) |                                  5s |  40.18MiB/256MiB(15.70%) |            5s |
  micronaut-consumer-api-native |        109ms |   12.73MiB/256MiB(4.97%) |                                  4s |  36.08MiB/256MiB(14.09%) |            1s |
 springboot-consumer-api-native |        222ms |  43.24MiB/256MiB(16.89%) |                                  2s |  46.25MiB/256MiB(18.07%) |            3s |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
      quarkus-elasticsearch-jvm |       1732ms |  66.15MiB/256MiB(25.84%) |             11s |                7s |  136.6MiB/256MiB(53.38%) |            2s |
    micronaut-elasticsearch-jvm |       6660ms |  76.27MiB/256MiB(29.79%) |             10s |                7s |  136.9MiB/256MiB(53.46%) |            2s |
   springboot-elasticsearch-jvm |       4144ms |  200.4MiB/256MiB(78.30%) |             10s |                7s |  242.9MiB/256MiB(94.90%) |            4s |
   quarkus-elasticsearch-native |         42ms |   5.711MiB/256MiB(2.23%) |              7s |                7s |  42.32MiB/256MiB(16.53%) |            2s |
 micronaut-elasticsearch-native |            - |                        - |               - |                 - |                        - |             - |
springboot-elasticsearch-native |        268ms |  90.54MiB/256MiB(35.37%) |              5s |                5s |  124.8MiB/256MiB(48.75%) |            4s |
```

**Comments**

- Unable to collect running statistics for `micronaut-elasticsearch-native` See [Issues](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/elasticsearch/micronaut-elasticsearch#issues)

- `micronaut-producer-api-native` or `micronaut-consumer-api-native` has very slow startup time, 10s. See [Micronaut Core, issue #5206](https://github.com/micronaut-projects/micronaut-core/issues/5206)

- Checking the Final Memory Usage column, `Quarkus` native apps have better memory utilization (after load tests) than `Micronaut` and `Spring Boot` ones; In this experiment, we set **256MiB** the container limit memory. If we reduce the container limit memmory to **128MiB**, all `Micronaut` native apps will have memory issues. For `Quarkus` native apps, I was able to reduce the container limit memmory to even **64MiB**. Below it, the apps performance will degrade.

- Comparing `Ab Testing Time` with `Ab Testing Time 2` columns, we can see that JVM was able to perform some runtime optimizations, making the JVM applications to perform faster on the second ab test run.

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
