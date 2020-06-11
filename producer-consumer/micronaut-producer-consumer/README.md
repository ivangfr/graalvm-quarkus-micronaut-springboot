# graalvm-quarkus-micronaut-springboot
## `> producer-consumer > micronaut-producer-consumer`

The goal of this project is to implement two [`Micronaut`](https://micronaut.io/) applications: one that _produces_ messages to a [`Kafka`](https://kafka.apache.org/) topic and another that _consumes_ those messages. Besides, we will use `GraalVM`'s `native-image` tool to generate the native image of the applications.

## Applications

- **producer-api**

  `Micronaut` Web Java application that exposes one endpoint at which users can post `news`. Once a request is made, `producer-api` pushes a message about the `news` to `Kafka`.

  It has the following endpoint:
  ```
  POST /api/news {"source": "...", "title": "..."}
  ```

- **consumer-api**

  `Micronaut` Web Java application that listens to messages (published by the `producer-api`) and logs it.

## Running applications

> **Note:** `Kafka`, `Zookeeper` and other containers present in `docker-compose.yml` file must be up and running as explained [here](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/producer-consumer#start-environment)

### Development Mode

- **Startup**

  - **producer-api**

    - Open a terminal and navigate to `graalvm-quarkus-micronaut-springboot/producer-consumer/micronaut-producer-consumer` folder

    - Run the command below
      ```
      ./gradlew producer-api:clean producer-api:run
      ```

  - **consumer-api**

    - Open another terminal and navigate to `graalvm-quarkus-micronaut-springboot/producer-consumer/micronaut-producer-consumer` folder

    - Run the command below
      ```
      export MICRONAUT_SERVER_PORT=8081 && ./gradlew consumer-api:clean consumer-api:run
      ```

- **Simple Test**

  - In a new terminal, post a news
    ```
    curl -i -X POST localhost:8080/api/news -H 'Content-Type: application/json' \
      -d '{ "source":"Micronaut Blog", "title":"Dev Micronaut Framework" }'
    ```

  - See `producer-api` and `consumer-api` logs

- **Shutdown**

  Press `Ctrl+C` in `producer-api` and `consumer-api` terminals

### Docker in JVM Mode

- **Startup**

  - **producer-api**

    - In a terminal, make sure you are inside `graalvm-quarkus-micronaut-springboot/producer-consumer/micronaut-producer-consumer` folder

    - Package the application `jar` file
      ```
      ./gradlew producer-api:clean producer-api:assemble 
      ```

    - Run the script below to build the Docker image
      ```
      cd producer-api && ./docker-build.sh && cd ..
      ```

    - Run the following command to start the Docker container
      ```
      docker run --rm --name micronaut-producer-api-jvm \
        -p 9102:8080 -e KAFKA_HOST=kafka -e ZIPKIN_HOST=zipkin \
        --network producer-consumer_default \
        docker.mycompany.com/micronaut-producer-api-jvm:1.0.0
      ```

  - **consumer-api**

    - In another terminal, make sure you are inside `graalvm-quarkus-micronaut-springboot/producer-consumer/micronaut-producer-consumer` folder

    - Package the application `jar` file
      ```
      ./gradlew consumer-api:clean consumer-api:assemble 
      ```

    - Run the script below to build the Docker image
      ```
      cd consumer-api && ./docker-build.sh && cd ..
      ```

    - Run the following command to start the Docker container
      ```
      docker run --rm --name micronaut-consumer-api-jvm \
        -p 9107:8080 -e KAFKA_HOST=kafka -e ZIPKIN_HOST=zipkin \
        --network producer-consumer_default \
        docker.mycompany.com/micronaut-consumer-api-jvm:1.0.0
      ```

- **Simple Test**

  - In a new terminal, post a news
    ```
    curl -i -X POST localhost:9102/api/news -H 'Content-Type: application/json' \
      -d '{ "source":"Micronaut Blog", "title":"Micronaut Framework" }'
    ```

  - See `producer-api` and `consumer-api` Docker logs

- **Shutdown**

  Press `Ctrl+C` in `producer-api` and `consumer-api` terminals

### Docker in Native Mode

- **Startup**

  - **producer-api**

    - In a terminal, make sure you are inside `graalvm-quarkus-micronaut-springboot/producer-consumer/micronaut-producer-consumer` folder

    - Package the application `jar` file
      ```
      ./gradlew producer-api:clean producer-api:assemble
      ```

    - Run the script below to build the Docker image
      ```
      cd producer-api && ./docker-build.sh native && cd ..
      ```

    - Run the following command to start the Docker container
      ```
      docker run --rm --name micronaut-producer-api-native \
        -p 9103:8080 -e KAFKA_HOST=kafka -e ZIPKIN_HOST=zipkin \
        --network producer-consumer_default \
        docker.mycompany.com/micronaut-producer-api-native:1.0.0
      ```

  - **consumer-api**

    - In another terminal, make sure you are inside `graalvm-quarkus-micronaut-springboot/producer-consumer/micronaut-producer-consumer` folder

    - Package the application `jar` file
      ```
      ./gradlew consumer-api:clean consumer-api:assemble 
      ```

    - Run the script below to build the Docker image
      ```
      cd consumer-api && ./docker-build.sh native && cd ..
      ```

    - Run the following command to start the Docker container
      ```
      docker run --rm --name micronaut-consumer-api-native \
        -p 9108:8080 -e KAFKA_HOST=kafka -e ZIPKIN_HOST=zipkin \
        --network producer-consumer_default \
        docker.mycompany.com/micronaut-consumer-api-native:1.0.0
      ```

- **Simple Test**

  - In a new terminal, post a news
    ```
    curl -i -X POST localhost:9103/api/news -H 'Content-Type: application/json' \
      -d '{ "source":"Micronaut Blog", "title":"Micronaut Framework & GraalVM" }'
    ```

  - See `producer-api` and `consumer-api` Docker logs

- **Shutdown**

  To stop and remove `producer-api` and `consumer-api` Docker containers, run in a terminal
  ```
  docker stop micronaut-producer-api-native micronaut-consumer-api-native
  ```

## Issues

- Unable to update `micronaut-producer-api-native` to `Java 11`. The image compiles successfully. However, when the application receives the first request, the error below appears. The same doesn't occur when application is configured with Java version `1.8` in `build.gradle` and uses `oracle/graalvm-ce:20.0.0-java8` for natine image.

  ```
  ...
  16:59:23.631 [kafka-producer-network-thread | producer-1] WARN  o.a.k.c.producer.internals.Sender - [Producer clientId=producer-1] Got error produce response with correlation id 3 on topic-partition micronaut.news.json-0, retrying (2147483646 attempts left). Error: CORRUPT_MESSAGE
  16:59:23.736 [kafka-producer-network-thread | producer-1] WARN  o.a.k.c.producer.internals.Sender - [Producer clientId=producer-1] Got error produce response with correlation id 4 on topic-partition micronaut.news.json-0, retrying (2147483645 attempts left). Error: CORRUPT_MESSAGE
  16:59:23.842 [kafka-producer-network-thread | producer-1] WARN  o.a.k.c.producer.internals.Sender - [Producer clientId=producer-1] Got error produce response with correlation id 5 on topic-partition micronaut.news.json-0, retrying (2147483644 attempts left). Error: CORRUPT_MESSAGE
  ...
  ```

- Unable to update `micronaut-consumer-api-native` to `Java 11`. The image compiles successfully. However, when the application listens the first message, the error below appears. The same doesn't occur when application is configured with Java version `1.8` in `build.gradle` and uses `oracle/graalvm-ce:20.0.0-java8` for natine image.
  ```
  ...
  18:34:43.409 [pool-3-thread-1] ERROR i.m.c.k.e.KafkaListenerExceptionHandler - Kafka consumer [com.mycompany.consumerapi.kafka.  NewsListener@7f6b41801280] produced error: Received exception when fetching the next record from micronaut.news.json-0. If needed, please   seek past the record to continue consumption.
  org.apache.kafka.common.KafkaException: Received exception when fetching the next record from micronaut.news.json-0. If needed, please seek   past the record to continue consumption.
  	at org.apache.kafka.clients.consumer.internals.Fetcher$CompletedFetch.fetchRecords(Fetcher.java:1519)
  	at org.apache.kafka.clients.consumer.internals.Fetcher$CompletedFetch.access$1700(Fetcher.java:1374)
  	at org.apache.kafka.clients.consumer.internals.Fetcher.fetchRecords(Fetcher.java:676)
  	at org.apache.kafka.clients.consumer.internals.Fetcher.fetchedRecords(Fetcher.java:631)
  	at org.apache.kafka.clients.consumer.KafkaConsumer.pollForFetches(KafkaConsumer.java:1282)
  	at org.apache.kafka.clients.consumer.KafkaConsumer.poll(KafkaConsumer.java:1240)
  	at org.apache.kafka.clients.consumer.KafkaConsumer.poll(KafkaConsumer.java:1211)
  	at io.micronaut.configuration.kafka.processor.KafkaConsumerProcessor.lambda$process$7(KafkaConsumerProcessor.java:393)
  	at io.micrometer.core.instrument.composite.CompositeTimer.record(CompositeTimer.java:79)
  	at io.micrometer.core.instrument.Timer.lambda$wrap$0(Timer.java:144)
  	at java.util.concurrent.Executors$RunnableAdapter.call(Executors.java:515)
  	at java.util.concurrent.FutureTask.run(FutureTask.java:264)
  	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1128)
  	at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:628)
  	at java.lang.Thread.run(Thread.java:834)
  	at com.oracle.svm.core.thread.JavaThreads.threadStartRoutine(JavaThreads.java:527)
  	at com.oracle.svm.core.posix.thread.PosixJavaThreads.pthreadStartRoutine(PosixJavaThreads.java:193)
  Caused by: org.apache.kafka.common.KafkaException: Record batch for partition micronaut.news.json-0 at offset 0 is invalid, cause: Record is   corrupt (stored crc = 3058354739, computed crc = 1282275124)
  	at org.apache.kafka.clients.consumer.internals.Fetcher$CompletedFetch.maybeEnsureValid(Fetcher.java:1432)
  	at org.apache.kafka.clients.consumer.internals.Fetcher$CompletedFetch.nextFetchedRecord(Fetcher.java:1476)
  	at org.apache.kafka.clients.consumer.internals.Fetcher$CompletedFetch.fetchRecords(Fetcher.java:1533)
  	at org.apache.kafka.clients.consumer.internals.Fetcher$CompletedFetch.access$1700(Fetcher.java:1374)
  	at org.apache.kafka.clients.consumer.internals.Fetcher.fetchRecords(Fetcher.java:676)
  	at org.apache.kafka.clients.consumer.internals.Fetcher.fetchedRecords(Fetcher.java:631)
  	at org.apache.kafka.clients.consumer.KafkaConsumer.pollForFetches(KafkaConsumer.java:1313)
  	... 12 common frames omitted
    ...
  ```