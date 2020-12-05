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
      ./mvnw clean spring-boot:run -Dspring-boot.run.jvmArguments="-Dserver.port=8081" --projects consumer-api
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

    - Package the application `jar` file
      ```
      ./mvnw clean package --projects producer-api
      ```

    - Run the script below to build the Docker image
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

    - Package the application `jar` file
      ```
      ./mvnw clean package --projects consumer-api
      ```

    - Run the script below to build the Docker image
      ```
      cd consumer-api && ./docker-build.sh && cd ..
      ```

    - Run the following command to start the Docker container
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

    - Package the application `jar` file
      ```
      ./mvnw clean package --projects producer-api
      ```

    - Run the script below to build the Docker image
      ```
      cd producer-api && ./docker-build.sh native && cd ..
      ```

    - Run the following command to start the Docker container
      ```
      docker run --rm --name springboot-producer-api-native -p 9105:8080 \
        -e KAFKA_HOST=kafka -e KAFKA_PORT=9092 --network producer-consumer_default \
        docker.mycompany.com/springboot-producer-api-native:1.0.0
      ```

  - **consumer-api**

    - In another terminal, make sure you are inside `graalvm-quarkus-micronaut-springboot/producer-consumer/springboot-producer-consumer` folder

    - Package the application `jar` file
      ```
      ./mvnw clean package --projects consumer-api
      ```

    - Run the script below to build the Docker image
      ```
      cd consumer-api && ./docker-build.sh native && cd ..
      ```

    - Run the following command to start the Docker container
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

- Unable to run `springboot-producer-api-native`. It starts up fine but, when a JSON message is published an exception is thrown.
    ```
    .   ____          _            __ _ _
   /\\ / ___'_ __ _ _(_)_ __  __ _ \ \ \ \
  ( ( )\___ | '_ | '_| | '_ \/ _` | \ \ \ \
   \\/  ___)| |_)| | | | | || (_| |  ) ) ) )
    '  |____| .__|_| |_|_| |_\__, | / / / /
   =========|_|==============|___/=/_/_/_/
   :: Spring Boot ::                (v2.4.0)
  
  2020-12-05 14:04:51.040  INFO 1 --- [           main] c.m.producerapi.ProducerApiApplication   : Starting ProducerApiApplication using Java 11.0.9 on   5799bcb3764e with PID 1 (/workspace/com.mycompany.producerapi.ProducerApiApplication started by cnb in /workspace)
  2020-12-05 14:04:51.044  INFO 1 --- [           main] c.m.producerapi.ProducerApiApplication   : No active profile set, falling back to default profiles:   default
  2020-12-05 14:04:51.360  WARN 1 --- [           main] i.m.c.i.binder.jvm.JvmGcMetrics          : GC notifications will not be available because   MemoryPoolMXBeans are not provided by the JVM
  2020-12-05 14:04:51.366  INFO 1 --- [           main] o.s.b.a.e.web.EndpointLinksResolver      : Exposing 5 endpoint(s) beneath base path ''
  2020-12-05 14:04:51.395  INFO 1 --- [           main] o.a.k.clients.admin.AdminClientConfig    : AdminClientConfig values:
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
  
  2020-12-05 14:04:51.410  WARN 1 --- [           main] o.a.kafka.common.utils.AppInfoParser     : Error while loading kafka-version.properties: inStream   parameter is null
  2020-12-05 14:04:51.410  INFO 1 --- [           main] o.a.kafka.common.utils.AppInfoParser     : Kafka version: unknown
  2020-12-05 14:04:51.410  INFO 1 --- [           main] o.a.kafka.common.utils.AppInfoParser     : Kafka commitId: unknown
  2020-12-05 14:04:51.410  INFO 1 --- [           main] o.a.kafka.common.utils.AppInfoParser     : Kafka startTimeMs: 1607177091409
  2020-12-05 14:04:51.586  INFO 1 --- [           main] o.s.b.web.embedded.netty.NettyWebServer  : Netty started on port(s): 8080
  2020-12-05 14:04:51.588  INFO 1 --- [           main] c.m.producerapi.ProducerApiApplication   : Started ProducerApiApplication in 0.692 seconds (JVM running   for 0.73)
  Dec 05, 2020 2:06:53 PM com.fasterxml.jackson.databind.ext.Java7Handlers <clinit>
  WARNING: Unable to load JDK7 types (java.nio.file.Path): no Java7 type support added
  2020-12-05 14:06:53.501  INFO 1 --- [ctor-http-nio-2] c.m.producerapi.kafka.NewsProducer       : Sending News 'News(id=9ff5be9a-ff9b-483b-aaa4-4ca8dcffec58,   source=Spring Boot Blog, title=Spring Boot Framework & GraalVM)' to topic 'springboot.news.json'
  2020-12-05 14:06:53.502  INFO 1 --- [ctor-http-nio-2] o.a.k.clients.producer.ProducerConfig    : ProducerConfig values:
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
  
  2020-12-05 14:06:53.504  INFO 1 --- [ctor-http-nio-2] o.a.k.clients.producer.KafkaProducer     : [Producer clientId=producer-1] Closing the Kafka producer   with timeoutMillis = 0 ms.
  2020-12-05 14:06:53.510 ERROR 1 --- [ctor-http-nio-2] a.w.r.e.AbstractErrorWebExceptionHandler : [5e19447d-1]  500 Server Error for HTTP POST "/api/news"
  
  org.apache.kafka.common.KafkaException: Failed to construct kafka producer
  	at org.apache.kafka.clients.producer.KafkaProducer.<init>(KafkaProducer.java:441) ~[na:na]
  Caused by: org.apache.kafka.common.KafkaException: Could not find a public no-argument constructor for org.springframework.kafka.support.serializer.  JsonSerializer
  	at org.apache.kafka.common.utils.Utils.newInstance(Utils.java:349) ~[na:na]
  	at org.apache.kafka.common.config.AbstractConfig.getConfiguredInstance(AbstractConfig.java:377) ~[na:na]
  	at org.apache.kafka.common.config.AbstractConfig.getConfiguredInstance(AbstractConfig.java:399) ~[na:na]
  	at org.apache.kafka.clients.producer.KafkaProducer.<init>(KafkaProducer.java:374) ~[na:na]
  	at org.apache.kafka.clients.producer.KafkaProducer.<init>(KafkaProducer.java:290) ~[na:na]
  	at org.springframework.kafka.core.DefaultKafkaProducerFactory.createRawProducer(DefaultKafkaProducerFactory.java:701) ~[com.mycompany.producerapi.  ProducerApiApplication:2.6.3]
  	at org.springframework.kafka.core.DefaultKafkaProducerFactory.createKafkaProducer(DefaultKafkaProducerFactory.java:558) ~[com.mycompany.producerapi.  ProducerApiApplication:2.6.3]
  	at org.springframework.kafka.core.DefaultKafkaProducerFactory.doCreateProducer(DefaultKafkaProducerFactory.java:535) ~[com.mycompany.producerapi.  ProducerApiApplication:2.6.3]
  	at org.springframework.kafka.core.DefaultKafkaProducerFactory.createProducer(DefaultKafkaProducerFactory.java:492) ~[com.mycompany.producerapi.  ProducerApiApplication:2.6.3]
  	at org.springframework.kafka.core.DefaultKafkaProducerFactory.createProducer(DefaultKafkaProducerFactory.java:486) ~[com.mycompany.producerapi.  ProducerApiApplication:2.6.3]
  	at org.springframework.kafka.core.KafkaTemplate.getTheProducer(KafkaTemplate.java:666) ~[com.mycompany.producerapi.ProducerApiApplication:2.6.3]
  	at org.springframework.kafka.core.KafkaTemplate.doSend(KafkaTemplate.java:552) ~[com.mycompany.producerapi.ProducerApiApplication:2.6.3]
  	at org.springframework.kafka.core.KafkaTemplate.send(KafkaTemplate.java:369) ~[com.mycompany.producerapi.ProducerApiApplication:2.6.3]
  	at com.mycompany.producerapi.kafka.NewsProducer.send(NewsProducer.java:24) ~[com.mycompany.producerapi.ProducerApiApplication:na]
  	at com.mycompany.producerapi.rest.NewsController.publishNews(NewsController.java:29) ~[com.mycompany.producerapi.ProducerApiApplication:na]
  	at java.lang.reflect.Method.invoke(Method.java:566) ~[na:na]
  	at org.springframework.web.reactive.result.method.InvocableHandlerMethod.lambda$invoke$0(InvocableHandlerMethod.java:146) ~[na:na]
  	at reactor.core.publisher.MonoFlatMap$FlatMapMain.onNext(MonoFlatMap.java:125) ~[com.mycompany.producerapi.ProducerApiApplication:3.4.0]
  	at reactor.core.publisher.Operators$MonoSubscriber.complete(Operators.java:1784) ~[com.mycompany.producerapi.ProducerApiApplication:3.4.0]
  	at reactor.core.publisher.MonoZip$ZipCoordinator.signal(MonoZip.java:251) ~[com.mycompany.producerapi.ProducerApiApplication:3.4.0]
  	at reactor.core.publisher.MonoZip$ZipInner.onNext(MonoZip.java:336) ~[com.mycompany.producerapi.ProducerApiApplication:3.4.0]
  	at reactor.core.publisher.MonoPeekTerminal$MonoTerminalPeekSubscriber.onNext(MonoPeekTerminal.java:180) ~[na:na]
  	at reactor.core.publisher.FluxDefaultIfEmpty$DefaultIfEmptySubscriber.onNext(FluxDefaultIfEmpty.java:99) ~[na:na]
  	at reactor.core.publisher.FluxSwitchIfEmpty$SwitchIfEmptySubscriber.onNext(FluxSwitchIfEmpty.java:73) ~[na:na]
  	at reactor.core.publisher.FluxOnErrorResume$ResumeSubscriber.onNext(FluxOnErrorResume.java:79) ~[na:na]
  	at reactor.core.publisher.Operators$MonoSubscriber.complete(Operators.java:1784) ~[com.mycompany.producerapi.ProducerApiApplication:3.4.0]
  	at reactor.core.publisher.MonoFlatMap$FlatMapMain.onNext(MonoFlatMap.java:151) ~[com.mycompany.producerapi.ProducerApiApplication:3.4.0]
  	at reactor.core.publisher.FluxContextWrite$ContextWriteSubscriber.onNext(FluxContextWrite.java:107) ~[na:na]
  	at reactor.core.publisher.FluxMapFuseable$MapFuseableConditionalSubscriber.onNext(FluxMapFuseable.java:295) ~[na:na]
  	at reactor.core.publisher.FluxFilterFuseable$FilterFuseableConditionalSubscriber.onNext(FluxFilterFuseable.java:337) ~[na:na]
  	at reactor.core.publisher.Operators$MonoSubscriber.complete(Operators.java:1784) ~[com.mycompany.producerapi.ProducerApiApplication:3.4.0]
  	at reactor.core.publisher.MonoCollect$CollectSubscriber.onComplete(MonoCollect.java:159) ~[na:na]
  	at reactor.core.publisher.FluxMap$MapSubscriber.onComplete(FluxMap.java:142) ~[na:na]
  	at reactor.core.publisher.FluxPeek$PeekSubscriber.onComplete(FluxPeek.java:259) ~[na:na]
  	at reactor.core.publisher.FluxMap$MapSubscriber.onComplete(FluxMap.java:142) ~[na:na]
  	at reactor.netty.channel.FluxReceive.onInboundComplete(FluxReceive.java:383) ~[com.mycompany.producerapi.ProducerApiApplication:1.0.1]
  	at reactor.netty.channel.ChannelOperations.onInboundComplete(ChannelOperations.java:396) ~[com.mycompany.producerapi.ProducerApiApplication:1.0.1]
  	at reactor.netty.http.server.HttpServerOperations.onInboundNext(HttpServerOperations.java:540) ~[na:na]
  	at reactor.netty.channel.ChannelOperationsHandler.channelRead(ChannelOperationsHandler.java:94) ~[com.mycompany.producerapi.ProducerApiApplication:1.0.1]
  	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:379) ~[com.mycompany.producerapi.  ProducerApiApplication:4.1.54.Final]
  	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:365) ~[com.mycompany.producerapi.  ProducerApiApplication:4.1.54.Final]
  	at io.netty.channel.AbstractChannelHandlerContext.fireChannelRead(AbstractChannelHandlerContext.java:357) ~[com.mycompany.producerapi.  ProducerApiApplication:4.1.54.Final]
  	at reactor.netty.http.server.HttpTrafficHandler.channelRead(HttpTrafficHandler.java:229) ~[com.mycompany.producerapi.ProducerApiApplication:1.0.1]
  	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:379) ~[com.mycompany.producerapi.  ProducerApiApplication:4.1.54.Final]
  	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:365) ~[com.mycompany.producerapi.  ProducerApiApplication:4.1.54.Final]
  	at io.netty.channel.AbstractChannelHandlerContext.fireChannelRead(AbstractChannelHandlerContext.java:357) ~[com.mycompany.producerapi.  ProducerApiApplication:4.1.54.Final]
  	at io.netty.channel.CombinedChannelDuplexHandler$DelegatingChannelHandlerContext.fireChannelRead(CombinedChannelDuplexHandler.java:436) ~[na:na]
  	at io.netty.handler.codec.ByteToMessageDecoder.fireChannelRead(ByteToMessageDecoder.java:324) ~[na:na]
  	at io.netty.handler.codec.ByteToMessageDecoder.channelRead(ByteToMessageDecoder.java:296) ~[na:na]
  	at io.netty.channel.CombinedChannelDuplexHandler.channelRead(CombinedChannelDuplexHandler.java:251) ~[com.mycompany.producerapi.ProducerApiApplication:4.1.  54.Final]
  	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:379) ~[com.mycompany.producerapi.  ProducerApiApplication:4.1.54.Final]
  	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:365) ~[com.mycompany.producerapi.  ProducerApiApplication:4.1.54.Final]
  	at io.netty.channel.AbstractChannelHandlerContext.fireChannelRead(AbstractChannelHandlerContext.java:357) ~[com.mycompany.producerapi.  ProducerApiApplication:4.1.54.Final]
  	at io.netty.channel.DefaultChannelPipeline$HeadContext.channelRead(DefaultChannelPipeline.java:1410) ~[com.mycompany.producerapi.ProducerApiApplication:4.1.  54.Final]
  	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:379) ~[com.mycompany.producerapi.  ProducerApiApplication:4.1.54.Final]
  	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:365) ~[com.mycompany.producerapi.  ProducerApiApplication:4.1.54.Final]
  	at io.netty.channel.DefaultChannelPipeline.fireChannelRead(DefaultChannelPipeline.java:919) ~[com.mycompany.producerapi.ProducerApiApplication:4.1.54.Final]
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

- Unable to run `springboot-consumer-api-native`.
  ```
    .   ____          _            __ _ _
   /\\ / ___'_ __ _ _(_)_ __  __ _ \ \ \ \
  ( ( )\___ | '_ | '_| | '_ \/ _` | \ \ \ \
   \\/  ___)| |_)| | | | | || (_| |  ) ) ) )
    '  |____| .__|_| |_|_| |_\__, | / / / /
   =========|_|==============|___/=/_/_/_/
   :: Spring Boot ::                (v2.4.0)
  
  2020-12-05 14:05:32.912  INFO 1 --- [           main] c.m.consumerapi.ConsumerApiApplication   : Starting ConsumerApiApplication using Java 11.0.9 on   6dec4b549c36 with PID 1 (/workspace/com.mycompany.consumerapi.ConsumerApiApplication started by cnb in /workspace)
  2020-12-05 14:05:32.913  INFO 1 --- [           main] c.m.consumerapi.ConsumerApiApplication   : No active profile set, falling back to default profiles:   default
  2020-12-05 14:05:33.017  WARN 1 --- [           main] onfigReactiveWebServerApplicationContext : Exception encountered during context initialization -   cancelling refresh attempt: org.springframework.beans.factory.BeanCreationException: Error creating bean with name 'newsConsumer' defined in class path   resource [com/mycompany/consumerapi/kafka/NewsConsumer.class]: Initialization of bean failed; nested exception is java.lang.NullPointerException
  2020-12-05 14:05:33.020  INFO 1 --- [           main] ConditionEvaluationReportLoggingListener :
  
  Error starting ApplicationContext. To display the conditions report re-run your application with 'debug' enabled.
  2020-12-05 14:05:33.021 ERROR 1 --- [           main] o.s.boot.SpringApplication               : Application run failed
  
  org.springframework.beans.factory.BeanCreationException: Error creating bean with name 'newsConsumer' defined in class path resource [com/mycompany/  consumerapi/kafka/NewsConsumer.class]: Initialization of bean failed; nested exception is java.lang.NullPointerException
  	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.doCreateBean(AbstractAutowireCapableBeanFactory.java:617) ~[na:na]
  	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.createBean(AbstractAutowireCapableBeanFactory.java:531) ~[na:na]
  	at org.springframework.beans.factory.support.AbstractBeanFactory.lambda$doGetBean$0(AbstractBeanFactory.java:335) ~[na:na]
  	at org.springframework.beans.factory.support.DefaultSingletonBeanRegistry.getSingleton(DefaultSingletonBeanRegistry.java:234) ~[na:na]
  	at org.springframework.beans.factory.support.AbstractBeanFactory.doGetBean(AbstractBeanFactory.java:333) ~[na:na]
  	at org.springframework.beans.factory.support.AbstractBeanFactory.getBean(AbstractBeanFactory.java:208) ~[na:na]
  	at org.springframework.beans.factory.support.DefaultListableBeanFactory.preInstantiateSingletons(DefaultListableBeanFactory.java:944) ~[na:na]
  	at org.springframework.context.support.AbstractApplicationContext.finishBeanFactoryInitialization(AbstractApplicationContext.java:925) ~[na:na]
  	at org.springframework.context.support.AbstractApplicationContext.refresh(AbstractApplicationContext.java:588) ~[na:na]
  	at org.springframework.boot.web.reactive.context.ReactiveWebServerApplicationContext.refresh(ReactiveWebServerApplicationContext.java:63) ~[na:na]
  	at org.springframework.boot.SpringApplication.refresh(SpringApplication.java:767) ~[na:na]
  	at org.springframework.boot.SpringApplication.refresh(SpringApplication.java:759) ~[na:na]
  	at org.springframework.boot.SpringApplication.refreshContext(SpringApplication.java:426) ~[na:na]
  	at org.springframework.boot.SpringApplication.run(SpringApplication.java:326) ~[na:na]
  	at org.springframework.boot.SpringApplication.run(SpringApplication.java:1309) ~[na:na]
  	at org.springframework.boot.SpringApplication.run(SpringApplication.java:1298) ~[na:na]
  	at com.mycompany.consumerapi.ConsumerApiApplication.main(ConsumerApiApplication.java:10) ~[com.mycompany.consumerapi.ConsumerApiApplication:na]
  Caused by: java.lang.NullPointerException: null
  	at org.springframework.kafka.annotation.KafkaListenerAnnotationBeanPostProcessor.resolveExpression(KafkaListenerAnnotationBeanPostProcessor.java:751) ~[com.  mycompany.consumerapi.ConsumerApiApplication:2.6.3]
  	at org.springframework.kafka.annotation.KafkaListenerAnnotationBeanPostProcessor.resolveExpressionAsString(KafkaListenerAnnotationBeanPostProcessor.  java:705) ~[com.mycompany.consumerapi.ConsumerApiApplication:2.6.3]
  	at org.springframework.kafka.annotation.KafkaListenerAnnotationBeanPostProcessor.getEndpointGroupId(KafkaListenerAnnotationBeanPostProcessor.java:504) ~[com.  mycompany.consumerapi.ConsumerApiApplication:2.6.3]
  	at org.springframework.kafka.annotation.KafkaListenerAnnotationBeanPostProcessor.processListener(KafkaListenerAnnotationBeanPostProcessor.java:426) ~[com.  mycompany.consumerapi.ConsumerApiApplication:2.6.3]
  	at org.springframework.kafka.annotation.KafkaListenerAnnotationBeanPostProcessor.processKafkaListener(KafkaListenerAnnotationBeanPostProcessor.java:379) ~  [com.mycompany.consumerapi.ConsumerApiApplication:2.6.3]
  	at org.springframework.kafka.annotation.KafkaListenerAnnotationBeanPostProcessor.postProcessAfterInitialization(KafkaListenerAnnotationBeanPostProcessor.  java:307) ~[com.mycompany.consumerapi.ConsumerApiApplication:2.6.3]
  	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.applyBeanPostProcessorsAfterInitialization  (AbstractAutowireCapableBeanFactory.java:444) ~[na:na]
  	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.initializeBean(AbstractAutowireCapableBeanFactory.java:1792) ~[na:na]
  	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.doCreateBean(AbstractAutowireCapableBeanFactory.java:609) ~[na:na]
  	... 16 common frames omitted
  ```