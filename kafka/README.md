# graalvm-quarkus-micronaut-springboot
## `> kafka`

In this example, we will implement three versions of `kafka-producer - kafka-consumer` applications using `Quarkus`, `Micronaut` and `Spring Boot` Frameworks.

## Applications

- ### [quarkus-kafka](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/kafka/quarkus-kafka#graalvm-quarkus-micronaut-springboot)
- ### [micronaut-kafka](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/kafka/micronaut-kafka#graalvm-quarkus-micronaut-springboot)
- ### [springboot-kafka](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/kafka/springboot-kafka#graalvm-quarkus-micronaut-springboot)

## Dependency version

| Framework   | Confluent Platform | Apache Kafka |
|-------------|--------------------|--------------|
| Quarkus     | 7.3.x              | 3.3.2        |
| Micronaut   | 6.2.x              | 2.8.2        |
| Spring Boot | 7.3.x              | 3.3.1        |

## Start Environment

- Open a terminal and navigate to `graalvm-quarkus-micronaut-springboot/kafka` folder

- Run the command
  ```
  docker-compose up -d
  ```

- Wait for all containers to be up and running. To check it, run
  ```
  docker-compose ps
  ```

## Shutdown

- In a terminal, make sure you are in `graalvm-quarkus-micronaut-springboot/kafka` folder

- To stop and remove docker-compose containers, networks and volumes, run
  ```
  docker-compose down -v
  ```

## Useful links

- **Kafdrop**

  `Kafdrop` can be accessed at http://localhost:9000
