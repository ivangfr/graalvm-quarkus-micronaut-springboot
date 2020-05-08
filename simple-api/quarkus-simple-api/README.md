# graalvm-quarkus-micronaut-springboot
## `> simple-api > quarkus-simple-api`

## Application

- **quarkus-simple-api**

  [`Quarkus`](https://quarkus.io/) Java Web application that expose a simple REST API for greetings. It has the following endpoint
  ```
  GET /api/greeting[?name=...]
  ```

## Running application

### Development Mode

- Open a terminal navigate to `graalvm-quarkus-micronaut-springboot/simple-api/quarkus-simple-api` folder

- Run the command below
  ```
  ./mvnw compile quarkus:dev
  ```

### Docker in JVM Mode

- In a terminal, make sure you are inside `graalvm-quarkus-micronaut-springboot/simple-api/quarkus-simple-api` folder

- Package the application `jar` file
  ```
  ./mvnw clean package
  ```

- Run the script below to build the Docker image
  ```
  ./docker-build.sh
  ```

- Run the following command to start the Docker container
  ```
  docker run -d --rm --name quarkus-simple-api-jvm -p 9080:8080 \
    docker.mycompany.com/quarkus-simple-api-jvm:1.0.0
  ```

### Docker in Native Mode

- In a terminal, make sure you are inside `graalvm-quarkus-micronaut-springboot/simple-api/quarkus-simple-api` folder

- Package the application `jar` file
  ```
  ./mvnw clean package -Pnative -Dquarkus.native.container-build=true
  ```

- Run the script below to build the Docker image
  ```
  ./docker-build.sh native
  ```

- Run the following command to start the Docker container
  ```
  docker run -d --rm --name quarkus-simple-api-native -p 9081:8080 \
    docker.mycompany.com/quarkus-simple-api-native:1.0.0
  ```

## Shutdown

- Open a terminal

- To stop and remove application container run
  ```
  docker stop quarkus-simple-api-jvm quarkus-simple-api-native
  ```
