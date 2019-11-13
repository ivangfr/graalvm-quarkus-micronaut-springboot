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
| Quarkus     | 1.0.0.RC1     |
| Micronaut   | 1.2.6         |
| Spring Boot | 2.2.1.RELEASE |

## Bash scripts

In order to make it easier to collect data that will be used for comparing the frameworks, we've implemented some bash
scripts.

| Bash script                             | Description |
| --------------------------------------- | ----------- |
| collect-jvm-jar-docker-size-times.sh    | packages/assembles jar files and builds docker images of all JVM applications, collecting data like: jar packaging Time, size of the jar, docker build time and docker image size |
| collect-native-jar-docker-size-times.sh | packages/assembles jar files and builds docker images of all Native applications, collecting data like: jar packaging Time, size of the jar, docker build time and docker image size |
| collect-startup-ab-times.sh             | starts docker container of all applications (JVM and Native), collecting data like: startup time, initial memory consumption, time spent to run some ab tests and final memory consumption |

## Comparison

The following table shows the results after running the script `collect-jvm-jar-docker-size-times.sh`
```
                   Application | Packaging Time | Jar Size (bytes) | Docker Build Time | Docker Image Size |
------------------------------ + -------------- + ---------------- + ----------------- + ----------------- |
        quarkus-simple-api-jvm |            11s |           279841 |               17s |             101MB |
      micronaut-simple-api-jvm |            10s |         14089963 |                3s |             251MB |
     springboot-simple-api-jvm |             3s |         19465377 |                3s |             104MB |
.............................. + .............. + ................ + ................. + ................. |
          quarkus-book-api-jvm |            17s |           444524 |               26s |             160MB |
        micronaut-book-api-jvm |            19s |         32806941 |                4s |             270MB |
       springboot-book-api-jvm |             6s |         42358353 |                5s |             127MB |
.............................. + .............. + ................ + ................. + ................. |
      quarkus-producer-api-jvm |            14s |           359990 |               28s |             152MB |
    micronaut-producer-api-jvm |            15s |         24490195 |                3s |             262MB |
   springboot-producer-api-jvm |             9s |         33717616 |                4s |             119MB |
.............................. + .............. + ................ + ................. + ................. |
      quarkus-consumer-api-jvm |            13s |           323850 |               26s |             149MB |
    micronaut-consumer-api-jvm |            11s |         24465734 |                3s |             262MB |
   springboot-consumer-api-jvm |             7s |         33714996 |                5s |             119MB |
```

Table below shows the results after running the script `collect-native-jar-docker-size-times.sh`
```
                   Application | Packaging Time | Jar Size (bytes) | Docker Build Time | Docker Image Size |
------------------------------ + -------------- + ---------------- + ----------------- + ----------------- |
     quarkus-simple-api-native |           339s |         25975800 |                5s |             116MB |
   micronaut-simple-api-native |             7s |         14089954 |              510s |            87.1MB |
.............................. + .............. + ................ + ................. + ................. |
       quarkus-book-api-native |           546s |         63337952 |                8s |             153MB |
     micronaut-book-api-native |            17s |         32806929 |              656s |             145MB |
.............................. + .............. + ................ + ................. + ................. |
   quarkus-producer-api-native |           288s |         37868928 |                5s |             128MB |
 micronaut-producer-api-native |            12s |         24490209 |              383s |             108MB |
.............................. + .............. + ................ + ................. + ................. |
   quarkus-consumer-api-native |           272s |         35730816 |                5s |             126MB |
 micronaut-consumer-api-native |            10s |         24465737 |              386s |             108MB |
```

Finally, the following table shows the results after running the script `collect-startup-ab-times.sh`
```
                   Application | Startup Time | Initial Memory Consumption | Ab Testing Time | Final Memory Consumption |
------------------------------ + ------------ + -------------------------- + --------------- + ------------------------ |
        quarkus-simple-api-jvm |       2964ms |                   82.98MiB |             21s |                 127.8MiB |
      micronaut-simple-api-jvm |       5880ms |                   127.3MiB |             28s |                 165.4MiB |
     springboot-simple-api-jvm |       5686ms |                   226.5MiB |             21s |                 355.5MiB |
     quarkus-simple-api-native |         15ms |                   2.539MiB |             15s |                 258.7MiB |
   micronaut-simple-api-native |         55ms |                   11.57MiB |             17s |                 263.3MiB |
.............................. + ............ + .......................... + ............... + ........................ |
          quarkus-book-api-jvm |       6140ms |                     126MiB |             28s |                 164.2MiB |
        micronaut-book-api-jvm |       8118ms |                   78.22MiB |             33s |                 160.5MiB |
       springboot-book-api-jvm |      13955ms |                   409.4MiB |             28s |                   432MiB |
       quarkus-book-api-native |         20ms |                   4.105MiB |             17s |                 257.4MiB |
     micronaut-book-api-native |            - |                          - |               - |                        - |
.............................. + ............ + .......................... + ............... + ........................ |
      quarkus-producer-api-jvm |       7689ms |                   122.9MiB |             33s |                 159.9MiB |
    micronaut-producer-api-jvm |       6681ms |                   53.13MiB |             60s |                 170.9MiB |
   springboot-producer-api-jvm |      10657ms |                     256MiB |             32s |                 387.1MiB |
   quarkus-producer-api-native |         25ms |                   4.555MiB |             19s |                 265.6MiB |
 micronaut-producer-api-native |         60ms |                   14.92MiB |             25s |                   269MiB |
.............................. + ............ + .......................... + ............... + ........................ |
      quarkus-consumer-api-jvm |       6482ms |                   101.7MiB |             38s |                   121MiB |
    micronaut-consumer-api-jvm |       8317ms |                   60.69MiB |              5s |                 68.09MiB |
   springboot-consumer-api-jvm |       9858ms |                   286.1MiB |              3s |                 310.5MiB |
   quarkus-consumer-api-native |         65ms |                    4.98MiB |             23s |                 258.9MiB |
 micronaut-consumer-api-native |        145ms |                    17.2MiB |              2s |                 174.6MiB |
```

> Note 1. There is no results for `micronaut-book-api-native` because we are getting an error while trying to run it. It
> id related to this [issue](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/book-api/micronaut-book-api#issues) 

> Note 2. We can see that the performance of the `quarkus-consumer-api-jvm` and `quarkus-consumer-api-native` is really
> slow compared to other consumers. Checking the logs, it seems that the bottleneck is SmallRye Reactive Messaging. I
> have opened an issue related to it. For more information, see
>[`Consumer reads 500 messages and stops 3 seconds #290`](https://github.com/smallrye/smallrye-reactive-messaging/issues/290)

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
