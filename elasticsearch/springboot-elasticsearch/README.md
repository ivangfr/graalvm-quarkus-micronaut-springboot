# graalvm-quarkus-micronaut-springboot
## `> elasticsearch > springboot-elasticsearch`

## Application

- **springboot-elasticsearch**

  [`Spring Boot`](https://docs.spring.io/spring-boot/docs/current/reference/htmlsingle/) Java Web application that expose a simple REST API for indexing and searching movies in `Elasticsearch`.
  
  It has the following endpoint:
  ```
  POST /api/movies -d {"imdb": "...", "title": "..."}
  GET /api/movies[?title=...]
  ```

## Running application

> **Note:** `Elasticsearch` container must be running and initialized as explained [here](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/elasticsearch#start-environment)

### Development Mode

- Open a terminal and navigate to `graalvm-quarkus-micronaut-springboot/elasticsearch/springboot-elasticsearch` folder

- Run the command below to start the application
  ```
  ./mvnw clean spring-boot:run
  ```

- A simple test can be done by opening a new terminal and running
  ```
  curl -i -X POST "localhost:8080/api/movies" -H "Content-type: application/json" \
    -d '{"imdb": "123", "title": "I, Tonya"}'
  
  curl "localhost:8080/api/movies?title=tonya"
  ```

- To stop the application, press `Ctrl+C` in its terminal

### Docker in JVM Mode

- In a terminal, make sure you are inside `graalvm-quarkus-micronaut-springboot/elasticsearch/springboot-elasticsearch` folder

- Run the script below to build the Docker image
  ```
  ./docker-build.sh
  ```

- Run the following command to start the Docker container
  ```
  docker run --rm --name springboot-elasticsearch-jvm \
    -p 9109:8080 -e ELASTICSEARCH_HOST=elasticsearch --network elasticsearch_default \
    docker.mycompany.com/springboot-elasticsearch-jvm:1.0.0
  ```

- A simple test can be done by opening a new terminal and running
  ```
  curl -i -X POST "localhost:9109/api/movies" -H "Content-type: application/json" \
    -d '{"imdb": "456", "title": "American Pie"}'
  
  curl "localhost:9109/api/movies?title=american"
  ```

- To stop and remove application Docker container, press `Ctrl+C` in its terminal

### Docker in Native Mode

Spring team is working on supporting for `GraalVM` native images, https://github.com/spring-projects/spring-framework/wiki/GraalVM-native-image-support

## Issues

When running `Docker in JVM Mode`, this exception is thrown. Maybe, it's related to https://github.com/spring-projects/spring-boot/issues/23106
```
2020-11-21 15:06:58.954 ERROR 1 --- [or-http-epoll-2] reactor.core.publisher.Operators         : Operator called default onErrorDropped

reactor.core.Exceptions$ErrorCallbackNotImplemented: org.springframework.data.elasticsearch.client.NoReachableHostException: Host 'localhost:9200' not reachable. Cluster state is offline.
Caused by: org.springframework.data.elasticsearch.client.NoReachableHostException: Host 'localhost:9200' not reachable. Cluster state is offline.
	at org.springframework.data.elasticsearch.client.reactive.SingleNodeHostProvider.lambda$lookupActiveHost$4(SingleNodeHostProvider.java:108) ~[spring-data-elasticsearch-4.1.1.jar:4.1.1]
	at reactor.core.publisher.FluxHandle$HandleSubscriber.onNext(FluxHandle.java:102) ~[reactor-core-3.4.0.jar:3.4.0]
	at reactor.core.publisher.FluxMap$MapConditionalSubscriber.onNext(FluxMap.java:220) ~[reactor-core-3.4.0.jar:3.4.0]
	at reactor.core.publisher.FluxOnErrorResume$ResumeSubscriber.onNext(FluxOnErrorResume.java:79) ~[reactor-core-3.4.0.jar:3.4.0]
	at reactor.core.publisher.Operators$ScalarSubscription.request(Operators.java:2346) ~[reactor-core-3.4.0.jar:3.4.0]
	at reactor.core.publisher.Operators$MultiSubscriptionSubscriber.set(Operators.java:2154) ~[reactor-core-3.4.0.jar:3.4.0]
	at reactor.core.publisher.FluxOnErrorResume$ResumeSubscriber.onSubscribe(FluxOnErrorResume.java:74) ~[reactor-core-3.4.0.jar:3.4.0]
	at reactor.core.publisher.MonoJust.subscribe(MonoJust.java:54) ~[reactor-core-3.4.0.jar:3.4.0]
	at reactor.core.publisher.Mono.subscribe(Mono.java:3987) ~[reactor-core-3.4.0.jar:3.4.0]
	at reactor.core.publisher.FluxOnErrorResume$ResumeSubscriber.onError(FluxOnErrorResume.java:103) ~[reactor-core-3.4.0.jar:3.4.0]
	at reactor.core.publisher.MonoFlatMap$FlatMapMain.onError(MonoFlatMap.java:172) ~[reactor-core-3.4.0.jar:3.4.0]
	at reactor.core.publisher.Operators$MultiSubscriptionSubscriber.onError(Operators.java:2023) ~[reactor-core-3.4.0.jar:3.4.0]
	at reactor.core.publisher.FluxOnAssembly$OnAssemblySubscriber.onError(FluxOnAssembly.java:392) ~[reactor-core-3.4.0.jar:3.4.0]
	at reactor.core.publisher.MonoPeekTerminal$MonoTerminalPeekSubscriber.onError(MonoPeekTerminal.java:258) ~[reactor-core-3.4.0.jar:3.4.0]
	at reactor.core.publisher.FluxMap$MapConditionalSubscriber.onError(FluxMap.java:259) ~[reactor-core-3.4.0.jar:3.4.0]
	at reactor.core.publisher.FluxOnErrorResume$ResumeSubscriber.onError(FluxOnErrorResume.java:106) ~[reactor-core-3.4.0.jar:3.4.0]
	at reactor.core.publisher.Operators.error(Operators.java:196) ~[reactor-core-3.4.0.jar:3.4.0]
	at reactor.core.publisher.MonoErrorSupplied.subscribe(MonoErrorSupplied.java:71) ~[reactor-core-3.4.0.jar:3.4.0]
	at reactor.core.publisher.Mono.subscribe(Mono.java:3987) ~[reactor-core-3.4.0.jar:3.4.0]
	at reactor.core.publisher.FluxOnErrorResume$ResumeSubscriber.onError(FluxOnErrorResume.java:103) ~[reactor-core-3.4.0.jar:3.4.0]
	at reactor.core.publisher.FluxPeek$PeekSubscriber.onError(FluxPeek.java:221) ~[reactor-core-3.4.0.jar:3.4.0]
	at reactor.core.publisher.FluxPeek$PeekSubscriber.onError(FluxPeek.java:221) ~[reactor-core-3.4.0.jar:3.4.0]
	at reactor.core.publisher.FluxPeek$PeekSubscriber.onError(FluxPeek.java:221) ~[reactor-core-3.4.0.jar:3.4.0]
	at reactor.core.publisher.MonoNext$NextSubscriber.onError(MonoNext.java:93) ~[reactor-core-3.4.0.jar:3.4.0]
	at reactor.core.publisher.MonoFlatMapMany$FlatMapManyMain.onError(MonoFlatMapMany.java:204) ~[reactor-core-3.4.0.jar:3.4.0]
	at reactor.core.publisher.SerializedSubscriber.onError(SerializedSubscriber.java:124) ~[reactor-core-3.4.0.jar:3.4.0]
	at reactor.core.publisher.FluxRetryWhen$RetryWhenMainSubscriber.whenError(FluxRetryWhen.java:224) ~[reactor-core-3.4.0.jar:3.4.0]
	at reactor.core.publisher.FluxRetryWhen$RetryWhenOtherSubscriber.onError(FluxRetryWhen.java:273) ~[reactor-core-3.4.0.jar:3.4.0]
	at reactor.core.publisher.FluxConcatMap$ConcatMapImmediate.drain(FluxConcatMap.java:413) ~[reactor-core-3.4.0.jar:3.4.0]
	at reactor.core.publisher.FluxConcatMap$ConcatMapImmediate.onNext(FluxConcatMap.java:250) ~[reactor-core-3.4.0.jar:3.4.0]
	at reactor.core.publisher.EmitterProcessor.drain(EmitterProcessor.java:478) ~[reactor-core-3.4.0.jar:3.4.0]
	at reactor.core.publisher.EmitterProcessor.tryEmitNext(EmitterProcessor.java:286) ~[reactor-core-3.4.0.jar:3.4.0]
	at reactor.core.publisher.SinkManySerialized.tryEmitNext(SinkManySerialized.java:97) ~[reactor-core-3.4.0.jar:3.4.0]
	at reactor.core.publisher.InternalManySink.emitNext(InternalManySink.java:27) ~[reactor-core-3.4.0.jar:3.4.0]
	at reactor.core.publisher.FluxRetryWhen$RetryWhenMainSubscriber.onError(FluxRetryWhen.java:191) ~[reactor-core-3.4.0.jar:3.4.0]
	at reactor.core.publisher.MonoCreate$DefaultMonoSink.error(MonoCreate.java:189) ~[reactor-core-3.4.0.jar:3.4.0]
	at reactor.netty.http.client.HttpClientConnect$MonoHttpConnect$ClientTransportSubscriber.onError(HttpClientConnect.java:286) ~[reactor-netty-http-1.0.1.jar:1.0.1]
	at reactor.core.publisher.MonoCreate$DefaultMonoSink.error(MonoCreate.java:189) ~[reactor-core-3.4.0.jar:3.4.0]
	at reactor.netty.resources.DefaultPooledConnectionProvider$DisposableAcquire.onError(DefaultPooledConnectionProvider.java:165) ~[reactor-netty-core-1.0.1.jar:1.0.1]
	at reactor.netty.internal.shaded.reactor.pool.AbstractPool$Borrower.fail(AbstractPool.java:427) ~[reactor-netty-core-1.0.1.jar:1.0.1]
	at reactor.netty.internal.shaded.reactor.pool.SimpleDequePool.lambda$drainLoop$5(SimpleDequePool.java:310) ~[reactor-netty-core-1.0.1.jar:1.0.1]
	at reactor.core.publisher.FluxDoOnEach$DoOnEachSubscriber.onError(FluxDoOnEach.java:186) ~[reactor-core-3.4.0.jar:3.4.0]
	at reactor.core.publisher.MonoCreate$DefaultMonoSink.error(MonoCreate.java:189) ~[reactor-core-3.4.0.jar:3.4.0]
	at reactor.netty.resources.DefaultPooledConnectionProvider$PooledConnectionAllocator$PooledConnectionInitializer.onError(DefaultPooledConnectionProvider.java:564) ~[reactor-netty-core-1.0.1.jar:1.0.1]
	at reactor.core.publisher.MonoFlatMap$FlatMapMain.secondError(MonoFlatMap.java:192) ~[reactor-core-3.4.0.jar:3.4.0]
	at reactor.core.publisher.MonoFlatMap$FlatMapInner.onError(MonoFlatMap.java:259) ~[reactor-core-3.4.0.jar:3.4.0]
	at reactor.netty.transport.TransportConnector$MonoChannelPromise.tryFailure(TransportConnector.java:464) ~[reactor-netty-core-1.0.1.jar:1.0.1]
	at reactor.netty.transport.TransportConnector$MonoChannelPromise$1.tryFailure(TransportConnector.java:515) ~[reactor-netty-core-1.0.1.jar:1.0.1]
	at io.netty.channel.epoll.AbstractEpollChannel$AbstractEpollUnsafe.fulfillConnectPromise(AbstractEpollChannel.java:637) ~[netty-transport-native-epoll-4.1.54.Final-linux-x86_64.jar:4.1.54.Final]
	at io.netty.channel.epoll.AbstractEpollChannel$AbstractEpollUnsafe.finishConnect(AbstractEpollChannel.java:656) ~[netty-transport-native-epoll-4.1.54.Final-linux-x86_64.jar:4.1.54.Final]
	at io.netty.channel.epoll.AbstractEpollChannel$AbstractEpollUnsafe.epollOutReady(AbstractEpollChannel.java:530) ~[netty-transport-native-epoll-4.1.54.Final-linux-x86_64.jar:4.1.54.Final]
	at io.netty.channel.epoll.EpollEventLoop.processReady(EpollEventLoop.java:470) ~[netty-transport-native-epoll-4.1.54.Final-linux-x86_64.jar:4.1.54.Final]
	at io.netty.channel.epoll.EpollEventLoop.run(EpollEventLoop.java:378) ~[netty-transport-native-epoll-4.1.54.Final-linux-x86_64.jar:4.1.54.Final]
	at io.netty.util.concurrent.SingleThreadEventExecutor$4.run(SingleThreadEventExecutor.java:989) ~[netty-common-4.1.54.Final.jar:4.1.54.Final]
	at io.netty.util.internal.ThreadExecutorMap$2.run(ThreadExecutorMap.java:74) ~[netty-common-4.1.54.Final.jar:4.1.54.Final]
	at io.netty.util.concurrent.FastThreadLocalRunnable.run(FastThreadLocalRunnable.java:30) ~[netty-common-4.1.54.Final.jar:4.1.54.Final]
	at java.base/java.lang.Thread.run(Thread.java:834) ~[na:na]
  ```