# `graalvm-quarkus-micronaut-springboot`
## `> simple-api`

In this example, we will implement three versions of a simple Greeting REST API using `Quarkus`, `Micronaut` and `Spring Boot` Frameworks.

## Applications

#### quarkus-simple-api

#### micronaut-simple-api

#### springboot-simple-api

## Comparison 

|                                      | Quarkus-JVM | Quarkus-Native | Micronaut-Jar | Micronaut-Native | Spring Boot |
| ------------------------------------ | ----------- | -------------- | ------------- | -----------------| ----------- |
| Jar packaging time                   |             |                |               |                  |             |
| Size of the jar                      |             |                |               |                  |             |
| Docker building time                 |             |                |               |                  |             |
| Docker image size                    |             |                |               |                  |             |
| Startup time                         |             |                |               |                  |             |
| Initial memory consumption           |             |                |               |                  |             |
| Time to run the ab test <sup>1</sup> |             |                |               |                  |             |
| Final memory consumption             |             |                |               |                  |             |

<sup>1</sup> `ab` tests used
```
// Quarkus-JVM
ab -n 10000 -c 100 http://localhost:9080/api/greeting?name=Ivan

// Quarkus-Native
ab -n 10000 -c 100 http://localhost:9081/api/greeting?name=Ivan

// Micronaut-JVM
ab -n 10000 -c 100 http://localhost:9082/api/greeting?name=Ivan

// Micronaut-Native
ab -n 10000 -c 100 http://localhost:9083/api/greeting?name=Ivan

// Spring Boot
ab -n 10000 -c 100 http://localhost:9084/api/greeting?name=Ivan
```
