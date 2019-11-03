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
      quarkus-producer-api-jvm |      7154ms |                   132.6MiB |             31s |                 162.4MiB |
    micronaut-producer-api-jvm |      7920ms |                   58.02MiB |             60s |                   158MiB |
   springboot-producer-api-jvm |      9515ms |                   256.3MiB |             32s |                 389.3MiB |
   quarkus-producer-api-native |        31ms |                   4.535MiB |             19s |                 262.9MiB |
 micronaut-producer-api-native |       118ms |                   14.91MiB |             25s |                   268MiB |
.............................. + ........... + .......................... + ............... + ........................ |
      quarkus-consumer-api-jvm |      6498ms |                   100.7MiB |             35s |                 124.6MiB |
    micronaut-consumer-api-jvm |      7468ms |                   63.52MiB |              4s |                 68.17MiB |
   springboot-consumer-api-jvm |     10256ms |                   264.8MiB |              3s |                 262.4MiB |
   quarkus-consumer-api-native |        66ms |                       5MiB |             21s |                 260.1MiB |
 micronaut-consumer-api-native |       134ms |                   17.18MiB |              2s |                 174.6MiB |
```

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
