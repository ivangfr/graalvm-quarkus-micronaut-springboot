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
| Micronaut   | 3.2.4       |
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
       micronaut-jpa-mysql-jvm |            10s |            34M |               13s |             361MB |
      springboot-jpa-mysql-jvm |            26s |            43M |               16s |             291MB |
.............................. + .............. + .............. + ................. + ................. |
      quarkus-producer-api-jvm |             8s |            33M |                4s |             401MB |
    micronaut-producer-api-jvm |             9s |            29M |               13s |             355MB |
   springboot-producer-api-jvm |            16s |            38M |               14s |             286MB |
.............................. + .............. + .............. + ................. + ................. |
      quarkus-consumer-api-jvm |             8s |            32M |                2s |             399MB |
    micronaut-consumer-api-jvm |             9s |            29M |               12s |             355MB |
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
  micronaut-producer-api-native |             7s |            29M |              193s |            96.5MB |
 springboot-producer-api-native |            16s |            38M |              305s |             134MB |
............................... + .............. + .............. + ................. + ................. |
    quarkus-consumer-api-native |           177s |            60M |                4s |             101MB |
  micronaut-consumer-api-native |             7s |            29M |              184s |            96.4MB |
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
         quarkus-simple-api-jvm |       1624ms |  76.93MiB/512MiB(15.02%) |              8s |                6s |  283.5MiB/512MiB(55.36%) |            1s |
       micronaut-simple-api-jvm |       1645ms |  80.75MiB/512MiB(15.77%) |              9s |                6s |    106MiB/512MiB(20.70%) |            0s |
      springboot-simple-api-jvm |       4128ms |  255.3MiB/512MiB(49.86%) |             13s |                6s |  457.6MiB/512MiB(89.38%) |            2s |
      quarkus-simple-api-native |         18ms |   4.934MiB/512MiB(0.96%) |              5s |                7s |    263MiB/512MiB(51.36%) |            0s |
    micronaut-simple-api-native |         41ms |   8.605MiB/512MiB(1.68%) |              5s |                7s |  264.2MiB/512MiB(51.60%) |            0s |
   springboot-simple-api-native |         99ms |   25.64MiB/512MiB(5.01%) |              5s |                7s |  271.6MiB/512MiB(53.05%) |            2s |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
          quarkus-jpa-mysql-jvm |       2778ms |  138.1MiB/512MiB(26.97%) |              8s |                6s |  369.1MiB/512MiB(72.09%) |            1s |
        micronaut-jpa-mysql-jvm |       3915ms |  102.2MiB/512MiB(19.97%) |              8s |                6s |  153.6MiB/512MiB(30.00%) |            1s |
       springboot-jpa-mysql-jvm |       6965ms |  318.8MiB/512MiB(62.27%) |             10s |                7s |  511.3MiB/512MiB(99.86%) |            3s |
       quarkus-jpa-mysql-native |         42ms |   7.281MiB/512MiB(1.42%) |              6s |                6s |  266.1MiB/512MiB(51.97%) |            1s |
     micronaut-jpa-mysql-native |        107ms |   18.88MiB/512MiB(3.69%) |              6s |                6s |  267.3MiB/512MiB(52.20%) |            1s |
    springboot-jpa-mysql-native |        206ms |  64.99MiB/512MiB(12.69%) |              4s |                5s |  280.1MiB/512MiB(54.71%) |            3s |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
       quarkus-producer-api-jvm |       2175ms |  122.3MiB/512MiB(23.89%) |             12s |                9s |  346.3MiB/512MiB(67.65%) |            0s |
     micronaut-producer-api-jvm |       1702ms |  86.94MiB/512MiB(16.98%) |             13s |               11s |  129.8MiB/512MiB(25.35%) |            1s |
    springboot-producer-api-jvm |       4781ms |  296.2MiB/512MiB(57.86%) |             13s |               11s |  491.5MiB/512MiB(96.00%) |            2s |
    quarkus-producer-api-native |         31ms |   7.266MiB/512MiB(1.42%) |              8s |                9s |  266.7MiB/512MiB(52.09%) |            0s |
  micronaut-producer-api-native |         37ms |    8.91MiB/512MiB(1.74%) |              8s |               10s |  266.2MiB/512MiB(52.00%) |            0s |
 springboot-producer-api-native |        151ms |   34.19MiB/512MiB(6.68%) |              7s |                8s |    276MiB/512MiB(53.92%) |            2s |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
       quarkus-consumer-api-jvm |       1728ms |  105.8MiB/512MiB(20.66%) |                                  9s |  291.9MiB/512MiB(57.01%) |            4s |
     micronaut-consumer-api-jvm |       2958ms |  83.09MiB/512MiB(16.23%) |                                  4s |  97.05MiB/512MiB(18.96%) |            0s |
    springboot-consumer-api-jvm |       4654ms |  278.3MiB/512MiB(54.36%) |                                  4s |  323.3MiB/512MiB(63.15%) |            3s |
    quarkus-consumer-api-native |         44ms |   8.398MiB/512MiB(1.64%) |                                  5s |  265.1MiB/512MiB(51.77%) |            4s |
  micronaut-consumer-api-native |         81ms |   11.86MiB/512MiB(2.32%) |                                  5s |    261MiB/512MiB(50.97%) |            0s |
 springboot-consumer-api-native |        109ms |   31.77MiB/512MiB(6.21%) |                                  5s |  191.5MiB/512MiB(37.40%) |            3s |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
      quarkus-elasticsearch-jvm |       1778ms |  96.13MiB/512MiB(18.78%) |             10s |                7s |  340.5MiB/512MiB(66.50%) |            1s |
    micronaut-elasticsearch-jvm |       2115ms |  87.51MiB/512MiB(17.09%) |             10s |                8s |  142.8MiB/512MiB(27.90%) |            0s |
   springboot-elasticsearch-jvm |       5167ms |  342.5MiB/512MiB(66.89%) |             12s |                9s |  505.8MiB/512MiB(98.78%) |            2s |
   quarkus-elasticsearch-native |         26ms |   5.082MiB/512MiB(0.99%) |              7s |                6s |  263.3MiB/512MiB(51.42%) |            0s |
 micronaut-elasticsearch-native |         49ms |    8.77MiB/512MiB(1.71%) |              7s |                7s |  267.4MiB/512MiB(52.24%) |            1s |
springboot-elasticsearch-native |        106ms |   33.33MiB/512MiB(6.51%) |              5s |                6s |  276.5MiB/512MiB(54.01%) |            2s |
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
