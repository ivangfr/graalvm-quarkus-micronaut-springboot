# graalvm-quarkus-micronaut-springboot

The goal of this project is to compare some Java frameworks like: [`Quarkus`](https://quarkus.io/), [`Micronaut`](https://micronaut.io/) and [`Spring Boot`](https://docs.spring.io/spring-boot/docs/current/reference/htmlsingle/). For it, we will implement applications using those frameworks, measure their start-up times, memory footprint, etc.

Besides, as `Quarkus` and `Micronaut` support [`GraalVM`](https://www.graalvm.org/) out-of-the-box, we will use `GraalVM`’s `native-image` tool to build `Quarkus` and `Micronaut` native applications.

> **Note:** Spring team is working on supporting for `GraalVM` native images, https://github.com/spring-projects/spring-framework/wiki/GraalVM-native-image-support

## Examples

- ### [simple-api](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/simple-api#graalvm-quarkus-micronaut-springboot)
- ### [book-api](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/book-api#graalvm-quarkus-micronaut-springboot)
- ### [producer-consumer](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/producer-consumer#graalvm-quarkus-micronaut-springboot)

## Framework version

We are using the following Framework versions

| Framework   | Version       |
| ----------- | ------------- |
| Quarkus     | 1.4.2.Final   |
| Micronaut   | 2.0.0.M3      |
| Spring Boot | 2.2.7.RELEASE |

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
        quarkus-simple-api-jvm |            12s |           302177 |               81s |             450MB |
      micronaut-simple-api-jvm |            12s |         15705383 |                2s |             356MB |
     springboot-simple-api-jvm |             4s |         19686292 |                2s |             105MB |
.............................. + .............. + ................ + ................. + ................. |
          quarkus-book-api-jvm |            13s |           495895 |               13s |             475MB |
        micronaut-book-api-jvm |            23s |         34465100 |                4s |             375MB |
       springboot-book-api-jvm |             6s |         42620076 |                5s |             128MB |
.............................. + .............. + ................ + ................. + ................. |
      quarkus-producer-api-jvm |            11s |           416076 |               12s |             478MB |
    micronaut-producer-api-jvm |            17s |         26742833 |                4s |             367MB |
   springboot-producer-api-jvm |             8s |         34013511 |                3s |             119MB |
.............................. + .............. + ................ + ................. + ................. |
      quarkus-consumer-api-jvm |            13s |           392889 |               14s |             478MB |
    micronaut-consumer-api-jvm |            12s |         26723217 |                4s |             367MB |
   springboot-consumer-api-jvm |             7s |         34010901 |                3s |             119MB |
```

Table below shows the results after running the script `collect-native-jar-docker-size-times.sh`
```
                   Application | Packaging Time | Jar Size (bytes) | Docker Build Time | Docker Image Size |
------------------------------ + -------------- + ---------------- + ----------------- + ----------------- |
     quarkus-simple-api-native |           272s |         31931560 |                7s |             170MB |
   micronaut-simple-api-native |             8s |         15705381 |              335s |            91.2MB |
.............................. + .............. + ................ + ................. + ................. |
       quarkus-book-api-native |           667s |         74237352 |               10s |             254MB |
     micronaut-book-api-native |              - |                - |                 - |                 - |
.............................. + .............. + ................ + ................. + ................. |
   quarkus-producer-api-native |           398s |         49802872 |                7s |             205MB |
 micronaut-producer-api-native |            15s |         26742835 |              398s |             113MB |
.............................. + .............. + ................ + ................. + ................. |
   quarkus-consumer-api-native |           375s |         43764696 |                6s |             193MB |
 micronaut-consumer-api-native |            11s |         26723218 |              377s |             113MB |
```
> **Note 1:** There is no results for `micronaut-book-api-native` because I was not able to build it. This is the [issue](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/book-api/micronaut-book-api#issues)

Finally, the following table shows the results after running the script `collect-startup-ab-times.sh`
```
                   Application | Startup Time | Initial Memory Consumption | Ab Testing Time | Final Memory Consumption |
------------------------------ + ------------ + -------------------------- + --------------- + ------------------------ |
        quarkus-simple-api-jvm |       2154ms |                   99.09MiB |             32s |                 129.3MiB |
      micronaut-simple-api-jvm |       2024ms |                   103.2MiB |             41s |                 145.2MiB |
     springboot-simple-api-jvm |       5427ms |                   225.5MiB |             39s |                 328.7MiB |
     quarkus-simple-api-native |         95ms |                   3.902MiB |             26s |                 261.1MiB |
   micronaut-simple-api-native |        210ms |                   9.047MiB |             31s |                   264MiB |
.............................. +  ........... + .......................... + ............... + ........................ |
          quarkus-book-api-jvm |       3362ms |                   151.9MiB |             34s |                 185.6MiB |
        micronaut-book-api-jvm |       4386ms |                   156.1MiB |             31s |                 195.1MiB |
       springboot-book-api-jvm |      11396ms |                   811.2MiB |             29s |                 847.8MiB |
       quarkus-book-api-native |         35ms |                   6.121MiB |             21s |                 257.4MiB |
     micronaut-book-api-native |            - |                          - |               - |                        - |
.............................. +  ........... + .......................... + ............... + ........................ |
      quarkus-producer-api-jvm |       6397ms |                   148.7MiB |             39s |                 164.1MiB |
    micronaut-producer-api-jvm |       2373ms |                     119MiB |             54s |                 189.2MiB |
   springboot-producer-api-jvm |       8437ms |                   355.5MiB |             42s |                 415.5MiB |
   quarkus-producer-api-native |         92ms |                   5.227MiB |             27s |                 264.5MiB |
 micronaut-producer-api-native |         75ms |                   11.19MiB |             32s |                 267.3MiB |
.............................. +  ........... + .......................... + ............... + ........................ |
      quarkus-consumer-api-jvm |       2269ms |                   114.3MiB |             27s |                 161.9MiB |
    micronaut-consumer-api-jvm |       3313ms |                   127.1MiB |              4s |                 131.8MiB |
   springboot-consumer-api-jvm |       7473ms |                     358MiB |              4s |                 356.4MiB |
   quarkus-consumer-api-native |         70ms |                   5.598MiB |             13s |                 254.8MiB |
 micronaut-consumer-api-native |        124ms |                   111.6MiB |              1s |                 144.9MiB |
```

> **Note 1:** There is no results for `micronaut-book-api-native` because I was not able to build it. This is the [issue](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/book-api/micronaut-book-api#issues)

> **Note 2:** We can see that the performance of the `quarkus-consumer-api-jvm` and `quarkus-consumer-api-native` are really slow compared to other consumers. Checking the logs, it seems that the bottleneck is SmallRye Reactive Messaging. I have opened an issue related to it. For more information, see [Consumer reads 500 messages and stops a few seconds #290](https://github.com/smallrye/smallrye-reactive-messaging/issues/290)

`ab` tests used
```
                   Application | ab Test                                                                                  |
------------------------------ + ---------------------------------------------------------------------------------------- |
        quarkus-simple-api-jvm | ab -c 10 -n 7500 http://localhost:9080/api/greeting?name=Ivan                            |
      micronaut-simple-api-jvm | ab -c 10 -n 7500 http://localhost:9082/api/greeting?name=Ivan                            |
     springboot-simple-api-jvm | ab -c 10 -n 7500 http://localhost:9084/api/greeting?name=Ivan                            |
     quarkus-simple-api-native | ab -c 10 -n 7500 http://localhost:9081/api/greeting?name=Ivan                            |
   micronaut-simple-api-native | ab -c 10 -n 7500 http://localhost:9083/api/greeting?name=Ivan                            |
.............................. + ........................................................................................ |
          quarkus-book-api-jvm | ab -p test-books.json -T 'application/json' -c 5 -n 2500 http://localhost:9085/api/books |
        micronaut-book-api-jvm | ab -p test-books.json -T 'application/json' -c 5 -n 2500 http://localhost:9087/api/books |
       springboot-book-api-jvm | ab -p test-books.json -T 'application/json' -c 5 -n 2500 http://localhost:9089/api/books |
       quarkus-book-api-native | ab -p test-books.json -T 'application/json' -c 5 -n 2500 http://localhost:9086/api/books |
     micronaut-book-api-native | ab -p test-books.json -T 'application/json' -c 5 -n 2500 http://localhost:9088/api/books |
.............................. + ........................................................................................ |
      quarkus-producer-api-jvm | ab -p test-news.json -T 'application/json' -c 5 -n 5000 http://localhost:9100/api/news   |
    micronaut-producer-api-jvm | ab -p test-news.json -T 'application/json' -c 5 -n 5000 http://localhost:9102/api/news   |
   springboot-producer-api-jvm | ab -p test-news.json -T 'application/json' -c 5 -n 5000 http://localhost:9104/api/news   |
   quarkus-producer-api-native | ab -p test-news.json -T 'application/json' -c 5 -n 5000 http://localhost:9101/api/news   |
 micronaut-producer-api-native | ab -p test-news.json -T 'application/json' -c 5 -n 5000 http://localhost:9103/api/news   |
```
