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

    - Run the command below to start the application
		  > See [Issues](#springboot-consumer-api-issues)
      ```
      ./mvnw clean package spring-boot:run -Dspring-boot.run.jvmArguments="-Dserver.port=8081" --projects consumer-api
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
      docker run --rm --name springboot-producer-api-jvm -p 9104:8080 \
        -e KAFKA_HOST=kafka -e KAFKA_PORT=9092 --network producer-consumer_default \
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

    - Run the following command to start the Docker container
		  > See [Issues](#springboot-consumer-api-issues)
      ```
      docker run --rm --name springboot-consumer-api-jvm -p 9110:8080 \
        -e KAFKA_HOST=kafka -e KAFKA_PORT=9092 --network producer-consumer_default \
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

    - Run the following command to start the Docker container
			> See [Issues](#springboot-producer-api-issues)
      ```
      docker run --rm --name springboot-producer-api-native -p 9105:8080 \
        -e KAFKA_HOST=kafka -e KAFKA_PORT=9092 --network producer-consumer_default \
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

    - Run the following command to start the Docker container
		  > See [Issues](#springboot-consumer-api-issues)
      ```
      docker run --rm --name springboot-consumer-api-native -p 9111:8080 \
        -e KAFKA_HOST=kafka -e KAFKA_PORT=9092 --network producer-consumer_default \
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

- When **Docker in Native Mode**, it starts up fine. However, when a JSON message is published, an exception is thrown
  ```
    .   ____          _            __ _ _
   /\\ / ___'_ __ _ _(_)_ __  __ _ \ \ \ \
  ( ( )\___ | '_ | '_| | '_ \/ _` | \ \ \ \
   \\/  ___)| |_)| | | | | || (_| |  ) ) ) )
    '  |____| .__|_| |_|_| |_\__, | / / / /
   =========|_|==============|___/=/_/_/_/
   :: Spring Boot ::                (v2.4.3)
  
  INFO 1 --- [           main] c.m.producerapi.ProducerApiApplication   : Starting   ProducerApiApplication using Java 11.0.10 on 14941f3a3986 with PID 1 (/workspace/com.mycompany.producerapi.  ProducerApiApplication started by cnb in /workspace)
  2021-03-16 12:50:45.672  INFO 1 --- [           main] c.m.producerapi.ProducerApiApplication   : No active profile   set, falling back to default profiles: default
  WARN 1 --- [           main] i.m.c.i.binder.jvm.JvmGcMetrics          : GC notifications   will not be available because MemoryPoolMXBeans are not provided by the JVM
  INFO 1 --- [           main] o.s.b.a.e.web.EndpointLinksResolver      : Exposing 5 endpoint  (s) beneath base path ''
  INFO 1 --- [           main] o.a.k.clients.admin.AdminClientConfig    : AdminClientConfig   values:
  	bootstrap.servers = [kafka:9092]
  	client.dns.lookup = use_all_dns_ips
  	client.id =
  	connections.max.idle.ms = 300000
  	default.api.timeout.ms = 60000
  	metadata.max.age.ms = 300000
  	metric.reporters = []
  	metrics.num.samples = 2
  	metrics.recording.level = INFO
  	metrics.sample.window.ms = 30000
  	receive.buffer.bytes = 65536
  	reconnect.backoff.max.ms = 1000
  	reconnect.backoff.ms = 50
  	request.timeout.ms = 30000
  	retries = 2147483647
  	retry.backoff.ms = 100
  	sasl.client.callback.handler.class = null
  	sasl.jaas.config = null
  	sasl.kerberos.kinit.cmd = /usr/bin/kinit
  	sasl.kerberos.min.time.before.relogin = 60000
  	sasl.kerberos.service.name = null
  	sasl.kerberos.ticket.renew.jitter = 0.05
  	sasl.kerberos.ticket.renew.window.factor = 0.8
  	sasl.login.callback.handler.class = null
  	sasl.login.class = null
  	sasl.login.refresh.buffer.seconds = 300
  	sasl.login.refresh.min.period.seconds = 60
  	sasl.login.refresh.window.factor = 0.8
  	sasl.login.refresh.window.jitter = 0.05
  	sasl.mechanism = GSSAPI
  	security.protocol = PLAINTEXT
  	security.providers = null
  	send.buffer.bytes = 131072
  	ssl.cipher.suites = null
  	ssl.enabled.protocols = [TLSv1.2, TLSv1.3]
  	ssl.endpoint.identification.algorithm = https
  	ssl.engine.factory.class = null
  	ssl.key.password = null
  	ssl.keymanager.algorithm = SunX509
  	ssl.keystore.location = null
  	ssl.keystore.password = null
  	ssl.keystore.type = JKS
  	ssl.protocol = TLSv1.3
  	ssl.provider = null
  	ssl.secure.random.implementation = null
  	ssl.trustmanager.algorithm = PKIX
  	ssl.truststore.location = null
  	ssl.truststore.password = null
  	ssl.truststore.type = JKS
  
  WARN 1 --- [           main] o.a.kafka.common.utils.AppInfoParser     : Error while loading   kafka-version.properties: inStream parameter is null
  INFO 1 --- [           main] o.a.kafka.common.utils.AppInfoParser     : Kafka version:   unknown
  INFO 1 --- [           main] o.a.kafka.common.utils.AppInfoParser     : Kafka commitId:   unknown
  INFO 1 --- [           main] o.a.kafka.common.utils.AppInfoParser     : Kafka startTimeMs:   1615899045882
  INFO 1 --- [           main] o.s.b.web.embedded.netty.NettyWebServer  : Netty started on   port 8080
  INFO 1 --- [           main] c.m.producerapi.ProducerApiApplication   : Started   ProducerApiApplication in 0.314 seconds (JVM running for 0.325)
  INFO 1 --- [ctor-http-nio-2] c.m.producerapi.kafka.NewsProducer       : Sending News 'News  (id=48bd256b-ccb0-4243-b367-c000ea77f4a5, source=Spring Boot Blog, title=Spring Boot Framework & GraalVM)' to topic   'springboot.news.json'
  INFO 1 --- [ctor-http-nio-2] o.a.k.clients.producer.ProducerConfig    : ProducerConfig   values:
  	acks = 1
  	batch.size = 16384
  	bootstrap.servers = [kafka:9092]
  	buffer.memory = 33554432
  	client.dns.lookup = use_all_dns_ips
  	client.id = producer-1
  	compression.type = none
  	connections.max.idle.ms = 540000
  	delivery.timeout.ms = 120000
  	enable.idempotence = false
  	interceptor.classes = []
  	internal.auto.downgrade.txn.commit = true
  	key.serializer = class org.apache.kafka.common.serialization.StringSerializer
  	linger.ms = 0
  	max.block.ms = 60000
  	max.in.flight.requests.per.connection = 5
  	max.request.size = 1048576
  	metadata.max.age.ms = 300000
  	metadata.max.idle.ms = 300000
  	metric.reporters = []
  	metrics.num.samples = 2
  	metrics.recording.level = INFO
  	metrics.sample.window.ms = 30000
  	partitioner.class = class org.apache.kafka.clients.producer.internals.DefaultPartitioner
  	receive.buffer.bytes = 32768
  	reconnect.backoff.max.ms = 1000
  	reconnect.backoff.ms = 50
  	request.timeout.ms = 30000
  	retries = 2147483647
  	retry.backoff.ms = 100
  	sasl.client.callback.handler.class = null
  	sasl.jaas.config = null
  	sasl.kerberos.kinit.cmd = /usr/bin/kinit
  	sasl.kerberos.min.time.before.relogin = 60000
  	sasl.kerberos.service.name = null
  	sasl.kerberos.ticket.renew.jitter = 0.05
  	sasl.kerberos.ticket.renew.window.factor = 0.8
  	sasl.login.callback.handler.class = null
  	sasl.login.class = null
  	sasl.login.refresh.buffer.seconds = 300
  	sasl.login.refresh.min.period.seconds = 60
  	sasl.login.refresh.window.factor = 0.8
  	sasl.login.refresh.window.jitter = 0.05
  	sasl.mechanism = GSSAPI
  	security.protocol = PLAINTEXT
  	security.providers = null
  	send.buffer.bytes = 131072
  	ssl.cipher.suites = null
  	ssl.enabled.protocols = [TLSv1.2, TLSv1.3]
  	ssl.endpoint.identification.algorithm = https
  	ssl.engine.factory.class = null
  	ssl.key.password = null
  	ssl.keymanager.algorithm = SunX509
  	ssl.keystore.location = null
  	ssl.keystore.password = null
  	ssl.keystore.type = JKS
  	ssl.protocol = TLSv1.3
  	ssl.provider = null
  	ssl.secure.random.implementation = null
  	ssl.trustmanager.algorithm = PKIX
  	ssl.truststore.location = null
  	ssl.truststore.password = null
  	ssl.truststore.type = JKS
  	transaction.timeout.ms = 60000
  	transactional.id = null
  	value.serializer = class org.springframework.kafka.support.serializer.JsonSerializer
  
  INFO 1 --- [ctor-http-nio-2] o.a.k.clients.producer.KafkaProducer     : [Producer   clientId=producer-1] Closing the Kafka producer with timeoutMillis = 0 ms.
  ERROR 1 --- [ctor-http-nio-2] a.w.r.e.AbstractErrorWebExceptionHandler : [fd41eb4d-1]  500   Server Error for HTTP POST "/api/news"
  
  org.apache.kafka.common.KafkaException: Failed to construct kafka producer
  	at org.apache.kafka.clients.producer.KafkaProducer.<init>(KafkaProducer.java:441) ~[na:na]
  	Suppressed: reactor.core.publisher.FluxOnAssembly$OnAssemblyException:
  Error has been observed at the following site(s):
  	|_ checkpoint ? org.springframework.boot.actuate.metrics.web.reactive.server.MetricsWebFilter   [DefaultWebFilterChain]
  	|_ checkpoint ? HTTP POST "/api/news" [ExceptionHandlingWebHandler]
  Stack trace:
  		at org.apache.kafka.clients.producer.KafkaProducer.<init>(KafkaProducer.java:441) ~[na:na]
  		at org.apache.kafka.clients.producer.KafkaProducer.<init>(KafkaProducer.java:290) ~[na:na]
  		at org.springframework.kafka.core.DefaultKafkaProducerFactory.createRawProducer(DefaultKafkaProducerFactory.  java:729) ~[com.mycompany.producerapi.ProducerApiApplication:2.6.6]
  		at org.springframework.kafka.core.DefaultKafkaProducerFactory.createKafkaProducer(DefaultKafkaProducerFactory.  java:583) ~[com.mycompany.producerapi.ProducerApiApplication:2.6.6]
  		at org.springframework.kafka.core.DefaultKafkaProducerFactory.doCreateProducer(DefaultKafkaProducerFactory.  java:543) ~[com.mycompany.producerapi.ProducerApiApplication:2.6.6]
  		at org.springframework.kafka.core.DefaultKafkaProducerFactory.createProducer(DefaultKafkaProducerFactory.  java:518) ~[com.mycompany.producerapi.ProducerApiApplication:2.6.6]
  		at org.springframework.kafka.core.DefaultKafkaProducerFactory.createProducer(DefaultKafkaProducerFactory.  java:512) ~[com.mycompany.producerapi.ProducerApiApplication:2.6.6]
  		at org.springframework.kafka.core.KafkaTemplate.getTheProducer(KafkaTemplate.java:666) ~[com.mycompany.  producerapi.ProducerApiApplication:2.6.6]
  		at org.springframework.kafka.core.KafkaTemplate.doSend(KafkaTemplate.java:552) ~[com.mycompany.producerapi.  ProducerApiApplication:2.6.6]
  		at org.springframework.kafka.core.KafkaTemplate.send(KafkaTemplate.java:369) ~[com.mycompany.producerapi.  ProducerApiApplication:2.6.6]
  		at com.mycompany.producerapi.kafka.NewsProducer.send(NewsProducer.java:24) ~[com.mycompany.producerapi.  ProducerApiApplication:na]
  		at com.mycompany.producerapi.rest.NewsController.publishNews(NewsController.java:29) ~[com.mycompany.producerapi.  ProducerApiApplication:na]
  		at java.lang.reflect.Method.invoke(Method.java:566) ~[na:na]
  		at org.springframework.web.reactive.result.method.InvocableHandlerMethod.lambda$invoke$0(InvocableHandlerMethod.  java:146) ~[na:na]
  		at reactor.core.publisher.MonoFlatMap$FlatMapMain.onNext(MonoFlatMap.java:125) ~[com.mycompany.producerapi.  ProducerApiApplication:3.4.3]
  		at reactor.core.publisher.Operators$MonoSubscriber.complete(Operators.java:1815) ~[com.mycompany.producerapi.  ProducerApiApplication:3.4.3]
  		at reactor.core.publisher.MonoZip$ZipCoordinator.signal(MonoZip.java:251) ~[com.mycompany.producerapi.  ProducerApiApplication:3.4.3]
  		at reactor.core.publisher.MonoZip$ZipInner.onNext(MonoZip.java:336) ~[com.mycompany.producerapi.  ProducerApiApplication:3.4.3]
  		at reactor.core.publisher.MonoPeekTerminal$MonoTerminalPeekSubscriber.onNext(MonoPeekTerminal.java:180) ~[na:na]
  		at reactor.core.publisher.FluxDefaultIfEmpty$DefaultIfEmptySubscriber.onNext(FluxDefaultIfEmpty.java:100) ~[na:na]
  		at reactor.core.publisher.FluxSwitchIfEmpty$SwitchIfEmptySubscriber.onNext(FluxSwitchIfEmpty.java:73) ~[na:na]
  		at reactor.core.publisher.FluxOnErrorResume$ResumeSubscriber.onNext(FluxOnErrorResume.java:79) ~[na:na]
  		at reactor.core.publisher.Operators$MonoSubscriber.complete(Operators.java:1815) ~[com.mycompany.producerapi.  ProducerApiApplication:3.4.3]
  		at reactor.core.publisher.MonoFlatMap$FlatMapMain.onNext(MonoFlatMap.java:151) ~[com.mycompany.producerapi.  ProducerApiApplication:3.4.3]
  		at reactor.core.publisher.FluxContextWrite$ContextWriteSubscriber.onNext(FluxContextWrite.java:107) ~[na:na]
  		at reactor.core.publisher.FluxMapFuseable$MapFuseableConditionalSubscriber.onNext(FluxMapFuseable.java:295) ~  [na:na]
  		at reactor.core.publisher.FluxFilterFuseable$FilterFuseableConditionalSubscriber.onNext(FluxFilterFuseable.  java:337) ~[na:na]
  		at reactor.core.publisher.Operators$MonoSubscriber.complete(Operators.java:1815) ~[com.mycompany.producerapi.  ProducerApiApplication:3.4.3]
  		at reactor.core.publisher.MonoCollect$CollectSubscriber.onComplete(MonoCollect.java:159) ~[na:na]
  		at reactor.core.publisher.FluxMap$MapSubscriber.onComplete(FluxMap.java:142) ~[na:na]
  		at reactor.core.publisher.FluxPeek$PeekSubscriber.onComplete(FluxPeek.java:259) ~[na:na]
  		at reactor.core.publisher.FluxMap$MapSubscriber.onComplete(FluxMap.java:142) ~[na:na]
  		at reactor.netty.channel.FluxReceive.onInboundComplete(FluxReceive.java:389) ~[com.mycompany.producerapi.  ProducerApiApplication:1.0.4]
  		at reactor.netty.channel.ChannelOperations.onInboundComplete(ChannelOperations.java:396) ~[com.mycompany.  producerapi.ProducerApiApplication:1.0.4]
  		at reactor.netty.http.server.HttpServerOperations.onInboundNext(HttpServerOperations.java:555) ~[na:na]
  		at reactor.netty.channel.ChannelOperationsHandler.channelRead(ChannelOperationsHandler.java:94) ~[na:na]
  		at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:379) ~  [na:na]
  		at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:365) ~  [na:na]
  		at io.netty.channel.AbstractChannelHandlerContext.fireChannelRead(AbstractChannelHandlerContext.java:357) ~[na:na]
  		at reactor.netty.http.server.HttpTrafficHandler.channelRead(HttpTrafficHandler.java:253) ~[na:na]
  		at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:379) ~  [na:na]
  		at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:365) ~  [na:na]
  		at io.netty.channel.AbstractChannelHandlerContext.fireChannelRead(AbstractChannelHandlerContext.java:357) ~[na:na]
  		at io.netty.channel.CombinedChannelDuplexHandler$DelegatingChannelHandlerContext.fireChannelRead  (CombinedChannelDuplexHandler.java:436) ~[na:na]
  		at io.netty.handler.codec.ByteToMessageDecoder.fireChannelRead(ByteToMessageDecoder.java:324) ~[na:na]
  		at io.netty.handler.codec.ByteToMessageDecoder.channelRead(ByteToMessageDecoder.java:296) ~[na:na]
  		at io.netty.channel.CombinedChannelDuplexHandler.channelRead(CombinedChannelDuplexHandler.java:251) ~[na:na]
  		at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:379) ~  [na:na]
  		at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:365) ~  [na:na]
  		at io.netty.channel.AbstractChannelHandlerContext.fireChannelRead(AbstractChannelHandlerContext.java:357) ~[na:na]
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
  Caused by: org.apache.kafka.common.KafkaException: Could not find a public no-argument constructor for org.  springframework.kafka.support.serializer.JsonSerializer
  	at org.apache.kafka.common.utils.Utils.newInstance(Utils.java:349) ~[na:na]
  	at org.apache.kafka.common.config.AbstractConfig.getConfiguredInstance(AbstractConfig.java:377) ~[na:na]
  	at org.apache.kafka.common.config.AbstractConfig.getConfiguredInstance(AbstractConfig.java:399) ~[na:na]
  	at org.apache.kafka.clients.producer.KafkaProducer.<init>(KafkaProducer.java:374) ~[na:na]
  	at org.apache.kafka.clients.producer.KafkaProducer.<init>(KafkaProducer.java:290) ~[na:na]
  	at org.springframework.kafka.core.DefaultKafkaProducerFactory.createRawProducer(DefaultKafkaProducerFactory.  java:729) ~[com.mycompany.producerapi.ProducerApiApplication:2.6.6]
  	at org.springframework.kafka.core.DefaultKafkaProducerFactory.createKafkaProducer(DefaultKafkaProducerFactory.  java:583) ~[com.mycompany.producerapi.ProducerApiApplication:2.6.6]
  	at org.springframework.kafka.core.DefaultKafkaProducerFactory.doCreateProducer(DefaultKafkaProducerFactory.  java:543) ~[com.mycompany.producerapi.ProducerApiApplication:2.6.6]
  	at org.springframework.kafka.core.DefaultKafkaProducerFactory.createProducer(DefaultKafkaProducerFactory.java:518) ~  [com.mycompany.producerapi.ProducerApiApplication:2.6.6]
  	at org.springframework.kafka.core.DefaultKafkaProducerFactory.createProducer(DefaultKafkaProducerFactory.java:512) ~  [com.mycompany.producerapi.ProducerApiApplication:2.6.6]
  	at org.springframework.kafka.core.KafkaTemplate.getTheProducer(KafkaTemplate.java:666) ~[com.mycompany.producerapi.  ProducerApiApplication:2.6.6]
  	at org.springframework.kafka.core.KafkaTemplate.doSend(KafkaTemplate.java:552) ~[com.mycompany.producerapi.  ProducerApiApplication:2.6.6]
  	at org.springframework.kafka.core.KafkaTemplate.send(KafkaTemplate.java:369) ~[com.mycompany.producerapi.  ProducerApiApplication:2.6.6]
  	at com.mycompany.producerapi.kafka.NewsProducer.send(NewsProducer.java:24) ~[com.mycompany.producerapi.  ProducerApiApplication:na]
  	at com.mycompany.producerapi.rest.NewsController.publishNews(NewsController.java:29) ~[com.mycompany.producerapi.  ProducerApiApplication:na]
  	at java.lang.reflect.Method.invoke(Method.java:566) ~[na:na]
  	at org.springframework.web.reactive.result.method.InvocableHandlerMethod.lambda$invoke$0(InvocableHandlerMethod.  java:146) ~[na:na]
  	at reactor.core.publisher.MonoFlatMap$FlatMapMain.onNext(MonoFlatMap.java:125) ~[com.mycompany.producerapi.  ProducerApiApplication:3.4.3]
  	at reactor.core.publisher.Operators$MonoSubscriber.complete(Operators.java:1815) ~[com.mycompany.producerapi.  ProducerApiApplication:3.4.3]
  	at reactor.core.publisher.MonoZip$ZipCoordinator.signal(MonoZip.java:251) ~[com.mycompany.producerapi.  ProducerApiApplication:3.4.3]
  	at reactor.core.publisher.MonoZip$ZipInner.onNext(MonoZip.java:336) ~[com.mycompany.producerapi.  ProducerApiApplication:3.4.3]
  	at reactor.core.publisher.MonoPeekTerminal$MonoTerminalPeekSubscriber.onNext(MonoPeekTerminal.java:180) ~[na:na]
  	at reactor.core.publisher.FluxDefaultIfEmpty$DefaultIfEmptySubscriber.onNext(FluxDefaultIfEmpty.java:100) ~[na:na]
  	at reactor.core.publisher.FluxSwitchIfEmpty$SwitchIfEmptySubscriber.onNext(FluxSwitchIfEmpty.java:73) ~[na:na]
  	at reactor.core.publisher.FluxOnErrorResume$ResumeSubscriber.onNext(FluxOnErrorResume.java:79) ~[na:na]
  	at reactor.core.publisher.Operators$MonoSubscriber.complete(Operators.java:1815) ~[com.mycompany.producerapi.  ProducerApiApplication:3.4.3]
  	at reactor.core.publisher.MonoFlatMap$FlatMapMain.onNext(MonoFlatMap.java:151) ~[com.mycompany.producerapi.  ProducerApiApplication:3.4.3]
  	at reactor.core.publisher.FluxContextWrite$ContextWriteSubscriber.onNext(FluxContextWrite.java:107) ~[na:na]
  	at reactor.core.publisher.FluxMapFuseable$MapFuseableConditionalSubscriber.onNext(FluxMapFuseable.java:295) ~[na:na]
  	at reactor.core.publisher.FluxFilterFuseable$FilterFuseableConditionalSubscriber.onNext(FluxFilterFuseable.  java:337) ~[na:na]
  	at reactor.core.publisher.Operators$MonoSubscriber.complete(Operators.java:1815) ~[com.mycompany.producerapi.  ProducerApiApplication:3.4.3]
  	at reactor.core.publisher.MonoCollect$CollectSubscriber.onComplete(MonoCollect.java:159) ~[na:na]
  	at reactor.core.publisher.FluxMap$MapSubscriber.onComplete(FluxMap.java:142) ~[na:na]
  	at reactor.core.publisher.FluxPeek$PeekSubscriber.onComplete(FluxPeek.java:259) ~[na:na]
  	at reactor.core.publisher.FluxMap$MapSubscriber.onComplete(FluxMap.java:142) ~[na:na]
  	at reactor.netty.channel.FluxReceive.onInboundComplete(FluxReceive.java:389) ~[com.mycompany.producerapi.  ProducerApiApplication:1.0.4]
  	at reactor.netty.channel.ChannelOperations.onInboundComplete(ChannelOperations.java:396) ~[com.mycompany.  producerapi.ProducerApiApplication:1.0.4]
  	at reactor.netty.http.server.HttpServerOperations.onInboundNext(HttpServerOperations.java:555) ~[na:na]
  	at reactor.netty.channel.ChannelOperationsHandler.channelRead(ChannelOperationsHandler.java:94) ~[na:na]
  	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:379) ~[na:na]
  	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:365) ~[na:na]
  	at io.netty.channel.AbstractChannelHandlerContext.fireChannelRead(AbstractChannelHandlerContext.java:357) ~[na:na]
  	at reactor.netty.http.server.HttpTrafficHandler.channelRead(HttpTrafficHandler.java:253) ~[na:na]
  	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:379) ~[na:na]
  	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:365) ~[na:na]
  	at io.netty.channel.AbstractChannelHandlerContext.fireChannelRead(AbstractChannelHandlerContext.java:357) ~[na:na]
  	at io.netty.channel.CombinedChannelDuplexHandler$DelegatingChannelHandlerContext.fireChannelRead  (CombinedChannelDuplexHandler.java:436) ~[na:na]
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

### springboot-consumer-api issues

- Unable to run in **Development Mode**, **Docker in JVM Mode** and **Docker in Native Mode**
  ```
  ERROR 26183 --- [           main] o.s.boot.SpringApplication               : Application run failed
  
  org.springframework.beans.factory.BeanCreationException: Error creating bean with name 'newsConsumer' defined in   class path resource [com/mycompany/consumerapi/kafka/NewsConsumer.class]: Initialization of bean failed; nested   exception is java.lang.NullPointerException
  	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.doCreateBean  (AbstractAutowireCapableBeanFactory.java:610) ~[spring-beans-5.3.4.jar:5.3.4]
  	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.createBean  (AbstractAutowireCapableBeanFactory.java:524) ~[spring-beans-5.3.4.jar:5.3.4]
  	at org.springframework.beans.factory.support.AbstractBeanFactory.lambda$doGetBean$0(AbstractBeanFactory.java:335) ~  [spring-beans-5.3.4.jar:5.3.4]
  	at org.springframework.beans.factory.support.DefaultSingletonBeanRegistry.getSingleton(DefaultSingletonBeanRegistry.  java:234) ~[spring-beans-5.3.4.jar:5.3.4]
  	at org.springframework.beans.factory.support.AbstractBeanFactory.doGetBean(AbstractBeanFactory.java:333) ~  [spring-beans-5.3.4.jar:5.3.4]
  	at org.springframework.beans.factory.support.AbstractBeanFactory.getBean(AbstractBeanFactory.java:208) ~  [spring-beans-5.3.4.jar:5.3.4]
  	at org.springframework.beans.factory.support.DefaultListableBeanFactory.preInstantiateSingletons  (DefaultListableBeanFactory.java:944) ~[spring-beans-5.3.4.jar:5.3.4]
  	at org.springframework.context.support.AbstractApplicationContext.finishBeanFactoryInitialization  (AbstractApplicationContext.java:917) ~[spring-context-5.3.4.jar:5.3.4]
  	at org.springframework.context.support.AbstractApplicationContext.refresh(AbstractApplicationContext.java:582) ~  [spring-context-5.3.4.jar:5.3.4]
  	at org.springframework.boot.web.reactive.context.ReactiveWebServerApplicationContext.refresh  (ReactiveWebServerApplicationContext.java:63) ~[spring-boot-2.4.3.jar:2.4.3]
  	at org.springframework.boot.SpringApplication.refresh(SpringApplication.java:767) ~[spring-boot-2.4.3.jar:2.4.3]
  	at org.springframework.boot.SpringApplication.refresh(SpringApplication.java:759) ~[spring-boot-2.4.3.jar:2.4.3]
  	at org.springframework.boot.SpringApplication.refreshContext(SpringApplication.java:426) ~[spring-boot-2.4.3.jar:2.  4.3]
  	at org.springframework.boot.SpringApplication.run(SpringApplication.java:326) ~[spring-boot-2.4.3.jar:2.4.3]
  	at org.springframework.boot.SpringApplication.run(SpringApplication.java:1311) ~[spring-boot-2.4.3.jar:2.4.3]
  	at org.springframework.boot.SpringApplication.run(SpringApplication.java:1300) ~[spring-boot-2.4.3.jar:2.4.3]
  	at com.mycompany.consumerapi.ConsumerApiApplication.main(ConsumerApiApplication.java:10) ~[classes/:na]
  Caused by: java.lang.NullPointerException: null
  	at org.springframework.kafka.annotation.KafkaListenerAnnotationBeanPostProcessor.resolveExpression  (KafkaListenerAnnotationBeanPostProcessor.java:735) ~[spring-kafka-2.6.6.jar:2.6.6]
  	at org.springframework.kafka.annotation.KafkaListenerAnnotationBeanPostProcessor.resolveExpressionAsString  (KafkaListenerAnnotationBeanPostProcessor.java:689) ~[spring-kafka-2.6.6.jar:2.6.6]
  	at org.springframework.kafka.annotation.KafkaListenerAnnotationBeanPostProcessor.getEndpointGroupId  (KafkaListenerAnnotationBeanPostProcessor.java:507) ~[spring-kafka-2.6.6.jar:2.6.6]
  	at org.springframework.kafka.annotation.KafkaListenerAnnotationBeanPostProcessor.processListener  (KafkaListenerAnnotationBeanPostProcessor.java:429) ~[spring-kafka-2.6.6.jar:2.6.6]
  	at org.springframework.kafka.annotation.KafkaListenerAnnotationBeanPostProcessor.processKafkaListener  (KafkaListenerAnnotationBeanPostProcessor.java:382) ~[spring-kafka-2.6.6.jar:2.6.6]
  	at org.springframework.kafka.annotation.KafkaListenerAnnotationBeanPostProcessor.postProcessAfterInitialization  (KafkaListenerAnnotationBeanPostProcessor.java:310) ~[spring-kafka-2.6.6.jar:2.6.6]
  	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.  applyBeanPostProcessorsAfterInitialization(AbstractAutowireCapableBeanFactory.java:437) ~[spring-beans-5.3.4.jar:5.  3.4]
  	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.initializeBean  (AbstractAutowireCapableBeanFactory.java:1790) ~[spring-beans-5.3.4.jar:5.3.4]
  	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.doCreateBean  (AbstractAutowireCapableBeanFactory.java:602) ~[spring-beans-5.3.4.jar:5.3.4]
  	... 16 common frames omitted
	```
