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
| Quarkus     | 2.7.0.Final |
| Micronaut   | 3.2.7       |
| Spring Boot | 2.6.3       |

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
      micronaut-simple-api-jvm |             5s |            15M |               17s |             341MB |
     springboot-simple-api-jvm |            14s |            23M |               15s |             294MB |
.............................. + .............. + .............. + ................. + ................. |
         quarkus-jpa-mysql-jvm |             8s |            34M |                3s |             402MB |
       micronaut-jpa-mysql-jvm |            10s |            34M |               13s |             361MB |
      springboot-jpa-mysql-jvm |            26s |            43M |               16s |             317MB |
.............................. + .............. + .............. + ................. + ................. |
      quarkus-producer-api-jvm |             8s |            33M |                4s |             401MB |
    micronaut-producer-api-jvm |             9s |            29M |               13s |             355MB |
   springboot-producer-api-jvm |            16s |            38M |               14s |             312MB |
.............................. + .............. + .............. + ................. + ................. |
      quarkus-consumer-api-jvm |             8s |            32M |                2s |             400MB |
    micronaut-consumer-api-jvm |             9s |            29M |               12s |             355MB |
   springboot-consumer-api-jvm |            15s |            37M |               11s |             311MB |
.............................. + .............. + .............. + ................. + ................. |
     quarkus-elasticsearch-jvm |             7s |            41M |                4s |             410MB |
   micronaut-elasticsearch-jvm |            10s |            47M |               14s |             375MB |
  springboot-elasticsearch-jvm |            17s |            54M |               12s |             329MB |
```

Table below shows the results after running the script `collect-native-jar-docker-size-times.sh`
```
                    Application | Packaging Time | Packaging Size | Docker Build Time | Docker Image Size |
------------------------------- + -------------- + -------------- + ----------------- + ----------------- |
      quarkus-simple-api-native |           174s |            44M |                3s |            84.9MB |
    micronaut-simple-api-native |             5s |            15M |              174s |            79.3MB |
   springboot-simple-api-native |            15s |            23M |              257s |             108MB |
............................... + .............. + .............. + ................. + ................. |
       quarkus-jpa-mysql-native |           263s |            81M |                6s |             124MB |
     micronaut-jpa-mysql-native |             9s |            34M |              249s |             119MB |
    springboot-jpa-mysql-native |            21s |            43M |              409s |             160MB |
............................... + .............. + .............. + ................. + ................. |
    quarkus-producer-api-native |           178s |            63M |                4s |             105MB |
  micronaut-producer-api-native |             7s |            29M |              193s |            96.5MB |
 springboot-producer-api-native |            16s |            38M |              305s |             134MB |
............................... + .............. + .............. + ................. + ................. |
    quarkus-consumer-api-native |           177s |            60M |                4s |             101MB |
  micronaut-consumer-api-native |             7s |            29M |              184s |            96.4MB |
 springboot-consumer-api-native |            16s |            37M |              280s |             112MB |
............................... + .............. + .............. + ................. + ................. |
   quarkus-elasticsearch-native |           190s |            52M |                6s |            93.3MB |
 micronaut-elasticsearch-native |             9s |            47M |              222s |            98.8MB |
springboot-elasticsearch-native |            17s |            54M |              370s |             135MB |
```

Finally, the following table shows the results after running the script `collect-ab-times-memory-usage.sh`
```
                    Application | Startup Time |     Initial Memory Usage | Ab Testing Time | Ab Testing Time 2 |       Final Memory Usage | Shutdown Time |
------------------------------- + ------------ + ------------------------ + --------------- + ----------------- + ------------------------ + ------------- |
         quarkus-simple-api-jvm |       1583ms |  77.62MiB/512MiB(15.16%) |              8s |                6s |  301.8MiB/512MiB(58.94%) |            0s |
       micronaut-simple-api-jvm |       1753ms |  80.94MiB/512MiB(15.81%) |              8s |                6s |  106.9MiB/512MiB(20.88%) |            2s |
      springboot-simple-api-jvm |       3839ms |  241.1MiB/512MiB(47.10%) |             12s |                7s |  445.7MiB/512MiB(87.06%) |            2s |
      quarkus-simple-api-native |         18ms |   4.926MiB/512MiB(0.96%) |              5s |                8s |  261.9MiB/512MiB(51.15%) |            1s |
    micronaut-simple-api-native |         42ms |   8.551MiB/512MiB(1.67%) |              5s |                6s |    264MiB/512MiB(51.57%) |            1s |
   springboot-simple-api-native |         84ms |   25.53MiB/512MiB(4.99%) |              6s |                4s |  271.7MiB/512MiB(53.06%) |            2s |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
          quarkus-jpa-mysql-jvm |       2732ms |  156.8MiB/512MiB(30.63%) |              9s |                6s |  364.5MiB/512MiB(71.19%) |            1s |
        micronaut-jpa-mysql-jvm |       3832ms |  101.9MiB/512MiB(19.91%) |              8s |                7s |  153.4MiB/512MiB(29.96%) |            1s |
       springboot-jpa-mysql-jvm |       6121ms |  365.9MiB/512MiB(71.47%) |             10s |                8s |  511.9MiB/512MiB(99.99%) |            2s |
       quarkus-jpa-mysql-native |         41ms |   7.277MiB/512MiB(1.42%) |              6s |                6s |  265.8MiB/512MiB(51.91%) |            0s |
     micronaut-jpa-mysql-native |         82ms |   18.83MiB/512MiB(3.68%) |              4s |                5s |  267.1MiB/512MiB(52.17%) |            0s |
    springboot-jpa-mysql-native |        186ms |  64.77MiB/512MiB(12.65%) |              5s |                5s |  280.1MiB/512MiB(54.71%) |            3s |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
       quarkus-producer-api-jvm |       2129ms |  123.4MiB/512MiB(24.10%) |             13s |               10s |  360.2MiB/512MiB(70.36%) |            1s |
     micronaut-producer-api-jvm |       1676ms |  84.95MiB/512MiB(16.59%) |             12s |               11s |  131.8MiB/512MiB(25.75%) |            1s |
    springboot-producer-api-jvm |       4383ms |  286.2MiB/512MiB(55.90%) |             13s |               12s |  495.8MiB/512MiB(96.83%) |            2s |
    quarkus-producer-api-native |         27ms |    7.27MiB/512MiB(1.42%) |              7s |               10s |  266.5MiB/512MiB(52.05%) |            0s |
  micronaut-producer-api-native |         39ms |   8.859MiB/512MiB(1.73%) |              8s |               10s |  266.3MiB/512MiB(52.01%) |            0s |
 springboot-producer-api-native |        163ms |      34MiB/512MiB(6.64%) |              6s |                8s |  276.1MiB/512MiB(53.93%) |            3s |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
       quarkus-consumer-api-jvm |       1905ms |  109.3MiB/512MiB(21.34%) |                                  8s |  274.7MiB/512MiB(53.66%) |            3s |
     micronaut-consumer-api-jvm |       2966ms |  82.35MiB/512MiB(16.08%) |                                  6s |  96.14MiB/512MiB(18.78%) |            0s |
    springboot-consumer-api-jvm |       4496ms |  288.4MiB/512MiB(56.33%) |                                  4s |  294.2MiB/512MiB(57.47%) |            3s |
    quarkus-consumer-api-native |         43ms |   8.414MiB/512MiB(1.64%) |                                  6s |  264.4MiB/512MiB(51.64%) |            3s |
  micronaut-consumer-api-native |         63ms |      12MiB/512MiB(2.34%) |                                  6s |  261.6MiB/512MiB(51.10%) |            1s |
 springboot-consumer-api-native |        112ms |   31.62MiB/512MiB(6.18%) |                                  5s |  190.4MiB/512MiB(37.18%) |            2s |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
      quarkus-elasticsearch-jvm |       1796ms |  95.45MiB/512MiB(18.64%) |             10s |                7s |  309.7MiB/512MiB(60.49%) |            1s |
    micronaut-elasticsearch-jvm |       1999ms |   87.9MiB/512MiB(17.17%) |             10s |                8s |  148.2MiB/512MiB(28.94%) |            0s |
   springboot-elasticsearch-jvm |       4697ms |  281.1MiB/512MiB(54.90%) |             10s |                8s |  511.9MiB/512MiB(99.97%) |            3s |
   quarkus-elasticsearch-native |         26ms |   5.082MiB/512MiB(0.99%) |              7s |                6s |  263.1MiB/512MiB(51.39%) |            1s |
 micronaut-elasticsearch-native |         46ms |   8.766MiB/512MiB(1.71%) |              6s |                7s |  267.3MiB/512MiB(52.21%) |            1s |
springboot-elasticsearch-native |        111ms |   33.18MiB/512MiB(6.48%) |              6s |                7s |  276.3MiB/512MiB(53.96%) |            3s |
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
