# graalvm-quarkus-micronaut-springboot
## `> producer-consumer`

In this example, we will implement three versions of `producer - consumer` applications using `Quarkus`, `Micronaut` and `Spring Boot` Frameworks.

## Applications

- ### [quarkus-producer-consumer](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/producer-consumer/quarkus-producer-consumer#graalvm-quarkus-micronaut-springboot)
- ### [micronaut-producer-consumer](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/producer-consumer/micronaut-producer-consumer#graalvm-quarkus-micronaut-springboot)
- ### [springboot-producer-consumer](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/producer-consumer/springboot-producer-consumer#graalvm-quarkus-micronaut-springboot)

## Start environment

- Open a terminal and navigate to `graalvm-quarkus-micronaut-springboot/producer-consumer` folder

- Run the command
  ```
  docker-compose up -d
  ```

- Wait a little bit until all containers `Up (healthy)`. You can check it by running
  ```
  docker-compose ps
  ```

## Shutdown

- In a terminal, make sure you are in `graalvm-quarkus-micronaut-springboot/producer-consumer` folder

- To stop and remove docker-compose containers, networks and volumes, run
  ```
  docker-compose down -v
  ```

## Useful links

- **Kafka Topics UI**
     
  `Kafka Topics UI` can be accessed at http://localhost:8085

- **Kafka Manager**
     
  `Kafka Manager` can be accessed at http://localhost:9000

  *Configuration*

  - First, you must create a new cluster. Click on `Cluster` (dropdown on the header) and then on `Add Cluster`
  - Type the name of your cluster in `Cluster Name` field, for example: `MyZooCluster`
  - Type `zookeeper:2181` in `Cluster Zookeeper Hosts` field
  - Enable checkbox `Poll consumer information (Not recommended for large # of consumers)`
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
