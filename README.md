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
| Quarkus     | 2.6.1.Final |
| Micronaut   | 3.2.3       |
| Spring Boot | 2.6.2       |

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
     springboot-simple-api-jvm |            14s |            23M |               15s |             268MB |
.............................. + .............. + .............. + ................. + ................. |
         quarkus-jpa-mysql-jvm |             8s |            34M |                3s |             402MB |
       micronaut-jpa-mysql-jvm |            10s |            33M |               13s |             361MB |
      springboot-jpa-mysql-jvm |            26s |            43M |               16s |             291MB |
.............................. + .............. + .............. + ................. + ................. |
      quarkus-producer-api-jvm |             8s |            33M |                4s |             401MB |
    micronaut-producer-api-jvm |             9s |            28M |               13s |             355MB |
   springboot-producer-api-jvm |            16s |            38M |               14s |             286MB |
.............................. + .............. + .............. + ................. + ................. |
      quarkus-consumer-api-jvm |             8s |            32M |                2s |             399MB |
    micronaut-consumer-api-jvm |             9s |            28M |               12s |             355MB |
   springboot-consumer-api-jvm |            15s |            37M |               11s |             284MB |
.............................. + .............. + .............. + ................. + ................. |
     quarkus-elasticsearch-jvm |             7s |            41M |                4s |             410MB |
   micronaut-elasticsearch-jvm |            10s |            47M |               14s |             375MB |
  springboot-elasticsearch-jvm |            17s |            54M |               12s |             303MB |
```

Table below shows the results after running the script `collect-native-jar-docker-size-times.sh`
```
                    Application | Packaging Time | Packaging Size | Docker Build Time | Docker Image Size |
------------------------------- + -------------- + -------------- + ----------------- + ----------------- |
      quarkus-simple-api-native |           174s |            44M |                3s |            84.9MB |
    micronaut-simple-api-native |             5s |            15M |              174s |            79.3MB |
   springboot-simple-api-native |            15s |            23M |              257s |             108MB |
............................... + .............. + .............. + ................. + ................. |
       quarkus-jpa-mysql-native |           263s |            82M |                6s |             124MB |
     micronaut-jpa-mysql-native |             9s |            34M |              249s |             119MB |
    springboot-jpa-mysql-native |            21s |            43M |              409s |             160MB |
............................... + .............. + .............. + ................. + ................. |
    quarkus-producer-api-native |           178s |            63M |                4s |             105MB |
  micronaut-producer-api-native |             7s |            28M |              193s |            96.5MB |
 springboot-producer-api-native |            16s |            38M |              305s |             134MB |
............................... + .............. + .............. + ................. + ................. |
    quarkus-consumer-api-native |           177s |            60M |                4s |             101MB |
  micronaut-consumer-api-native |             7s |            28M |              184s |            96.4MB |
 springboot-consumer-api-native |            16s |            37M |              280s |             112MB |
............................... + .............. + .............. + ................. + ................. |
   quarkus-elasticsearch-native |           190s |            52M |                6s |            93.4MB |
 micronaut-elasticsearch-native |             9s |            47M |              222s |            98.8MB |
springboot-elasticsearch-native |            17s |            54M |              370s |             135MB |
```

Finally, the following table shows the results after running the script `collect-ab-times-memory-usage.sh`
```
                    Application | Startup Time |     Initial Memory Usage | Ab Testing Time | Ab Testing Time 2 |       Final Memory Usage | Shutdown Time |
------------------------------- + ------------ + ------------------------ + --------------- + ----------------- + ------------------------ + ------------- |
         quarkus-simple-api-jvm |       1645ms |  80.69MiB/512MiB(15.76%) |              8s |                5s |  255.7MiB/512MiB(49.95%) |            1s |
       micronaut-simple-api-jvm |       2044ms |  81.07MiB/512MiB(15.83%) |              8s |                6s |  108.7MiB/512MiB(21.23%) |            0s |
      springboot-simple-api-jvm |       3461ms |    229MiB/512MiB(44.73%) |             13s |                9s |  398.7MiB/512MiB(77.87%) |            2s |
      quarkus-simple-api-native |         33ms |   4.918MiB/512MiB(0.96%) |              4s |                7s |  262.9MiB/512MiB(51.34%) |            1s |
    micronaut-simple-api-native |         51ms |   8.562MiB/512MiB(1.67%) |              4s |                9s |  264.1MiB/512MiB(51.59%) |            1s |
   springboot-simple-api-native |        128ms |   25.72MiB/512MiB(5.02%) |              5s |                5s |  271.7MiB/512MiB(53.08%) |            3s |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
          quarkus-jpa-mysql-jvm |       2779ms |  138.3MiB/512MiB(27.01%) |             10s |                5s |  321.1MiB/512MiB(62.72%) |            0s |
        micronaut-jpa-mysql-jvm |       4398ms |  103.4MiB/512MiB(20.20%) |              8s |                7s |  154.8MiB/512MiB(30.23%) |            1s |
       springboot-jpa-mysql-jvm |       6778ms |  344.3MiB/512MiB(67.25%) |             10s |                6s |  510.2MiB/512MiB(99.65%) |            3s |
       quarkus-jpa-mysql-native |         48ms |   7.281MiB/512MiB(1.42%) |              4s |                6s |  266.4MiB/512MiB(52.03%) |            0s |
     micronaut-jpa-mysql-native |        106ms |   18.86MiB/512MiB(3.68%) |              5s |                6s |  267.1MiB/512MiB(52.17%) |            0s |
    springboot-jpa-mysql-native |        235ms |  64.95MiB/512MiB(12.69%) |              5s |                6s |  280.2MiB/512MiB(54.72%) |            2s |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
       quarkus-producer-api-jvm |       2249ms |    122MiB/512MiB(23.83%) |             12s |                8s |  309.9MiB/512MiB(60.53%) |            1s |
     micronaut-producer-api-jvm |       2392ms |  62.98MiB/512MiB(12.30%) |             12s |               11s |  131.6MiB/512MiB(25.71%) |            0s |
    springboot-producer-api-jvm |       4909ms |  268.4MiB/512MiB(52.42%) |             14s |               11s |  437.1MiB/512MiB(85.38%) |            3s |
    quarkus-producer-api-native |         47ms |    7.25MiB/512MiB(1.42%) |              8s |                8s |  267.1MiB/512MiB(52.16%) |            1s |
  micronaut-producer-api-native |         53ms |    8.93MiB/512MiB(1.74%) |              9s |                9s |  266.3MiB/512MiB(52.01%) |            1s |
 springboot-producer-api-native |            - |                        - |               - |                 - |                        - |             - |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
       quarkus-consumer-api-jvm |       1805ms |  107.7MiB/512MiB(21.04%) |                                 10s |  285.2MiB/512MiB(55.71%) |            2s |
     micronaut-consumer-api-jvm |       3137ms |  82.99MiB/512MiB(16.21%) |                                  7s |  95.74MiB/512MiB(18.70%) |            1s |
    springboot-consumer-api-jvm |       4714ms |  281.9MiB/512MiB(55.07%) |                                  5s |  308.7MiB/512MiB(60.30%) |            2s |
    quarkus-consumer-api-native |         49ms |    8.41MiB/512MiB(1.64%) |                                  8s |  265.8MiB/512MiB(51.92%) |            3s |
  micronaut-consumer-api-native |        287ms |    151MiB/512MiB(29.49%) |                                  3s |    262MiB/512MiB(51.17%) |            0s |
 springboot-consumer-api-native |            - |                        - |                                   - |                        - |             - |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
      quarkus-elasticsearch-jvm |       1943ms |   94.4MiB/512MiB(18.44%) |             10s |                8s |  313.9MiB/512MiB(61.30%) |            1s |
    micronaut-elasticsearch-jvm |       2211ms |  65.75MiB/512MiB(12.84%) |             10s |                8s |    143MiB/512MiB(27.93%) |            0s |
   springboot-elasticsearch-jvm |       5618ms |  322.4MiB/512MiB(62.97%) |             11s |                8s |  501.2MiB/512MiB(97.89%) |            2s |
   quarkus-elasticsearch-native |         33ms |   5.082MiB/512MiB(0.99%) |              6s |                6s |    264MiB/512MiB(51.55%) |            0s |
 micronaut-elasticsearch-native |         52ms |   8.762MiB/512MiB(1.71%) |              7s |                7s |  267.1MiB/512MiB(52.18%) |            1s |
springboot-elasticsearch-native |            - |                        - |               - |                 - |                        - |             - |
```

**Comments**

- Comparing `Ab Testing Time` with `Ab Testing Time 2` columns, we can see that JVM was able to perform some runtime optimizations, making the JVM applications to perform faster on the second ab test run;

- `springboot-consumer-api-native` is not working, see [`Issues`](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/producer-consumer/springboot-producer-consumer#issues)

- `springboot-elasticsearch-native` is not working, see [`Issues`](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/elasticsearch/springboot-elasticsearch#issues)

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
