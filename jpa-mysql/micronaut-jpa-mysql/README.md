# graalvm-quarkus-micronaut-springboot
## `> jpa-mysql > micronaut-jpa-mysql`

## Application

- ### micronaut-jpa-mysql

  [`Micronaut`](https://micronaut.io/) Java Web application that exposes a REST API for managing books.

  It has the following endpoints:
  ```
  GET /api/books
  GET /api/books/{id}
  POST /api/books {"isbn": "...", "title": "..."}
  ```

## Running application

> **Note:** `MySQL` container must be running and initialized as explained [here](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/jpa-mysql#start-environment)

### Development Mode

- Open a terminal and navigate to `graalvm-quarkus-micronaut-springboot/jpa-mysql/micronaut-jpa-mysql` folder

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

- In a terminal, make sure you are inside `graalvm-quarkus-micronaut-springboot/jpa-mysql/micronaut-jpa-mysql` folder

- Clean the application
  ```
  ./mvnw clean
  ```

- Run the script below to build the Docker image
  ```
  ./docker-build.sh
  ```

- Run the following command to start the Docker container
  ```
  docker run --rm --name micronaut-jpa-mysql-jvm \
    -p 9088:8080 -e MYSQL_HOST=mysql \
    --network jpa-mysql_default \
    ivanfranchin/micronaut-jpa-mysql-jvm:1.0.0
  ```

- A simple test can be done by opening a new terminal and running
  ```
  curl -i -X POST localhost:9088/api/books -H "Content-Type: application/json" \
    -d '{"isbn": "456", "title": "Learn Docker"}'
  
  curl -i localhost:9088/api/books
  ```

- To stop and remove application Docker container, press `Ctrl+C` in its terminal

### Docker in Native Mode

- In a terminal, make sure you are inside `graalvm-quarkus-micronaut-springboot/jpa-mysql/micronaut-jpa-mysql` folder

- Clean the application
  ```
  ./mvnw clean
  ```

- Run the script below to build the Docker image
  ```
  ./docker-build.sh native
  ```

- Run the following command to start the Docker container (see [Issues](#issues))
  ```
  docker run --rm --name micronaut-jpa-mysql-native \
    -p 9089:8080 -e MICRONAUT_ENVIRONMENTS=native -e MYSQL_HOST=mysql \
    --network jpa-mysql_default \
    ivanfranchin/micronaut-jpa-mysql-native:1.0.0
  ```

- A simple test can be done by opening a new terminal and running
  ```
  curl -i -X POST localhost:9089/api/books -H "Content-Type: application/json" \
    -d '{"isbn": "789", "title": "Learn GraalVM"}'
  
  curl -i localhost:9089/api/books
  ```

- To stop and remove application Docker container, press `Ctrl+C` in its terminal

## Issues

After building the Docker native image successfully, the following exception is thrown at startup time
```
ERROR i.m.c.h.jpa.EntityManagerFactoryBean - Hibernate mapping error
org.hibernate.AnnotationException: No identifier specified for entity: com.mycompany.micronautjpamysql.model.Book
	at org.hibernate.cfg.InheritanceState.determineDefaultAccessType(InheritanceState.java:266)
	at org.hibernate.cfg.InheritanceState.getElementsToProcess(InheritanceState.java:211)
	at org.hibernate.cfg.AnnotationBinder.bindClass(AnnotationBinder.java:783)
	at org.hibernate.boot.model.source.internal.annotations.AnnotationMetadataSourceProcessorImpl.processEntityHierarchies(AnnotationMetadataSourceProcessorImpl.java:225)
	at org.hibernate.boot.model.process.spi.MetadataBuildingProcess$1.processEntityHierarchies(MetadataBuildingProcess.java:239)
	at org.hibernate.boot.model.process.spi.MetadataBuildingProcess.complete(MetadataBuildingProcess.java:282)
	at org.hibernate.boot.model.process.spi.MetadataBuildingProcess.build(MetadataBuildingProcess.java:86)
	at org.hibernate.boot.internal.MetadataBuilderImpl.build(MetadataBuilderImpl.java:479)
	at org.hibernate.boot.internal.MetadataBuilderImpl.build(MetadataBuilderImpl.java:85)
	at org.hibernate.boot.MetadataSources.buildMetadata(MetadataSources.java:202)
	at io.micronaut.configuration.hibernate.jpa.EntityManagerFactoryBean.hibernateSessionFactoryBuilder(EntityManagerFactoryBean.java:188)
	at io.micronaut.configuration.hibernate.jpa.$EntityManagerFactoryBean$HibernateSessionFactoryBuilder2Definition.build(Unknown Source)
	at io.micronaut.context.BeanDefinitionDelegate.build(BeanDefinitionDelegate.java:136)
	at io.micronaut.context.DefaultBeanContext.doCreateBean(DefaultBeanContext.java:2238)
	at io.micronaut.context.DefaultBeanContext.createAndRegisterSingletonInternal(DefaultBeanContext.java:3193)
	at io.micronaut.context.DefaultBeanContext.createAndRegisterSingleton(DefaultBeanContext.java:3179)
	at io.micronaut.context.DefaultBeanContext.getBeanForDefinition(DefaultBeanContext.java:2723)
	at io.micronaut.context.DefaultBeanContext.getBeanInternal(DefaultBeanContext.java:2685)
	at io.micronaut.context.DefaultBeanContext.getBean(DefaultBeanContext.java:1555)
	at io.micronaut.context.AbstractBeanDefinition.getBeanForConstructorArgument(AbstractBeanDefinition.java:1052)
	at io.micronaut.configuration.hibernate.jpa.$EntityManagerFactoryBean$HibernateSessionFactory3Definition.build(Unknown Source)
	at io.micronaut.context.BeanDefinitionDelegate.build(BeanDefinitionDelegate.java:136)
	at io.micronaut.context.DefaultBeanContext.doCreateBean(DefaultBeanContext.java:2238)
	at io.micronaut.context.DefaultBeanContext.createAndRegisterSingletonInternal(DefaultBeanContext.java:3193)
	at io.micronaut.context.DefaultBeanContext.createAndRegisterSingleton(DefaultBeanContext.java:3179)
	at io.micronaut.context.DefaultBeanContext.loadContextScopeBean(DefaultBeanContext.java:2555)
	at io.micronaut.context.DefaultBeanContext.initializeContext(DefaultBeanContext.java:1834)
	at io.micronaut.context.DefaultApplicationContext.initializeContext(DefaultApplicationContext.java:235)
	at io.micronaut.context.DefaultBeanContext.readAllBeanDefinitionClasses(DefaultBeanContext.java:3362)
	at io.micronaut.context.DefaultBeanContext.start(DefaultBeanContext.java:243)
	at io.micronaut.context.DefaultApplicationContext.start(DefaultApplicationContext.java:181)
	at io.micronaut.runtime.Micronaut.start(Micronaut.java:71)
	at io.micronaut.runtime.Micronaut.run(Micronaut.java:311)
	at io.micronaut.runtime.Micronaut.run(Micronaut.java:297)
	at com.mycompany.micronautjpamysql.Application.main(Application.java:8)
ERROR io.micronaut.runtime.Micronaut - Error starting Micronaut server: Bean definition [org.hibernate.SessionFactory] could not be loaded: Error instantiating bean of type  [org.hibernate.SessionFactory]

Message: No identifier specified for entity: com.mycompany.micronautjpamysql.model.Book
Path Taken: SessionFactory.hibernateSessionFactory([SessionFactoryBuilder sessionFactoryBuilder])
io.micronaut.context.exceptions.BeanInstantiationException: Bean definition [org.hibernate.SessionFactory] could not be loaded: Error instantiating bean of type  [org.hibernate.SessionFactory]

Message: No identifier specified for entity: com.mycompany.micronautjpamysql.model.Book
Path Taken: SessionFactory.hibernateSessionFactory([SessionFactoryBuilder sessionFactoryBuilder])
	at io.micronaut.context.DefaultBeanContext.initializeContext(DefaultBeanContext.java:1840)
	at io.micronaut.context.DefaultApplicationContext.initializeContext(DefaultApplicationContext.java:235)
	at io.micronaut.context.DefaultBeanContext.readAllBeanDefinitionClasses(DefaultBeanContext.java:3362)
	at io.micronaut.context.DefaultBeanContext.start(DefaultBeanContext.java:243)
	at io.micronaut.context.DefaultApplicationContext.start(DefaultApplicationContext.java:181)
	at io.micronaut.runtime.Micronaut.start(Micronaut.java:71)
	at io.micronaut.runtime.Micronaut.run(Micronaut.java:311)
	at io.micronaut.runtime.Micronaut.run(Micronaut.java:297)
	at com.mycompany.micronautjpamysql.Application.main(Application.java:8)
Caused by: io.micronaut.context.exceptions.BeanInstantiationException: Error instantiating bean of type  [org.hibernate.SessionFactory]

Message: No identifier specified for entity: com.mycompany.micronautjpamysql.model.Book
Path Taken: SessionFactory.hibernateSessionFactory([SessionFactoryBuilder sessionFactoryBuilder])
	at io.micronaut.context.DefaultBeanContext.doCreateBean(DefaultBeanContext.java:2265)
	at io.micronaut.context.DefaultBeanContext.createAndRegisterSingletonInternal(DefaultBeanContext.java:3193)
	at io.micronaut.context.DefaultBeanContext.createAndRegisterSingleton(DefaultBeanContext.java:3179)
	at io.micronaut.context.DefaultBeanContext.getBeanForDefinition(DefaultBeanContext.java:2723)
	at io.micronaut.context.DefaultBeanContext.getBeanInternal(DefaultBeanContext.java:2685)
	at io.micronaut.context.DefaultBeanContext.getBean(DefaultBeanContext.java:1555)
	at io.micronaut.context.AbstractBeanDefinition.getBeanForConstructorArgument(AbstractBeanDefinition.java:1052)
	at io.micronaut.configuration.hibernate.jpa.$EntityManagerFactoryBean$HibernateSessionFactory3Definition.build(Unknown Source)
	at io.micronaut.context.BeanDefinitionDelegate.build(BeanDefinitionDelegate.java:136)
	at io.micronaut.context.DefaultBeanContext.doCreateBean(DefaultBeanContext.java:2238)
	at io.micronaut.context.DefaultBeanContext.createAndRegisterSingletonInternal(DefaultBeanContext.java:3193)
	at io.micronaut.context.DefaultBeanContext.createAndRegisterSingleton(DefaultBeanContext.java:3179)
	at io.micronaut.context.DefaultBeanContext.loadContextScopeBean(DefaultBeanContext.java:2555)
	at io.micronaut.context.DefaultBeanContext.initializeContext(DefaultBeanContext.java:1834)
	... 8 common frames omitted
Caused by: org.hibernate.AnnotationException: No identifier specified for entity: com.mycompany.micronautjpamysql.model.Book
	at org.hibernate.cfg.InheritanceState.determineDefaultAccessType(InheritanceState.java:266)
	at org.hibernate.cfg.InheritanceState.getElementsToProcess(InheritanceState.java:211)
	at org.hibernate.cfg.AnnotationBinder.bindClass(AnnotationBinder.java:783)
	at org.hibernate.boot.model.source.internal.annotations.AnnotationMetadataSourceProcessorImpl.processEntityHierarchies(AnnotationMetadataSourceProcessorImpl.java:225)
	at org.hibernate.boot.model.process.spi.MetadataBuildingProcess$1.processEntityHierarchies(MetadataBuildingProcess.java:239)
	at org.hibernate.boot.model.process.spi.MetadataBuildingProcess.complete(MetadataBuildingProcess.java:282)
	at org.hibernate.boot.model.process.spi.MetadataBuildingProcess.build(MetadataBuildingProcess.java:86)
	at org.hibernate.boot.internal.MetadataBuilderImpl.build(MetadataBuilderImpl.java:479)
	at org.hibernate.boot.internal.MetadataBuilderImpl.build(MetadataBuilderImpl.java:85)
	at org.hibernate.boot.MetadataSources.buildMetadata(MetadataSources.java:202)
	at io.micronaut.configuration.hibernate.jpa.EntityManagerFactoryBean.hibernateSessionFactoryBuilder(EntityManagerFactoryBean.java:188)
	at io.micronaut.configuration.hibernate.jpa.$EntityManagerFactoryBean$HibernateSessionFactoryBuilder2Definition.build(Unknown Source)
	at io.micronaut.context.BeanDefinitionDelegate.build(BeanDefinitionDelegate.java:136)
	at io.micronaut.context.DefaultBeanContext.doCreateBean(DefaultBeanContext.java:2238)
	... 21 common frames omitted
```