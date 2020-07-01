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
  ./gradlew clean run
  ```

- A simple test can be done by opening a new terminal and running
  ```
  curl -i -X POST localhost:8080/api/books -H "Content-Type: application/json" \
    -d '{"isbn": "123", "title": "Learn Java"}'
  
  curl -i localhost:8080/api/books
  ```

- To stop the application, press `Ctrl+C` in its terminals

### Docker in JVM Mode

- In a terminal, make sure you are inside `graalvm-quarkus-micronaut-springboot/book-api/micronaut-book-api` folder

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

- To stop and remove application Docker container, press `Ctrl+C` in its terminals

### Docker in Native Mode

- In a terminal, make sure you are inside `graalvm-quarkus-micronaut-springboot/book-api/micronaut-book-api` folder

- Package the application `jar` file
  ```
  ./gradlew clean assemble
  ```

- Run the script below to build the Docker image
  ```
  ./docker-build.sh native
  ```

- Run the following command to start the Docker container
  > **Important:** Unable to run the Docker Native Image. For more details see [issues](#issues)
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

- To stop and remove application Docker container, press `Ctrl+C` in its terminals

## Issues

- Unable to run the Docker Native Image. It seems that there's a [`MySQL` compatibility issue with `GraalVM`](https://bugs.mysql.com/bug.php?id=91968)
  ```
  Error starting Micronaut server: Bean definition [javax.sql.DataSource] could not be loaded: Error   instantiating bean of type [javax.sql.DataSource]: Failed to initialize pool: com.mysql.cj.exceptions.  CJException cannot be cast to com.mysql.cj.exceptions.WrongArgumentException
  io.micronaut.context.exceptions.BeanInstantiationException: Bean definition [javax.sql.DataSource]   could not be loaded: Error instantiating bean of type [javax.sql.DataSource]: Failed to initialize   pool: com.mysql.cj.exceptions.CJException cannot be cast to com.mysql.cj.exceptions.  WrongArgumentException
  	at io.micronaut.context.DefaultBeanContext.initializeContext(DefaultBeanContext.java:1466)
  	at io.micronaut.context.DefaultApplicationContext.initializeContext(DefaultApplicationContext.  java:220)
  	at io.micronaut.context.DefaultBeanContext.readAllBeanDefinitionClasses(DefaultBeanContext.java:2682)
  	at io.micronaut.context.DefaultBeanContext.start(DefaultBeanContext.java:216)
  	at io.micronaut.context.DefaultApplicationContext.start(DefaultApplicationContext.java:166)
  	at io.micronaut.runtime.Micronaut.start(Micronaut.java:64)
  	at io.micronaut.runtime.Micronaut.run(Micronaut.java:294)
  	at io.micronaut.runtime.Micronaut.run(Micronaut.java:280)
  	at com.mycompany.micronautbookapi.Application.main(Application.java:12)
  Caused by: io.micronaut.context.exceptions.BeanInstantiationException: Error instantiating bean of type   [javax.sql.DataSource]: Failed to initialize pool: com.mysql.cj.exceptions.CJException cannot be cast   to com.mysql.cj.exceptions.WrongArgumentException
  	at io.micronaut.context.DefaultBeanContext.doCreateBean(DefaultBeanContext.java:1842)
  	at io.micronaut.context.DefaultBeanContext.createAndRegisterSingletonInternal(DefaultBeanContext.  java:2549)
  	at io.micronaut.context.DefaultBeanContext.createAndRegisterSingleton(DefaultBeanContext.java:2535)
  	at io.micronaut.context.DefaultBeanContext.loadContextScopeBean(DefaultBeanContext.java:2089)
  	at io.micronaut.context.DefaultBeanContext.initializeContext(DefaultBeanContext.java:1464)
  	... 8 common frames omitted
  Caused by: com.zaxxer.hikari.pool.HikariPool$PoolInitializationException: Failed to initialize pool:   com.mysql.cj.exceptions.CJException cannot be cast to com.mysql.cj.exceptions.WrongArgumentException
  	at com.zaxxer.hikari.pool.HikariPool.throwPoolInitializationException(HikariPool.java:589)
  	at com.zaxxer.hikari.pool.HikariPool.checkFailFast(HikariPool.java:575)
  	at com.zaxxer.hikari.pool.HikariPool.<init>(HikariPool.java:115)
  	at com.zaxxer.hikari.HikariDataSource.<init>(HikariDataSource.java:81)
  	at io.micronaut.configuration.jdbc.hikari.HikariUrlDataSource.<init>(HikariUrlDataSource.java:35)
  	at io.micronaut.configuration.jdbc.hikari.DatasourceFactory.dataSource(DatasourceFactory.java:66)
  	at io.micronaut.configuration.jdbc.hikari.$DatasourceFactory$DataSource0Definition.build(Unknown   Source)
  	at io.micronaut.context.BeanDefinitionDelegate.build(BeanDefinitionDelegate.java:137)
  	at io.micronaut.context.DefaultBeanContext.doCreateBean(DefaultBeanContext.java:1814)
  	... 12 common frames omitted
  Caused by: java.lang.ClassCastException: com.mysql.cj.exceptions.CJException cannot be cast to com.  mysql.cj.exceptions.WrongArgumentException
  	at com.mysql.cj.util.Util.getInstance(Util.java:169)
  	at com.mysql.cj.util.Util.getInstance(Util.java:174)
  	at com.mysql.cj.conf.ConnectionUrl$Type.getImplementingInstance(ConnectionUrl.java:241)
  	at com.mysql.cj.conf.ConnectionUrl$Type.getConnectionUrlInstance(ConnectionUrl.java:211)
  	at com.mysql.cj.conf.ConnectionUrl.getConnectionUrlInstance(ConnectionUrl.java:280)
  	at com.mysql.cj.jdbc.NonRegisteringDriver.connect(NonRegisteringDriver.java:194)
  	at com.zaxxer.hikari.util.DriverDataSource.getConnection(DriverDataSource.java:138)
  	at com.zaxxer.hikari.pool.PoolBase.newConnection(PoolBase.java:354)
  	at com.zaxxer.hikari.pool.PoolBase.newPoolEntry(PoolBase.java:202)
  	at com.zaxxer.hikari.pool.HikariPool.createPoolEntry(HikariPool.java:473)
  	at com.zaxxer.hikari.pool.HikariPool.checkFailFast(HikariPool.java:554)
  	... 19 common frames omitted
  ```