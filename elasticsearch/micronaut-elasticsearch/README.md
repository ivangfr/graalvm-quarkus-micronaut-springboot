# graalvm-quarkus-micronaut-springboot
## `> elasticsearch > micronaut-elasticsearch`

## Application

- **micronaut-elasticsearch**

  [`Micronaut`](https://micronaut.io/) Java Web application that expose a simple REST API for indexing and searching movies in `Elasticsearch`.
  
  It has the following endpoint:
  ```
  POST /api/movies -d {"imdb": "...", "title": "..."}
  GET /api/movies[?title=...]
  ```

## Running application

> **Note:** `Elasticsearch` container must be running and initialized as explained [here](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/elasticsearch#start-environment)

### Development Mode

- Open a terminal and navigate to `graalvm-quarkus-micronaut-springboot/elasticsearch/micronaut-elasticsearch` folder

- Run the command below to start the application
  ```
  ./gradlew clean run
  ```

- A simple test can be done by opening a new terminal and running
  ```
  curl -i -X POST "localhost:8080/api/movies" -H "Content-type: application/json" -d '{"imdb": "123", "title": "I, Tonya"}'
  curl -i "localhost:8080/api/movies?title=tonya"
  ```

- To stop the application, press `Ctrl+C` in its terminals

### Docker in JVM Mode

- In a terminal, make sure you are inside `graalvm-quarkus-micronaut-springboot/elasticsearch/micronaut-elasticsearch` folder

- Package the application `jar` file
  ```
  ./gradlew clean assemble
  ```

- Run the script below to build the Docker image
  ```
  ./docker-build.sh
  ```

- Run the following command to start the Docker container
  ```
  docker run --rm --name micronaut-elasticsearch-jvm \
    -p 9107:8080 -e ELASTICSEARCH_HOST=elasticsearch --network elasticsearch_default \
    docker.mycompany.com/micronaut-elasticsearch-jvm:1.0.0
  ```

- A simple test can be done by opening a new terminal and running
  ```
  curl -i -X POST "localhost:9107/api/movies" -H "Content-type: application/json" -d '{"imdb": "456", "title": "American Pie"}'
  curl -i "localhost:9107/api/movies?title=american"
  ```

- To stop and remove application Docker container, press `Ctrl+C` in its terminals

### Docker in Native Mode

- In a terminal, make sure you are inside `graalvm-quarkus-micronaut-springboot/elasticsearch/micronaut-elasticsearch` folder

- Package the application `jar` file
  ```
  ./gradlew clean assemble
  ```

- Run the script below to build the Docker image
  ```
  ./docker-build.sh native
  ```

- Run the following command to start the Docker container
  ```
  docker run --rm --name micronaut-elasticsearch-native \
    -p 9108:8080 -e ELASTICSEARCH_HOST=elasticsearch --network elasticsearch_default \
    docker.mycompany.com/micronaut-elasticsearch-native:1.0.0
  ```

- A simple test can be done by opening a new terminal and running
  > **Important:** an exception is thrown when the application a request. For more details see [issues](#issues)
  ```
  curl -i -X POST "localhost:9108/api/movies" -H "Content-type: application/json" -d '{"imdb": "789", "title": "Resident Evil"}'
  curl -i "localhost:9108/api/movies?title=evil"
  ```

- To stop and remove application Docker container, press `Ctrl+C` in its terminals

## Issues

- When application receives a request, the following exception is thrown. It seems and problem initializing `RestClient` bean
  ```
  [nioEventLoopGroup-1-3] ERROR i.m.h.s.netty.RoutingInBoundHandler - Unexpected error occurred: Error   instantiating bean of type  [com.mycompany.service.MovieServiceImpl]
  
  Message: Could not initialize class org.elasticsearch.client.RestClient
  Path Taken: new $MovieControllerDefinition$Intercepted([MovieService movieService],MovieMapper   movieMapper,BeanContext beanContext,Qualifier qualifier,Interceptor[] interceptors) --> new   MovieServiceImpl([RestHighLevelClient client],MovieMapper movieMapper,ObjectMapper objectMapper)
  io.micronaut.context.exceptions.BeanInstantiationException: Error instantiating bean of type  [com.  mycompany.service.MovieServiceImpl]
  
  Message: Could not initialize class org.elasticsearch.client.RestClient
  Path Taken: new $MovieControllerDefinition$Intercepted([MovieService movieService],MovieMapper   movieMapper,BeanContext beanContext,Qualifier qualifier,Interceptor[] interceptors) --> new   MovieServiceImpl([RestHighLevelClient client],MovieMapper movieMapper,ObjectMapper objectMapper)
  	at io.micronaut.context.DefaultBeanContext.doCreateBean(DefaultBeanContext.java:1840)
  	at io.micronaut.context.DefaultBeanContext.getScopedBeanForDefinition(DefaultBeanContext.java:2309)
  	at io.micronaut.context.DefaultBeanContext.getBeanForDefinition(DefaultBeanContext.java:2224)
  	at io.micronaut.context.DefaultBeanContext.getBeanInternal(DefaultBeanContext.java:2196)
  	at io.micronaut.context.DefaultBeanContext.getBean(DefaultBeanContext.java:1198)
  	at io.micronaut.context.AbstractBeanDefinition.getBeanForConstructorArgument(AbstractBeanDefinition.  java:1039)
  	at com.mycompany.service.$MovieServiceImplDefinition.build(Unknown Source)
  	at io.micronaut.context.DefaultBeanContext.doCreateBean(DefaultBeanContext.java:1814)
  	at io.micronaut.context.DefaultBeanContext.createAndRegisterSingletonInternal(DefaultBeanContext.  java:2549)
  	at io.micronaut.context.DefaultBeanContext.createAndRegisterSingleton(DefaultBeanContext.java:2535)
  	at io.micronaut.context.DefaultBeanContext.getBeanForDefinition(DefaultBeanContext.java:2222)
  	at io.micronaut.context.DefaultBeanContext.getBeanInternal(DefaultBeanContext.java:2196)
  	at io.micronaut.context.DefaultBeanContext.getBean(DefaultBeanContext.java:1198)
  	at io.micronaut.context.AbstractBeanDefinition.getBeanForConstructorArgument(AbstractBeanDefinition.  java:1039)
  	at com.mycompany.rest.$$MovieControllerDefinition$InterceptedDefinition.build(Unknown Source)
  	at io.micronaut.context.DefaultBeanContext.doCreateBean(DefaultBeanContext.java:1814)
  	at io.micronaut.context.DefaultBeanContext.createAndRegisterSingletonInternal(DefaultBeanContext.  java:2549)
  	at io.micronaut.context.DefaultBeanContext.createAndRegisterSingleton(DefaultBeanContext.java:2535)
  	at io.micronaut.context.DefaultBeanContext.getBeanForDefinition(DefaultBeanContext.java:2222)
  	at io.micronaut.context.DefaultBeanContext.access$100(DefaultBeanContext.java:78)
  	at io.micronaut.context.DefaultBeanContext$4.getTarget(DefaultBeanContext.java:414)
  	at io.micronaut.context.DefaultBeanContext$4.invoke(DefaultBeanContext.java:457)
  	at io.micronaut.web.router.AbstractRouteMatch.execute(AbstractRouteMatch.java:313)
  	at io.micronaut.web.router.RouteMatch.execute(RouteMatch.java:117)
  	at io.micronaut.http.server.netty.RoutingInBoundHandler.lambda$buildResultEmitter$11  (RoutingInBoundHandler.java:1322)
  	at io.reactivex.internal.operators.flowable.FlowableDefer.subscribeActual(FlowableDefer.java:35)
  	at io.reactivex.Flowable.subscribe(Flowable.java:14918)
  	at io.reactivex.Flowable.subscribe(Flowable.java:14868)
  	at io.micronaut.configuration.metrics.binder.web.WebMetricsPublisher.subscribe(WebMetricsPublisher.  java:153)
  	at io.micronaut.http.context.ServerRequestTracingPublisher.lambda$subscribe$0  (ServerRequestTracingPublisher.java:52)
  	at io.micronaut.http.context.ServerRequestContext.with(ServerRequestContext.java:68)
  	at io.micronaut.http.context.ServerRequestTracingPublisher.subscribe(ServerRequestTracingPublisher.  java:52)
  	at io.reactivex.internal.operators.flowable.FlowableFromPublisher.subscribeActual  (FlowableFromPublisher.java:29)
  	at io.reactivex.Flowable.subscribe(Flowable.java:14918)
  	at io.reactivex.Flowable.subscribe(Flowable.java:14868)
  	at io.micronaut.http.server.netty.RoutingInBoundHandler.lambda$buildExecutableRoute$5  (RoutingInBoundHandler.java:1026)
  	at io.micronaut.web.router.DefaultUriRouteMatch$1.execute(DefaultUriRouteMatch.java:81)
  	at io.micronaut.web.router.RouteMatch.execute(RouteMatch.java:117)
  	at io.micronaut.http.server.netty.RoutingInBoundHandler.handleRouteMatch(RoutingInBoundHandler.  java:687)
  	at io.micronaut.http.server.netty.RoutingInBoundHandler.channelRead0(RoutingInBoundHandler.java:549)
  	at io.micronaut.http.server.netty.RoutingInBoundHandler.channelRead0(RoutingInBoundHandler.java:144)
  	at io.netty.channel.SimpleChannelInboundHandler.channelRead(SimpleChannelInboundHandler.java:99)
  	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.  java:379)
  	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.  java:365)
  	at io.netty.channel.AbstractChannelHandlerContext.fireChannelRead(AbstractChannelHandlerContext.  java:357)
  	at io.netty.channel.SimpleChannelInboundHandler.channelRead(SimpleChannelInboundHandler.java:102)
  	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.  java:379)
  	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.  java:365)
  	at io.netty.channel.AbstractChannelHandlerContext.fireChannelRead(AbstractChannelHandlerContext.  java:357)
  	at io.netty.handler.codec.MessageToMessageDecoder.channelRead(MessageToMessageDecoder.java:102)
  	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.  java:379)
  	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.  java:365)
  	at io.netty.channel.AbstractChannelHandlerContext.fireChannelRead(AbstractChannelHandlerContext.  java:357)
  	at io.netty.channel.ChannelInboundHandlerAdapter.channelRead(ChannelInboundHandlerAdapter.java:93)
  	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.  java:379)
  	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.  java:365)
  	at io.netty.channel.AbstractChannelHandlerContext.fireChannelRead(AbstractChannelHandlerContext.  java:357)
  	at io.micronaut.http.netty.stream.HttpStreamsHandler.channelRead(HttpStreamsHandler.java:196)
  	at io.micronaut.http.netty.stream.HttpStreamsServerHandler.channelRead(HttpStreamsServerHandler.  java:121)
  	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.  java:379)
  	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.  java:365)
  	at io.netty.channel.AbstractChannelHandlerContext.fireChannelRead(AbstractChannelHandlerContext.  java:357)
  	at io.netty.handler.codec.MessageToMessageDecoder.channelRead(MessageToMessageDecoder.java:102)
  	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.  java:379)
  	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.  java:365)
  	at io.netty.channel.AbstractChannelHandlerContext.fireChannelRead(AbstractChannelHandlerContext.  java:357)
  	at io.netty.handler.codec.MessageToMessageDecoder.channelRead(MessageToMessageDecoder.java:102)
  	at io.netty.handler.codec.MessageToMessageCodec.channelRead(MessageToMessageCodec.java:111)
  	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.  java:379)
  	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.  java:365)
  	at io.netty.channel.AbstractChannelHandlerContext.fireChannelRead(AbstractChannelHandlerContext.  java:357)
  	at io.netty.channel.ChannelInboundHandlerAdapter.channelRead(ChannelInboundHandlerAdapter.java:93)
  	at io.netty.handler.codec.http.HttpServerKeepAliveHandler.channelRead(HttpServerKeepAliveHandler.  java:64)
  	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.  java:379)
  	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.  java:365)
  	at io.netty.channel.AbstractChannelHandlerContext.fireChannelRead(AbstractChannelHandlerContext.  java:357)
  	at io.netty.handler.flow.FlowControlHandler.dequeue(FlowControlHandler.java:191)
  	at io.netty.handler.flow.FlowControlHandler.channelRead(FlowControlHandler.java:153)
  	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.  java:379)
  	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.  java:365)
  	at io.netty.channel.AbstractChannelHandlerContext.fireChannelRead(AbstractChannelHandlerContext.  java:357)
  	at io.netty.channel.CombinedChannelDuplexHandler$DelegatingChannelHandlerContext.fireChannelRead  (CombinedChannelDuplexHandler.java:436)
  	at io.netty.handler.codec.ByteToMessageDecoder.fireChannelRead(ByteToMessageDecoder.java:321)
  	at io.netty.handler.codec.ByteToMessageDecoder.channelRead(ByteToMessageDecoder.java:295)
  	at io.netty.channel.CombinedChannelDuplexHandler.channelRead(CombinedChannelDuplexHandler.java:251)
  	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.  java:379)
  	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.  java:365)
  	at io.netty.channel.AbstractChannelHandlerContext.fireChannelRead(AbstractChannelHandlerContext.  java:357)
  	at io.netty.handler.timeout.IdleStateHandler.channelRead(IdleStateHandler.java:286)
  	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.  java:379)
  	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.  java:365)
  	at io.netty.channel.AbstractChannelHandlerContext.fireChannelRead(AbstractChannelHandlerContext.  java:357)
  	at io.netty.channel.DefaultChannelPipeline$HeadContext.channelRead(DefaultChannelPipeline.java:1410)
  	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.  java:379)
  	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.  java:365)
  	at io.netty.channel.DefaultChannelPipeline.fireChannelRead(DefaultChannelPipeline.java:919)
  	at io.netty.channel.nio.AbstractNioByteChannel$NioByteUnsafe.read(AbstractNioByteChannel.java:163)
  	at io.netty.channel.nio.NioEventLoop.processSelectedKey(NioEventLoop.java:714)
  	at io.netty.channel.nio.NioEventLoop.processSelectedKeysOptimized(NioEventLoop.java:650)
  	at io.netty.channel.nio.NioEventLoop.processSelectedKeys(NioEventLoop.java:576)
  	at io.netty.channel.nio.NioEventLoop.run(NioEventLoop.java:493)
  	at io.netty.util.concurrent.SingleThreadEventExecutor$4.run(SingleThreadEventExecutor.java:989)
  	at io.netty.util.internal.ThreadExecutorMap$2.run(ThreadExecutorMap.java:74)
  	at io.netty.util.concurrent.FastThreadLocalRunnable.run(FastThreadLocalRunnable.java:30)
  	at java.lang.Thread.run(Thread.java:748)
  	at com.oracle.svm.core.thread.JavaThreads.threadStartRoutine(JavaThreads.java:527)
  	at com.oracle.svm.core.posix.thread.PosixJavaThreads.pthreadStartRoutine(PosixJavaThreads.java:193)
  Caused by: java.lang.NoClassDefFoundError: Could not initialize class org.elasticsearch.client.  RestClient
  	at com.oracle.svm.core.hub.ClassInitializationInfo.initialize(ClassInitializationInfo.java:214)
  	at java.lang.Class.ensureInitialized(DynamicHub.java:496)
  	at io.micronaut.configuration.elasticsearch.DefaultElasticsearchClientFactory.restClientBuilder  (DefaultElasticsearchClientFactory.java:62)
  	at io.micronaut.configuration.elasticsearch.DefaultElasticsearchClientFactory.restHighLevelClient  (DefaultElasticsearchClientFactory.java:45)
  	at io.micronaut.configuration.elasticsearch.  $DefaultElasticsearchClientFactory$RestHighLevelClientDefinition.build(Unknown Source)
  	at io.micronaut.context.DefaultBeanContext.doCreateBean(DefaultBeanContext.java:1814)
  	... 106 common frames omitted
  18:59:10.846 [pool-2-thread-1] ERROR i.m.s.DefaultTaskExceptionHandler - Error invoking scheduled task   Error instantiating bean of type  [io.micronaut.configuration.elasticsearch.health.  ElasticsearchHealthIndicator]
  
  Message: Could not initialize class org.elasticsearch.client.RestClient
  Path Taken: new HealthMonitorTask(CurrentHealthStatus currentHealthStatus,[List healthIndicators]) -->   new ElasticsearchHealthIndicator([RestHighLevelClient restHighLevelClient])
  io.micronaut.context.exceptions.BeanInstantiationException: Error instantiating bean of type  [io.  micronaut.configuration.elasticsearch.health.ElasticsearchHealthIndicator]
  
  Message: Could not initialize class org.elasticsearch.client.RestClient
  Path Taken: new HealthMonitorTask(CurrentHealthStatus currentHealthStatus,[List healthIndicators]) -->   new ElasticsearchHealthIndicator([RestHighLevelClient restHighLevelClient])
  	at io.micronaut.context.DefaultBeanContext.doCreateBean(DefaultBeanContext.java:1840)
  	at io.micronaut.context.DefaultBeanContext.getScopedBeanForDefinition(DefaultBeanContext.java:2309)
  	at io.micronaut.context.DefaultBeanContext.getBeanForDefinition(DefaultBeanContext.java:2224)
  	at io.micronaut.context.DefaultBeanContext.getBeanInternal(DefaultBeanContext.java:2196)
  	at io.micronaut.context.DefaultBeanContext.getBean(DefaultBeanContext.java:1198)
  	at io.micronaut.context.AbstractBeanDefinition.getBeanForConstructorArgument(AbstractBeanDefinition.  java:1039)
  	at io.micronaut.configuration.elasticsearch.health.$ElasticsearchHealthIndicatorDefinition.build  (Unknown Source)
  	at io.micronaut.context.DefaultBeanContext.doCreateBean(DefaultBeanContext.java:1814)
  	at io.micronaut.context.DefaultBeanContext.addCandidateToList(DefaultBeanContext.java:2868)
  	at io.micronaut.context.DefaultBeanContext.getBeansOfTypeInternal(DefaultBeanContext.java:2780)
  	at io.micronaut.context.DefaultBeanContext.getBeansOfType(DefaultBeanContext.java:1014)
  	at io.micronaut.context.AbstractBeanDefinition.lambda$getBeansOfTypeForConstructorArgument$9  (AbstractBeanDefinition.java:1156)
  	at io.micronaut.context.AbstractBeanDefinition.resolveBeanWithGenericsFromConstructorArgument  (AbstractBeanDefinition.java:1808)
  	at io.micronaut.context.AbstractBeanDefinition.getBeansOfTypeForConstructorArgument  (AbstractBeanDefinition.java:1151)
  	at io.micronaut.context.AbstractBeanDefinition.getBeanForConstructorArgument(AbstractBeanDefinition.  java:1016)
  	at io.micronaut.management.health.monitor.$HealthMonitorTaskDefinition.build(Unknown Source)
  	at io.micronaut.context.DefaultBeanContext.doCreateBean(DefaultBeanContext.java:1814)
  	at io.micronaut.context.DefaultBeanContext.createAndRegisterSingletonInternal(DefaultBeanContext.  java:2549)
  	at io.micronaut.context.DefaultBeanContext.createAndRegisterSingleton(DefaultBeanContext.java:2535)
  	at io.micronaut.context.DefaultBeanContext.getBeanForDefinition(DefaultBeanContext.java:2222)
  	at io.micronaut.context.DefaultBeanContext.getBeanInternal(DefaultBeanContext.java:2196)
  	at io.micronaut.context.DefaultBeanContext.getBean(DefaultBeanContext.java:703)
  	at io.micronaut.scheduling.processor.ScheduledMethodProcessor.lambda$process$5  (ScheduledMethodProcessor.java:123)
  	at io.micrometer.core.instrument.composite.CompositeTimer.record(CompositeTimer.java:79)
  	at io.micrometer.core.instrument.Timer.lambda$wrap$0(Timer.java:144)
  	at java.util.concurrent.Executors$RunnableAdapter.call(Executors.java:511)
  	at java.util.concurrent.FutureTask.runAndReset(FutureTask.java:308)
  	at java.util.concurrent.ScheduledThreadPoolExecutor$ScheduledFutureTask.access$301  (ScheduledThreadPoolExecutor.java:180)
  	at java.util.concurrent.ScheduledThreadPoolExecutor$ScheduledFutureTask.run  (ScheduledThreadPoolExecutor.java:294)
  	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1149)
  	at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:624)
  	at java.lang.Thread.run(Thread.java:748)
  	at com.oracle.svm.core.thread.JavaThreads.threadStartRoutine(JavaThreads.java:527)
  	at com.oracle.svm.core.posix.thread.PosixJavaThreads.pthreadStartRoutine(PosixJavaThreads.java:193)
  Caused by: java.lang.NoClassDefFoundError: Could not initialize class org.elasticsearch.client.  RestClient
  	at com.oracle.svm.core.hub.ClassInitializationInfo.initialize(ClassInitializationInfo.java:214)
  	at java.lang.Class.ensureInitialized(DynamicHub.java:496)
  	at io.micronaut.configuration.elasticsearch.DefaultElasticsearchClientFactory.restClientBuilder  (DefaultElasticsearchClientFactory.java:62)
  	at io.micronaut.configuration.elasticsearch.DefaultElasticsearchClientFactory.restHighLevelClient  (DefaultElasticsearchClientFactory.java:45)
  	at io.micronaut.configuration.elasticsearch.  $DefaultElasticsearchClientFactory$RestHighLevelClientDefinition.build(Unknown Source)
  	at io.micronaut.context.DefaultBeanContext.doCreateBean(DefaultBeanContext.java:1814)
  	... 33 common frames omitted
  ```
