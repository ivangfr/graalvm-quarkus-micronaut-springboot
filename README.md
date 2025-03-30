# graalvm-quarkus-micronaut-springboot

The goal of this project is to compare some Java Microservices Frameworks like: [`Quarkus`](https://quarkus.io/), [`Micronaut`](https://micronaut.io/) and [`Spring Boot`](https://docs.spring.io/spring-boot/index.html). For it, we will implement applications using those frameworks, build their JVM and Native Docker images and measure start-up times, memory footprint, etc.

## Proof-of-Concepts & Articles

On [ivangfr.github.io](https://ivangfr.github.io), I have compiled my Proof-of-Concepts (PoCs) and articles. You can easily search for the technology you are interested in by using the filter. Who knows, perhaps I have already implemented a PoC or written an article about what you are looking for.

## Additional Readings

- \[**Medium**\] [**Java Microservice Framework’s Battles: Quarkus vs Micronaut vs Spring Boot**](https://medium.com/@ivangfr/java-microservice-frameworks-battles-quarkus-vs-micronaut-vs-spring-boot-2321dc5712ae)
- \[**Medium**\] [**Unveiling the Java Microservice Frameworks Battle: Insights, Earnings, and GitHub Contributions**](https://medium.com/@ivangfr/unveiling-the-java-microservice-frameworks-battle-insights-earnings-and-github-contributions-6540cd0a0a1a)
- \[**Medium**\] [**Battle: Quarkus 3.7.2 vs. Micronaut 4.3.1 vs. Spring Boot 3.2.2**](https://medium.com/@ivangfr/battle-quarkus-3-7-2-vs-micronaut-4-3-1-vs-spring-boot-3-2-2-8d6765e15e45)
- \[**Medium**\] [**Battle: Quarkus 3.12.0 vs. Micronaut 4.5.0 vs. Spring Boot 3.3.1**](https://medium.com/@ivangfr/battle-quarkus-3-12-0-vs-micronaut-4-5-0-vs-spring-boot-3-3-1-b9a4424fc52f)
- \[**Medium**\] [**Battle: Quarkus 3.14.2 vs. Micronaut 4.6.1 vs. Spring Boot 3.3.3**](https://medium.com/@ivangfr/battle-quarkus-3-14-2-vs-micronaut-4-6-1-vs-spring-boot-3-3-3-41947196fb31)
- \[**Medium**\] [**Battle: Quarkus 3.15.1 vs. Micronaut 4.6.3 vs. Spring Boot 3.3.4**](https://medium.com/@ivangfr/battle-quarkus-3-15-1-vs-micronaut-4-6-3-vs-spring-boot-3-3-4-9ae4a7cefac6)

## Categories

- ### [simple-api](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/simple-api#graalvm-quarkus-micronaut-springboot)
- ### [jpa-mysql](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/jpa-mysql#graalvm-quarkus-micronaut-springboot)
- ### [kafka](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/kafka#graalvm-quarkus-micronaut-springboot)
- ### [elasticsearch](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/elasticsearch#graalvm-quarkus-micronaut-springboot)

## Latest Framework Version Used

| Framework   | Version |
|-------------|---------|
| Quarkus     | 3.21.0  |
| Micronaut   | 4.7.6   |
| Spring Boot | 3.4.4   |

## Prerequisites

- [`Java 17+`](https://www.oracle.com/java/technologies/downloads/#java17)
- [`Docker`](https://www.docker.com/)

## Docker Images

The application’s JVM and Native Docker images can be found in [this Docker Hub link](https://hub.docker.com/search?q=ivanfranchin).

## Bash scripts

We've implemented three bash scripts that collect data used in the frameworks comparison.

- **collect-jvm-jar-docker-size-times.sh**
  
  It packages jar files and builds Docker image of JVM applications, collecting data like: jar packaging time, jar size, docker build time and docker image size.

- **collect-native-jar-docker-size-times.sh**

  It packages jar files and builds Docker image of Native applications, collecting data like: jar packaging time, jar size, docker build time and docker image size.
  
  > **Note**: On Mac and Windows, it's recommended to increase the memory allocated to Docker to at least 8G (and potentially to add more CPUs as well) since native-image compiler is a heavy process. On Linux, Docker uses by default the resources available on the host so no configuration is needed.

- **collect-ab-times-memory-usage.sh**

  It starts Docker container of JVM and Native applications, collecting data like: startup time, initial memory usage, time spent to run ab tests for the first time and (after some warm up) for the second time, final memory usage and shutdown time.

- **remove-jvm-docker-images.sh**

  It removes the Docker image of JVM applications.

- **remove-native-docker-images.sh**

  It removes the Docker image of Native applications.

## AB Tests

  ```
                       Application | ab Test                                                                                     |
  -------------------------------- + ------------------------------------------------------------------------------------------- |
            quarkus-simple-api-jvm | ab -c 2 -n 6000 'http://localhost:9080/api/greeting?name=Ivan'                              |
          micronaut-simple-api-jvm | ab -c 2 -n 6000 'http://localhost:9082/api/greeting?name=Ivan'                              |
         springboot-simple-api-jvm | ab -c 2 -n 6000 'http://localhost:9084/api/greeting?name=Ivan'                              |
         quarkus-simple-api-native | ab -c 2 -n 6000 'http://localhost:9081/api/greeting?name=Ivan'                              |
       micronaut-simple-api-native | ab -c 2 -n 6000 'http://localhost:9083/api/greeting?name=Ivan'                              |
      springboot-simple-api-native | ab -c 2 -n 6000 'http://localhost:9085/api/greeting?name=Ivan'                              |
  ................................ + ........................................................................................... |
             quarkus-jpa-mysql-jvm | ab -p test-book.json -T 'application/json' -c 2 -n 4000 http://localhost:9086/api/books     |
           micronaut-jpa-mysql-jvm | ab -p test-book.json -T 'application/json' -c 2 -n 4000 http://localhost:9088/api/books     |
          springboot-jpa-mysql-jvm | ab -p test-book.json -T 'application/json' -c 2 -n 4000 http://localhost:9090/api/books     |
          quarkus-jpa-mysql-native | ab -p test-book.json -T 'application/json' -c 2 -n 4000 http://localhost:9087/api/books     |
        micronaut-jpa-mysql-native | ab -p test-book.json -T 'application/json' -c 2 -n 4000 http://localhost:9089/api/books     |
       springboot-jpa-mysql-native | ab -p test-book.json -T 'application/json' -c 2 -n 4000 http://localhost:9091/api/books     |
  ................................ + ........................................................................................... |
        quarkus-kafka-producer-jvm | ab -p test-news.json -T 'application/json' -c 2 -n 6000 http://localhost:9100/api/news      |
      micronaut-kafka-producer-jvm | ab -p test-news.json -T 'application/json' -c 2 -n 6000 http://localhost:9102/api/news      |
     springboot-kafka-producer-jvm | ab -p test-news.json -T 'application/json' -c 2 -n 6000 http://localhost:9104/api/news      |
     quarkus-kafka-producer-native | ab -p test-news.json -T 'application/json' -c 2 -n 6000 http://localhost:9101/api/news      |
   micronaut-kafka-producer-native | ab -p test-news.json -T 'application/json' -c 2 -n 6000 http://localhost:9103/api/news      |
  springboot-kafka-producer-native | ab -p test-news.json -T 'application/json' -c 2 -n 6000 http://localhost:9105/api/news      |
  ................................ + ........................................................................................... |
         quarkus-elasticsearch-jvm | ab -p test-movies.json -T 'application/json' -c 2 -n 4000 http://localhost:9112/api/movies  |
       micronaut-elasticsearch-jvm | ab -p test-movies.json -T 'application/json' -c 2 -n 4000 http://localhost:9114/api/movies  |
      springboot-elasticsearch-jvm | ab -p test-movies.json -T 'application/json' -c 2 -n 4000 http://localhost:9116/api/movies  |
      quarkus-elasticsearch-native | ab -p test-movies.json -T 'application/json' -c 2 -n 4000 http://localhost:9113/api/movies  |
    micronaut-elasticsearch-native | ab -p test-movies.json -T 'application/json' -c 2 -n 4000 http://localhost:9115/api/movies  |
   springboot-elasticsearch-native | ab -p test-movies.json -T 'application/json' -c 2 -n 4000 http://localhost:9117/api/movies  |
  ```

## Monitoring CPU and Memory with cAdvisor

In order to have a better insight about the Docker container's CPU and Memory Usage, we can use [`cAdvisor`](https://github.com/google/cadvisor).

- In a terminal, run the following command
  ```
  docker run -d --rm --name=cadvisor -p 8080:8080 \
    -v /:/rootfs:ro \
    -v /var/run:/var/run:ro \
    -v /sys:/sys:ro \
    -v /var/lib/docker/:/var/lib/docker:ro \
    -v /dev/disk/:/dev/disk:ro \
    -v /var/run/docker.sock:/var/run/docker.sock \
    --privileged \
    --device=/dev/kmsg \
    gcr.io/cadvisor/cadvisor:v0.49.1
  ```

- In a browser, access
  - http://localhost:8080/docker/ to explore the running containers;
  - http://localhost:8080/docker/container-name to go directly to the info of a specific container.

- To stop it, run
  ```
  docker stop cadvisor
  ```