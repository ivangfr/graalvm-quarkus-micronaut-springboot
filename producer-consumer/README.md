# `graalvm-quarkus-micronaut-springboot`
## `> producer-consumer`

In this example, we will implement three versions of a producer and a consumer applications using `Quarkus`, `Micronaut` and `Spring Boot` Frameworks.

## Applications

#### [`Quarkus`: producer-api & consumer-api]()

#### [`Micronaut`: producer-api & consumer-api]()

#### [`Spring Boot`: producer-api & consumer-api]()

## Start environment

Open a terminal and inside `graalvm-quarkus-micronaut-springboot/producer-consumer` folder run
```
docker-compose up -d
```

Wait a little bit until all containers `Up (healthy)`. You can check it by running
```
docker-compose ps
```

## Comparison

### Producer results

|                                       | Quarkus-JVM | Quarkus-Native | Micronaut-JVM | Micronaut-Native | Spring Boot |
| ------------------------------------- | ----------- | -------------- | ------------- | ---------------- | ----------- |
| Jar packaging time                    |             |                |               |                  |             |
| Size of the jar                       |             |                |               |                  |             |
| Docker building time                  |             |                |               |                  |             |
| Docker image size                     |             |                |               |                  |             |
| Startup time                          |             |                |               |                  |             |
| Initial memory consumption            |             |                |               |                  |             |
| Time to produce 10k news <sup>1</sup> |             |                |               |                  |             |
| Final memory consumption              |             |                |               |                  |             |

<sup>1</sup> `ab` tests used
```
// Quarkus-JVM
ab -p test-news.json -T 'application/json' -c 100 -n 10000 http://localhost:9090/api/news

// Quarkus-Native
ab -p test-news.json -T 'application/json' -c 100 -n 10000 http://localhost:9091/api/news

// Micronaut-JVM
ab -p test-news.json -T 'application/json' -c 100 -n 10000 http://localhost:9092/api/news

// Micronaut-Native
ab -p test-news.json -T 'application/json' -c 100 -n 10000 http://localhost:9093/api/news

// Spring Boot
ab -p test-news.json -T 'application/json' -c 100 -n 10000 http://localhost:9094/api/news
```

### Consumer results

|                            | Quarkus-JVM | Quarkus-Native | Micronaut-JVM | Micronaut-Native | Spring Boot |
| -------------------------- | ----------- | -------------- | ------------- | ---------------- | ----------- |
| Jar packaging time         |             |                |               |                  |             |
| Size of the jar            |             |                |               |                  |             |
| Docker building time       |             |                |               |                  |             |
| Docker image size          |             |                |               |                  |             |
| Startup time               |             |                |               |                  |             |
| Initial memory consumption |             |                |               |                  |             |
| Time to consume 10k news   |             |                |               |                  |             |
| Final memory consumption   |             |                |               |                  |             |

## Shutdown

To stop and remove containers, networks and volumes, run
```
docker-compose down -v
```

## Useful links

### Kafka Topics UI
     
`Kafka Topics UI` can be accessed at http://localhost:8085

### Kafka Manager
     
`Kafka Manager` can be accessed at http://localhost:9000

**Configuration**

- First, you must create a new cluster. Click on `Cluster` (dropdown on the header) and then on `Add Cluster`
- Type the name of your cluster in `Cluster Name` field, for example: `MyZooCluster`
- Type `zookeeper:2181` in `Cluster Zookeeper Hosts` field
- Enable checkbox `Poll consumer information (Not recommended for large # of consumers if ZK is used for offsets tracking on older Kafka versions)`
- Click on `Save` button at the bottom of the page.

## Issues

- https://github.com/micronaut-projects/micronaut-kafka/issues/68