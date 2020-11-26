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

- Unable to build `springboot-producer-api-native`. `NewsProducerConfig` needs to be refactored.
  ```
  [INFO]     [creator]     Fatal error:java.lang.IllegalStateException: java.lang.IllegalStateException: ERROR: in 'com.mycompany.producerapi.kafka.  NewsProducerConfig' these methods are directly invoking methods marked @Bean: [producerFactory, kafkaTemplate] - due to the enforced proxyBeanMethods=false for   components in a native-image, please consider refactoring to use instance injection. If you are confident this is not going to affect your application, you may   turn this check off using -Dspring.native.verify=false.
  [INFO]     [creator]     	at java.base/jdk.internal.reflect.NativeConstructorAccessorImpl.newInstance0(Native Method)
  [INFO]     [creator]     	at java.base/jdk.internal.reflect.NativeConstructorAccessorImpl.newInstance(NativeConstructorAccessorImpl.java:62)
  [INFO]     [creator]     	at java.base/jdk.internal.reflect.DelegatingConstructorAccessorImpl.newInstance(DelegatingConstructorAccessorImpl.java:45)
  [INFO]     [creator]     	at java.base/java.lang.reflect.Constructor.newInstance(Constructor.java:490)
  [INFO]     [creator]     	at java.base/java.util.concurrent.ForkJoinTask.getThrowableException(ForkJoinTask.java:600)
  [INFO]     [creator]     	at java.base/java.util.concurrent.ForkJoinTask.get(ForkJoinTask.java:1006)
  [INFO]     [creator]     	at com.oracle.svm.hosted.NativeImageGenerator.run(NativeImageGenerator.java:483)
  [INFO]     [creator]     	at com.oracle.svm.hosted.NativeImageGeneratorRunner.buildImage(NativeImageGeneratorRunner.java:350)
  [INFO]     [creator]     	at com.oracle.svm.hosted.NativeImageGeneratorRunner.build(NativeImageGeneratorRunner.java:509)
  [INFO]     [creator]     	at com.oracle.svm.hosted.NativeImageGeneratorRunner.main(NativeImageGeneratorRunner.java:115)
  [INFO]     [creator]     	at com.oracle.svm.hosted.NativeImageGeneratorRunner$JDK9Plus.main(NativeImageGeneratorRunner.java:541)
  [INFO]     [creator]     Caused by: java.lang.IllegalStateException: ERROR: in 'com.mycompany.producerapi.kafka.NewsProducerConfig' these methods are directly   invoking methods marked @Bean: [producerFactory, kafkaTemplate] - due to the enforced proxyBeanMethods=false for components in a native-image, please consider   refactoring to use instance injection. If you are confident this is not going to affect your application, you may turn this check off using -Dspring.native.  verify=false.
  [INFO]     [creator]     	at org.springframework.graalvm.type.Type.verifyComponent(Type.java:2273)
  [INFO]     [creator]     	at org.springframework.graalvm.support.ResourcesHandler.processType(ResourcesHandler.java:1282)
  [INFO]     [creator]     	at org.springframework.graalvm.support.ResourcesHandler.processType(ResourcesHandler.java:960)
  [INFO]     [creator]     	at org.springframework.graalvm.support.ResourcesHandler.checkAndRegisterConfigurationType(ResourcesHandler.java:950)
  [INFO]     [creator]     	at org.springframework.graalvm.support.ResourcesHandler.processSpringComponent(ResourcesHandler.java:409)
  [INFO]     [creator]     	at org.springframework.graalvm.support.ResourcesHandler.processSpringComponents(ResourcesHandler.java:371)
  [INFO]     [creator]     	at org.springframework.graalvm.support.ResourcesHandler.handleSpringComponents(ResourcesHandler.java:261)
  [INFO]     [creator]     	at org.springframework.graalvm.support.ResourcesHandler.register(ResourcesHandler.java:139)
  [INFO]     [creator]     	at org.springframework.graalvm.support.SpringFeature.beforeAnalysis(SpringFeature.java:107)
  [INFO]     [creator]     	at com.oracle.svm.hosted.NativeImageGenerator.lambda$runPointsToAnalysis$7(NativeImageGenerator.java:696)
  [INFO]     [creator]     	at com.oracle.svm.hosted.FeatureHandler.forEachFeature(FeatureHandler.java:70)
  [INFO]     [creator]     	at com.oracle.svm.hosted.NativeImageGenerator.runPointsToAnalysis(NativeImageGenerator.java:696)
  [INFO]     [creator]     	at com.oracle.svm.hosted.NativeImageGenerator.doRun(NativeImageGenerator.java:558)
  [INFO]     [creator]     	at com.oracle.svm.hosted.NativeImageGenerator.lambda$run$0(NativeImageGenerator.java:471)
  [INFO]     [creator]     	at java.base/java.util.concurrent.ForkJoinTask$AdaptedRunnableAction.exec(ForkJoinTask.java:1407)
  [INFO]     [creator]     	at java.base/java.util.concurrent.ForkJoinTask.doExec(ForkJoinTask.java:290)
  [INFO]     [creator]     	at java.base/java.util.concurrent.ForkJoinPool$WorkQueue.topLevelExec(ForkJoinPool.java:1020)
  [INFO]     [creator]     	at java.base/java.util.concurrent.ForkJoinPool.scan(ForkJoinPool.java:1656)
  [INFO]     [creator]     	at java.base/java.util.concurrent.ForkJoinPool.runWorker(ForkJoinPool.java:1594)
  [INFO]     [creator]     	at java.base/java.util.concurrent.ForkJoinWorkerThread.run(ForkJoinWorkerThread.java:183)
  [INFO]     [creator]     Error: Image build request failed with exit status 1
  [INFO]     [creator]     unable to invoke layer creator
  [INFO]     [creator]     unable to contribute native-image layer
  [INFO]     [creator]     error running build
  [INFO]     [creator]     exit status 1
  [INFO]     [creator]     ERROR: failed to build: exit status 1
  ```

- Unable to build `springboot-consumer-api-native`. `NewsConsumerConfig` needs to be refactored.
  ```
  [INFO]     [creator]     Fatal error:java.lang.IllegalStateException: java.lang.IllegalStateException: ERROR: in 'com.mycompany.consumerapi.kafka.  NewsConsumerConfig' these methods are directly invoking methods marked @Bean: [kafkaListenerContainerFactory, consumerFactory] - due to the enforced   proxyBeanMethods=false for components in a native-image, please consider refactoring to use instance injection. If you are confident this is not going to affect   your application, you may turn this check off using -Dspring.native.verify=false.
  [INFO]     [creator]     	at java.base/jdk.internal.reflect.NativeConstructorAccessorImpl.newInstance0(Native Method)
  [INFO]     [creator]     	at java.base/jdk.internal.reflect.NativeConstructorAccessorImpl.newInstance(NativeConstructorAccessorImpl.java:62)
  [INFO]     [creator]     	at java.base/jdk.internal.reflect.DelegatingConstructorAccessorImpl.newInstance(DelegatingConstructorAccessorImpl.java:45)
  [INFO]     [creator]     	at java.base/java.lang.reflect.Constructor.newInstance(Constructor.java:490)
  [INFO]     [creator]     	at java.base/java.util.concurrent.ForkJoinTask.getThrowableException(ForkJoinTask.java:600)
  [INFO]     [creator]     	at java.base/java.util.concurrent.ForkJoinTask.get(ForkJoinTask.java:1006)
  [INFO]     [creator]     	at com.oracle.svm.hosted.NativeImageGenerator.run(NativeImageGenerator.java:483)
  [INFO]     [creator]     	at com.oracle.svm.hosted.NativeImageGeneratorRunner.buildImage(NativeImageGeneratorRunner.java:350)
  [INFO]     [creator]     	at com.oracle.svm.hosted.NativeImageGeneratorRunner.build(NativeImageGeneratorRunner.java:509)
  [INFO]     [creator]     	at com.oracle.svm.hosted.NativeImageGeneratorRunner.main(NativeImageGeneratorRunner.java:115)
  [INFO]     [creator]     	at com.oracle.svm.hosted.NativeImageGeneratorRunner$JDK9Plus.main(NativeImageGeneratorRunner.java:541)
  [INFO]     [creator]     Caused by: java.lang.IllegalStateException: ERROR: in 'com.mycompany.consumerapi.kafka.NewsConsumerConfig' these methods are directly   invoking methods marked @Bean: [kafkaListenerContainerFactory, consumerFactory] - due to the enforced proxyBeanMethods=false for components in a native-image,   please consider refactoring to use instance injection. If you are confident this is not going to affect your application, you may turn this check off using   -Dspring.native.verify=false.
  [INFO]     [creator]     	at org.springframework.graalvm.type.Type.verifyComponent(Type.java:2273)
  [INFO]     [creator]     	at org.springframework.graalvm.support.ResourcesHandler.processType(ResourcesHandler.java:1282)
  [INFO]     [creator]     	at org.springframework.graalvm.support.ResourcesHandler.processType(ResourcesHandler.java:960)
  [INFO]     [creator]     	at org.springframework.graalvm.support.ResourcesHandler.checkAndRegisterConfigurationType(ResourcesHandler.java:950)
  [INFO]     [creator]     	at org.springframework.graalvm.support.ResourcesHandler.processSpringComponent(ResourcesHandler.java:409)
  [INFO]     [creator]     	at org.springframework.graalvm.support.ResourcesHandler.processSpringComponents(ResourcesHandler.java:371)
  [INFO]     [creator]     	at org.springframework.graalvm.support.ResourcesHandler.handleSpringComponents(ResourcesHandler.java:261)
  [INFO]     [creator]     	at org.springframework.graalvm.support.ResourcesHandler.register(ResourcesHandler.java:139)
  [INFO]     [creator]     	at org.springframework.graalvm.support.SpringFeature.beforeAnalysis(SpringFeature.java:107)
  [INFO]     [creator]     	at com.oracle.svm.hosted.NativeImageGenerator.lambda$runPointsToAnalysis$7(NativeImageGenerator.java:696)
  [INFO]     [creator]     	at com.oracle.svm.hosted.FeatureHandler.forEachFeature(FeatureHandler.java:70)
  [INFO]     [creator]     	at com.oracle.svm.hosted.NativeImageGenerator.runPointsToAnalysis(NativeImageGenerator.java:696)
  [INFO]     [creator]     	at com.oracle.svm.hosted.NativeImageGenerator.doRun(NativeImageGenerator.java:558)
  [INFO]     [creator]     	at com.oracle.svm.hosted.NativeImageGenerator.lambda$run$0(NativeImageGenerator.java:471)
  [INFO]     [creator]     	at java.base/java.util.concurrent.ForkJoinTask$AdaptedRunnableAction.exec(ForkJoinTask.java:1407)
  [INFO]     [creator]     	at java.base/java.util.concurrent.ForkJoinTask.doExec(ForkJoinTask.java:290)
  [INFO]     [creator]     	at java.base/java.util.concurrent.ForkJoinPool$WorkQueue.topLevelExec(ForkJoinPool.java:1020)
  [INFO]     [creator]     	at java.base/java.util.concurrent.ForkJoinPool.scan(ForkJoinPool.java:1656)
  [INFO]     [creator]     	at java.base/java.util.concurrent.ForkJoinPool.runWorker(ForkJoinPool.java:1594)
  [INFO]     [creator]     	at java.base/java.util.concurrent.ForkJoinWorkerThread.run(ForkJoinWorkerThread.java:183)
  [INFO]     [creator]     Error: Image build request failed with exit status 1
  [INFO]     [creator]     unable to invoke layer creator
  [INFO]     [creator]     unable to contribute native-image layer
  [INFO]     [creator]     error running build
  [INFO]     [creator]     exit status 1
  [INFO]     [creator]     ERROR: failed to build: exit status 1
  ```