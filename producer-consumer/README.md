# `graalvm-quarkus-micronaut-springboot`
## `> producer-consumer`

In this example, we will implement three versions of a producer and a consumer applications using `Quarkus`, `Micronaut`
and `Spring Boot` Frameworks.

## Applications

#### [quarkus-producer-consumer](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/producer-consumer/quarkus-producer-consumer#graalvm-quarkus-micronaut-springboot)

#### [micronaut-producer-consumer](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/producer-consumer/micronaut-producer-consumer#graalvm-quarkus-micronaut-springboot)

#### [springboot-producer-consumer](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/producer-consumer/springboot-producer-consumer#graalvm-quarkus-micronaut-springboot)

## Start environment

Open a terminal and inside `graalvm-quarkus-micronaut-springboot/producer-consumer` folder run
```
docker-compose up -d
```

Wait a little bit until all containers `Up (healthy)`. You can check it by running
```
docker-compose ps
```

## Comparison

```
                   Application | Packaging Time | Jar Size (bytes) | Docker Build Time | Docker Image Size |
------------------------------ + -------------- + ---------------- + ----------------- + ----------------- |
      quarkus-producer-api-jvm |            11s |           359418 |               24s |             116MB |
    micronaut-producer-api-jvm |            11s |         24486929 |                4s |             267MB |
   springboot-producer-api-jvm |             7s |         33715188 |                4s |             119MB |
   quarkus-producer-api-native |           272s |           359507 |                7s |             128MB |
 micronaut-producer-api-native |            12s |         24486909 |              385s |             108MB |
.............................. + .............. + ................ + ................. + ................. |
      quarkus-consumer-api-jvm |            10s |           323143 |               21s |             114MB |
    micronaut-consumer-api-jvm |            12s |         24462502 |                3s |             267MB |
   springboot-consumer-api-jvm |             8s |         33712531 |                5s |             119MB |
   quarkus-consumer-api-native |           260s |           323141 |                7s |             126MB |
 micronaut-consumer-api-native |            10s |         24462514 |              377s |             108MB |
```

```
                   Application | Statup Time | Initial Memory Consumption | Ab Testing Time | Final Memory Consumption |
------------------------------ + ----------- + -------------------------- + --------------- + ------------------------ |
      quarkus-producer-api-jvm |      7209ms |                   131.3MiB |             29s |                   155MiB |
    micronaut-producer-api-jvm |      3391ms |                   54.25MiB |             59s |                 155.2MiB |
   springboot-producer-api-jvm |      9346ms |                   245.2MiB |             30s |                 303.5MiB |
   quarkus-producer-api-native |        23ms |                   4.523MiB |             17s |                 263.1MiB |
 micronaut-producer-api-native |        88ms |                   14.94MiB |             26s |                   268MiB |
.............................. + ........... + .......................... + ............... + ........................ |
      quarkus-consumer-api-jvm |      8091ms |                   97.06MiB |             36s |                 126.7MiB |
    micronaut-consumer-api-jvm |      3969ms |                   64.02MiB |              7s |                 66.21MiB |
   springboot-consumer-api-jvm |      9146ms |                   258.4MiB |              3s |                 259.6MiB |
   quarkus-consumer-api-native |        76ms |                   4.973MiB |             27s |                 259.8MiB |
 micronaut-consumer-api-native |       148ms |                   17.23MiB |              2s |                 174.5MiB |
```
> Note. We can see that the performance of the `quarkus-consumer-api-jvm` and `quarkus-consumer-api-native` is really
> slow compared to other consumers. Checking the logs, it seems that the bottleneck is SmallRye Reactive Messaging. I
> have opened an issue related to it. For more information, see
>[`Consumer reads 500 messages and stops 3 seconds #290`](https://github.com/smallrye/smallrye-reactive-messaging/issues/290)

`ab` tests used
```
                   Application |                                                                                ab Test |
------------------------------ | -------------------------------------------------------------------------------------- |
      quarkus-producer-api-jvm | ab -p test-news.json -T 'application/json' -c 5 -n 5000 http://localhost:9100/api/news |
    micronaut-producer-api-jvm | ab -p test-news.json -T 'application/json' -c 5 -n 5000 http://localhost:9102/api/news |
   springboot-producer-api-jvm | ab -p test-news.json -T 'application/json' -c 5 -n 5000 http://localhost:9104/api/news |
   quarkus-producer-api-native | ab -p test-news.json -T 'application/json' -c 5 -n 5000 http://localhost:9101/api/news |
 micronaut-producer-api-native | ab -p test-news.json -T 'application/json' -c 5 -n 5000 http://localhost:9103/api/news |
```

## Shutdown

To stop and remove containers, networks and volumes, run
```
docker-compose down -v
```

## Useful links

### Kafka Topics UI
     
`Kafka Topics UI` can be accessed at http://localhost:8085

### Kafka Manager
     
`Kafka Manager` can be accessed at http://localhost:9000

**Configuration**

- First, you must create a new cluster. Click on `Cluster` (dropdown on the header) and then on `Add Cluster`
- Type the name of your cluster in `Cluster Name` field, for example: `MyZooCluster`
- Type `zookeeper:2181` in `Cluster Zookeeper Hosts` field
- Enable checkbox `Poll consumer information (Not recommended for large # of consumers if ZK is used for offsets tracking on older Kafka versions)`
- Click on `Save` button at the bottom of the page.

## Troubleshooting

If you are facing the following `WARNING`, see https://thoeni.io/post/macos-sierra-java/
```
WARNING [io.ver.cor.imp.BlockedThreadChecker] (vertx-blocked-thread-checker) Thread Thread[vert.x-eventloop-thread-7,5,main]=Thread[vert.x-eventloop-thread-7,5,main] has been blocked for 3889 ms, time limit is 2000 ms: io.vertx.core.VertxException: Thread blocked
        at io.vertx.core.http.impl.HttpServerImpl.listen(HttpServerImpl.java:222)
        at io.vertx.core.http.impl.HttpServerImpl.listen(HttpServerImpl.java:171)
        at io.quarkus.vertx.http.runtime.VertxHttpRecorder$WebDeploymentVerticle.start(VertxHttpRecorder.java:444)
        at io.vertx.core.Verticle.start(Verticle.java:66)
        at io.vertx.core.impl.DeploymentManager.lambda$doDeploy$8(DeploymentManager.java:556)
        at io.vertx.core.impl.DeploymentManager$$Lambda$313/936906727.handle(Unknown Source)
        at io.vertx.core.impl.ContextImpl.executeTask(ContextImpl.java:369)
        at io.vertx.core.impl.EventLoopContext.lambda$executeAsync$0(EventLoopContext.java:38)
        at io.vertx.core.impl.EventLoopContext$$Lambda$314/1911138454.run(Unknown Source)
        at io.netty.util.concurrent.AbstractEventExecutor.safeExecute(AbstractEventExecutor.java:163)
        at io.netty.util.concurrent.SingleThreadEventExecutor.runAllTasks(SingleThreadEventExecutor.java:416)
        at io.netty.channel.nio.NioEventLoop.run(NioEventLoop.java:515)
        at io.netty.util.concurrent.SingleThreadEventExecutor$5.run(SingleThreadEventExecutor.java:918)
        at io.netty.util.internal.ThreadExecutorMap$2.run(ThreadExecutorMap.java:74)
        at io.netty.util.concurrent.FastThreadLocalRunnable.run(FastThreadLocalRunnable.java:30)
        at java.lang.Thread.run(Thread.java:748)
```
