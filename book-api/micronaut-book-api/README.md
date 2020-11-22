# graalvm-quarkus-micronaut-springboot
## `> book-api > micronaut-book-api`

## Application

- **micronaut-book-api**

  [`Micronaut`](https://micronaut.io/) Java Web application that exposes a REST API for managing books.

  It has the following endpoints:
  ```
  GET /api/books
  GET /api/books/{id}
  POST /api/books {"isbn": "...", "title": "..."}
  ```

## Running application

> **Note:** `MySQL` container must be running and initialized as explained [here](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/book-api#start-environment)

### Development Mode

- Open a terminal and navigate to `graalvm-quarkus-micronaut-springboot/book-api/micronaut-book-api` folder

- Run the command below to start the application
  ```
  ./mvnw clean mn:run
  ```

- A simple test can be done by opening a new terminal and running
  ```
  curl -i -X POST localhost:8080/api/books -H "Content-Type: application/json" \
    -d '{"isbn": "123", "title": "Learn Java"}'
  
  curl -i localhost:8080/api/books
  ```

- To stop the application, press `Ctrl+C` in its terminal

### Docker in JVM Mode

- In a terminal, make sure you are inside `graalvm-quarkus-micronaut-springboot/book-api/micronaut-book-api` folder

- Run the script below to build the Docker image
  ```
  ./docker-build.sh
  ```

- Run the following command to start the Docker container
  ```
  docker run --rm --name micronaut-book-api-jvm \
    -p 9087:8080 -e MYSQL_HOST=mysql --network book-api_default \
    docker.mycompany.com/micronaut-book-api-jvm:1.0.0
  ```

- A simple test can be done by opening a new terminal and running
  ```
  curl -i -X POST localhost:9087/api/books -H "Content-Type: application/json" \
    -d '{"isbn": "123", "title": "Learn Docker"}'
  
  curl -i localhost:9087/api/books
  ```

- To stop and remove application Docker container, press `Ctrl+C` in its terminal

### Docker in Native Mode

- In a terminal, make sure you are inside `graalvm-quarkus-micronaut-springboot/book-api/micronaut-book-api` folder

- Run the script below to build the Docker image
  ```
  ./docker-build.sh native
  ```

- Run the following command to start the Docker container
  ```
  docker run --rm --name micronaut-book-api-native \
    -p 9088:8080 -e MYSQL_HOST=mysql --network book-api_default \
    docker.mycompany.com/micronaut-book-api-native:1.0.0
  ```

- A simple test can be done by opening a new terminal and running
  ```
  curl -i -X POST localhost:9088/api/books -H "Content-Type: application/json" \
    -d '{"isbn": "123", "title": "Learn GraalVM"}'
  
  curl -i localhost:9088/api/books
  ```

- To stop and remove application Docker container, press `Ctrl+C` in its terminal

## Issues

While shutting down the native application, it's throwning the following exception
```
ERROR i.m.context.DefaultBeanContext - Error disposing of bean registration [io.micronaut.configuration.jdbc.hikari.DatasourceFactory]: java.lang.IllegalAccessException: Cannot set final field: java.util.concurrent.CopyOnWriteArrayList.lock. Enable by specifying "allowWrite" for this field in the reflection configuration.
java.lang.Error: java.lang.IllegalAccessException: Cannot set final field: java.util.concurrent.CopyOnWriteArrayList.lock. Enable by specifying "allowWrite" for this field in the reflection configuration.
	at java.util.concurrent.CopyOnWriteArrayList.resetLock(CopyOnWriteArrayList.java:1607)
	at java.util.concurrent.CopyOnWriteArrayList.clone(CopyOnWriteArrayList.java:301)
	at com.zaxxer.hikari.util.ConcurrentBag.values(ConcurrentBag.java:279)
	at com.zaxxer.hikari.pool.HikariPool.softEvictConnections(HikariPool.java:382)
	at com.zaxxer.hikari.pool.HikariPool.shutdown(HikariPool.java:230)
	at com.zaxxer.hikari.HikariDataSource.close(HikariDataSource.java:351)
	at io.micronaut.configuration.jdbc.hikari.DatasourceFactory.close(DatasourceFactory.java:96)
	at io.micronaut.configuration.jdbc.hikari.$DatasourceFactoryDefinition.dispose(Unknown Source)
	at io.micronaut.inject.DisposableBeanDefinition.dispose(DisposableBeanDefinition.java:41)
	at io.micronaut.context.DefaultBeanContext.stop(DefaultBeanContext.java:290)
	at io.micronaut.context.DefaultApplicationContext.stop(DefaultApplicationContext.java:171)
	at io.micronaut.http.server.netty.NettyHttpServer.stopInternal(NettyHttpServer.java:530)
	at io.micronaut.http.server.netty.NettyHttpServer.stop(NettyHttpServer.java:365)
	at io.micronaut.http.server.netty.NettyHttpServer.stop(NettyHttpServer.java:110)
	at io.micronaut.runtime.Micronaut.lambda$null$0(Micronaut.java:110)
	at java.lang.Thread.run(Thread.java:834)
	at com.oracle.svm.core.thread.JavaThreads.threadStartRoutine(JavaThreads.java:519)
	at com.oracle.svm.core.posix.thread.PosixJavaThreads.pthreadStartRoutine(PosixJavaThreads.java:192)
Caused by: java.lang.IllegalAccessException: Cannot set final field: java.util.concurrent.CopyOnWriteArrayList.lock. Enable by specifying "allowWrite" for this field in the reflection configuration.
	at java.lang.reflect.Field.set(Field.java:780)
	at java.util.concurrent.CopyOnWriteArrayList.resetLock(CopyOnWriteArrayList.java:1605)
	... 17 common frames omitted
```