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
      ./mvnw clean spring-boot:run --projects producer-api
      ```

  - **consumer-api**

    - Open another terminal and make sure your are in `graalvm-quarkus-micronaut-springboot/producer-consumer/springboot-producer-consumer` folder

    - Run the command below to start the application
      ```
      ./mvnw clean spring-boot:run --projects consumer-api -Dspring-boot.run.jvmArguments="-Dserver.port=8081"
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
        ivanfranchin/springboot-producer-api-jvm:1.0.0
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

    - Run the following command to start the Docker container
      ```
      docker run --rm --name springboot-consumer-api-jvm \
        -p 9110:8080 -e KAFKA_HOST=kafka -e KAFKA_PORT=9092 \
        --network producer-consumer_default \
        ivanfranchin/springboot-consumer-api-jvm:1.0.0
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

    - Run the following command to start the Docker container
      ```
      docker run --rm --name springboot-producer-api-native \
        -p 9105:8080 -e SPRING_PROFILES_ACTIVE=native -e KAFKA_HOST=kafka -e KAFKA_PORT=9092 \
        --network producer-consumer_default \
        ivanfranchin/springboot-producer-api-native:1.0.0
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

    - Run the following command to start the Docker container
      ```
      docker run --rm --name springboot-consumer-api-native \
        -p 9111:8080 -e SPRING_PROFILES_ACTIVE=native -e KAFKA_HOST=kafka -e KAFKA_PORT=9092 \
        --network producer-consumer_default \
        ivanfranchin/springboot-consumer-api-native:1.0.0
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

When running the Docker native container of `producer-api` and submitting an invalid request according to `javax.validation.constraints`, like
```
curl -i -X POST localhost:9105/api/news -H 'Content-Type: application/json' \
  -d '{ "source2":"Spring Boot Blog", "title":"Spring Boot Framework & GraalVM" }'
```
the response is
```
HTTP/1.1 500 Internal Server Error
```
and following exception is logged
```
ERROR 1 --- [ctor-http-nio-3] o.s.w.s.adapter.HttpWebHandlerAdapter    : [657a7f7a-2] 500 Server Error for HTTP POST "/api/news"

org.springframework.core.codec.CodecException: Type definition error: [simple type, class org.springframework.validation.beanvalidation.SpringValidatorAdapter$ViolationFieldError]; nested exception is com.fasterxml.jackson.databind.exc.InvalidDefinitionException: No serializer found for class org.springframework.validation.beanvalidation.SpringValidatorAdapter$ViolationFieldError and no properties discovered to create BeanSerializer (to avoid exception, disable SerializationFeature.FAIL_ON_EMPTY_BEANS) (through reference chain: java.util.LinkedHashMap["errors"]->java.util.Collections$UnmodifiableRandomAccessList[0])
	at org.springframework.http.codec.json.AbstractJackson2Encoder.encodeValue(AbstractJackson2Encoder.java:226) ~[na:na]
	at org.springframework.http.codec.json.AbstractJackson2Encoder.lambda$encode$0(AbstractJackson2Encoder.java:150) ~[na:na]
	at reactor.core.publisher.FluxMapFuseable$MapFuseableSubscriber.onNext(FluxMapFuseable.java:113) ~[na:na]
	at reactor.core.publisher.Operators$ScalarSubscription.request(Operators.java:2398) ~[com.mycompany.producerapi.ProducerApiApplication:3.4.10]
	at reactor.core.publisher.FluxMapFuseable$MapFuseableSubscriber.request(FluxMapFuseable.java:169) ~[na:na]
	at reactor.core.publisher.MonoSingle$SingleSubscriber.doOnRequest(MonoSingle.java:103) ~[na:na]
	at reactor.core.publisher.Operators$MonoInnerProducerBase.request(Operators.java:2731) ~[com.mycompany.producerapi.ProducerApiApplication:3.4.10]
	at reactor.core.publisher.Operators$MultiSubscriptionSubscriber.set(Operators.java:2194) ~[com.mycompany.producerapi.ProducerApiApplication:3.4.10]
	at reactor.core.publisher.Operators$MultiSubscriptionSubscriber.onSubscribe(Operators.java:2068) ~[com.mycompany.producerapi.ProducerApiApplication:3.4.10]
	at reactor.core.publisher.MonoSingle$SingleSubscriber.onSubscribe(MonoSingle.java:115) ~[na:na]
	at reactor.core.publisher.FluxMapFuseable$MapFuseableSubscriber.onSubscribe(FluxMapFuseable.java:96) ~[na:na]
	at reactor.core.publisher.MonoJust.subscribe(MonoJust.java:55) ~[na:na]
	at reactor.core.publisher.InternalMonoOperator.subscribe(InternalMonoOperator.java:64) ~[na:na]
	at reactor.core.publisher.MonoFlatMap$FlatMapMain.onNext(MonoFlatMap.java:157) ~[com.mycompany.producerapi.ProducerApiApplication:3.4.10]
	at reactor.core.publisher.FluxPeekFuseable$PeekFuseableSubscriber.onNext(FluxPeekFuseable.java:210) ~[na:na]
	at reactor.core.publisher.Operators$MonoSubscriber.complete(Operators.java:1816) ~[com.mycompany.producerapi.ProducerApiApplication:3.4.10]
	at reactor.core.publisher.MonoFlatMap$FlatMapMain.onNext(MonoFlatMap.java:151) ~[com.mycompany.producerapi.ProducerApiApplication:3.4.10]
	at reactor.core.publisher.FluxSwitchIfEmpty$SwitchIfEmptySubscriber.onNext(FluxSwitchIfEmpty.java:74) ~[na:na]
	at reactor.core.publisher.MonoNext$NextSubscriber.onNext(MonoNext.java:82) ~[com.mycompany.producerapi.ProducerApiApplication:3.4.10]
	at reactor.core.publisher.FluxConcatArray$ConcatArraySubscriber.onNext(FluxConcatArray.java:201) ~[com.mycompany.producerapi.ProducerApiApplication:3.4.10]
	at reactor.core.publisher.Operators$ScalarSubscription.request(Operators.java:2398) ~[com.mycompany.producerapi.ProducerApiApplication:3.4.10]
	at reactor.core.publisher.FluxConcatArray$ConcatArraySubscriber.onSubscribe(FluxConcatArray.java:193) ~[com.mycompany.producerapi.ProducerApiApplication:3.4.10]
	at reactor.core.publisher.MonoJust.subscribe(MonoJust.java:55) ~[na:na]
	at reactor.core.publisher.MonoDefer.subscribe(MonoDefer.java:52) ~[na:na]
	at reactor.core.publisher.Mono.subscribe(Mono.java:4361) ~[na:na]
	at reactor.core.publisher.FluxConcatArray$ConcatArraySubscriber.onComplete(FluxConcatArray.java:255) ~[com.mycompany.producerapi.ProducerApiApplication:3.4.10]
	at reactor.core.publisher.FluxConcatArray.subscribe(FluxConcatArray.java:78) ~[na:na]
	at reactor.core.publisher.Mono.subscribe(Mono.java:4361) ~[na:na]
	at reactor.core.publisher.FluxOnErrorResume$ResumeSubscriber.onError(FluxOnErrorResume.java:103) ~[na:na]
	at reactor.core.publisher.FluxOnErrorResume$ResumeSubscriber.onError(FluxOnErrorResume.java:106) ~[na:na]
	at reactor.core.publisher.FluxOnAssembly$OnAssemblySubscriber.onError(FluxOnAssembly.java:393) ~[na:na]
	at reactor.core.publisher.Operators.error(Operators.java:198) ~[na:na]
	at reactor.core.publisher.MonoError.subscribe(MonoError.java:53) ~[na:na]
	at reactor.core.publisher.Mono.subscribe(Mono.java:4361) ~[na:na]
	at reactor.core.publisher.FluxOnErrorResume$ResumeSubscriber.onError(FluxOnErrorResume.java:103) ~[na:na]
	at reactor.core.publisher.FluxOnAssembly$OnAssemblySubscriber.onError(FluxOnAssembly.java:393) ~[na:na]
	at reactor.core.publisher.FluxPeek$PeekSubscriber.onError(FluxPeek.java:222) ~[na:na]
	at reactor.core.publisher.FluxDoOnEach$DoOnEachSubscriber.onError(FluxDoOnEach.java:195) ~[na:na]
	at reactor.core.publisher.MonoFlatMap$FlatMapMain.onError(MonoFlatMap.java:172) ~[com.mycompany.producerapi.ProducerApiApplication:3.4.10]
	at reactor.core.publisher.MonoFlatMap$FlatMapMain.secondError(MonoFlatMap.java:192) ~[com.mycompany.producerapi.ProducerApiApplication:3.4.10]
	at reactor.core.publisher.MonoFlatMap$FlatMapInner.onError(MonoFlatMap.java:259) ~[com.mycompany.producerapi.ProducerApiApplication:3.4.10]
	at reactor.core.publisher.FluxOnErrorResume$ResumeSubscriber.onError(FluxOnErrorResume.java:106) ~[na:na]
	at reactor.core.publisher.Operators.error(Operators.java:198) ~[na:na]
	at reactor.core.publisher.MonoError.subscribe(MonoError.java:53) ~[na:na]
	at reactor.core.publisher.Mono.subscribe(Mono.java:4361) ~[na:na]
	at reactor.core.publisher.FluxOnErrorResume$ResumeSubscriber.onError(FluxOnErrorResume.java:103) ~[na:na]
	at reactor.core.publisher.FluxPeek$PeekSubscriber.onError(FluxPeek.java:222) ~[na:na]
	at reactor.core.publisher.FluxPeek$PeekSubscriber.onError(FluxPeek.java:222) ~[na:na]
	at reactor.core.publisher.MonoIgnoreThen$ThenIgnoreMain.onError(MonoIgnoreThen.java:270) ~[com.mycompany.producerapi.ProducerApiApplication:3.4.10]
	at reactor.core.publisher.MonoFlatMap$FlatMapMain.onError(MonoFlatMap.java:172) ~[com.mycompany.producerapi.ProducerApiApplication:3.4.10]
	at reactor.core.publisher.MonoZip$ZipInner.onError(MonoZip.java:350) ~[com.mycompany.producerapi.ProducerApiApplication:3.4.10]
	at reactor.core.publisher.MonoPeekTerminal$MonoTerminalPeekSubscriber.onError(MonoPeekTerminal.java:258) ~[na:na]
	at reactor.core.publisher.Operators$MonoSubscriber.onError(Operators.java:1863) ~[com.mycompany.producerapi.ProducerApiApplication:3.4.10]
	at reactor.core.publisher.FluxPeek$PeekSubscriber.onError(FluxPeek.java:222) ~[na:na]
	at reactor.core.publisher.FluxPeek$PeekSubscriber.onNext(FluxPeek.java:194) ~[na:na]
	at reactor.core.publisher.FluxSwitchIfEmpty$SwitchIfEmptySubscriber.onNext(FluxSwitchIfEmpty.java:74) ~[na:na]
	at reactor.core.publisher.FluxOnErrorResume$ResumeSubscriber.onNext(FluxOnErrorResume.java:79) ~[na:na]
	at reactor.core.publisher.Operators$MonoSubscriber.complete(Operators.java:1816) ~[com.mycompany.producerapi.ProducerApiApplication:3.4.10]
	at reactor.core.publisher.MonoFlatMap$FlatMapMain.onNext(MonoFlatMap.java:151) ~[com.mycompany.producerapi.ProducerApiApplication:3.4.10]
	at reactor.core.publisher.FluxContextWrite$ContextWriteSubscriber.onNext(FluxContextWrite.java:107) ~[na:na]
	at reactor.core.publisher.FluxMapFuseable$MapFuseableConditionalSubscriber.onNext(FluxMapFuseable.java:295) ~[na:na]
	at reactor.core.publisher.FluxFilterFuseable$FilterFuseableConditionalSubscriber.onNext(FluxFilterFuseable.java:337) ~[na:na]
	at reactor.core.publisher.Operators$MonoSubscriber.complete(Operators.java:1816) ~[com.mycompany.producerapi.ProducerApiApplication:3.4.10]
	at reactor.core.publisher.MonoCollect$CollectSubscriber.onComplete(MonoCollect.java:159) ~[na:na]
	at reactor.core.publisher.FluxMap$MapSubscriber.onComplete(FluxMap.java:142) ~[na:na]
	at reactor.core.publisher.FluxPeek$PeekSubscriber.onComplete(FluxPeek.java:260) ~[na:na]
	at reactor.core.publisher.FluxMap$MapSubscriber.onComplete(FluxMap.java:142) ~[na:na]
	at reactor.netty.channel.FluxReceive.onInboundComplete(FluxReceive.java:400) ~[com.mycompany.producerapi.ProducerApiApplication:1.0.11]
	at reactor.netty.channel.ChannelOperations.onInboundComplete(ChannelOperations.java:419) ~[com.mycompany.producerapi.ProducerApiApplication:1.0.11]
	at reactor.netty.http.server.HttpServerOperations.onInboundNext(HttpServerOperations.java:575) ~[na:na]
	at reactor.netty.channel.ChannelOperationsHandler.channelRead(ChannelOperationsHandler.java:93) ~[na:na]
	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:379) ~[na:na]
	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:365) ~[na:na]
	at io.netty.channel.AbstractChannelHandlerContext.fireChannelRead(AbstractChannelHandlerContext.java:357) ~[na:na]
	at reactor.netty.http.server.HttpTrafficHandler.channelRead(HttpTrafficHandler.java:261) ~[na:na]
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
	at io.netty.util.concurrent.SingleThreadEventExecutor$4.run(SingleThreadEventExecutor.java:986) ~[na:na]
	at io.netty.util.internal.ThreadExecutorMap$2.run(ThreadExecutorMap.java:74) ~[na:na]
	at io.netty.util.concurrent.FastThreadLocalRunnable.run(FastThreadLocalRunnable.java:30) ~[na:na]
	at java.lang.Thread.run(Thread.java:829) ~[na:na]
	at com.oracle.svm.core.thread.JavaThreads.threadStartRoutine(JavaThreads.java:567) ~[na:na]
	at com.oracle.svm.core.posix.thread.PosixJavaThreads.pthreadStartRoutine(PosixJavaThreads.java:192) ~[na:na]
Caused by: com.fasterxml.jackson.databind.exc.InvalidDefinitionException: No serializer found for class org.springframework.validation.beanvalidation.SpringValidatorAdapter$ViolationFieldError and no properties discovered to create BeanSerializer (to avoid exception, disable SerializationFeature.FAIL_ON_EMPTY_BEANS) (through reference chain: java.util.LinkedHashMap["errors"]->java.util.Collections$UnmodifiableRandomAccessList[0])
	at com.fasterxml.jackson.databind.SerializerProvider.reportBadDefinition(SerializerProvider.java:1276) ~[na:na]
	at com.fasterxml.jackson.databind.DatabindContext.reportBadDefinition(DatabindContext.java:400) ~[na:na]
	at com.fasterxml.jackson.databind.ser.impl.UnknownSerializer.failForEmpty(UnknownSerializer.java:71) ~[na:na]
	at com.fasterxml.jackson.databind.ser.impl.UnknownSerializer.serialize(UnknownSerializer.java:33) ~[na:na]
	at com.fasterxml.jackson.databind.ser.impl.IndexedListSerializer.serializeContents(IndexedListSerializer.java:119) ~[na:na]
	at com.fasterxml.jackson.databind.ser.impl.IndexedListSerializer.serialize(IndexedListSerializer.java:79) ~[na:na]
	at com.fasterxml.jackson.databind.ser.impl.IndexedListSerializer.serialize(IndexedListSerializer.java:18) ~[na:na]
	at com.fasterxml.jackson.databind.ser.std.MapSerializer.serializeFields(MapSerializer.java:808) ~[na:na]
	at com.fasterxml.jackson.databind.ser.std.MapSerializer.serializeWithoutTypeInfo(MapSerializer.java:764) ~[na:na]
	at com.fasterxml.jackson.databind.ser.std.MapSerializer.serialize(MapSerializer.java:720) ~[na:na]
	at com.fasterxml.jackson.databind.ser.std.MapSerializer.serialize(MapSerializer.java:35) ~[na:na]
	at com.fasterxml.jackson.databind.ser.DefaultSerializerProvider._serialize(DefaultSerializerProvider.java:480) ~[na:na]
	at com.fasterxml.jackson.databind.ser.DefaultSerializerProvider.serializeValue(DefaultSerializerProvider.java:400) ~[na:na]
	at com.fasterxml.jackson.databind.ObjectWriter$Prefetch.serialize(ObjectWriter.java:1510) ~[na:na]
	at com.fasterxml.jackson.databind.ObjectWriter.writeValue(ObjectWriter.java:1006) ~[na:na]
	at org.springframework.http.codec.json.AbstractJackson2Encoder.encodeValue(AbstractJackson2Encoder.java:222) ~[na:na]
	... 99 common frames omitted
```
The expected response (as it happens with Docker JVM) should be something like
```
HTTP/1.1 400 Bad Request
{
   "timestamp":"...",
   "path":"/api/news",
   "status":400,
   "error":"Bad Request",
   "message":"Validation failed for argument at index 0 in method: public java.lang.String com.mycompany.producerapi.rest.NewsController.publishNews(com.mycompany.producerapi.rest.dto.CreateNewsRequest), with 1 error(s): [Field error in object 'createNewsRequest' on field 'source': rejected value [null]; codes [NotBlank.createNewsRequest.source,NotBlank.source,NotBlank.java.lang.String,NotBlank]; arguments [org.springframework.context.support.DefaultMessageSourceResolvable: codes [createNewsRequest.source,source]; arguments []; default message [source]]; default message [must not be blank]] ",
   "requestId":"d0a8f82f-1",
   "exception":"org.springframework.web.bind.support.WebExchangeBindException",
   "errors":[
      {
         "codes":[
            "NotBlank.createNewsRequest.source",
            "NotBlank.source",
            "NotBlank.java.lang.String",
            "NotBlank"
         ],
         "arguments":[
            {
               "codes":[
                  "createNewsRequest.source",
                  "source"
               ],
               "arguments":null,
               "defaultMessage":"source",
               "code":"source"
            }
         ],
         "defaultMessage":"must not be blank",
         "objectName":"createNewsRequest",
         "field":"source",
         "rejectedValue":null,
         "bindingFailure":false,
         "code":"NotBlank"
      }
   ]
}
```