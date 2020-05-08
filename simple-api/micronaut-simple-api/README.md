# graalvm-quarkus-micronaut-springboot
## `> simple-api > micronaut-simple-api`

## Application

- **micronaut-simple-api**

  [`Micronaut`](https://micronaut.io/) Java Web application that expose a simple REST API for greetings. It has the following endpoint
  ```
  GET /api/greeting[?name=...]
  ```

## Running application

### Development Mode

- Open a terminal and navigate to `graalvm-quarkus-micronaut-springboot/simple-api/micronaut-simple-api` folder

- Run the command below
  ```
  ./gradlew run
  ```

### Docker in JVM Mode

- In a terminal, make sure you are inside `graalvm-quarkus-micronaut-springboot/simple-api/micronaut-simple-api` folder

- Package the application `jar` file
  ```
  ./gradlew clean assemble
  ```

- Run the script below to build the Docker image
  ```
  ./docker-build.sh
  ```

- Run the following command to start the Docker container
  ```
  docker run -d --rm --name micronaut-simple-api-jvm -p 9082:8080 \
    docker.mycompany.com/micronaut-simple-api-jvm:1.0.0
  ```

### Docker in Native Mode

- In a terminal, make sure you are inside `graalvm-quarkus-micronaut-springboot/simple-api/micronaut-simple-api` folder

- Package the application `jar` file
  ```
  ./gradlew clean assemble
  ```

- Run the script below to build the Docker image
  ```
  ./docker-build.sh native
  ```

- Run the following command to start the Docker container
  ```
  docker run -d --rm --name micronaut-simple-api-native -p 9083:8080 \
    docker.mycompany.com/micronaut-simple-api-native:1.0.0
  ```

## Shutdown

- Open a terminal

- To stop and remove application container run
  ```
  docker stop micronaut-simple-api-jvm micronaut-simple-api-native
  ```
