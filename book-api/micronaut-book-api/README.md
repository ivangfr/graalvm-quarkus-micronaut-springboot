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

- Unable to run the Docker Native Image.
  ```
  [main] ERROR io.micronaut.runtime.Micronaut - Error starting Micronaut server: Bean   definition [org.hibernate.SessionFactory] could not be loaded: Error instantiating bean of type    [org.hibernate.boot.registry.StandardServiceRegistry]
  
  Message: Bean Factory [Definition: io.micronaut.configuration.hibernate.jpa.  EntityManagerFactoryBean] returned null
  Path Taken: SessionFactory.hibernateSessionFactory([SessionFactoryBuilder sessionFactoryBuilder]  ) --> SessionFactoryBuilder.hibernateSessionFactoryBuilder([MetadataSources metadataSources],  ValidatorFactory validatorFactory) --> MetadataSources.hibernateMetadataSources(JpaConfiguration   jpaConfiguration,[StandardServiceRegistry standardServiceRegistry]) --> StandardServiceRegistry.  hibernateStandardServiceRegistry(String dataSourceName,[DataSource dataSource])
  io.micronaut.context.exceptions.BeanInstantiationException: Bean definition [org.hibernate.  SessionFactory] could not be loaded: Error instantiating bean of type  [org.hibernate.boot.  registry.StandardServiceRegistry]
  
  Message: Bean Factory [Definition: io.micronaut.configuration.hibernate.jpa.  EntityManagerFactoryBean] returned null
  Path Taken: SessionFactory.hibernateSessionFactory([SessionFactoryBuilder sessionFactoryBuilder]  ) --> SessionFactoryBuilder.hibernateSessionFactoryBuilder([MetadataSources metadataSources],  ValidatorFactory validatorFactory) --> MetadataSources.hibernateMetadataSources(JpaConfiguration   jpaConfiguration,[StandardServiceRegistry standardServiceRegistry]) --> StandardServiceRegistry.  hibernateStandardServiceRegistry(String dataSourceName,[DataSource dataSource])
  	at io.micronaut.context.DefaultBeanContext.initializeContext(DefaultBeanContext.java:1533)
  	at io.micronaut.context.DefaultApplicationContext.initializeContext(DefaultApplicationContext.  java:220)
  	at io.micronaut.context.DefaultBeanContext.readAllBeanDefinitionClasses(DefaultBeanContext.  java:2763)
  	at io.micronaut.context.DefaultBeanContext.start(DefaultBeanContext.java:227)
  	at io.micronaut.context.DefaultApplicationContext.start(DefaultApplicationContext.java:166)
  	at io.micronaut.runtime.Micronaut.start(Micronaut.java:64)
  	at io.micronaut.runtime.Micronaut.run(Micronaut.java:294)
  	at io.micronaut.runtime.Micronaut.run(Micronaut.java:280)
  	at com.mycompany.micronautbookapi.Application.main(Application.java:18)
  Caused by: io.micronaut.context.exceptions.BeanInstantiationException: Error instantiating bean   of type  [org.hibernate.boot.registry.StandardServiceRegistry]
  
  Message: Bean Factory [Definition: io.micronaut.configuration.hibernate.jpa.  EntityManagerFactoryBean] returned null
  Path Taken: SessionFactory.hibernateSessionFactory([SessionFactoryBuilder sessionFactoryBuilder]  ) --> SessionFactoryBuilder.hibernateSessionFactoryBuilder([MetadataSources metadataSources],  ValidatorFactory validatorFactory) --> MetadataSources.hibernateMetadataSources(JpaConfiguration   jpaConfiguration,[StandardServiceRegistry standardServiceRegistry]) --> StandardServiceRegistry.  hibernateStandardServiceRegistry(String dataSourceName,[DataSource dataSource])
  	at io.micronaut.context.DefaultBeanContext.doCreateBean(DefaultBeanContext.java:1897)
  	at io.micronaut.context.DefaultBeanContext.createAndRegisterSingletonInternal  (DefaultBeanContext.java:2630)
  	at io.micronaut.context.DefaultBeanContext.createAndRegisterSingleton(DefaultBeanContext.  java:2616)
  	at io.micronaut.context.DefaultBeanContext.loadContextScopeBean(DefaultBeanContext.java:2166)
  	at io.micronaut.context.DefaultBeanContext.initializeContext(DefaultBeanContext.java:1531)
  	... 8 common frames omitted
  ```