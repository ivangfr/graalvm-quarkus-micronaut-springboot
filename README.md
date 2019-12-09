# `graalvm-quarkus-micronaut-springboot`

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
| Quarkus     | 1.0.1.Final   |
| Micronaut   | 1.2.7         |
| Spring Boot | 2.2.2.RELEASE |

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
        quarkus-simple-api-jvm |             9s |           293875 |               14s |             101MB |
      micronaut-simple-api-jvm |            12s |         14100675 |                3s |             251MB |
     springboot-simple-api-jvm |             4s |         19487525 |                3s |             104MB |
.............................. + .............. + ................ + ................. + ................. |
          quarkus-book-api-jvm |            12s |           464953 |               22s |             161MB |
        micronaut-book-api-jvm |            22s |         32843393 |                3s |             270MB |
       springboot-book-api-jvm |             5s |         42394343 |                5s |             127MB |
.............................. + .............. + ................ + ................. + ................. |
      quarkus-producer-api-jvm |            13s |           379554 |               22s |             152MB |
    micronaut-producer-api-jvm |            12s |         24503988 |                3s |             262MB |
   springboot-producer-api-jvm |             8s |         33754969 |                4s |             119MB |
.............................. + .............. + ................ + ................. + ................. |
      quarkus-consumer-api-jvm |            11s |           341441 |               21s |             149MB |
    micronaut-consumer-api-jvm |            13s |         24479506 |                3s |             262MB |
   springboot-consumer-api-jvm |             7s |         33752348 |                2s |             119MB |
```

Table below shows the results after running the script `collect-native-jar-docker-size-times.sh`
```
                   Application | Packaging Time | Jar Size (bytes) | Docker Build Time | Docker Image Size |
------------------------------ + -------------- + ---------------- + ----------------- + ----------------- |
     quarkus-simple-api-native |           194s |         25963512 |                5s |             116MB |
   micronaut-simple-api-native |             8s |         14100675 |              671s |              87MB |
.............................. + .............. + ................ + ................. + ................. |
       quarkus-book-api-native |           307s |         63260128 |                6s |             153MB |
     micronaut-book-api-native |            21s |         32843388 |              542s |             145MB |
.............................. + .............. + ................ + ................. + ................. |
   quarkus-producer-api-native |           233s |         37852544 |                5s |             128MB |
 micronaut-producer-api-native |            11s |         24504005 |              651s |             108MB |
.............................. + .............. + ................ + ................. + ................. |
   quarkus-consumer-api-native |           219s |         35706240 |                4s |             126MB |
 micronaut-consumer-api-native |            11s |         24479534 |              481s |             108MB |
```

Finally, the following table shows the results after running the script `collect-startup-ab-times.sh`
```
                    Application | Startup Time | Initial Memory Consumption | Ab Testing Time | Final Memory Consumption |
------------------------------ + ------------ + -------------------------- + --------------- + ------------------------ |
        quarkus-simple-api-jvm |       1172ms |                   83.67MiB |             17s |                 123.5MiB |
      micronaut-simple-api-jvm |       2503ms |                    49.3MiB |             27s |                 130.3MiB |
     springboot-simple-api-jvm |       3024ms |                   222.6MiB |             20s |                 384.2MiB |
     quarkus-simple-api-native |         13ms |                   2.527MiB |             12s |                 259.4MiB |
   micronaut-simple-api-native |         49ms |                   9.555MiB |             15s |                 262.5MiB |
.............................. +  ........... + .......................... + ............... + ........................ |
          quarkus-book-api-jvm |       2756ms |                   137.8MiB |             23s |                 166.4MiB |
        micronaut-book-api-jvm |       3797ms |                   77.25MiB |             27s |                 160.9MiB |
       springboot-book-api-jvm |       6674ms |                   411.4MiB |             22s |                 427.8MiB |
       quarkus-book-api-native |         24ms |                    4.07MiB |             13s |                 252.7MiB |
     micronaut-book-api-native |            - |                          - |               - |                        - |
.............................. +  ........... + .......................... + ............... + ........................ |
      quarkus-producer-api-jvm |       2139ms |                   108.9MiB |             22s |                 149.8MiB |
    micronaut-producer-api-jvm |       2530ms |                   55.66MiB |             37s |                 210.4MiB |
   springboot-producer-api-jvm |       5224ms |                   271.4MiB |             24s |                 383.6MiB |
   quarkus-producer-api-native |         31ms |                   4.531MiB |             15s |                 264.3MiB |
 micronaut-producer-api-native |         74ms |                   12.68MiB |             17s |                 266.9MiB |
.............................. +  ........... + .......................... + ............... + ........................ |
      quarkus-consumer-api-jvm |       4680ms |                   100.4MiB |             30s |                 136.7MiB |
    micronaut-consumer-api-jvm |       2947ms |                    58.5MiB |              9s |                 64.73MiB |
   springboot-consumer-api-jvm |       5141ms |                   318.9MiB |              4s |                 328.9MiB |
   quarkus-consumer-api-native |         52ms |                       5MiB |             15s |                 260.1MiB |
 micronaut-consumer-api-native |        102ms |                   14.81MiB |              4s |                   148MiB |
```

> **Note 1:** There is no results for `micronaut-book-api-native` because we are getting an error while trying to run it. It id related to this [issue](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/book-api/micronaut-book-api#issues)

> **Note 2:** We can see that the performance of the `quarkus-consumer-api-jvm` and `quarkus-consumer-api-native` is really slow compared to other consumers. Checking the logs, it seems that the bottleneck is SmallRye Reactive Messaging. I have opened an issue related to it. For more information, see [Consumer reads 500 messages and stops a few seconds #290](https://github.com/smallrye/smallrye-reactive-messaging/issues/290)

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
