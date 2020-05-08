# graalvm-quarkus-micronaut-springboot
## `> book-api > quarkus-book-api`

## Application

- **quarkus-book-api**

  [`Quarkus`](https://quarkus.io/) Java Web application that exposes a REST API for managing books.
                                 
  It has the following endpoints:
  ```
  GET /api/books
  GET /api/books/{id}
  POST /api/books {"isbn": "...", "title": "..."}
  ```

## Running application

> **Note:** `MySQL` container must be running and initialized as explained [here](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/book-api#start-environment)

### Development Mode

- Open a terminal and navigate to `graalvm-quarkus-micronaut-springboot/book-api/quarkus-book-api` folder

- Run the command below
  ```
  ./mvnw compile quarkus:dev
  ```

### Docker in JVM Mode

- In a terminal, make sure you are inside `graalvm-quarkus-micronaut-springboot/book-api/quarkus-book-api` folder

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
  docker run -d --rm --name quarkus-book-api-jvm \
    -p 9085:8080 -e MYSQL_HOST=mysql --network book-api_default \
    docker.mycompany.com/quarkus-book-api-jvm:1.0.0
  ```

### Docker in Native Mode

- In a terminal, make sure you are inside `graalvm-quarkus-micronaut-springboot/book-api/quarkus-book-api` folder

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
  docker run -d --rm --name quarkus-book-api-native \
    -p 9086:8080 -e MYSQL_HOST=mysql --network book-api_default \
    docker.mycompany.com/quarkus-book-api-native:1.0.0
  ```

## Shutdown

- Open a terminal

- To stop and remove application container run
  ```
  docker stop quarkus-book-api-jvm quarkus-book-api-native
  ```
