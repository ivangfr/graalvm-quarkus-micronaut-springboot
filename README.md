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
| Quarkus     | 2.2.3.Final |
| Micronaut   | 3.0.1       |
| Spring Boot | 2.5.5       |

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
        quarkus-simple-api-jvm |             6s |            15M |                3s |             385MB |
      micronaut-simple-api-jvm |             5s |            15M |               16s |             340MB |
     springboot-simple-api-jvm |            17s |            23M |               14s |             268MB |
.............................. + .............. + .............. + ................. + ................. |
         quarkus-jpa-mysql-jvm |            11s |            33M |                3s |             404MB |
       micronaut-jpa-mysql-jvm |             9s |            36M |               16s |             362MB |
      springboot-jpa-mysql-jvm |            36s |            43M |               18s |             291MB |
.............................. + .............. + .............. + ................. + ................. |
      quarkus-producer-api-jvm |             9s |            33M |                3s |             404MB |
    micronaut-producer-api-jvm |             8s |            28M |               13s |             354MB |
   springboot-producer-api-jvm |            19s |            36M |               10s |             284MB |
.............................. + .............. + .............. + ................. + ................. |
      quarkus-consumer-api-jvm |             8s |            31M |                2s |             402MB |
    micronaut-consumer-api-jvm |             7s |            28M |               12s |             354MB |
   springboot-consumer-api-jvm |            18s |            35M |               10s |             282MB |
.............................. + .............. + .............. + ................. + ................. |
     quarkus-elasticsearch-jvm |             8s |            40M |                2s |             412MB |
   micronaut-elasticsearch-jvm |            10s |            44M |               12s |             370MB |
  springboot-elasticsearch-jvm |            21s |            52M |               10s |             301MB |
```

Table below shows the results after running the script `collect-native-jar-docker-size-times.sh`
```
                    Application | Packaging Time | Packaging Size | Docker Build Time | Docker Image Size |
------------------------------- + -------------- + -------------- + ----------------- + ----------------- |
      quarkus-simple-api-native |           159s |            44M |                6s |             148MB |
    micronaut-simple-api-native |             6s |            15M |              203s |            77.2MB |
   springboot-simple-api-native |            15s |            23M |              585s |             123MB |
............................... + .............. + .............. + ................. + ................. |
       quarkus-jpa-mysql-native |           234s |            71M |                4s |             177MB |
     micronaut-jpa-mysql-native |             9s |            36M |              272s |             110MB |
    springboot-jpa-mysql-native |            22s |            43M |             1088s |             187MB |
............................... + .............. + .............. + ................. + ................. |
    quarkus-producer-api-native |           206s |            64M |                3s |             169MB |
  micronaut-producer-api-native |             8s |            28M |              216s |            95.1MB |
 springboot-producer-api-native |            18s |            36M |              752s |             152MB |
............................... + .............. + .............. + ................. + ................. |
    quarkus-consumer-api-native |           193s |            60M |                4s |             166MB |
  micronaut-consumer-api-native |             6s |            28M |              218s |            94.9MB |
 springboot-consumer-api-native |            17s |            35M |              616s |             123MB |
............................... + .............. + .............. + ................. + ................. |
   quarkus-elasticsearch-native |           202s |            52M |                7s |             157MB |
 micronaut-elasticsearch-native |             9s |            44M |              247s |            97.3MB |
springboot-elasticsearch-native |            24s |            52M |              819s |             167MB |
```

Finally, the following table shows the results after running the script `collect-ab-times-memory-usage.sh`
```
                    Application | Startup Time |     Initial Memory Usage | Ab Testing Time | Ab Testing Time 2 |       Final Memory Usage | Shutdown Time |
------------------------------- + ------------ + ------------------------ + --------------- + ----------------- + ------------------------ + ------------- |
         quarkus-simple-api-jvm |       1599ms |  64.25MiB/256MiB(25.10%) |              8s |                6s |  113.1MiB/256MiB(44.18%) |            0s |
       micronaut-simple-api-jvm |       6588ms |  79.46MiB/256MiB(31.04%) |             11s |                7s |  105.8MiB/256MiB(41.34%) |            0s |
      springboot-simple-api-jvm |       3011ms |  126.2MiB/256MiB(49.28%) |             10s |                6s |  177.6MiB/256MiB(69.39%) |            3s |
      quarkus-simple-api-native |         22ms |   5.723MiB/256MiB(2.24%) |              6s |                9s |   31.6MiB/256MiB(12.34%) |            1s |
    micronaut-simple-api-native |         27ms |   7.641MiB/256MiB(2.98%) |              5s |                5s |  161.7MiB/256MiB(63.17%) |            1s |
   springboot-simple-api-native |        138ms |  34.53MiB/256MiB(13.49%) |              4s |                4s |  106.3MiB/256MiB(41.51%) |            4s |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
          quarkus-jpa-mysql-jvm |       2764ms |  99.44MiB/256MiB(38.84%) |              9s |                6s |  157.5MiB/256MiB(61.52%) |            0s |
        micronaut-jpa-mysql-jvm |       8689ms |  105.4MiB/256MiB(41.17%) |              8s |                6s |  156.9MiB/256MiB(61.27%) |            1s |
       springboot-jpa-mysql-jvm |       4837ms |  172.4MiB/256MiB(67.35%) |              8s |                6s |  219.8MiB/256MiB(85.87%) |            2s |
       quarkus-jpa-mysql-native |         31ms |   7.895MiB/256MiB(3.08%) |              5s |                6s |  41.81MiB/256MiB(16.33%) |            1s |
     micronaut-jpa-mysql-native |         54ms |   18.78MiB/256MiB(7.33%) |              5s |                6s |    172MiB/256MiB(67.21%) |            1s |
    springboot-jpa-mysql-native |        195ms |  44.86MiB/256MiB(17.52%) |              5s |                5s |  114.9MiB/256MiB(44.87%) |            3s |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
       quarkus-producer-api-jvm |       2188ms |  88.23MiB/256MiB(34.47%) |             13s |               10s |  160.4MiB/256MiB(62.65%) |            1s |
     micronaut-producer-api-jvm |       6799ms |  63.32MiB/256MiB(24.73%) |             13s |                9s |  131.6MiB/256MiB(51.42%) |            1s |
    springboot-producer-api-jvm |       3732ms |    143MiB/256MiB(55.86%) |             12s |                9s |  196.6MiB/256MiB(76.80%) |            3s |
    quarkus-producer-api-native |         33ms |   8.086MiB/256MiB(3.16%) |              9s |                9s |  44.16MiB/256MiB(17.25%) |            1s |
  micronaut-producer-api-native |         29ms |   7.754MiB/256MiB(3.03%) |              9s |               10s |  171.1MiB/256MiB(66.83%) |            0s |
 springboot-producer-api-native |        207ms |  38.12MiB/256MiB(14.89%) |              8s |                8s |  110.7MiB/256MiB(43.23%) |            3s |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
       quarkus-consumer-api-jvm |       1738ms |  79.32MiB/256MiB(30.98%) |                                  7s |  114.9MiB/256MiB(44.87%) |            3s |
     micronaut-consumer-api-jvm |       2229ms |  87.09MiB/256MiB(34.02%) |                                  4s |  95.35MiB/256MiB(37.25%) |            0s |
    springboot-consumer-api-jvm |       3414ms |  146.4MiB/256MiB(57.20%) |                                  4s |  157.3MiB/256MiB(61.44%) |            2s |
    quarkus-consumer-api-native |         28ms |   9.316MiB/256MiB(3.64%) |                                  4s |  39.71MiB/256MiB(15.51%) |            3s |
  micronaut-consumer-api-native |      10024ms |   10.76MiB/256MiB(4.20%) |                                  3s |  34.88MiB/256MiB(13.62%) |            1s |
 springboot-consumer-api-native |        142ms |  38.33MiB/256MiB(14.97%) |                                  4s |  47.51MiB/256MiB(18.56%) |            2s |
............................... + ............ + ........................ + ............... + ................. + ........................ +  ............ |
      quarkus-elasticsearch-jvm |       1804ms |  74.49MiB/256MiB(29.10%) |             10s |                7s |  141.6MiB/256MiB(55.33%) |            0s |
    micronaut-elasticsearch-jvm |       6685ms |  84.86MiB/256MiB(33.15%) |              9s |                7s |  139.3MiB/256MiB(54.42%) |            1s |
   springboot-elasticsearch-jvm |       4228ms |  199.6MiB/256MiB(77.96%) |              9s |                7s |  236.3MiB/256MiB(92.32%) |            2s |
   quarkus-elasticsearch-native |         23ms |   5.852MiB/256MiB(2.29%) |              6s |                6s |  41.94MiB/256MiB(16.38%) |            0s |
 micronaut-elasticsearch-native |         27ms |   7.652MiB/256MiB(2.99%) |              6s |                6s |  171.6MiB/256MiB(67.05%) |            1s |
springboot-elasticsearch-native |        160ms |  91.32MiB/256MiB(35.67%) |              6s |                6s |  122.8MiB/256MiB(47.97%) |            2s |
```

**Comments**

- Comparing `Ab Testing Time` with `Ab Testing Time 2` columns, we can see that JVM was able to perform some runtime optimizations, making the JVM applications to perform faster on the second ab test run;

- `micronaut-producer-api-native` or `micronaut-consumer-api-native` has very slow startup time, 10s. See [Micronaut Core, issue #5206](https://github.com/micronaut-projects/micronaut-core/issues/5206);

- `quarkus-consumer-api-jvm` and `quarkus-consumer-api-native` are very slow consuming the messages compared to `Micronaut` and `Spring Boot` consumers;

- Checking the Final Memory Usage column, `Quarkus` native apps have better memory utilization (after load tests) than `Micronaut` and `Spring Boot` ones; In this experiment, we set **256MiB** the container limit memory. If we reduce the container limit memmory to **128MiB**, all `Micronaut` native apps will have memory issues. For `Quarkus` native apps, I was able to reduce the container limit memmory to even **64MiB**. Below it, the apps performance will degrade.

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
