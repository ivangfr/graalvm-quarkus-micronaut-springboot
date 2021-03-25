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
