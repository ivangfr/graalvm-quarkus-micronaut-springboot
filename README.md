# graalvm-quarkus-micronaut-springboot

The goal of this project is to compare some Java frameworks like: [`Quarkus`](https://quarkus.io/), [`Micronaut`](https://micronaut.io/) and [`Spring Boot`](https://docs.spring.io/spring-boot/docs/current/reference/htmlsingle/). For it, we will implement applications using those frameworks, measure their start-up times, memory footprint, etc.

Besides, as `Quarkus` and `Micronaut` support [`GraalVM`](https://www.graalvm.org/) out-of-the-box, we will use `GraalVM`’s `native-image` tool to build `Quarkus` and `Micronaut` native applications.

> **Note:** Spring team is working on supporting for `GraalVM` native images, https://github.com/spring-projects/spring-framework/wiki/GraalVM-native-image-support

## Examples

- ### [simple-api](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/simple-api#graalvm-quarkus-micronaut-springboot)
- ### [book-api](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/book-api#graalvm-quarkus-micronaut-springboot)
- ### [producer-consumer](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/producer-consumer#graalvm-quarkus-micronaut-springboot)
- ### [elasticsearch](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/elasticsearch#graalvm-quarkus-micronaut-springboot)

## Framework version

We are using the following Framework versions

| Framework   | Version       |
| ----------- | ------------- |
| Quarkus     | 1.4.2.Final   |
| Micronaut   | 2.0.0.M3      |
| Spring Boot | 2.3.0.RELEASE |

## Bash scripts

In order to make it easier to collect data that will be used for comparing the frameworks, we've implemented some bash scripts.

| Bash script                             | Description |
| --------------------------------------- | ----------- |
| collect-jvm-jar-docker-size-times.sh    | it packages/assembles jar files and builds docker images of all JVM applications, collecting data like: jar packaging Time, size of the jar, docker build time and docker image size |
| collect-native-jar-docker-size-times.sh | it packages/assembles jar files and builds docker images of all Native applications, collecting data like: jar packaging Time, size of the jar, docker build time and docker image size |
| collect-startup-ab-times.sh             | it starts docker container of all applications (JVM and Native), collecting data like: startup time, initial memory consumption, time spent to run some ab tests and final memory consumption |

## Comparison

The following table shows the results after running the script `collect-jvm-jar-docker-size-times.sh`
```
                   Application | Packaging Time | Jar Size (bytes) | Docker Build Time | Docker Image Size |
------------------------------ + -------------- + ---------------- + ----------------- + ----------------- |
        quarkus-simple-api-jvm |            11s |           302166 |               66s |             449MB |
      micronaut-simple-api-jvm |            12s |         15705454 |                2s |             356MB |
     springboot-simple-api-jvm |             4s |         21922311 |                2s |             107MB |
.............................. + .............. + ................ + ................. + ................. |
          quarkus-book-api-jvm |            12s |           495878 |               11s |             474MB |
        micronaut-book-api-jvm |            17s |         34449439 |                4s |             375MB |
       springboot-book-api-jvm |             6s |         43169558 |                3s |             128MB |
.............................. + .............. + ................ + ................. + ................. |
      quarkus-producer-api-jvm |            10s |           416313 |               12s |             477MB |
    micronaut-producer-api-jvm |            13s |         26742888 |                2s |             367MB |
   springboot-producer-api-jvm |             6s |         35438854 |                3s |             120MB |
.............................. + .............. + ................ + ................. + ................. |
      quarkus-consumer-api-jvm |            10s |           392821 |               12s |             477MB |
    micronaut-consumer-api-jvm |            11s |         26723265 |                3s |             367MB |
   springboot-consumer-api-jvm |             6s |         35436245 |                3s |             120MB |
.............................. + .............. + ................ + ................. + ................. |
     quarkus-elasticsearch-jvm |            11s |           330613 |               65s |             540MB |
   micronaut-elasticsearch-jvm |            16s |         42408882 |                3s |             383MB |
  springboot-elasticsearch-jvm |             7s |         54347146 |                5s |             139MB |
```

Table below shows the results after running the script `collect-native-jar-docker-size-times.sh`
```
                   Application | Packaging Time | Jar Size (bytes) | Docker Build Time | Docker Image Size |
------------------------------ + -------------- + ---------------- + ----------------- + ----------------- |
     quarkus-simple-api-native |           235s |         30834008 |                4s |             168MB |
   micronaut-simple-api-native |            11s |         15705449 |              304s |            91.6MB |
.............................. + .............. + ................ + ................. + ................. |
       quarkus-book-api-native |           536s |         74237352 |                8s |             255MB |
     micronaut-book-api-native |            16s |         34449425 |              574s |             151MB |
.............................. + .............. + ................ + ................. + ................. |
   quarkus-producer-api-native |           361s |         49819256 |                5s |             206MB |
 micronaut-producer-api-native |            11s |         26742868 |              351s |             114MB |
.............................. + .............. + ................ + ................. + ................. |
   quarkus-consumer-api-native |           297s |         42597160 |                5s |             192MB |
 micronaut-consumer-api-native |            11s |         26723265 |              345s |             114MB |
.............................. + .............. + ................ + ................. + ................. |
  quarkus-elasticsearch-native |           298s |         38681768 |                5s |             184MB |
micronaut-elasticsearch-native |            16s |         42408629 |              413s |             127MB |
```

Finally, the following table shows the results after running the script `collect-startup-ab-times.sh`
```
                   Application | Startup Time | Initial Memory Consumption | Ab Testing Time | Final Memory Consumption |
------------------------------ + ------------ + -------------------------- + --------------- + ------------------------ |
        quarkus-simple-api-jvm |       1649ms |                   100.6MiB |             33s |                   131MiB |
      micronaut-simple-api-jvm |       2151ms |                   103.8MiB |             37s |                 159.6MiB |
     springboot-simple-api-jvm |       5937ms |                   334.4MiB |             36s |                 451.7MiB |
     quarkus-simple-api-native |         83ms |                   3.809MiB |             25s |                 259.8MiB |
   micronaut-simple-api-native |        123ms |                   9.301MiB |             27s |                 263.4MiB |
.............................. +  ........... + .......................... + ............... + ........................ |
          quarkus-book-api-jvm |       3531ms |                     152MiB |             30s |                   186MiB |
        micronaut-book-api-jvm |       4411ms |                   153.9MiB |             31s |                 199.4MiB |
       springboot-book-api-jvm |      12101ms |                     809MiB |             31s |                 853.4MiB |
       quarkus-book-api-native |        162ms |                   6.027MiB |             20s |                 259.4MiB |
     micronaut-book-api-native |            - |                          - |               - |                        - |
.............................. +  ........... + .......................... + ............... + ........................ |
      quarkus-producer-api-jvm |       5284ms |                     149MiB |             36s |                 178.9MiB |
    micronaut-producer-api-jvm |       2363ms |                   109.8MiB |             46s |                 188.2MiB |
   springboot-producer-api-jvm |       7971ms |                   394.4MiB |             38s |                 487.3MiB |
   quarkus-producer-api-native |        144ms |                   5.402MiB |             27s |                   264MiB |
 micronaut-producer-api-native |        164ms |                   11.37MiB |             32s |                 267.4MiB |
.............................. +  ........... + .......................... + ............... + ........................ |
      quarkus-consumer-api-jvm |       2230ms |                   113.5MiB |             22s |                 168.9MiB |
    micronaut-consumer-api-jvm |       3011ms |                   127.6MiB |              5s |                 129.8MiB |
   springboot-consumer-api-jvm |       7695ms |                   395.4MiB |              4s |                 437.6MiB |
   quarkus-consumer-api-native |        140ms |                   20.26MiB |             16s |                 254.8MiB |
 micronaut-consumer-api-native |        182ms |                   50.68MiB |              1s |                 145.3MiB |
.............................. +  ........... + .......................... + ............... + ........................ |
     quarkus-elasticsearch-jvm |       2085ms |                   93.64MiB |             32s |                 161.2MiB |
   micronaut-elasticsearch-jvm |       2031ms |                   113.1MiB |             32s |                 184.1MiB |
  springboot-elasticsearch-jvm |       8974ms |                   469.5MiB |             30s |                 529.5MiB |
  quarkus-elasticsearch-native |            - |                          - |               - |                        - |
micronaut-elasticsearch-native |            - |                          - |               - |                        - |
```

> **Note 1:** There is no results for `micronaut-book-api-native` due to a `MySQL` compatibility issue with `GraalVM`. For more details see [`micronaut-book-api` issues](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/book-api/micronaut-book-api#issues)

> **Note 2:** We can see that the performance of the `quarkus-consumer-api-jvm` and `quarkus-consumer-api-native` are really slow compared to other consumers. Checking the logs, it seems that the bottleneck is SmallRye Reactive Messaging. I have opened an issue related to it. For more information, see [Consumer reads 500 messages and stops a few seconds #290](https://github.com/smallrye/smallrye-reactive-messaging/issues/290)

> **Note 3:** There is no results for `quarkus-elasticsearch-native` because an exception is thrown when the application a request. For more details see [`quarkus-elasticsearch-native` issues](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/elasticsearch/quarkus-elasticsearch#issues)

> **Note 4:** There is no results for `micronaut-elasticsearch-native` because an exception is thrown when the application a request. For more details see [`micronaut-elasticsearch-native` issues](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/elasticsearch/micronaut-elasticsearch#issues)

`ab` tests used
```
                   Application | ab Test                                                                                     |
------------------------------ + ------------------------------------------------------------------------------------------- |
        quarkus-simple-api-jvm | ab -c 10 -n 7500 http://localhost:9080/api/greeting?name=Ivan                               |
      micronaut-simple-api-jvm | ab -c 10 -n 7500 http://localhost:9082/api/greeting?name=Ivan                               |
     springboot-simple-api-jvm | ab -c 10 -n 7500 http://localhost:9084/api/greeting?name=Ivan                               |
     quarkus-simple-api-native | ab -c 10 -n 7500 http://localhost:9081/api/greeting?name=Ivan                               |
   micronaut-simple-api-native | ab -c 10 -n 7500 http://localhost:9083/api/greeting?name=Ivan                               |
.............................. + ........................................................................................... |
          quarkus-book-api-jvm | ab -p test-books.json -T 'application/json' -c 5 -n 2500 http://localhost:9085/api/books    |
        micronaut-book-api-jvm | ab -p test-books.json -T 'application/json' -c 5 -n 2500 http://localhost:9087/api/books    |
       springboot-book-api-jvm | ab -p test-books.json -T 'application/json' -c 5 -n 2500 http://localhost:9089/api/books    |
       quarkus-book-api-native | ab -p test-books.json -T 'application/json' -c 5 -n 2500 http://localhost:9086/api/books    |
     micronaut-book-api-native | ab -p test-books.json -T 'application/json' -c 5 -n 2500 http://localhost:9088/api/books    |
.............................. + ........................................................................................... |
      quarkus-producer-api-jvm | ab -p test-news.json -T 'application/json' -c 5 -n 5000 http://localhost:9100/api/news      |
    micronaut-producer-api-jvm | ab -p test-news.json -T 'application/json' -c 5 -n 5000 http://localhost:9102/api/news      |
   springboot-producer-api-jvm | ab -p test-news.json -T 'application/json' -c 5 -n 5000 http://localhost:9104/api/news      |
   quarkus-producer-api-native | ab -p test-news.json -T 'application/json' -c 5 -n 5000 http://localhost:9101/api/news      |
 micronaut-producer-api-native | ab -p test-news.json -T 'application/json' -c 5 -n 5000 http://localhost:9103/api/news      |
.............................. + ........................................................................................... |
      quarkus-elasticsearch-jvm | ab -p test-movies.json -T 'application/json' -c 5 -n 2500 http://localhost:9105/api/movies |
    micronaut-elasticsearch-jvm | ab -p test-movies.json -T 'application/json' -c 5 -n 2500 http://localhost:9107/api/movies |
   springboot-elasticsearch-jvm | ab -p test-movies.json -T 'application/json' -c 5 -n 2500 http://localhost:9109/api/movies |
   quarkus-elasticsearch-native | ab -p test-movies.json -T 'application/json' -c 5 -n 2500 http://localhost:9106/api/movies |
 micronaut-elasticsearch-native | ab -p test-movies.json -T 'application/json' -c 5 -n 2500 http://localhost:9107/api/movies |
```
