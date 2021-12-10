# graalvm-quarkus-micronaut-springboot
## `> elasticsearch > springboot-elasticsearch`

## Application

- ### springboot-elasticsearch

  [`Spring Boot`](https://docs.spring.io/spring-boot/docs/current/reference/htmlsingle/) Java Web application that exposes a simple REST API for indexing and searching movies in `Elasticsearch`.
  
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
  
  curl -i "localhost:8080/api/movies?title=tonya"
  ```

- To stop the application, press `Ctrl+C` in its terminal

### Docker in JVM Mode

- In a terminal, make sure you are inside `graalvm-quarkus-micronaut-springboot/elasticsearch/springboot-elasticsearch` folder

- Clean the target folder
  ```
  ./mvnw clean
  ```

- Run the script below to build the Docker image
  ```
  ./docker-build.sh
  ```

- Run the following command to start the Docker container
  ```
  docker run --rm --name springboot-elasticsearch-jvm \
    -p 9116:8080 -e ELASTICSEARCH_HOST=elasticsearch \
    --network elasticsearch_default \
    ivanfranchin/springboot-elasticsearch-jvm:1.0.0
  ```

- A simple test can be done by opening a new terminal and running
  ```
  curl -i -X POST "localhost:9116/api/movies" -H "Content-type: application/json" \
    -d '{"imdb": "456", "title": "American Pie"}'
  
  curl -i "localhost:9116/api/movies?title=american"
  ```

- To stop and remove application Docker container, press `Ctrl+C` in its terminal

### Docker in Native Mode

- In a terminal, make sure you are inside `graalvm-quarkus-micronaut-springboot/elasticsearch/springboot-elasticsearch` folder

- Clean the target folder
  ```
  ./mvnw clean
  ```

- Run the script below to build the Docker image
  ```
  ./docker-build.sh native
  ```

- Run the following command to start the Docker container
  ```
  docker run --rm --name springboot-elasticsearch-native \
    -p 9117:8080 -e SPRING_PROFILES_ACTIVE=native -e ELASTICSEARCH_HOST=elasticsearch \
    --network elasticsearch_default \
    ivanfranchin/springboot-elasticsearch-native:1.0.0
  ```

- A simple test can be done by opening a new terminal and running
  ```
  curl -i -X POST "localhost:9117/api/movies" -H "Content-type: application/json" \
    -d '{"imdb": "789", "title": "Resident Evil"}'
  
  curl -i "localhost:9117/api/movies?title=evil"
  ```

- To stop and remove application Docker container, press `Ctrl+C` in its terminal

## Issues

- After building and running successfully the Docker native image, the following exception is throw when submitting a POST request
  ```
  ERROR 1 --- [ctor-http-nio-2] c.m.s.service.MovieServiceImpl           : An exception occurred while indexing 'Movie(imdb=789, title=Resident Evil)'. No serializer found for class com.mycompany.springbootelasticsearch.model.Movie and no properties discovered to create BeanSerializer (to avoid exception, disable SerializationFeature.FAIL_ON_EMPTY_BEANS)
  ERROR 1 --- [ctor-http-nio-2] a.w.r.e.AbstractErrorWebExceptionHandler : [382feaf4-1]  500 Server Error for HTTP POST "/api/movies"
  
  com.mycompany.springbootelasticsearch.exception.MovieServiceException: An exception occurred while indexing 'Movie(imdb=789, title=Resident Evil)'. No serializer found for class com.mycompany.springbootelasticsearch.model.Movie and no properties discovered to create BeanSerializer (to avoid exception, disable SerializationFeature.FAIL_ON_EMPTY_BEANS)
  	at com.mycompany.springbootelasticsearch.service.MovieServiceImpl.saveMovie(MovieServiceImpl.java:53) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:na]
  	Suppressed: reactor.core.publisher.FluxOnAssembly$OnAssemblyException:
  Error has been observed at the following site(s):
  	*__checkpoint ? org.springframework.boot.actuate.metrics.web.reactive.server.MetricsWebFilter [DefaultWebFilterChain]
  	*__checkpoint ? HTTP POST "/api/movies" [ExceptionHandlingWebHandler]
  Original Stack Trace:
  		at com.mycompany.springbootelasticsearch.service.MovieServiceImpl.saveMovie(MovieServiceImpl.java:53) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:na]
  		at com.mycompany.springbootelasticsearch.rest.MoviesController.createMovie(MoviesController.java:33) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:na]
  		at java.lang.reflect.Method.invoke(Method.java:566) ~[na:na]
  		at org.springframework.web.reactive.result.method.InvocableHandlerMethod.lambda$invoke$0(InvocableHandlerMethod.java:144) ~[na:na]
  		at reactor.core.publisher.MonoFlatMap$FlatMapMain.onNext(MonoFlatMap.java:125) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:3.4.12]
  		at reactor.core.publisher.Operators$MonoSubscriber.complete(Operators.java:1816) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:3.4.12]
  		at reactor.core.publisher.MonoZip$ZipCoordinator.signal(MonoZip.java:251) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:3.4.12]
  		at reactor.core.publisher.MonoZip$ZipInner.onNext(MonoZip.java:336) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:3.4.12]
  		at reactor.core.publisher.MonoPeekTerminal$MonoTerminalPeekSubscriber.onNext(MonoPeekTerminal.java:180) ~[na:na]
  		at reactor.core.publisher.FluxDefaultIfEmpty$DefaultIfEmptySubscriber.onNext(FluxDefaultIfEmpty.java:101) ~[na:na]
  		at reactor.core.publisher.FluxPeek$PeekSubscriber.onNext(FluxPeek.java:200) ~[na:na]
  		at reactor.core.publisher.FluxSwitchIfEmpty$SwitchIfEmptySubscriber.onNext(FluxSwitchIfEmpty.java:74) ~[na:na]
  		at reactor.core.publisher.FluxOnErrorResume$ResumeSubscriber.onNext(FluxOnErrorResume.java:79) ~[na:na]
  		at reactor.core.publisher.Operators$MonoSubscriber.complete(Operators.java:1816) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:3.4.12]
  		at reactor.core.publisher.MonoFlatMap$FlatMapMain.onNext(MonoFlatMap.java:151) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:3.4.12]
  		at reactor.core.publisher.FluxContextWrite$ContextWriteSubscriber.onNext(FluxContextWrite.java:107) ~[na:na]
  		at reactor.core.publisher.FluxMapFuseable$MapFuseableConditionalSubscriber.onNext(FluxMapFuseable.java:295) ~[na:na]
  		at reactor.core.publisher.FluxFilterFuseable$FilterFuseableConditionalSubscriber.onNext(FluxFilterFuseable.java:337) ~[na:na]
  		at reactor.core.publisher.Operators$MonoSubscriber.complete(Operators.java:1816) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:3.4.12]
  		at reactor.core.publisher.MonoCollect$CollectSubscriber.onComplete(MonoCollect.java:159) ~[na:na]
  		at reactor.core.publisher.FluxMap$MapSubscriber.onComplete(FluxMap.java:142) ~[na:na]
  		at reactor.core.publisher.FluxPeek$PeekSubscriber.onComplete(FluxPeek.java:260) ~[na:na]
  		at reactor.core.publisher.FluxMap$MapSubscriber.onComplete(FluxMap.java:142) ~[na:na]
  		at reactor.netty.channel.FluxReceive.onInboundComplete(FluxReceive.java:400) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:1.0.13]
  		at reactor.netty.channel.ChannelOperations.onInboundComplete(ChannelOperations.java:419) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:1.0.13]
  		at reactor.netty.http.server.HttpServerOperations.onInboundNext(HttpServerOperations.java:590) ~[na:na]
  		at reactor.netty.channel.ChannelOperationsHandler.channelRead(ChannelOperationsHandler.java:93) ~[na:na]
  		at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:379) ~[na:na]
  		at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:365) ~[na:na]
  		at io.netty.channel.AbstractChannelHandlerContext.fireChannelRead(AbstractChannelHandlerContext.java:357) ~[na:na]
  		at reactor.netty.http.server.HttpTrafficHandler.channelRead(HttpTrafficHandler.java:264) ~[na:na]
  		at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:379) ~[na:na]
  		at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:365) ~[na:na]
  		at io.netty.channel.AbstractChannelHandlerContext.fireChannelRead(AbstractChannelHandlerContext.java:357) ~[na:na]
  		at io.netty.channel.CombinedChannelDuplexHandler$DelegatingChannelHandlerContext.fireChannelRead(CombinedChannelDuplexHandler.java:436) ~[na:na]
  		at io.netty.handler.codec.ByteToMessageDecoder.fireChannelRead(ByteToMessageDecoder.java:324) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:4.1.70.Final]
  		at io.netty.handler.codec.ByteToMessageDecoder.channelRead(ByteToMessageDecoder.java:296) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:4.1.70.Final]
  		at io.netty.channel.CombinedChannelDuplexHandler.channelRead(CombinedChannelDuplexHandler.java:251) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:4.1.70.Final]
  		at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:379) ~[na:na]
  		at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:365) ~[na:na]
  		at io.netty.channel.AbstractChannelHandlerContext.fireChannelRead(AbstractChannelHandlerContext.java:357) ~[na:na]
  		at io.netty.channel.DefaultChannelPipeline$HeadContext.channelRead(DefaultChannelPipeline.java:1410) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:4.1.70.Final]
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
  		at com.oracle.svm.core.thread.JavaThreads.threadStartRoutine(JavaThreads.java:596) ~[na:na]
  		at com.oracle.svm.core.posix.thread.PosixJavaThreads.pthreadStartRoutine(PosixJavaThreads.java:192) ~[na:na]
  Caused by: com.fasterxml.jackson.databind.exc.InvalidDefinitionException: No serializer found for class com.mycompany.springbootelasticsearch.model.Movie and no properties discovered to create BeanSerializer (to avoid exception, disable SerializationFeature.FAIL_ON_EMPTY_BEANS)
  	at com.fasterxml.jackson.databind.SerializerProvider.reportBadDefinition(SerializerProvider.java:1300) ~[na:na]
  	at com.fasterxml.jackson.databind.DatabindContext.reportBadDefinition(DatabindContext.java:400) ~[na:na]
  	at com.fasterxml.jackson.databind.ser.impl.UnknownSerializer.failForEmpty(UnknownSerializer.java:46) ~[na:na]
  	at com.fasterxml.jackson.databind.ser.impl.UnknownSerializer.serialize(UnknownSerializer.java:29) ~[na:na]
  	at com.fasterxml.jackson.databind.ser.DefaultSerializerProvider._serialize(DefaultSerializerProvider.java:480) ~[na:na]
  	at com.fasterxml.jackson.databind.ser.DefaultSerializerProvider.serializeValue(DefaultSerializerProvider.java:319) ~[na:na]
  	at com.fasterxml.jackson.databind.ObjectMapper._writeValueAndClose(ObjectMapper.java:4569) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:2.13.0]
  	at com.fasterxml.jackson.databind.ObjectMapper.writeValueAsString(ObjectMapper.java:3822) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:2.13.0]
  	at com.mycompany.springbootelasticsearch.service.MovieServiceImpl.saveMovie(MovieServiceImpl.java:44) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:na]
  	at com.mycompany.springbootelasticsearch.rest.MoviesController.createMovie(MoviesController.java:33) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:na]
  	at java.lang.reflect.Method.invoke(Method.java:566) ~[na:na]
  	at org.springframework.web.reactive.result.method.InvocableHandlerMethod.lambda$invoke$0(InvocableHandlerMethod.java:144) ~[na:na]
  	at reactor.core.publisher.MonoFlatMap$FlatMapMain.onNext(MonoFlatMap.java:125) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:3.4.12]
  	at reactor.core.publisher.Operators$MonoSubscriber.complete(Operators.java:1816) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:3.4.12]
  	at reactor.core.publisher.MonoZip$ZipCoordinator.signal(MonoZip.java:251) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:3.4.12]
  	at reactor.core.publisher.MonoZip$ZipInner.onNext(MonoZip.java:336) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:3.4.12]
  	at reactor.core.publisher.MonoPeekTerminal$MonoTerminalPeekSubscriber.onNext(MonoPeekTerminal.java:180) ~[na:na]
  	at reactor.core.publisher.FluxDefaultIfEmpty$DefaultIfEmptySubscriber.onNext(FluxDefaultIfEmpty.java:101) ~[na:na]
  	at reactor.core.publisher.FluxPeek$PeekSubscriber.onNext(FluxPeek.java:200) ~[na:na]
  	at reactor.core.publisher.FluxSwitchIfEmpty$SwitchIfEmptySubscriber.onNext(FluxSwitchIfEmpty.java:74) ~[na:na]
  	at reactor.core.publisher.FluxOnErrorResume$ResumeSubscriber.onNext(FluxOnErrorResume.java:79) ~[na:na]
  	at reactor.core.publisher.Operators$MonoSubscriber.complete(Operators.java:1816) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:3.4.12]
  	at reactor.core.publisher.MonoFlatMap$FlatMapMain.onNext(MonoFlatMap.java:151) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:3.4.12]
  	at reactor.core.publisher.FluxContextWrite$ContextWriteSubscriber.onNext(FluxContextWrite.java:107) ~[na:na]
  	at reactor.core.publisher.FluxMapFuseable$MapFuseableConditionalSubscriber.onNext(FluxMapFuseable.java:295) ~[na:na]
  	at reactor.core.publisher.FluxFilterFuseable$FilterFuseableConditionalSubscriber.onNext(FluxFilterFuseable.java:337) ~[na:na]
  	at reactor.core.publisher.Operators$MonoSubscriber.complete(Operators.java:1816) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:3.4.12]
  	at reactor.core.publisher.MonoCollect$CollectSubscriber.onComplete(MonoCollect.java:159) ~[na:na]
  	at reactor.core.publisher.FluxMap$MapSubscriber.onComplete(FluxMap.java:142) ~[na:na]
  	at reactor.core.publisher.FluxPeek$PeekSubscriber.onComplete(FluxPeek.java:260) ~[na:na]
  	at reactor.core.publisher.FluxMap$MapSubscriber.onComplete(FluxMap.java:142) ~[na:na]
  	at reactor.netty.channel.FluxReceive.onInboundComplete(FluxReceive.java:400) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:1.0.13]
  	at reactor.netty.channel.ChannelOperations.onInboundComplete(ChannelOperations.java:419) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:1.0.13]
  	at reactor.netty.http.server.HttpServerOperations.onInboundNext(HttpServerOperations.java:590) ~[na:na]
  	at reactor.netty.channel.ChannelOperationsHandler.channelRead(ChannelOperationsHandler.java:93) ~[na:na]
  	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:379) ~[na:na]
  	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:365) ~[na:na]
  	at io.netty.channel.AbstractChannelHandlerContext.fireChannelRead(AbstractChannelHandlerContext.java:357) ~[na:na]
  	at reactor.netty.http.server.HttpTrafficHandler.channelRead(HttpTrafficHandler.java:264) ~[na:na]
  	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:379) ~[na:na]
  	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:365) ~[na:na]
  	at io.netty.channel.AbstractChannelHandlerContext.fireChannelRead(AbstractChannelHandlerContext.java:357) ~[na:na]
  	at io.netty.channel.CombinedChannelDuplexHandler$DelegatingChannelHandlerContext.fireChannelRead(CombinedChannelDuplexHandler.java:436) ~[na:na]
  	at io.netty.handler.codec.ByteToMessageDecoder.fireChannelRead(ByteToMessageDecoder.java:324) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:4.1.70.Final]
  	at io.netty.handler.codec.ByteToMessageDecoder.channelRead(ByteToMessageDecoder.java:296) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:4.1.70.Final]
  	at io.netty.channel.CombinedChannelDuplexHandler.channelRead(CombinedChannelDuplexHandler.java:251) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:4.1.70.Final]
  	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:379) ~[na:na]
  	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:365) ~[na:na]
  	at io.netty.channel.AbstractChannelHandlerContext.fireChannelRead(AbstractChannelHandlerContext.java:357) ~[na:na]
  	at io.netty.channel.DefaultChannelPipeline$HeadContext.channelRead(DefaultChannelPipeline.java:1410) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:4.1.70.Final]
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
  	at com.oracle.svm.core.thread.JavaThreads.threadStartRoutine(JavaThreads.java:596) ~[na:na]
  	at com.oracle.svm.core.posix.thread.PosixJavaThreads.pthreadStartRoutine(PosixJavaThreads.java:192) ~[na:na]
  ```

- When submitting an invalid request according to `javax.validation.constraints`, like
  ```
  curl -i -X POST "localhost:9117/api/movies" -H "Content-type: application/json" \
    -d '{"imdb2": "456", "title": "American Pie"}'
  ```
  the response is
  ```
  HTTP/1.1 500 Internal Server Error
  ```
  and following exception is logged
  ```
  ERROR 1 --- [ctor-http-nio-3] o.s.w.s.adapter.HttpWebHandlerAdapter    : [e322b827-2] 500 Server Error for HTTP POST "/api/movies"
  
  org.springframework.core.codec.CodecException: Type definition error: [simple type, class org.springframework.validation.beanvalidation.SpringValidatorAdapter$ViolationFieldError]; nested exception is com.fasterxml.jackson.databind.exc.InvalidDefinitionException: No serializer found for class org.springframework.validation.beanvalidation.SpringValidatorAdapter$ViolationFieldError and no properties discovered to create BeanSerializer (to avoid exception, disable SerializationFeature.FAIL_ON_EMPTY_BEANS) (through reference chain: java.util.LinkedHashMap["errors"]->java.util.Collections$UnmodifiableRandomAccessList[0])
  	at org.springframework.http.codec.json.AbstractJackson2Encoder.encodeValue(AbstractJackson2Encoder.java:226) ~[na:na]
  	at org.springframework.http.codec.json.AbstractJackson2Encoder.lambda$encode$0(AbstractJackson2Encoder.java:150) ~[na:na]
  	at reactor.core.publisher.FluxMapFuseable$MapFuseableSubscriber.onNext(FluxMapFuseable.java:113) ~[na:na]
  	at reactor.core.publisher.Operators$ScalarSubscription.request(Operators.java:2398) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:3.4.12]
  	at reactor.core.publisher.FluxMapFuseable$MapFuseableSubscriber.request(FluxMapFuseable.java:169) ~[na:na]
  	at reactor.core.publisher.MonoSingle$SingleSubscriber.doOnRequest(MonoSingle.java:103) ~[na:na]
  	at reactor.core.publisher.Operators$MonoInnerProducerBase.request(Operators.java:2731) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:3.4.12]
  	at reactor.core.publisher.Operators$MultiSubscriptionSubscriber.set(Operators.java:2194) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:3.4.12]
  	at reactor.core.publisher.Operators$MultiSubscriptionSubscriber.onSubscribe(Operators.java:2068) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:3.4.12]
  	at reactor.core.publisher.MonoSingle$SingleSubscriber.onSubscribe(MonoSingle.java:115) ~[na:na]
  	at reactor.core.publisher.FluxMapFuseable$MapFuseableSubscriber.onSubscribe(FluxMapFuseable.java:96) ~[na:na]
  	at reactor.core.publisher.MonoJust.subscribe(MonoJust.java:55) ~[na:na]
  	at reactor.core.publisher.InternalMonoOperator.subscribe(InternalMonoOperator.java:64) ~[na:na]
  	at reactor.core.publisher.MonoFlatMap$FlatMapMain.onNext(MonoFlatMap.java:157) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:3.4.12]
  	at reactor.core.publisher.FluxPeekFuseable$PeekFuseableSubscriber.onNext(FluxPeekFuseable.java:210) ~[na:na]
  	at reactor.core.publisher.Operators$MonoSubscriber.complete(Operators.java:1816) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:3.4.12]
  	at reactor.core.publisher.MonoFlatMap$FlatMapMain.onNext(MonoFlatMap.java:151) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:3.4.12]
  	at reactor.core.publisher.FluxSwitchIfEmpty$SwitchIfEmptySubscriber.onNext(FluxSwitchIfEmpty.java:74) ~[na:na]
  	at reactor.core.publisher.MonoNext$NextSubscriber.onNext(MonoNext.java:82) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:3.4.12]
  	at reactor.core.publisher.FluxConcatArray$ConcatArraySubscriber.onNext(FluxConcatArray.java:201) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:3.4.12]
  	at reactor.core.publisher.Operators$ScalarSubscription.request(Operators.java:2398) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:3.4.12]
  	at reactor.core.publisher.FluxConcatArray$ConcatArraySubscriber.onSubscribe(FluxConcatArray.java:193) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:3.4.12]
  	at reactor.core.publisher.MonoJust.subscribe(MonoJust.java:55) ~[na:na]
  	at reactor.core.publisher.MonoDefer.subscribe(MonoDefer.java:52) ~[na:na]
  	at reactor.core.publisher.Mono.subscribe(Mono.java:4400) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:3.4.12]
  	at reactor.core.publisher.FluxConcatArray$ConcatArraySubscriber.onComplete(FluxConcatArray.java:258) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:3.4.12]
  	at reactor.core.publisher.FluxConcatArray.subscribe(FluxConcatArray.java:78) ~[na:na]
  	at reactor.core.publisher.Mono.subscribe(Mono.java:4400) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:3.4.12]
  	at reactor.core.publisher.FluxOnErrorResume$ResumeSubscriber.onError(FluxOnErrorResume.java:103) ~[na:na]
  	at reactor.core.publisher.FluxOnErrorResume$ResumeSubscriber.onError(FluxOnErrorResume.java:106) ~[na:na]
  	at reactor.core.publisher.FluxOnAssembly$OnAssemblySubscriber.onError(FluxOnAssembly.java:544) ~[na:na]
  	at reactor.core.publisher.Operators.error(Operators.java:198) ~[na:na]
  	at reactor.core.publisher.MonoError.subscribe(MonoError.java:53) ~[na:na]
  	at reactor.core.publisher.Mono.subscribe(Mono.java:4400) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:3.4.12]
  	at reactor.core.publisher.FluxOnErrorResume$ResumeSubscriber.onError(FluxOnErrorResume.java:103) ~[na:na]
  	at reactor.core.publisher.FluxOnAssembly$OnAssemblySubscriber.onError(FluxOnAssembly.java:544) ~[na:na]
  	at reactor.core.publisher.FluxPeek$PeekSubscriber.onError(FluxPeek.java:222) ~[na:na]
  	at reactor.core.publisher.FluxDoOnEach$DoOnEachSubscriber.onError(FluxDoOnEach.java:195) ~[na:na]
  	at reactor.core.publisher.MonoFlatMap$FlatMapMain.onError(MonoFlatMap.java:172) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:3.4.12]
  	at reactor.core.publisher.MonoFlatMap$FlatMapMain.secondError(MonoFlatMap.java:192) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:3.4.12]
  	at reactor.core.publisher.MonoFlatMap$FlatMapInner.onError(MonoFlatMap.java:259) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:3.4.12]
  	at reactor.core.publisher.FluxOnErrorResume$ResumeSubscriber.onError(FluxOnErrorResume.java:106) ~[na:na]
  	at reactor.core.publisher.Operators.error(Operators.java:198) ~[na:na]
  	at reactor.core.publisher.MonoError.subscribe(MonoError.java:53) ~[na:na]
  	at reactor.core.publisher.Mono.subscribe(Mono.java:4400) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:3.4.12]
  	at reactor.core.publisher.FluxOnErrorResume$ResumeSubscriber.onError(FluxOnErrorResume.java:103) ~[na:na]
  	at reactor.core.publisher.FluxPeek$PeekSubscriber.onError(FluxPeek.java:222) ~[na:na]
  	at reactor.core.publisher.FluxPeek$PeekSubscriber.onError(FluxPeek.java:222) ~[na:na]
  	at reactor.core.publisher.MonoIgnoreThen$ThenIgnoreMain.onError(MonoIgnoreThen.java:270) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:3.4.12]
  	at reactor.core.publisher.MonoFlatMap$FlatMapMain.onError(MonoFlatMap.java:172) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:3.4.12]
  	at reactor.core.publisher.MonoZip$ZipInner.onError(MonoZip.java:350) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:3.4.12]
  	at reactor.core.publisher.MonoPeekTerminal$MonoTerminalPeekSubscriber.onError(MonoPeekTerminal.java:258) ~[na:na]
  	at reactor.core.publisher.Operators$MonoSubscriber.onError(Operators.java:1863) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:3.4.12]
  	at reactor.core.publisher.FluxPeek$PeekSubscriber.onError(FluxPeek.java:222) ~[na:na]
  	at reactor.core.publisher.FluxPeek$PeekSubscriber.onNext(FluxPeek.java:194) ~[na:na]
  	at reactor.core.publisher.FluxSwitchIfEmpty$SwitchIfEmptySubscriber.onNext(FluxSwitchIfEmpty.java:74) ~[na:na]
  	at reactor.core.publisher.FluxOnErrorResume$ResumeSubscriber.onNext(FluxOnErrorResume.java:79) ~[na:na]
  	at reactor.core.publisher.Operators$MonoSubscriber.complete(Operators.java:1816) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:3.4.12]
  	at reactor.core.publisher.MonoFlatMap$FlatMapMain.onNext(MonoFlatMap.java:151) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:3.4.12]
  	at reactor.core.publisher.FluxContextWrite$ContextWriteSubscriber.onNext(FluxContextWrite.java:107) ~[na:na]
  	at reactor.core.publisher.FluxMapFuseable$MapFuseableConditionalSubscriber.onNext(FluxMapFuseable.java:295) ~[na:na]
  	at reactor.core.publisher.FluxFilterFuseable$FilterFuseableConditionalSubscriber.onNext(FluxFilterFuseable.java:337) ~[na:na]
  	at reactor.core.publisher.Operators$MonoSubscriber.complete(Operators.java:1816) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:3.4.12]
  	at reactor.core.publisher.MonoCollect$CollectSubscriber.onComplete(MonoCollect.java:159) ~[na:na]
  	at reactor.core.publisher.FluxMap$MapSubscriber.onComplete(FluxMap.java:142) ~[na:na]
  	at reactor.core.publisher.FluxPeek$PeekSubscriber.onComplete(FluxPeek.java:260) ~[na:na]
  	at reactor.core.publisher.FluxMap$MapSubscriber.onComplete(FluxMap.java:142) ~[na:na]
  	at reactor.netty.channel.FluxReceive.onInboundComplete(FluxReceive.java:400) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:1.0.13]
  	at reactor.netty.channel.ChannelOperations.onInboundComplete(ChannelOperations.java:419) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:1.0.13]
  	at reactor.netty.http.server.HttpServerOperations.onInboundNext(HttpServerOperations.java:590) ~[na:na]
  	at reactor.netty.channel.ChannelOperationsHandler.channelRead(ChannelOperationsHandler.java:93) ~[na:na]
  	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:379) ~[na:na]
  	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:365) ~[na:na]
  	at io.netty.channel.AbstractChannelHandlerContext.fireChannelRead(AbstractChannelHandlerContext.java:357) ~[na:na]
  	at reactor.netty.http.server.HttpTrafficHandler.channelRead(HttpTrafficHandler.java:264) ~[na:na]
  	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:379) ~[na:na]
  	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:365) ~[na:na]
  	at io.netty.channel.AbstractChannelHandlerContext.fireChannelRead(AbstractChannelHandlerContext.java:357) ~[na:na]
  	at io.netty.channel.CombinedChannelDuplexHandler$DelegatingChannelHandlerContext.fireChannelRead(CombinedChannelDuplexHandler.java:436) ~[na:na]
  	at io.netty.handler.codec.ByteToMessageDecoder.fireChannelRead(ByteToMessageDecoder.java:324) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:4.1.70.Final]
  	at io.netty.handler.codec.ByteToMessageDecoder.channelRead(ByteToMessageDecoder.java:296) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:4.1.70.Final]
  	at io.netty.channel.CombinedChannelDuplexHandler.channelRead(CombinedChannelDuplexHandler.java:251) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:4.1.70.Final]
  	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:379) ~[na:na]
  	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:365) ~[na:na]
  	at io.netty.channel.AbstractChannelHandlerContext.fireChannelRead(AbstractChannelHandlerContext.java:357) ~[na:na]
  	at io.netty.channel.DefaultChannelPipeline$HeadContext.channelRead(DefaultChannelPipeline.java:1410) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:4.1.70.Final]
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
  	at com.oracle.svm.core.thread.JavaThreads.threadStartRoutine(JavaThreads.java:596) ~[na:na]
  	at com.oracle.svm.core.posix.thread.PosixJavaThreads.pthreadStartRoutine(PosixJavaThreads.java:192) ~[na:na]
  Caused by: com.fasterxml.jackson.databind.exc.InvalidDefinitionException: No serializer found for class org.springframework.validation.beanvalidation.SpringValidatorAdapter$ViolationFieldError and no properties discovered to create BeanSerializer (to avoid exception, disable SerializationFeature.FAIL_ON_EMPTY_BEANS) (through reference chain: java.util.LinkedHashMap["errors"]->java.util.Collections$UnmodifiableRandomAccessList[0])
  	at com.fasterxml.jackson.databind.SerializerProvider.reportBadDefinition(SerializerProvider.java:1300) ~[na:na]
  	at com.fasterxml.jackson.databind.DatabindContext.reportBadDefinition(DatabindContext.java:400) ~[na:na]
  	at com.fasterxml.jackson.databind.ser.impl.UnknownSerializer.failForEmpty(UnknownSerializer.java:46) ~[na:na]
  	at com.fasterxml.jackson.databind.ser.impl.UnknownSerializer.serialize(UnknownSerializer.java:29) ~[na:na]
  	at com.fasterxml.jackson.databind.ser.impl.IndexedListSerializer.serializeContents(IndexedListSerializer.java:119) ~[na:na]
  	at com.fasterxml.jackson.databind.ser.impl.IndexedListSerializer.serialize(IndexedListSerializer.java:79) ~[na:na]
  	at com.fasterxml.jackson.databind.ser.impl.IndexedListSerializer.serialize(IndexedListSerializer.java:18) ~[na:na]
  	at com.fasterxml.jackson.databind.ser.std.MapSerializer.serializeFields(MapSerializer.java:808) ~[na:na]
  	at com.fasterxml.jackson.databind.ser.std.MapSerializer.serializeWithoutTypeInfo(MapSerializer.java:764) ~[na:na]
  	at com.fasterxml.jackson.databind.ser.std.MapSerializer.serialize(MapSerializer.java:720) ~[na:na]
  	at com.fasterxml.jackson.databind.ser.std.MapSerializer.serialize(MapSerializer.java:35) ~[na:na]
  	at com.fasterxml.jackson.databind.ser.DefaultSerializerProvider._serialize(DefaultSerializerProvider.java:480) ~[na:na]
  	at com.fasterxml.jackson.databind.ser.DefaultSerializerProvider.serializeValue(DefaultSerializerProvider.java:400) ~[na:na]
  	at com.fasterxml.jackson.databind.ObjectWriter$Prefetch.serialize(ObjectWriter.java:1514) ~[na:na]
  	at com.fasterxml.jackson.databind.ObjectWriter.writeValue(ObjectWriter.java:1007) ~[na:na]
  	at org.springframework.http.codec.json.AbstractJackson2Encoder.encodeValue(AbstractJackson2Encoder.java:222) ~[na:na]
  	... 99 common frames omitted
  ```
  The expected response (as it happens with Docker JVM) should be something like
  ```
  HTTP/1.1 400 Bad Request
  {
     "timestamp":"...",
     "path":"/api/movies",
     "status":400,
     "error":"Bad Request",
     "message":"Validation failed for argument at index 0 in method: public java.lang.String com.mycompany.springbootelasticsearch.rest.MoviesController.createMovie(com.mycompany.springbootelasticsearch.rest.dto.CreateMovieRequest), with 1 error(s): [Field error in object 'createMovieRequest' on field 'imdb': rejected value [null]; codes [NotBlank.createMovieRequest.imdb,NotBlank.imdb,NotBlank.java.lang.String,NotBlank]; arguments [org.springframework.context.support.DefaultMessageSourceResolvable: codes [createMovieRequest.imdb,imdb]; arguments []; default message [imdb]]; default message [must not be blank]] ",
     "requestId":"28ac15b9-1",
     "exception":"org.springframework.web.bind.support.WebExchangeBindException",
     "errors":[
        {
           "codes":[
              "NotBlank.createMovieRequest.imdb",
              "NotBlank.imdb",
              "NotBlank.java.lang.String",
              "NotBlank"
           ],
           "arguments":[
              {
                 "codes":[
                    "createMovieRequest.imdb",
                    "imdb"
                 ],
                 "arguments":null,
                 "defaultMessage":"imdb",
                 "code":"imdb"
              }
           ],
           "defaultMessage":"must not be blank",
           "objectName":"createMovieRequest",
           "field":"imdb",
           "rejectedValue":null,
           "bindingFailure":false,
           "code":"NotBlank"
        }
     ]
  }
