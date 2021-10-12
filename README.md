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
| ----------- | ----------- |
| Quarkus     | 2.3.0.Final |
| Micronaut   | 3.1.0       |
| Spring Boot | 2.5.5       |

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
        quarkus-simple-api-jvm |             7s |            17M |                4s |             388MB |
      micronaut-simple-api-jvm |             6s |            15M |               16s |             340MB |
     springboot-simple-api-jvm |            16s |            23M |               13s |             268MB |
.............................. + .............. + .............. + ................. + ................. |
         quarkus-jpa-mysql-jvm |            10s |            36M |                3s |             407MB |
       micronaut-jpa-mysql-jvm |            10s |            34M |               12s |             359MB |
      springboot-jpa-mysql-jvm |            21s |            43M |               11s |             291MB |
.............................. + .............. + .............. + ................. + ................. |
      quarkus-producer-api-jvm |             9s |            33M |                2s |             404MB |
    micronaut-producer-api-jvm |             8s |            28M |               14s |             354MB |
   springboot-producer-api-jvm |            19s |            36M |               11s |             284MB |
.............................. + .............. + .............. + ................. + ................. |
      quarkus-consumer-api-jvm |             8s |            31M |                2s |             402MB |
    micronaut-consumer-api-jvm |             7s |            28M |               12s |             354MB |
   springboot-consumer-api-jvm |            17s |            35M |               11s |             282MB |
.............................. + .............. + .............. + ................. + ................. |
     quarkus-elasticsearch-jvm |             8s |            41M |                3s |             413MB |
   micronaut-elasticsearch-jvm |             9s |            44M |               13s |             370MB |
  springboot-elasticsearch-jvm |            19s |            52M |               11s |             301MB |
```

Table below shows the results after running the script `collect-native-jar-docker-size-times.sh`
```
                    Application | Packaging Time | Packaging Size | Docker Build Time | Docker Image Size |
------------------------------- + -------------- + -------------- + ----------------- + ----------------- |
      quarkus-simple-api-native |           167s |            48M |                4s |             153MB |
    micronaut-simple-api-native |             5s |            15M |              208s |            78.2MB |
   springboot-simple-api-native |            17s |            23M |              608s |             122MB |
............................... + .............. + .............. + ................. + ................. |
       quarkus-jpa-mysql-native |           244s |            75M |                3s |             181MB |
     micronaut-jpa-mysql-native |            10s |            34M |              269s |             110MB |
    springboot-jpa-mysql-native |            23s |            43M |              880s |             187MB |
............................... + .............. + .............. + ................. + ................. |
    quarkus-producer-api-native |           209s |            64M |                4s |             169MB |
  micronaut-producer-api-native |             8s |            29M |              222s |              96MB |
 springboot-producer-api-native |            18s |            36M |              715s |             152MB |
............................... + .............. + .............. + ................. + ................. |
    quarkus-consumer-api-native |           196s |            59M |                4s |             164MB |
  micronaut-consumer-api-native |             7s |            28M |              217s |            95.9MB |
 springboot-consumer-api-native |            18s |            35M |              641s |             123MB |
............................... + .............. + .............. + ................. + ................. |
   quarkus-elasticsearch-native |           204s |            53M |                6s |             158MB |
 micronaut-elasticsearch-native |             9s |            44M |              254s |            97.2MB |
springboot-elasticsearch-native |            22s |            52M |              859s |             167MB |
```

Finally, the following table shows the results after running the script `collect-ab-times-memory-usage.sh`
```
                    Application | Startup Time |     Initial Memory Usage | Ab Testing Time | Ab Testing Time 2 |       Final Memory Usage | Shutdown Time |
------------------------------- + ------------ + ------------------------ + --------------- + ----------------- + ------------------------ + ------------- |
         quarkus-simple-api-jvm |       1688ms |   68.6MiB/256MiB(26.80%) |              9s |                7s |  133.4MiB/256MiB(52.11%) |            0s |
       micronaut-simple-api-jvm |       6610ms |   80.5MiB/256MiB(31.45%) |             11s |                7s |  105.1MiB/256MiB(41.07%) |            1s |
      springboot-simple-api-jvm |       2989ms |  135.8MiB/256MiB(53.04%) |             11s |                6s |  181.7MiB/256MiB(70.97%) |            3s |
      quarkus-simple-api-native |         27ms |   5.742MiB/256MiB(2.24%) |              5s |                7s |  31.61MiB/256MiB(12.35%) |            0s |
    micronaut-simple-api-native |         36ms |   7.754MiB/256MiB(3.03%) |              5s |                8s |  163.3MiB/256MiB(63.77%) |            0s |
   springboot-simple-api-native |        145ms |  34.53MiB/256MiB(13.49%) |              5s |                6s |     42MiB/256MiB(16.41%) |            2s |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
          quarkus-jpa-mysql-jvm |       2885ms |  108.8MiB/256MiB(42.49%) |              9s |                6s |    174MiB/256MiB(67.96%) |            0s |
        micronaut-jpa-mysql-jvm |       8440ms |  103.8MiB/256MiB(40.55%) |              9s |                5s |  153.9MiB/256MiB(60.10%) |            1s |
       springboot-jpa-mysql-jvm |       5426ms |  182.7MiB/256MiB(71.35%) |              9s |                5s |  242.3MiB/256MiB(94.65%) |            3s |
       quarkus-jpa-mysql-native |         37ms |   7.922MiB/256MiB(3.09%) |              4s |                5s |  42.01MiB/256MiB(16.41%) |            1s |
     micronaut-jpa-mysql-native |         87ms |   19.11MiB/256MiB(7.46%) |              6s |                5s |  171.5MiB/256MiB(67.00%) |            0s |
    springboot-jpa-mysql-native |        230ms |   48.7MiB/256MiB(19.02%) |              6s |                5s |  55.24MiB/256MiB(21.58%) |            3s |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
       quarkus-producer-api-jvm |       2194ms |  86.96MiB/256MiB(33.97%) |             14s |               10s |  154.6MiB/256MiB(60.38%) |            1s |
     micronaut-producer-api-jvm |       6764ms |  63.28MiB/256MiB(24.72%) |             14s |               10s |  132.9MiB/256MiB(51.91%) |            1s |
    springboot-producer-api-jvm |       3936ms |  150.6MiB/256MiB(58.84%) |             12s |                9s |  199.3MiB/256MiB(77.84%) |            2s |
    quarkus-producer-api-native |         43ms |   7.996MiB/256MiB(3.12%) |              9s |                9s |  44.35MiB/256MiB(17.32%) |            2s |
  micronaut-producer-api-native |         38ms |   8.051MiB/256MiB(3.14%) |              9s |                9s |  171.2MiB/256MiB(66.87%) |            0s |
 springboot-producer-api-native |        222ms |   42.1MiB/256MiB(16.45%) |              8s |                9s |  51.04MiB/256MiB(19.94%) |            3s |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
       quarkus-consumer-api-jvm |       1788ms |  80.34MiB/256MiB(31.38%) |                                  6s |  122.4MiB/256MiB(47.82%) |            2s |
     micronaut-consumer-api-jvm |       2266ms |  85.65MiB/256MiB(33.46%) |                                  6s |  96.58MiB/256MiB(37.73%) |            0s |
    springboot-consumer-api-jvm |       3412ms |  151.9MiB/256MiB(59.35%) |                                  6s |  169.2MiB/256MiB(66.09%) |            3s |
    quarkus-consumer-api-native |         39ms |   9.242MiB/256MiB(3.61%) |                                  5s |  40.45MiB/256MiB(15.80%) |            3s |
  micronaut-consumer-api-native |      10063ms |   10.99MiB/256MiB(4.29%) |                                  4s |  34.82MiB/256MiB(13.60%) |            1s |
 springboot-consumer-api-native |        153ms |   44.2MiB/256MiB(17.27%) |                                  3s |   45.7MiB/256MiB(17.85%) |            2s |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
      quarkus-elasticsearch-jvm |       1866ms |  75.94MiB/256MiB(29.66%) |             10s |                6s |  148.4MiB/256MiB(57.98%) |            1s |
    micronaut-elasticsearch-jvm |       6783ms |  76.49MiB/256MiB(29.88%) |             10s |                6s |  139.7MiB/256MiB(54.56%) |            0s |
   springboot-elasticsearch-jvm |       4916ms |  208.1MiB/256MiB(81.28%) |             10s |                7s |  232.2MiB/256MiB(90.71%) |            3s |
   quarkus-elasticsearch-native |         19ms |   5.836MiB/256MiB(2.28%) |              6s |                6s |  42.08MiB/256MiB(16.44%) |            1s |
 micronaut-elasticsearch-native |         33ms |   7.953MiB/256MiB(3.11%) |              6s |                7s |  170.1MiB/256MiB(66.43%) |            0s |
springboot-elasticsearch-native |        185ms |  59.55MiB/256MiB(23.26%) |              6s |                6s |  59.01MiB/256MiB(23.05%) |            2s |
```

**Comments**

- Comparing `Ab Testing Time` with `Ab Testing Time 2` columns, we can see that JVM was able to perform some runtime optimizations, making the JVM applications to perform faster on the second ab test run;

- `micronaut-producer-api-native` or `micronaut-consumer-api-native` has very slow startup time, 10s. See [Micronaut Core, issue #5206](https://github.com/micronaut-projects/micronaut-core/issues/5206);

- Checking the Final Memory Usage column, `Quarkus` native apps have better memory utilization (after load tests) than `Micronaut` and `Spring Boot` ones; In this experiment, we set **256MiB** the container limit memory. If we reduce the container limit memory to **128MiB**, all `Micronaut` native apps will have memory issues. For `Quarkus` native apps, I was able to reduce the container limit memory to even **64MiB**. Below it, the app's performance will degrade.

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
