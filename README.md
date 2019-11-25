# `graalvm-quarkus-micronaut-springboot`

The goal of this project is to compare some Java frameworks like: [`Quarkus`](https://quarkus.io/),
[`Micronaut`](https://micronaut.io/) and [`Spring Boot`](https://docs.spring.io/spring-boot/docs/current/reference/htmlsingle/).
For it, we will implement applications using those frameworks, measure their start-up times, memory footprint, etc.

Besides, as `Quarkus` and `Micronaut` support [`GraalVM`](https://www.graalvm.org/) out-of-the-box, we will use
`GraalVM`’s `native-image` tool to build `Quarkus` and `Micronaut` native applications.

> Note: Spring team is working on supporting for `GraalVM` native images,
https://github.com/spring-projects/spring-framework/wiki/GraalVM-native-image-support

## Examples

### [simple-api](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/simple-api#graalvm-quarkus-micronaut-springboot)

### [book-api](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/book-api#graalvm-quarkus-micronaut-springboot)

### [producer-consumer](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/producer-consumer#graalvm-quarkus-micronaut-springboot)

## Framework version

We are using the following Framework versions

| Framework   | Version       |
| ----------- | ------------- |
| Quarkus     | 1.0.0.Final   |
| Micronaut   | 1.2.6         |
| Spring Boot | 2.2.1.RELEASE |

## Bash scripts

In order to make it easier to collect data that will be used for comparing the frameworks, we've implemented some bash
scripts.

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
        quarkus-simple-api-jvm |             8s |           293940 |               15s |             101MB |
      micronaut-simple-api-jvm |             7s |         14089963 |                3s |             251MB |
     springboot-simple-api-jvm |             5s |         19465377 |                2s |             104MB |
.............................. + .............. + ................ + ................. + ................. |
          quarkus-book-api-jvm |            12s |           465106 |               24s |             161MB |
        micronaut-book-api-jvm |            19s |         32832619 |                3s |             270MB |
       springboot-book-api-jvm |             5s |         42358353 |                4s |             127MB |
.............................. + .............. + ................ + ................. + ................. |
      quarkus-producer-api-jvm |            11s |           379626 |               23s |             152MB |
    micronaut-producer-api-jvm |            12s |         24490214 |                3s |             262MB |
   springboot-producer-api-jvm |             7s |         33717616 |                3s |             119MB |
.............................. + .............. + ................ + ................. + ................. |
      quarkus-consumer-api-jvm |            11s |           341476 |               22s |             149MB |
    micronaut-consumer-api-jvm |            11s |         24465735 |                3s |             262MB |
   springboot-consumer-api-jvm |             7s |         33714996 |                3s |             119MB |
```

Table below shows the results after running the script `collect-native-jar-docker-size-times.sh`
```
                   Application | Packaging Time | Jar Size (bytes) | Docker Build Time | Docker Image Size |
------------------------------ + -------------- + ---------------- + ----------------- + ----------------- |
     quarkus-simple-api-native |           182s |         25963512 |                4s |             116MB |
   micronaut-simple-api-native |            12s |         14089966 |              286s |            87.1MB |
.............................. + .............. + ................ + ................. + ................. |
       quarkus-book-api-native |           305s |         63260128 |                6s |             153MB |
     micronaut-book-api-native |            17s |         32832610 |              548s |             145MB |
.............................. + .............. + ................ + ................. + ................. |
   quarkus-producer-api-native |           237s |         37852544 |                5s |             128MB |
 micronaut-producer-api-native |            11s |         24490205 |              329s |             108MB |
.............................. + .............. + ................ + ................. + ................. |
   quarkus-consumer-api-native |           219s |         35706240 |                4s |             126MB |
 micronaut-consumer-api-native |            10s |         24465722 |              315s |             108MB |
```

Finally, the following table shows the results after running the script `collect-startup-ab-times.sh`
```
                   Application | Startup Time | Initial Memory Consumption | Ab Testing Time | Final Memory Consumption |
------------------------------ + ------------ + -------------------------- + --------------- + ------------------------ |
        quarkus-simple-api-jvm |       1130ms |                   83.55MiB |             16s |                 117.7MiB |
      micronaut-simple-api-jvm |       5382ms |                   52.44MiB |             26s |                 130.2MiB |
     springboot-simple-api-jvm |       3142ms |                   221.9MiB |             20s |                 360.3MiB |
     quarkus-simple-api-native |         12ms |                   2.539MiB |             11s |                 256.1MiB |
   micronaut-simple-api-native |         54ms |                   11.64MiB |             14s |                 263.3MiB |
.............................. +  ........... + .......................... + ............... + ........................ |
          quarkus-book-api-jvm |       2716ms |                   144.5MiB |             21s |                 165.9MiB |
        micronaut-book-api-jvm |       6766ms |                   79.27MiB |             27s |                 162.8MiB |
       springboot-book-api-jvm |       6927ms |                   403.8MiB |             22s |                 434.3MiB |
       quarkus-book-api-native |         23ms |                   4.066MiB |             13s |                 255.5MiB |
     micronaut-book-api-native |            - |                          - |               - |                        - |
.............................. +  ........... + .......................... + ............... + ........................ |
      quarkus-producer-api-jvm |       2334ms |                   112.1MiB |             22s |                 149.6MiB |
    micronaut-producer-api-jvm |       5701ms |                   55.46MiB |             42s |                   154MiB |
   springboot-producer-api-jvm |       5006ms |                   253.3MiB |             24s |                 369.1MiB |
   quarkus-producer-api-native |         36ms |                   4.512MiB |             14s |                 265.8MiB |
 micronaut-producer-api-native |       3069ms |                    14.9MiB |             18s |                 267.9MiB |
.............................. +  ........... + .......................... + ............... + ........................ |
      quarkus-consumer-api-jvm |       4285ms |                   96.49MiB |             29s |                 141.8MiB |
    micronaut-consumer-api-jvm |       2963ms |                   60.42MiB |              8s |                 67.68MiB |
   springboot-consumer-api-jvm |       5542ms |                   285.5MiB |              5s |                 307.4MiB |
   quarkus-consumer-api-native |         99ms |                   4.953MiB |             14s |                   260MiB |
 micronaut-consumer-api-native |         91ms |                   17.23MiB |              2s |                 174.4MiB |
```

> Note 1. There is no results for `micronaut-book-api-native` because we are getting an error while trying to run it. It
> id related to this [issue](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/book-api/micronaut-book-api#issues) 

> Note 2. We can see that the performance of the `quarkus-consumer-api-jvm` and `quarkus-consumer-api-native` is really
> slow compared to other consumers. Checking the logs, it seems that the bottleneck is SmallRye Reactive Messaging. I
> have opened an issue related to it. For more information, see
> [Consumer reads 500 messages and stops a few seconds #290](https://github.com/smallrye/smallrye-reactive-messaging/issues/290)

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
