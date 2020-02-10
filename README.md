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
| Quarkus     | 1.2.0.Final   |
| Micronaut   | 1.2.10        |
| Spring Boot | 2.2.4.RELEASE |

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
        quarkus-simple-api-jvm |            13s |           277396 |               53s |             279MB |
      micronaut-simple-api-jvm |            12s |         14089680 |                2s |             251MB |
     springboot-simple-api-jvm |             5s |         19546121 |                2s |             104MB |
.............................. + .............. + ................ + ................. + ................. |
          quarkus-book-api-jvm |            14s |           459218 |               18s |             311MB |
        micronaut-book-api-jvm |            20s |         32864169 |                4s |             270MB |
       springboot-book-api-jvm |             7s |         42481231 |                4s |             127MB |
.............................. + .............. + ................ + ................. + ................. |
      quarkus-producer-api-jvm |            11s |           369633 |               13s |             306MB |
    micronaut-producer-api-jvm |            13s |         24493009 |                2s |             262MB |
   springboot-producer-api-jvm |             7s |         33816896 |                4s |             119MB |
.............................. + .............. + ................ + ................. + ................. |
      quarkus-consumer-api-jvm |            10s |           328952 |               16s |             304MB |
    micronaut-consumer-api-jvm |            11s |         24468519 |                3s |             262MB |
   springboot-consumer-api-jvm |             7s |         33814275 |                4s |             119MB |
```

Table below shows the results after running the script `collect-native-jar-docker-size-times.sh`
```
                   Application | Packaging Time | Jar Size (bytes) | Docker Build Time | Docker Image Size |
------------------------------ + -------------- + ---------------- + ----------------- + ----------------- |
     quarkus-simple-api-native |           202s |         26254376 |                4s |             158MB |
   micronaut-simple-api-native |             7s |         14089675 |              312s |            86.9MB |
.............................. + .............. + ................ + ................. + ................. |
       quarkus-book-api-native |           377s |         65320464 |                8s |             236MB |
     micronaut-book-api-native |            16s |         32864183 |              633s |             145MB |
.............................. + .............. + ................ + ................. + ................. |
   quarkus-producer-api-native |           272s |         38831536 |                5s |             183MB |
 micronaut-producer-api-native |            13s |         24492996 |              393s |             108MB |
.............................. + .............. + ................ + ................. + ................. |
   quarkus-consumer-api-native |           260s |         36701616 |                5s |             179MB |
 micronaut-consumer-api-native |            11s |         24468531 |              402s |             108MB |
```

Finally, the following table shows the results after running the script `collect-startup-ab-times.sh`
```
                    Application | Startup Time | Initial Memory Consumption | Ab Testing Time | Final Memory Consumption |
------------------------------ + ------------ + -------------------------- + --------------- + ------------------------ |
        quarkus-simple-api-jvm |       1515ms |                   104.2MiB |             30s |                 148.4MiB |
      micronaut-simple-api-jvm |       5413ms |                   51.09MiB |             41s |                 130.8MiB |
     springboot-simple-api-jvm |       3791ms |                   222.9MiB |             33s |                 347.8MiB |
     quarkus-simple-api-native |         19ms |                    3.18MiB |             23s |                 258.7MiB |
   micronaut-simple-api-native |         58ms |                   9.617MiB |             24s |                   261MiB |
.............................. +  ........... + .......................... + ............... + ........................ |
          quarkus-book-api-jvm |       3464ms |                   160.1MiB |             29s |                 188.8MiB |
        micronaut-book-api-jvm |       8574ms |                   83.39MiB |             41s |                 165.5MiB |
       springboot-book-api-jvm |       8047ms |                   412.5MiB |             29s |                 452.5MiB |
       quarkus-book-api-native |         55ms |                   5.324MiB |             19s |                 256.4MiB |
     micronaut-book-api-native |            - |                          - |               - |                        - |
.............................. +  ........... + .......................... + ............... + ........................ |
      quarkus-producer-api-jvm |       2187ms |                     143MiB |             33s |                 176.5MiB |
    micronaut-producer-api-jvm |       6527ms |                   57.97MiB |             54s |                 189.6MiB |
   springboot-producer-api-jvm |       5922ms |                   262.2MiB |             34s |                   401MiB |
   quarkus-producer-api-native |         34ms |                   5.227MiB |             21s |                 262.5MiB |
 micronaut-producer-api-native |         72ms |                   12.64MiB |             26s |                 267.6MiB |
.............................. +  ........... + .......................... + ............... + ........................ |
      quarkus-consumer-api-jvm |       4853ms |                   113.6MiB |             27s |                 157.9MiB |
    micronaut-consumer-api-jvm |       6446ms |                   60.69MiB |              6s |                 66.17MiB |
   springboot-consumer-api-jvm |       6803ms |                   272.8MiB |              5s |                 320.2MiB |
   quarkus-consumer-api-native |        106ms |                   5.695MiB |             16s |                 259.9MiB |
 micronaut-consumer-api-native |        108ms |                   14.85MiB |              2s |                 147.9MiB |
```

> **Note 1:** There is no results for `micronaut-book-api-native` because we are getting an error while trying to run it. It id related to this [issue](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/book-api/micronaut-book-api#issues)

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
