# graalvm-quarkus-micronaut-springboot
## `> elasticsearch > micronaut-elasticsearch`

## Application

- **micronaut-elasticsearch**

  [`Micronaut`](https://micronaut.io/) Java Web application that expose a simple REST API for indexing and searching movies in `Elasticsearch`.
  
  It has the following endpoint:
  ```
  POST /api/movies -d {"imdb": "...", "title": "..."}
  GET /api/movies[?title=...]
  ```

## Running application

> **Note:** `Elasticsearch` container must be running and initialized as explained [here](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/elasticsearch#start-environment)

### Development Mode

- Open a terminal and navigate to `graalvm-quarkus-micronaut-springboot/elasticsearch/micronaut-elasticsearch` folder

- Run the command below to start the application
  ```
  ./mvnw clean mn:run
  ```

- A simple test can be done by opening a new terminal and running
  ```
  curl -i -X POST "localhost:8080/api/movies" -H "Content-type: application/json" \
    -d '{"imdb": "123", "title": "I, Tonya"}'
  
  curl -i "localhost:8080/api/movies?title=tonya"
  ```

- To stop the application, press `Ctrl+C` in its terminals

### Docker in JVM Mode

- In a terminal, make sure you are inside `graalvm-quarkus-micronaut-springboot/elasticsearch/micronaut-elasticsearch` folder

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
  docker run --rm --name micronaut-elasticsearch-jvm \
    -p 9107:8080 -e ELASTICSEARCH_HOST=elasticsearch --network elasticsearch_default \
    docker.mycompany.com/micronaut-elasticsearch-jvm:1.0.0
  ```

- A simple test can be done by opening a new terminal and running
  ```
  curl -i -X POST "localhost:9107/api/movies" -H "Content-type: application/json" \
    -d '{"imdb": "456", "title": "American Pie"}'
  
  curl -i "localhost:9107/api/movies?title=american"
  ```

- To stop and remove application Docker container, press `Ctrl+C` in its terminals

### Docker in Native Mode

- In a terminal, make sure you are inside `graalvm-quarkus-micronaut-springboot/elasticsearch/micronaut-elasticsearch` folder

- Package the application `jar` file
  ```
  ./mvnw clean package
  ```

- Run the script below to build the Docker image
  ```
  ./docker-build.sh native
  ```

- Run the following command to start the Docker container
  ```
  docker run --rm --name micronaut-elasticsearch-native \
    -p 9108:8080 -e ELASTICSEARCH_HOST=elasticsearch --network elasticsearch_default \
    docker.mycompany.com/micronaut-elasticsearch-native:1.0.0
  ```

- A simple test can be done by opening a new terminal and running
  ```
  curl -i -X POST "localhost:9108/api/movies" -H "Content-type: application/json" \
    -d '{"imdb": "789", "title": "Resident Evil"}'
  
  curl -i "localhost:9108/api/movies?title=evil"
  ```

- To stop and remove application Docker container, run in a terminal
  ```
  docker stop micronaut-elasticsearch-native
  ```
