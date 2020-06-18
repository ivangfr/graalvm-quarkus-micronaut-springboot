# graalvm-quarkus-micronaut-springboot
## `> elasticsearch > quarkus-elasticsearch`

## Application

- **quarkus-elasticsearch**

  [`Quarkus`](https://quarkus.io/) Java Web application that expose a simple REST API for indexing and searching movies in `Elasticsearch`.
  
  It has the following endpoint:
  ```
  POST /api/movies -d {"imdb": "...", "title": "..."}
  GET /api/movies[?title=...]
  ```

## Running application

> **Note:** `Elasticsearch` container must be running and initialized as explained [here](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/elasticsearch#start-environment)

### Development Mode

- Open a terminal and navigate to `graalvm-quarkus-micronaut-springboot/elasticsearch/quarkus-elasticsearch` folder

- Run the command below to start the application
  ```
  ./mvnw clean compile quarkus:dev
  ```

- A simple test can be done by opening a new terminal and running
  ```
  curl -i -X POST "localhost:8080/api/movies" -H "Content-type: application/json" -d '{"imdb": "123", "title": "I, Tonya"}'
  curl -i "localhost:8080/api/movies?title=tonya"
  ```

- To stop the application, press `Ctrl+C` in its terminals

### Docker in JVM Mode

- In a terminal, make sure you are inside `graalvm-quarkus-micronaut-springboot/elasticsearch/quarkus-elasticsearch` folder

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
  docker run --rm --name quarkus-elasticsearch-jvm \
    -p 9105:8080 -e ELASTICSEARCH_HOST=elasticsearch --network elasticsearch_default \
    docker.mycompany.com/quarkus-elasticsearch-jvm:1.0.0
  ```

- A simple test can be done by opening a new terminal and running
  ```
  curl -i -X POST "localhost:9105/api/movies" -H "Content-type: application/json" -d '{"imdb": "456", "title": "American Pie"}'
  curl -i "localhost:9105/api/movies?title=american"
  ```

- To stop and remove application Docker container, press `Ctrl+C` in its terminals

### Docker in Native Mode

- In a terminal, make sure you are inside `graalvm-quarkus-micronaut-springboot/elasticsearch/quarkus-elasticsearch` folder

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
  docker run --rm --name quarkus-elasticsearch-native \
    -p 9106:8080 -e ELASTICSEARCH_HOST=elasticsearch --network elasticsearch_default \
    docker.mycompany.com/quarkus-elasticsearch-native:1.0.0
  ```

- A simple test can be done by opening a new terminal and running
  > **Important:** an exception is thrown when the application a request. For more details see [issues](#issues)
  ```
  curl -i -X POST "localhost:9106/api/movies" -H "Content-type: application/json" -d '{"imdb": "789", "title": "Resident Evil"}'
  curl -i "localhost:9106/api/movies?title=evil"
  ```

- To stop and remove application Docker container, press `Ctrl+C` in its terminals

## Issues

- When application receives a request, the following response is returned. It seems and problem injecting `RestHighLevelClient`
  ```
  curl -i "localhost:9106/api/movies?title=evil"
  HTTP/1.1 500 Internal Server Error
  Content-Length: 217
  Content-Type: application/json
  
  {
    "error": "Internal Server Error",
    "message": "Error injecting org.elasticsearch.client.  RestHighLevelClient com.mycompany.quarkuselasticsearch.service.  MovieServiceImpl.client",
    "path": "",
    "status": 500,
    "timestamp": "..."
  }
  ```