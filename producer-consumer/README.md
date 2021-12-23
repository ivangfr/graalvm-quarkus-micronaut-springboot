# graalvm-quarkus-micronaut-springboot
## `> producer-consumer`

In this example, we will implement three versions of `producer - consumer` applications using `Quarkus`, `Micronaut` and `Spring Boot` Frameworks.

## Applications

- ### [quarkus-producer-consumer](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/producer-consumer/quarkus-producer-consumer#graalvm-quarkus-micronaut-springboot)
- ### [micronaut-producer-consumer](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/producer-consumer/micronaut-producer-consumer#graalvm-quarkus-micronaut-springboot)
- ### [springboot-producer-consumer](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/producer-consumer/springboot-producer-consumer#graalvm-quarkus-micronaut-springboot)

## Dependency version

| Framework   | Confluent Platform | Apache Kafka |
| ----------- | ------------------ | ------------ |
| Quarkus     | 7.0.x              | 3.0.0        |
| Micronaut   | 6.2.x              | 2.8.0        |
| Spring Boot | 7.0.x              | 3.0.0        |

## Start Environment

- Open a terminal and navigate to `graalvm-quarkus-micronaut-springboot/producer-consumer` folder

- Run the command
  ```
  docker-compose up -d
  ```

- Wait for all containers to be up and running. To check it, run
  ```
  docker-compose ps
  ```

## Shutdown

- In a terminal, make sure you are in `graalvm-quarkus-micronaut-springboot/producer-consumer` folder

- To stop and remove docker-compose containers, networks and volumes, run
  ```
  docker-compose down -v
  ```

## Useful links

- **Kafka Topics UI**
     
  `Kafka Topics UI` can be accessed at http://localhost:8085

- **Kafka Manager**
     
  `Kafka Manager` can be accessed at http://localhost:9000

  *Configuration*

  - First, you must create a new cluster. Click on `Cluster` (dropdown on the header) and then on `Add Cluster`
  - Type the name of your cluster in `Cluster Name` field, for example: `MyCluster`
  - Type `zookeeper:2181` in `Cluster Zookeeper Hosts` field
  - Enable checkbox `Poll consumer information (Not recommended for large # of consumers)`
  - Click on `Save` button at the bottom of the page.
