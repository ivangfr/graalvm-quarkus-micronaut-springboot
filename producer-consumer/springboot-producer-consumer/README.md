# graalvm-quarkus-micronaut-springboot
## `> producer-consumer > springboot-producer-consumer`

The goal of this project is to implement two [`Spring Boot`](https://docs.spring.io/spring-boot/docs/current/reference/htmlsingle/) applications: one that _produces_ messages to a [`Kafka`](https://kafka.apache.org/) topic and another that _consumes_ those messages.

## Applications

- ### producer-api

  `Spring Boot` Web Java application that exposes one endpoint at which users can post `news`. Once a request is made, `producer-api` pushes a message about the `news` to `Kafka`.

  It has the following endpoint:
  ```
  POST /api/news {"source": "...", "title": "..."}
  ```

- ### consumer-api

  `Spring Boot` Web Java application that listens to messages (published by the `producer-api`) and logs it.

## Running applications

> **Note:** `Kafka`, `Zookeeper` and other containers present in `docker-compose.yml` file must be up and running as explained [here](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/producer-consumer#start-environment)

### Development Mode

- **Startup**

  - **producer-api**

    - Open a terminal and navigate to `graalvm-quarkus-micronaut-springboot/producer-consumer/springboot-producer-consumer` folder

    - Run the command below to start the application
      ```
      ./mvnw clean package spring-boot:run --projects producer-api
      ```

  - **consumer-api**

    - Open another terminal and make sure your are in `graalvm-quarkus-micronaut-springboot/producer-consumer/springboot-producer-consumer` folder

    - Run the command below to start the application (See [Issues](#springboot-consumer-api-issues))
      ```
      ./mvnw clean package spring-boot:run --projects consumer-api -Dspring-boot.run.jvmArguments="-Dserver.port=8081"
      ```

- **Simple Test**

  - In a new terminal, post a news
    ```
    curl -i -X POST localhost:8080/api/news -H 'Content-Type: application/json' \
      -d '{ "source":"Spring Boot Blog", "title":"Dev Spring Boot Framework" }'
    ```

  - See `producer-api` and `consumer-api` logs

- **Shutdown**

  Press `Ctrl+C` in `producer-api` and `consumer-api` terminals

### Docker in JVM Mode

- **Startup**

  - **producer-api**

    - In a terminal, make sure you are inside `graalvm-quarkus-micronaut-springboot/producer-consumer/springboot-producer-consumer` folder

    - Clean the application
      ```
      ./mvnw clean --projects producer-api
      ```

    - Run the command below to build the Docker image
      ```
      cd producer-api && ./docker-build.sh && cd ..
      ```

    - Run the following command to start the Docker container
      ```
      docker run --rm --name springboot-producer-api-jvm \
        -p 9104:8080 -e KAFKA_HOST=kafka -e KAFKA_PORT=9092 \
        --network producer-consumer_default \
        docker.mycompany.com/springboot-producer-api-jvm:1.0.0
      ```

  - **consumer-api**

    - In another terminal, make sure you are inside `graalvm-quarkus-micronaut-springboot/producer-consumer/springboot-producer-consumer` folder

    - Clean the application
      ```
      ./mvnw clean --projects consumer-api
      ```

    - Run the command below to build the Docker image
      ```
      cd consumer-api && ./docker-build.sh && cd ..
      ```

    - Run the following command to start the Docker container (See [Issues](#springboot-consumer-api-issues))
      ```
      docker run --rm --name springboot-consumer-api-jvm \
        -p 9110:8080 -e KAFKA_HOST=kafka -e KAFKA_PORT=9092 \
        --network producer-consumer_default \
        docker.mycompany.com/springboot-consumer-api-jvm:1.0.0
      ```

- **Simple Test**

  - In a new terminal, post a news
    ```
    curl -i -X POST localhost:9104/api/news -H 'Content-Type: application/json' \
      -d '{ "source":"Spring Boot Blog", "title":"Spring Boot Framework" }'
    ```

  - See `producer-api` and `consumer-api` logs

- **Shutdown**

  Press `Ctrl+C` in `producer-api` and `consumer-api` terminals

### Docker in Native Mode

- **Startup**

  - **producer-api**

    - In a terminal, make sure you are inside `graalvm-quarkus-micronaut-springboot/producer-consumer/springboot-producer-consumer` folder

    - Clean the application
      ```
      ./mvnw clean --projects producer-api
      ```

    - Run the command below to build the Docker image
      ```
      cd producer-api && ./docker-build.sh native && cd ..
      ```

    - Run the following command to start the Docker container (See [Issues](#springboot-producer-api-issues))
      ```
      docker run --rm --name springboot-producer-api-native \
        -p 9105:8080 -e SPRING_PROFILES_ACTIVE=native -e KAFKA_HOST=kafka -e KAFKA_PORT=9092 \
        --network producer-consumer_default \
        docker.mycompany.com/springboot-producer-api-native:1.0.0
      ```

  - **consumer-api**

    - In another terminal, make sure you are inside `graalvm-quarkus-micronaut-springboot/producer-consumer/springboot-producer-consumer` folder

    - Clean the application
      ```
      ./mvnw clean --projects consumer-api
      ```

    - Run the command below to build the Docker image
      ```
      cd consumer-api && ./docker-build.sh native && cd ..
      ```

    - Run the following command to start the Docker container (See [Issues](#springboot-consumer-api-issues))
      ```
      docker run --rm --name springboot-consumer-api-native \
        -p 9111:8080 -e SPRING_PROFILES_ACTIVE=native -e KAFKA_HOST=kafka -e KAFKA_PORT=9092 \
        --network producer-consumer_default \
        docker.mycompany.com/springboot-consumer-api-native:1.0.0
      ```

- **Simple Test**

  - In a new terminal, post a news
    ```
    curl -i -X POST localhost:9105/api/news -H 'Content-Type: application/json' \
      -d '{ "source":"Spring Boot Blog", "title":"Spring Boot Framework & GraalVM" }'
    ```

  - See `producer-api` and `consumer-api` logs

- **Shutdown**

  Press `Ctrl+C` in `producer-api` and `consumer-api` terminals

## Issues

### springboot-producer-api issues

- When **Docker in Native Mode**, it starts up fine. However, when a JSON message is published, an exception is thrown. I've created this [issue #659](https://github.com/spring-projects-experimental/spring-native/issues/659)
  ```
    .   ____          _            __ _ _
   /\\ / ___'_ __ _ _(_)_ __  __ _ \ \ \ \
  ( ( )\___ | '_ | '_| | '_ \/ _` | \ \ \ \
   \\/  ___)| |_)| | | | | || (_| |  ) ) ) )
    '  |____| .__|_| |_|_| |_\__, | / / / /
   =========|_|==============|___/=/_/_/_/
   :: Spring Boot ::                (v2.4.4)
  
  INFO 1 --- [           main] c.m.producerapi.ProducerApiApplication   : Starting ProducerApiApplication using Java 11.0.10 on 9309ce3432c8 with PID 1 (/  workspace/com.mycompany.producerapi.ProducerApiApplication started by cnb in /workspace)
  INFO 1 --- [           main] c.m.producerapi.ProducerApiApplication   : The following profiles are active: native
  
	...
  
	INFO 1 --- [           main] o.s.b.web.embedded.netty.NettyWebServer  : Netty started on port 8080
  INFO 1 --- [           main] c.m.producerapi.ProducerApiApplication   : Started ProducerApiApplication in 0.321 seconds (JVM running for 0.334)
  INFO 1 --- [ctor-http-nio-2] c.m.producerapi.kafka.NewsProducer       : Sending News 'News(id=22d6006f-7c28-4994-b663-03f5c743125e, source=Spring Boot Blog,   title=Spring Boot Framework & GraalVM)' to topic 'springboot.news.native.json'
  
	...
  
	ERROR 1 --- [ctor-http-nio-2] a.w.r.e.AbstractErrorWebExceptionHandler : [ae6274ce-1]  500 Server Error for HTTP POST "/api/news"
  
  org.apache.kafka.common.KafkaException: Failed to construct kafka producer
  	at org.apache.kafka.clients.producer.KafkaProducer.<init>(KafkaProducer.java:441) ~[na:na]
  	Suppressed: reactor.core.publisher.FluxOnAssembly$OnAssemblyException:
  Error has been observed at the following site(s):
  	|_ checkpoint ? org.springframework.boot.actuate.metrics.web.reactive.server.MetricsWebFilter [DefaultWebFilterChain]
  	|_ checkpoint ? HTTP POST "/api/news" [ExceptionHandlingWebHandler]
  Stack trace:
  		at org.apache.kafka.clients.producer.KafkaProducer.<init>(KafkaProducer.java:441) ~[na:na]
  		at org.apache.kafka.clients.producer.KafkaProducer.<init>(KafkaProducer.java:290) ~[na:na]
  		at org.springframework.kafka.core.DefaultKafkaProducerFactory.createRawProducer(DefaultKafkaProducerFactory.java:743) ~[com.mycompany.producerapi.  ProducerApiApplication:2.6.7]
  		at org.springframework.kafka.core.DefaultKafkaProducerFactory.createKafkaProducer(DefaultKafkaProducerFactory.java:584) ~[com.mycompany.producerapi.  ProducerApiApplication:2.6.7]
  		at org.springframework.kafka.core.DefaultKafkaProducerFactory.doCreateProducer(DefaultKafkaProducerFactory.java:544) ~[com.mycompany.producerapi.  ProducerApiApplication:2.6.7]
  		at org.springframework.kafka.core.DefaultKafkaProducerFactory.createProducer(DefaultKafkaProducerFactory.java:519) ~[com.mycompany.producerapi.  ProducerApiApplication:2.6.7]
  		at org.springframework.kafka.core.DefaultKafkaProducerFactory.createProducer(DefaultKafkaProducerFactory.java:513) ~[com.mycompany.producerapi.  ProducerApiApplication:2.6.7]
  		at org.springframework.kafka.core.KafkaTemplate.getTheProducer(KafkaTemplate.java:666) ~[com.mycompany.producerapi.ProducerApiApplication:2.6.7]
  		at org.springframework.kafka.core.KafkaTemplate.doSend(KafkaTemplate.java:552) ~[com.mycompany.producerapi.ProducerApiApplication:2.6.7]
  		at org.springframework.kafka.core.KafkaTemplate.send(KafkaTemplate.java:369) ~[com.mycompany.producerapi.ProducerApiApplication:2.6.7]
  		at com.mycompany.producerapi.kafka.NewsProducer.send(NewsProducer.java:24) ~[com.mycompany.producerapi.ProducerApiApplication:na]
  		at com.mycompany.producerapi.rest.NewsController.publishNews(NewsController.java:29) ~[com.mycompany.producerapi.ProducerApiApplication:na]
  		at java.lang.reflect.Method.invoke(Method.java:566) ~[na:na]
  		at org.springframework.web.reactive.result.method.InvocableHandlerMethod.lambda$invoke$0(InvocableHandlerMethod.java:146) ~[na:na]
  		at reactor.core.publisher.MonoFlatMap$FlatMapMain.onNext(MonoFlatMap.java:125) ~[com.mycompany.producerapi.ProducerApiApplication:3.4.4]
  		at reactor.core.publisher.Operators$MonoSubscriber.complete(Operators.java:1815) ~[com.mycompany.producerapi.ProducerApiApplication:3.4.4]
  		at reactor.core.publisher.MonoZip$ZipCoordinator.signal(MonoZip.java:251) ~[com.mycompany.producerapi.ProducerApiApplication:3.4.4]
  		at reactor.core.publisher.MonoZip$ZipInner.onNext(MonoZip.java:336) ~[com.mycompany.producerapi.ProducerApiApplication:3.4.4]
  		at reactor.core.publisher.MonoPeekTerminal$MonoTerminalPeekSubscriber.onNext(MonoPeekTerminal.java:180) ~[na:na]
  		at reactor.core.publisher.FluxDefaultIfEmpty$DefaultIfEmptySubscriber.onNext(FluxDefaultIfEmpty.java:100) ~[na:na]
  		at reactor.core.publisher.FluxSwitchIfEmpty$SwitchIfEmptySubscriber.onNext(FluxSwitchIfEmpty.java:73) ~[na:na]
  		at reactor.core.publisher.FluxOnErrorResume$ResumeSubscriber.onNext(FluxOnErrorResume.java:79) ~[na:na]
  		at reactor.core.publisher.Operators$MonoSubscriber.complete(Operators.java:1815) ~[com.mycompany.producerapi.ProducerApiApplication:3.4.4]
  		at reactor.core.publisher.MonoFlatMap$FlatMapMain.onNext(MonoFlatMap.java:151) ~[com.mycompany.producerapi.ProducerApiApplication:3.4.4]
  		at reactor.core.publisher.FluxContextWrite$ContextWriteSubscriber.onNext(FluxContextWrite.java:107) ~[na:na]
  		at reactor.core.publisher.FluxMapFuseable$MapFuseableConditionalSubscriber.onNext(FluxMapFuseable.java:295) ~[na:na]
  		at reactor.core.publisher.FluxFilterFuseable$FilterFuseableConditionalSubscriber.onNext(FluxFilterFuseable.java:337) ~[na:na]
  		at reactor.core.publisher.Operators$MonoSubscriber.complete(Operators.java:1815) ~[com.mycompany.producerapi.ProducerApiApplication:3.4.4]
  		at reactor.core.publisher.MonoCollect$CollectSubscriber.onComplete(MonoCollect.java:159) ~[na:na]
  		at reactor.core.publisher.FluxMap$MapSubscriber.onComplete(FluxMap.java:142) ~[na:na]
  		at reactor.core.publisher.FluxPeek$PeekSubscriber.onComplete(FluxPeek.java:259) ~[na:na]
  		at reactor.core.publisher.FluxMap$MapSubscriber.onComplete(FluxMap.java:142) ~[na:na]
  		at reactor.netty.channel.FluxReceive.onInboundComplete(FluxReceive.java:401) ~[com.mycompany.producerapi.ProducerApiApplication:1.0.5]
  		at reactor.netty.channel.ChannelOperations.onInboundComplete(ChannelOperations.java:416) ~[com.mycompany.producerapi.ProducerApiApplication:1.0.5]
  		at reactor.netty.http.server.HttpServerOperations.onInboundNext(HttpServerOperations.java:556) ~[na:na]
  		at reactor.netty.channel.ChannelOperationsHandler.channelRead(ChannelOperationsHandler.java:94) ~[na:na]
  		at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:379) ~[na:na]
  		at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:365) ~[na:na]
  		at io.netty.channel.AbstractChannelHandlerContext.fireChannelRead(AbstractChannelHandlerContext.java:357) ~[na:na]
  		at reactor.netty.http.server.HttpTrafficHandler.channelRead(HttpTrafficHandler.java:253) ~[na:na]
  		at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:379) ~[na:na]
  		at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:365) ~[na:na]
  		at io.netty.channel.AbstractChannelHandlerContext.fireChannelRead(AbstractChannelHandlerContext.java:357) ~[na:na]
  		at io.netty.channel.CombinedChannelDuplexHandler$DelegatingChannelHandlerContext.fireChannelRead(CombinedChannelDuplexHandler.java:436) ~[na:na]
  		at io.netty.handler.codec.ByteToMessageDecoder.fireChannelRead(ByteToMessageDecoder.java:324) ~[na:na]
  		at io.netty.handler.codec.ByteToMessageDecoder.channelRead(ByteToMessageDecoder.java:296) ~[na:na]
  		at io.netty.channel.CombinedChannelDuplexHandler.channelRead(CombinedChannelDuplexHandler.java:251) ~[na:na]
  		at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:379) ~[na:na]
  		at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:365) ~[na:na]
  		at io.netty.channel.AbstractChannelHandlerContext.fireChannelRead(AbstractChannelHandlerContext.java:357) ~[na:na]
  		at io.netty.channel.DefaultChannelPipeline$HeadContext.channelRead(DefaultChannelPipeline.java:1410) ~[na:na]
  		at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:379) ~[na:na]
  		at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:365) ~[na:na]
  		at io.netty.channel.DefaultChannelPipeline.fireChannelRead(DefaultChannelPipeline.java:919) ~[na:na]
  		at io.netty.channel.nio.AbstractNioByteChannel$NioByteUnsafe.read(AbstractNioByteChannel.java:166) ~[na:na]
  		at io.netty.channel.nio.NioEventLoop.processSelectedKey(NioEventLoop.java:719) ~[na:na]
  		at io.netty.channel.nio.NioEventLoop.processSelectedKeysOptimized(NioEventLoop.java:655) ~[na:na]
  		at io.netty.channel.nio.NioEventLoop.processSelectedKeys(NioEventLoop.java:581) ~[na:na]
  		at io.netty.channel.nio.NioEventLoop.run(NioEventLoop.java:493) ~[na:na]
  		at io.netty.util.concurrent.SingleThreadEventExecutor$4.run(SingleThreadEventExecutor.java:989) ~[na:na]
  		at io.netty.util.internal.ThreadExecutorMap$2.run(ThreadExecutorMap.java:74) ~[na:na]
  		at io.netty.util.concurrent.FastThreadLocalRunnable.run(FastThreadLocalRunnable.java:30) ~[na:na]
  		at java.lang.Thread.run(Thread.java:834) ~[na:na]
  		at com.oracle.svm.core.thread.JavaThreads.threadStartRoutine(JavaThreads.java:519) ~[na:na]
  		at com.oracle.svm.core.posix.thread.PosixJavaThreads.pthreadStartRoutine(PosixJavaThreads.java:192) ~[na:na]
  Caused by: org.apache.kafka.common.KafkaException: Could not find a public no-argument constructor for org.springframework.kafka.support.serializer.JsonSerializer
  	at org.apache.kafka.common.utils.Utils.newInstance(Utils.java:349) ~[na:na]
  	at org.apache.kafka.common.config.AbstractConfig.getConfiguredInstance(AbstractConfig.java:377) ~[na:na]
  	at org.apache.kafka.common.config.AbstractConfig.getConfiguredInstance(AbstractConfig.java:399) ~[na:na]
  	at org.apache.kafka.clients.producer.KafkaProducer.<init>(KafkaProducer.java:374) ~[na:na]
  	at org.apache.kafka.clients.producer.KafkaProducer.<init>(KafkaProducer.java:290) ~[na:na]
  	at org.springframework.kafka.core.DefaultKafkaProducerFactory.createRawProducer(DefaultKafkaProducerFactory.java:743) ~[com.mycompany.producerapi.  ProducerApiApplication:2.6.7]
  	at org.springframework.kafka.core.DefaultKafkaProducerFactory.createKafkaProducer(DefaultKafkaProducerFactory.java:584) ~[com.mycompany.producerapi.  ProducerApiApplication:2.6.7]
  	at org.springframework.kafka.core.DefaultKafkaProducerFactory.doCreateProducer(DefaultKafkaProducerFactory.java:544) ~[com.mycompany.producerapi.  ProducerApiApplication:2.6.7]
  	at org.springframework.kafka.core.DefaultKafkaProducerFactory.createProducer(DefaultKafkaProducerFactory.java:519) ~[com.mycompany.producerapi.  ProducerApiApplication:2.6.7]
  	at org.springframework.kafka.core.DefaultKafkaProducerFactory.createProducer(DefaultKafkaProducerFactory.java:513) ~[com.mycompany.producerapi.  ProducerApiApplication:2.6.7]
  	at org.springframework.kafka.core.KafkaTemplate.getTheProducer(KafkaTemplate.java:666) ~[com.mycompany.producerapi.ProducerApiApplication:2.6.7]
  	at org.springframework.kafka.core.KafkaTemplate.doSend(KafkaTemplate.java:552) ~[com.mycompany.producerapi.ProducerApiApplication:2.6.7]
  	at org.springframework.kafka.core.KafkaTemplate.send(KafkaTemplate.java:369) ~[com.mycompany.producerapi.ProducerApiApplication:2.6.7]
  	at com.mycompany.producerapi.kafka.NewsProducer.send(NewsProducer.java:24) ~[com.mycompany.producerapi.ProducerApiApplication:na]
  	at com.mycompany.producerapi.rest.NewsController.publishNews(NewsController.java:29) ~[com.mycompany.producerapi.ProducerApiApplication:na]
  	at java.lang.reflect.Method.invoke(Method.java:566) ~[na:na]
  	at org.springframework.web.reactive.result.method.InvocableHandlerMethod.lambda$invoke$0(InvocableHandlerMethod.java:146) ~[na:na]
  	at reactor.core.publisher.MonoFlatMap$FlatMapMain.onNext(MonoFlatMap.java:125) ~[com.mycompany.producerapi.ProducerApiApplication:3.4.4]
  	at reactor.core.publisher.Operators$MonoSubscriber.complete(Operators.java:1815) ~[com.mycompany.producerapi.ProducerApiApplication:3.4.4]
  	at reactor.core.publisher.MonoZip$ZipCoordinator.signal(MonoZip.java:251) ~[com.mycompany.producerapi.ProducerApiApplication:3.4.4]
  	at reactor.core.publisher.MonoZip$ZipInner.onNext(MonoZip.java:336) ~[com.mycompany.producerapi.ProducerApiApplication:3.4.4]
  	at reactor.core.publisher.MonoPeekTerminal$MonoTerminalPeekSubscriber.onNext(MonoPeekTerminal.java:180) ~[na:na]
  	at reactor.core.publisher.FluxDefaultIfEmpty$DefaultIfEmptySubscriber.onNext(FluxDefaultIfEmpty.java:100) ~[na:na]
  	at reactor.core.publisher.FluxSwitchIfEmpty$SwitchIfEmptySubscriber.onNext(FluxSwitchIfEmpty.java:73) ~[na:na]
  	at reactor.core.publisher.FluxOnErrorResume$ResumeSubscriber.onNext(FluxOnErrorResume.java:79) ~[na:na]
  	at reactor.core.publisher.Operators$MonoSubscriber.complete(Operators.java:1815) ~[com.mycompany.producerapi.ProducerApiApplication:3.4.4]
  	at reactor.core.publisher.MonoFlatMap$FlatMapMain.onNext(MonoFlatMap.java:151) ~[com.mycompany.producerapi.ProducerApiApplication:3.4.4]
  	at reactor.core.publisher.FluxContextWrite$ContextWriteSubscriber.onNext(FluxContextWrite.java:107) ~[na:na]
  	at reactor.core.publisher.FluxMapFuseable$MapFuseableConditionalSubscriber.onNext(FluxMapFuseable.java:295) ~[na:na]
  	at reactor.core.publisher.FluxFilterFuseable$FilterFuseableConditionalSubscriber.onNext(FluxFilterFuseable.java:337) ~[na:na]
  	at reactor.core.publisher.Operators$MonoSubscriber.complete(Operators.java:1815) ~[com.mycompany.producerapi.ProducerApiApplication:3.4.4]
  	at reactor.core.publisher.MonoCollect$CollectSubscriber.onComplete(MonoCollect.java:159) ~[na:na]
  	at reactor.core.publisher.FluxMap$MapSubscriber.onComplete(FluxMap.java:142) ~[na:na]
  	at reactor.core.publisher.FluxPeek$PeekSubscriber.onComplete(FluxPeek.java:259) ~[na:na]
  	at reactor.core.publisher.FluxMap$MapSubscriber.onComplete(FluxMap.java:142) ~[na:na]
  	at reactor.netty.channel.FluxReceive.onInboundComplete(FluxReceive.java:401) ~[com.mycompany.producerapi.ProducerApiApplication:1.0.5]
  	at reactor.netty.channel.ChannelOperations.onInboundComplete(ChannelOperations.java:416) ~[com.mycompany.producerapi.ProducerApiApplication:1.0.5]
  	at reactor.netty.http.server.HttpServerOperations.onInboundNext(HttpServerOperations.java:556) ~[na:na]
  	at reactor.netty.channel.ChannelOperationsHandler.channelRead(ChannelOperationsHandler.java:94) ~[na:na]
  	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:379) ~[na:na]
  	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:365) ~[na:na]
  	at io.netty.channel.AbstractChannelHandlerContext.fireChannelRead(AbstractChannelHandlerContext.java:357) ~[na:na]
  	at reactor.netty.http.server.HttpTrafficHandler.channelRead(HttpTrafficHandler.java:253) ~[na:na]
  	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:379) ~[na:na]
  	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:365) ~[na:na]
  	at io.netty.channel.AbstractChannelHandlerContext.fireChannelRead(AbstractChannelHandlerContext.java:357) ~[na:na]
  	at io.netty.channel.CombinedChannelDuplexHandler$DelegatingChannelHandlerContext.fireChannelRead(CombinedChannelDuplexHandler.java:436) ~[na:na]
  	at io.netty.handler.codec.ByteToMessageDecoder.fireChannelRead(ByteToMessageDecoder.java:324) ~[na:na]
  	at io.netty.handler.codec.ByteToMessageDecoder.channelRead(ByteToMessageDecoder.java:296) ~[na:na]
  	at io.netty.channel.CombinedChannelDuplexHandler.channelRead(CombinedChannelDuplexHandler.java:251) ~[na:na]
  	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:379) ~[na:na]
  	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:365) ~[na:na]
  	at io.netty.channel.AbstractChannelHandlerContext.fireChannelRead(AbstractChannelHandlerContext.java:357) ~[na:na]
  	at io.netty.channel.DefaultChannelPipeline$HeadContext.channelRead(DefaultChannelPipeline.java:1410) ~[na:na]
  	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:379) ~[na:na]
  	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:365) ~[na:na]
  	at io.netty.channel.DefaultChannelPipeline.fireChannelRead(DefaultChannelPipeline.java:919) ~[na:na]
  	at io.netty.channel.nio.AbstractNioByteChannel$NioByteUnsafe.read(AbstractNioByteChannel.java:166) ~[na:na]
  	at io.netty.channel.nio.NioEventLoop.processSelectedKey(NioEventLoop.java:719) ~[na:na]
  	at io.netty.channel.nio.NioEventLoop.processSelectedKeysOptimized(NioEventLoop.java:655) ~[na:na]
  	at io.netty.channel.nio.NioEventLoop.processSelectedKeys(NioEventLoop.java:581) ~[na:na]
  	at io.netty.channel.nio.NioEventLoop.run(NioEventLoop.java:493) ~[na:na]
  	at io.netty.util.concurrent.SingleThreadEventExecutor$4.run(SingleThreadEventExecutor.java:989) ~[na:na]
  	at io.netty.util.internal.ThreadExecutorMap$2.run(ThreadExecutorMap.java:74) ~[na:na]
  	at io.netty.util.concurrent.FastThreadLocalRunnable.run(FastThreadLocalRunnable.java:30) ~[na:na]
  	at java.lang.Thread.run(Thread.java:834) ~[na:na]
  	at com.oracle.svm.core.thread.JavaThreads.threadStartRoutine(JavaThreads.java:519) ~[na:na]
  	at com.oracle.svm.core.posix.thread.PosixJavaThreads.pthreadStartRoutine(PosixJavaThreads.java:192) ~[na:na]
  Caused by: java.lang.NoSuchMethodException: org.springframework.kafka.support.serializer.JsonSerializer.<init>()
  	at java.lang.Class.getConstructor0(DynamicHub.java:3349) ~[na:na]
  	at java.lang.Class.getDeclaredConstructor(DynamicHub.java:2553) ~[na:na]
  	at org.apache.kafka.common.utils.Utils.newInstance(Utils.java:347) ~[na:na]
  	... 67 common frames omitted
  ```

	I set `org.springframework.kafka.support.serializer.JsonSerializer` using `@TypeHint`. After building the native image, starting the container and posting a news, I get the following exception.
	
	Btw, if I do what the exception is suggesting _"to avoid exception,   disable SerializationFeature.FAIL_ON_EMPTY_BEANS"_, the payload of the message will be empty

	```
  ERROR 1 --- [ctor-http-nio-2] a.w.r.e.AbstractErrorWebExceptionHandler : [d2eb64eb-1]  500 Server Error for HTTP   POST "/api/news"
  
  org.apache.kafka.common.errors.SerializationException: Can't serialize data [News  (id=bb5f31b1-0450-44a6-a629-8c45887321bd, source=Spring Boot Blog, title=Spring Boot Framework & GraalVM)] for   topic [springboot.news.native.json]
  	Suppressed: reactor.core.publisher.FluxOnAssembly$OnAssemblyException:
  Error has been observed at the following site(s):
  	|_ checkpoint ? org.springframework.boot.actuate.metrics.web.reactive.server.MetricsWebFilter   [DefaultWebFilterChain]
  	|_ checkpoint ? HTTP POST "/api/news" [ExceptionHandlingWebHandler]
  Stack trace:
  Caused by: com.fasterxml.jackson.databind.exc.InvalidDefinitionException: No serializer found for class com.  mycompany.producerapi.domain.News and no properties discovered to create BeanSerializer (to avoid exception,   disable SerializationFeature.FAIL_ON_EMPTY_BEANS)
  	at com.fasterxml.jackson.databind.SerializerProvider.reportBadDefinition(SerializerProvider.java:1277) ~[na:na]
  	at com.fasterxml.jackson.databind.DatabindContext.reportBadDefinition(DatabindContext.java:400) ~[na:na]
  	at com.fasterxml.jackson.databind.ser.impl.UnknownSerializer.failForEmpty(UnknownSerializer.java:71) ~[na:na]
  	at com.fasterxml.jackson.databind.ser.impl.UnknownSerializer.serialize(UnknownSerializer.java:33) ~[na:na]
  	at com.fasterxml.jackson.databind.ser.DefaultSerializerProvider._serialize(DefaultSerializerProvider.java:480) ~  [na:na]
  	at com.fasterxml.jackson.databind.ser.DefaultSerializerProvider.serializeValue(DefaultSerializerProvider.  java:319) ~[na:na]
  	at com.fasterxml.jackson.databind.ObjectWriter$Prefetch.serialize(ObjectWriter.java:1516) ~[na:na]
  	at com.fasterxml.jackson.databind.ObjectWriter._writeValueAndClose(ObjectWriter.java:1217) ~[na:na]
  	at com.fasterxml.jackson.databind.ObjectWriter.writeValueAsBytes(ObjectWriter.java:1110) ~[na:na]
  	at org.springframework.kafka.support.serializer.JsonSerializer.serialize(JsonSerializer.java:195) ~[com.  mycompany.producerapi.ProducerApiApplication:2.6.7]
  	at org.springframework.kafka.support.serializer.JsonSerializer.serialize(JsonSerializer.java:185) ~[com.  mycompany.producerapi.ProducerApiApplication:2.6.7]
  	at org.apache.kafka.clients.producer.KafkaProducer.doSend(KafkaProducer.java:910) ~[na:na]
  	at org.apache.kafka.clients.producer.KafkaProducer.send(KafkaProducer.java:870) ~[na:na]
  	at org.springframework.kafka.core.DefaultKafkaProducerFactory$CloseSafeProducer.send(DefaultKafkaProducerFactory.  java:862) ~[na:na]
  	at org.springframework.kafka.core.KafkaTemplate.doSend(KafkaTemplate.java:563) ~[com.mycompany.producerapi.  ProducerApiApplication:2.6.7]
  	at org.springframework.kafka.core.KafkaTemplate.send(KafkaTemplate.java:369) ~[com.mycompany.producerapi.  ProducerApiApplication:2.6.7]
  	at com.mycompany.producerapi.kafka.NewsProducer.send(NewsProducer.java:24) ~[com.mycompany.producerapi.  ProducerApiApplication:na]
  	at com.mycompany.producerapi.rest.NewsController.publishNews(NewsController.java:29) ~[com.mycompany.producerapi.  ProducerApiApplication:na]
  	at java.lang.reflect.Method.invoke(Method.java:566) ~[na:na]
  	at org.springframework.web.reactive.result.method.InvocableHandlerMethod.lambda$invoke$0(InvocableHandlerMethod.  java:146) ~[na:na]
  	at reactor.core.publisher.MonoFlatMap$FlatMapMain.onNext(MonoFlatMap.java:125) ~[com.mycompany.producerapi.  ProducerApiApplication:3.4.4]
  	at reactor.core.publisher.Operators$MonoSubscriber.complete(Operators.java:1815) ~[com.mycompany.producerapi.  ProducerApiApplication:3.4.4]
  	at reactor.core.publisher.MonoZip$ZipCoordinator.signal(MonoZip.java:251) ~[com.mycompany.producerapi.  ProducerApiApplication:3.4.4]
  	at reactor.core.publisher.MonoZip$ZipInner.onNext(MonoZip.java:336) ~[com.mycompany.producerapi.  ProducerApiApplication:3.4.4]
  	at reactor.core.publisher.MonoPeekTerminal$MonoTerminalPeekSubscriber.onNext(MonoPeekTerminal.java:180) ~[na:na]
  	at reactor.core.publisher.FluxDefaultIfEmpty$DefaultIfEmptySubscriber.onNext(FluxDefaultIfEmpty.java:100) ~  [na:na]
  	at reactor.core.publisher.FluxSwitchIfEmpty$SwitchIfEmptySubscriber.onNext(FluxSwitchIfEmpty.java:73) ~[na:na]
  	at reactor.core.publisher.FluxOnErrorResume$ResumeSubscriber.onNext(FluxOnErrorResume.java:79) ~[na:na]
  	at reactor.core.publisher.Operators$MonoSubscriber.complete(Operators.java:1815) ~[com.mycompany.producerapi.  ProducerApiApplication:3.4.4]
  	at reactor.core.publisher.MonoFlatMap$FlatMapMain.onNext(MonoFlatMap.java:151) ~[com.mycompany.producerapi.  ProducerApiApplication:3.4.4]
  	at reactor.core.publisher.FluxContextWrite$ContextWriteSubscriber.onNext(FluxContextWrite.java:107) ~[na:na]
  	at reactor.core.publisher.FluxMapFuseable$MapFuseableConditionalSubscriber.onNext(FluxMapFuseable.java:295) ~  [na:na]
  	at reactor.core.publisher.FluxFilterFuseable$FilterFuseableConditionalSubscriber.onNext(FluxFilterFuseable.  java:337) ~[na:na]
  	at reactor.core.publisher.Operators$MonoSubscriber.complete(Operators.java:1815) ~[com.mycompany.producerapi.  ProducerApiApplication:3.4.4]
  	at reactor.core.publisher.MonoCollect$CollectSubscriber.onComplete(MonoCollect.java:159) ~[na:na]
  	at reactor.core.publisher.FluxMap$MapSubscriber.onComplete(FluxMap.java:142) ~[na:na]
  	at reactor.core.publisher.FluxPeek$PeekSubscriber.onComplete(FluxPeek.java:259) ~[na:na]
  	at reactor.core.publisher.FluxMap$MapSubscriber.onComplete(FluxMap.java:142) ~[na:na]
  	at reactor.netty.channel.FluxReceive.onInboundComplete(FluxReceive.java:401) ~[com.mycompany.producerapi.  ProducerApiApplication:1.0.5]
  	at reactor.netty.channel.ChannelOperations.onInboundComplete(ChannelOperations.java:416) ~[com.mycompany.  producerapi.ProducerApiApplication:1.0.5]
  	at reactor.netty.http.server.HttpServerOperations.onInboundNext(HttpServerOperations.java:556) ~[na:na]
  	at reactor.netty.channel.ChannelOperationsHandler.channelRead(ChannelOperationsHandler.java:94) ~[na:na]
  	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:379) ~  [na:na]
  	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:365) ~  [na:na]
  	at io.netty.channel.AbstractChannelHandlerContext.fireChannelRead(AbstractChannelHandlerContext.java:357) ~  [na:na]
  	at reactor.netty.http.server.HttpTrafficHandler.channelRead(HttpTrafficHandler.java:253) ~[na:na]
  	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:379) ~  [na:na]
  	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:365) ~  [na:na]
  	at io.netty.channel.AbstractChannelHandlerContext.fireChannelRead(AbstractChannelHandlerContext.java:357) ~  [na:na]
  	at io.netty.channel.CombinedChannelDuplexHandler$DelegatingChannelHandlerContext.fireChannelRead  (CombinedChannelDuplexHandler.java:436) ~[na:na]
  	at io.netty.handler.codec.ByteToMessageDecoder.fireChannelRead(ByteToMessageDecoder.java:324) ~[na:na]
  	at io.netty.handler.codec.ByteToMessageDecoder.channelRead(ByteToMessageDecoder.java:296) ~[na:na]
  	at io.netty.channel.CombinedChannelDuplexHandler.channelRead(CombinedChannelDuplexHandler.java:251) ~[na:na]
  	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:379) ~  [na:na]
  	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:365) ~  [na:na]
  	at io.netty.channel.AbstractChannelHandlerContext.fireChannelRead(AbstractChannelHandlerContext.java:357) ~  [na:na]
  	at io.netty.channel.DefaultChannelPipeline$HeadContext.channelRead(DefaultChannelPipeline.java:1410) ~[na:na]
  	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:379) ~  [na:na]
  	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:365) ~  [na:na]
  	at io.netty.channel.DefaultChannelPipeline.fireChannelRead(DefaultChannelPipeline.java:919) ~[na:na]
  	at io.netty.channel.nio.AbstractNioByteChannel$NioByteUnsafe.read(AbstractNioByteChannel.java:166) ~[na:na]
  	at io.netty.channel.nio.NioEventLoop.processSelectedKey(NioEventLoop.java:719) ~[na:na]
  	at io.netty.channel.nio.NioEventLoop.processSelectedKeysOptimized(NioEventLoop.java:655) ~[na:na]
  	at io.netty.channel.nio.NioEventLoop.processSelectedKeys(NioEventLoop.java:581) ~[na:na]
  	at io.netty.channel.nio.NioEventLoop.run(NioEventLoop.java:493) ~[na:na]
  	at io.netty.util.concurrent.SingleThreadEventExecutor$4.run(SingleThreadEventExecutor.java:989) ~[na:na]
  	at io.netty.util.internal.ThreadExecutorMap$2.run(ThreadExecutorMap.java:74) ~[na:na]
  	at io.netty.util.concurrent.FastThreadLocalRunnable.run(FastThreadLocalRunnable.java:30) ~[na:na]
  	at java.lang.Thread.run(Thread.java:834) ~[na:na]
  	at com.oracle.svm.core.thread.JavaThreads.threadStartRoutine(JavaThreads.java:519) ~[na:na]
  	at com.oracle.svm.core.posix.thread.PosixJavaThreads.pthreadStartRoutine(PosixJavaThreads.java:192) ~[na:na]
	```

### springboot-consumer-api issues

- Unable to run in **Development Mode**, **Docker in JVM Mode** and **Docker in Native Mode**. It is related to this [issue #605](https://github.com/spring-projects-experimental/spring-native/issues/605)
  ```
  ERROR 24820 --- [           main] o.s.boot.SpringApplication               : Application run failed
  
  org.springframework.beans.factory.BeanCreationException: Error creating bean with name 'newsConsumer' defined in   class path resource [com/mycompany/consumerapi/kafka/NewsConsumer.class]: Initialization of bean failed; nested   exception is java.lang.NullPointerException
  	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.doCreateBean  (AbstractAutowireCapableBeanFactory.java:610) ~[spring-beans-5.3.5.jar:5.3.5]
  	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.createBean  (AbstractAutowireCapableBeanFactory.java:524) ~[spring-beans-5.3.5.jar:5.3.5]
  	at org.springframework.beans.factory.support.AbstractBeanFactory.lambda$doGetBean$0(AbstractBeanFactory.java:335) ~  [spring-beans-5.3.5.jar:5.3.5]
  	at org.springframework.beans.factory.support.DefaultSingletonBeanRegistry.getSingleton(DefaultSingletonBeanRegistry.  java:234) ~[spring-beans-5.3.5.jar:5.3.5]
  	at org.springframework.beans.factory.support.AbstractBeanFactory.doGetBean(AbstractBeanFactory.java:333) ~  [spring-beans-5.3.5.jar:5.3.5]
  	at org.springframework.beans.factory.support.AbstractBeanFactory.getBean(AbstractBeanFactory.java:208) ~  [spring-beans-5.3.5.jar:5.3.5]
  	at org.springframework.beans.factory.support.DefaultListableBeanFactory.preInstantiateSingletons  (DefaultListableBeanFactory.java:944) ~[spring-beans-5.3.5.jar:5.3.5]
  	at org.springframework.context.support.AbstractApplicationContext.finishBeanFactoryInitialization  (AbstractApplicationContext.java:918) ~[spring-context-5.3.5.jar:5.3.5]
  	at org.springframework.context.support.AbstractApplicationContext.refresh(AbstractApplicationContext.java:583) ~  [spring-context-5.3.5.jar:5.3.5]
  	at org.springframework.boot.web.reactive.context.ReactiveWebServerApplicationContext.refresh  (ReactiveWebServerApplicationContext.java:63) ~[spring-boot-2.4.4.jar:2.4.4]
  	at org.springframework.boot.SpringApplication.refresh(SpringApplication.java:769) ~[spring-boot-2.4.4.jar:2.4.4]
  	at org.springframework.boot.SpringApplication.refresh(SpringApplication.java:761) ~[spring-boot-2.4.4.jar:2.4.4]
  	at org.springframework.boot.SpringApplication.refreshContext(SpringApplication.java:426) ~[spring-boot-2.4.4.jar:2.  4.4]
  	at org.springframework.boot.SpringApplication.run(SpringApplication.java:326) ~[spring-boot-2.4.4.jar:2.4.4]
  	at org.springframework.boot.SpringApplication.run(SpringApplication.java:1313) ~[spring-boot-2.4.4.jar:2.4.4]
  	at org.springframework.boot.SpringApplication.run(SpringApplication.java:1302) ~[spring-boot-2.4.4.jar:2.4.4]
  	at com.mycompany.consumerapi.ConsumerApiApplication.main(ConsumerApiApplication.java:10) ~[classes/:na]
  Caused by: java.lang.NullPointerException: null
  	at org.springframework.kafka.annotation.KafkaListenerAnnotationBeanPostProcessor.resolveExpression  (KafkaListenerAnnotationBeanPostProcessor.java:735) ~[spring-kafka-2.6.7.jar:2.6.7]
  	at org.springframework.kafka.annotation.KafkaListenerAnnotationBeanPostProcessor.resolveExpressionAsString  (KafkaListenerAnnotationBeanPostProcessor.java:689) ~[spring-kafka-2.6.7.jar:2.6.7]
  	at org.springframework.kafka.annotation.KafkaListenerAnnotationBeanPostProcessor.getEndpointGroupId  (KafkaListenerAnnotationBeanPostProcessor.java:507) ~[spring-kafka-2.6.7.jar:2.6.7]
  	at org.springframework.kafka.annotation.KafkaListenerAnnotationBeanPostProcessor.processListener  (KafkaListenerAnnotationBeanPostProcessor.java:429) ~[spring-kafka-2.6.7.jar:2.6.7]
  	at org.springframework.kafka.annotation.KafkaListenerAnnotationBeanPostProcessor.processKafkaListener  (KafkaListenerAnnotationBeanPostProcessor.java:382) ~[spring-kafka-2.6.7.jar:2.6.7]
  	at org.springframework.kafka.annotation.KafkaListenerAnnotationBeanPostProcessor.postProcessAfterInitialization  (KafkaListenerAnnotationBeanPostProcessor.java:310) ~[spring-kafka-2.6.7.jar:2.6.7]
  	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.  applyBeanPostProcessorsAfterInitialization(AbstractAutowireCapableBeanFactory.java:437) ~[spring-beans-5.3.5.jar:5.  3.5]
  	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.initializeBean  (AbstractAutowireCapableBeanFactory.java:1790) ~[spring-beans-5.3.5.jar:5.3.5]
  	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.doCreateBean  (AbstractAutowireCapableBeanFactory.java:602) ~[spring-beans-5.3.5.jar:5.3.5]
  	... 16 common frames omitted
	```
