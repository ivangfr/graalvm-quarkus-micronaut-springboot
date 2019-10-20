# `graalvm-quarkus-micronaut-springboot`
## `> book-api > micronaut-book-api`

## Application

### micronaut-book-api

[`Micronaut`](https://micronaut.io/) Java Web application that exposes a REST API for managing books.

It has the following endpoints:
```
GET /api/books
GET /api/books/{id}
POST /api/books {"isbn": "...", "title": "..."}
```

## Running application

> Note: `MySQL` container must be running and initialized as explained [here](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/book-api#start-environment)

### Development Mode

Open a terminal and inside `graalvm-quarkus-micronaut-springboot/book-api/micronaut-book-api` folder run
```
./gradlew run
```

### Docker in JVM Mode

Before building the docker image, you need to package the application `jar` file. So, in a terminal and inside
`graalvm-quarkus-micronaut-springboot/book-api/micronaut-book-api` folder run
```
./gradlew clean assemble
```

Then, build the image with the script
```
./docker-build.sh
```

Finally, run the container using
```
docker run -d --rm --name micronaut-book-api-jvm \
  -p 9087:8080 -e MYSQL_HOST=mysql --network book-api_default \
  docker.mycompany.com/micronaut-book-api-jvm:1.0.0
```

### Docker in Native Mode

Before building the docker image, you need to package the application `jar` file. So, in a terminal and inside
`graalvm-quarkus-micronaut-springboot/book-api/micronaut-book-api` folder run
```
./gradlew clean assemble
```

Then, build the image with the script
```
./docker-build.sh native
```

Finally, run the container using
```
docker run -d --rm --name micronaut-book-api-native \
  -p 9088:8080 -e MYSQL_HOST=mysql --network book-api_default \
  docker.mycompany.com/micronaut-book-api-native:1.0.0
```

## Shutdown

To stop and remove application containers run
```
docker stop micronaut-book-api-jvm micronaut-book-api-native
```

## Issues

- Using `MySQL` as database, I am having the exception shown below. It is a known issue for Oracle, https://bugs.mysql.com/bug.php?id=91968
```
ERROR com.zaxxer.hikari.pool.HikariPool - HikariPool-1 - Error thrown while acquiring connection from data source
java.lang.ClassCastException: com.mysql.cj.exceptions.CJException cannot be cast to com.mysql.cj.exceptions.WrongArgumentException
        at com.mysql.cj.util.Util.getInstance(Util.java:169)
        at com.mysql.cj.util.Util.getInstance(Util.java:174)
        at com.mysql.cj.conf.ConnectionUrl.getConnectionUrlInstance(ConnectionUrl.java:200)
        at com.mysql.cj.jdbc.NonRegisteringDriver.connect(NonRegisteringDriver.java:196)
        at com.zaxxer.hikari.util.DriverDataSource.getConnection(DriverDataSource.java:138)
        at com.zaxxer.hikari.pool.PoolBase.newConnection(PoolBase.java:353)
        at com.zaxxer.hikari.pool.PoolBase.newPoolEntry(PoolBase.java:201)
        at com.zaxxer.hikari.pool.HikariPool.createPoolEntry(HikariPool.java:473)
        at com.zaxxer.hikari.pool.HikariPool.checkFailFast(HikariPool.java:562)
        at com.zaxxer.hikari.pool.HikariPool.<init>(HikariPool.java:115)
        at com.zaxxer.hikari.HikariDataSource.<init>(HikariDataSource.java:81)
        at io.micronaut.configuration.jdbc.hikari.HikariUrlDataSource.<init>(HikariUrlDataSource.java:36)
        at io.micronaut.configuration.jdbc.hikari.DatasourceFactory.dataSource(DatasourceFactory.java:67)
        at io.micronaut.configuration.jdbc.hikari.$DatasourceFactory$DataSource0Definition.build(Unknown Source)
        at io.micronaut.context.BeanDefinitionDelegate.build(BeanDefinitionDelegate.java:113)
        at io.micronaut.context.DefaultBeanContext.doCreateBean(DefaultBeanContext.java:1598)
        at io.micronaut.context.DefaultBeanContext.createAndRegisterSingleton(DefaultBeanContext.java:2307)
        at io.micronaut.context.DefaultBeanContext.getBeanForDefinition(DefaultBeanContext.java:1989)
        at io.micronaut.context.DefaultBeanContext.getBeanInternal(DefaultBeanContext.java:1963)
        at io.micronaut.context.DefaultBeanContext.getBean(DefaultBeanContext.java:1082)
        at io.micronaut.context.AbstractBeanDefinition.getBeanForConstructorArgument(AbstractBeanDefinition.java:1007)
        at io.micronaut.data.hibernate.runtime.$DataEntityManagerFactoryBean$HibernateStandardServiceRegistry0Definition.doBuild(Unknown Source)
        at io.micronaut.context.AbstractParametrizedBeanDefinition.build(AbstractParametrizedBeanDefinition.java:117)
        at io.micronaut.context.BeanDefinitionDelegate.build(BeanDefinitionDelegate.java:109)
        at io.micronaut.context.DefaultBeanContext.doCreateBean(DefaultBeanContext.java:1598)
        at io.micronaut.context.DefaultBeanContext.createAndRegisterSingleton(DefaultBeanContext.java:2307)
        at io.micronaut.context.DefaultBeanContext.getBeanForDefinition(DefaultBeanContext.java:1989)
        at io.micronaut.context.DefaultBeanContext.getBeanInternal(DefaultBeanContext.java:1963)
        at io.micronaut.context.DefaultBeanContext.getBean(DefaultBeanContext.java:1082)
        at io.micronaut.context.AbstractBeanDefinition.getBeanForConstructorArgument(AbstractBeanDefinition.java:1007)
        at io.micronaut.configuration.hibernate.jpa.$EntityManagerFactoryBean$HibernateMetadataSources1Definition.doBuild(Unknown Source)
        at io.micronaut.context.AbstractParametrizedBeanDefinition.build(AbstractParametrizedBeanDefinition.java:117)
        at io.micronaut.context.BeanDefinitionDelegate.build(BeanDefinitionDelegate.java:109)
        at io.micronaut.context.DefaultBeanContext.doCreateBean(DefaultBeanContext.java:1598)
        at io.micronaut.context.DefaultBeanContext.createAndRegisterSingleton(DefaultBeanContext.java:2307)
        at io.micronaut.context.DefaultBeanContext.getBeanForDefinition(DefaultBeanContext.java:1989)
        at io.micronaut.context.DefaultBeanContext.getBeanInternal(DefaultBeanContext.java:1963)
        at io.micronaut.context.DefaultBeanContext.getBean(DefaultBeanContext.java:1082)
        at io.micronaut.context.AbstractBeanDefinition.getBeanForConstructorArgument(AbstractBeanDefinition.java:1007)
        at io.micronaut.configuration.hibernate.jpa.$EntityManagerFactoryBean$HibernateSessionFactoryBuilder2Definition.build(Unknown Source)
        at io.micronaut.context.BeanDefinitionDelegate.build(BeanDefinitionDelegate.java:113)
        at io.micronaut.context.DefaultBeanContext.doCreateBean(DefaultBeanContext.java:1598)
        at io.micronaut.context.DefaultBeanContext.createAndRegisterSingleton(DefaultBeanContext.java:2307)
        at io.micronaut.context.DefaultBeanContext.getBeanForDefinition(DefaultBeanContext.java:1989)
        at io.micronaut.context.DefaultBeanContext.getBeanInternal(DefaultBeanContext.java:1963)
        at io.micronaut.context.DefaultBeanContext.getBean(DefaultBeanContext.java:1082)
        at io.micronaut.context.AbstractBeanDefinition.getBeanForConstructorArgument(AbstractBeanDefinition.java:1007)
        at io.micronaut.configuration.hibernate.jpa.$EntityManagerFactoryBean$HibernateSessionFactory3Definition.build(Unknown Source)
        at io.micronaut.context.BeanDefinitionDelegate.build(BeanDefinitionDelegate.java:113)
        at io.micronaut.context.DefaultBeanContext.doCreateBean(DefaultBeanContext.java:1598)
        at io.micronaut.context.DefaultBeanContext.createAndRegisterSingleton(DefaultBeanContext.java:2307)
        at io.micronaut.context.DefaultBeanContext.loadContextScopeBean(DefaultBeanContext.java:1888)
        at io.micronaut.context.DefaultBeanContext.initializeContext(DefaultBeanContext.java:1262)
        at io.micronaut.context.DefaultApplicationContext.initializeContext(DefaultApplicationContext.java:236)
        at io.micronaut.context.DefaultBeanContext.readAllBeanDefinitionClasses(DefaultBeanContext.java:2446)
        at io.micronaut.context.DefaultBeanContext.start(DefaultBeanContext.java:200)
        at io.micronaut.context.DefaultApplicationContext.start(DefaultApplicationContext.java:187)
        at io.micronaut.runtime.Micronaut.start(Micronaut.java:69)
        at io.micronaut.runtime.Micronaut.run(Micronaut.java:307)
        at io.micronaut.runtime.Micronaut.run(Micronaut.java:293)
        at com.mycompany.micronautbookapi.Application.main(Application.java:8)
12:33:28.467 [main] ERROR com.zaxxer.hikari.pool.HikariPool - HikariPool-1 - Exception during pool initialization.
java.lang.ClassCastException: com.mysql.cj.exceptions.CJException cannot be cast to com.mysql.cj.exceptions.WrongArgumentException
        at com.mysql.cj.util.Util.getInstance(Util.java:169)
        at com.mysql.cj.util.Util.getInstance(Util.java:174)
        at com.mysql.cj.conf.ConnectionUrl.getConnectionUrlInstance(ConnectionUrl.java:200)
        at com.mysql.cj.jdbc.NonRegisteringDriver.connect(NonRegisteringDriver.java:196)
        at com.zaxxer.hikari.util.DriverDataSource.getConnection(DriverDataSource.java:138)
        at com.zaxxer.hikari.pool.PoolBase.newConnection(PoolBase.java:353)
        at com.zaxxer.hikari.pool.PoolBase.newPoolEntry(PoolBase.java:201)
        at com.zaxxer.hikari.pool.HikariPool.createPoolEntry(HikariPool.java:473)
        at com.zaxxer.hikari.pool.HikariPool.checkFailFast(HikariPool.java:562)
        at com.zaxxer.hikari.pool.HikariPool.<init>(HikariPool.java:115)
        at com.zaxxer.hikari.HikariDataSource.<init>(HikariDataSource.java:81)
        at io.micronaut.configuration.jdbc.hikari.HikariUrlDataSource.<init>(HikariUrlDataSource.java:36)
        at io.micronaut.configuration.jdbc.hikari.DatasourceFactory.dataSource(DatasourceFactory.java:67)
        at io.micronaut.configuration.jdbc.hikari.$DatasourceFactory$DataSource0Definition.build(Unknown Source)
        at io.micronaut.context.BeanDefinitionDelegate.build(BeanDefinitionDelegate.java:113)
        at io.micronaut.context.DefaultBeanContext.doCreateBean(DefaultBeanContext.java:1598)
        at io.micronaut.context.DefaultBeanContext.createAndRegisterSingleton(DefaultBeanContext.java:2307)
        at io.micronaut.context.DefaultBeanContext.getBeanForDefinition(DefaultBeanContext.java:1989)
        at io.micronaut.context.DefaultBeanContext.getBeanInternal(DefaultBeanContext.java:1963)
        at io.micronaut.context.DefaultBeanContext.getBean(DefaultBeanContext.java:1082)
        at io.micronaut.context.AbstractBeanDefinition.getBeanForConstructorArgument(AbstractBeanDefinition.java:1007)
        at io.micronaut.data.hibernate.runtime.$DataEntityManagerFactoryBean$HibernateStandardServiceRegistry0Definition.doBuild(Unknown Source)
        at io.micronaut.context.AbstractParametrizedBeanDefinition.build(AbstractParametrizedBeanDefinition.java:117)
        at io.micronaut.context.BeanDefinitionDelegate.build(BeanDefinitionDelegate.java:109)
        at io.micronaut.context.DefaultBeanContext.doCreateBean(DefaultBeanContext.java:1598)
        at io.micronaut.context.DefaultBeanContext.createAndRegisterSingleton(DefaultBeanContext.java:2307)
        at io.micronaut.context.DefaultBeanContext.getBeanForDefinition(DefaultBeanContext.java:1989)
        at io.micronaut.context.DefaultBeanContext.getBeanInternal(DefaultBeanContext.java:1963)
        at io.micronaut.context.DefaultBeanContext.getBean(DefaultBeanContext.java:1082)
        at io.micronaut.context.AbstractBeanDefinition.getBeanForConstructorArgument(AbstractBeanDefinition.java:1007)
        at io.micronaut.configuration.hibernate.jpa.$EntityManagerFactoryBean$HibernateMetadataSources1Definition.doBuild(Unknown Source)
        at io.micronaut.context.AbstractParametrizedBeanDefinition.build(AbstractParametrizedBeanDefinition.java:117)
        at io.micronaut.context.BeanDefinitionDelegate.build(BeanDefinitionDelegate.java:109)
        at io.micronaut.context.DefaultBeanContext.doCreateBean(DefaultBeanContext.java:1598)
        at io.micronaut.context.DefaultBeanContext.createAndRegisterSingleton(DefaultBeanContext.java:2307)
        at io.micronaut.context.DefaultBeanContext.getBeanForDefinition(DefaultBeanContext.java:1989)
        at io.micronaut.context.DefaultBeanContext.getBeanInternal(DefaultBeanContext.java:1963)
        at io.micronaut.context.DefaultBeanContext.getBean(DefaultBeanContext.java:1082)
        at io.micronaut.context.AbstractBeanDefinition.getBeanForConstructorArgument(AbstractBeanDefinition.java:1007)
        at io.micronaut.configuration.hibernate.jpa.$EntityManagerFactoryBean$HibernateSessionFactoryBuilder2Definition.build(Unknown Source)
        at io.micronaut.context.BeanDefinitionDelegate.build(BeanDefinitionDelegate.java:113)
        at io.micronaut.context.DefaultBeanContext.doCreateBean(DefaultBeanContext.java:1598)
        at io.micronaut.context.DefaultBeanContext.createAndRegisterSingleton(DefaultBeanContext.java:2307)
        at io.micronaut.context.DefaultBeanContext.getBeanForDefinition(DefaultBeanContext.java:1989)
        at io.micronaut.context.DefaultBeanContext.getBeanInternal(DefaultBeanContext.java:1963)
        at io.micronaut.context.DefaultBeanContext.getBean(DefaultBeanContext.java:1082)
        at io.micronaut.context.AbstractBeanDefinition.getBeanForConstructorArgument(AbstractBeanDefinition.java:1007)
        at io.micronaut.configuration.hibernate.jpa.$EntityManagerFactoryBean$HibernateSessionFactory3Definition.build(Unknown Source)
        at io.micronaut.context.BeanDefinitionDelegate.build(BeanDefinitionDelegate.java:113)
        at io.micronaut.context.DefaultBeanContext.doCreateBean(DefaultBeanContext.java:1598)
        at io.micronaut.context.DefaultBeanContext.createAndRegisterSingleton(DefaultBeanContext.java:2307)
        at io.micronaut.context.DefaultBeanContext.loadContextScopeBean(DefaultBeanContext.java:1888)
        at io.micronaut.context.DefaultBeanContext.initializeContext(DefaultBeanContext.java:1262)
        at io.micronaut.context.DefaultApplicationContext.initializeContext(DefaultApplicationContext.java:236)
        at io.micronaut.context.DefaultBeanContext.readAllBeanDefinitionClasses(DefaultBeanContext.java:2446)
        at io.micronaut.context.DefaultBeanContext.start(DefaultBeanContext.java:200)
        at io.micronaut.context.DefaultApplicationContext.start(DefaultApplicationContext.java:187)
        at io.micronaut.runtime.Micronaut.start(Micronaut.java:69)
        at io.micronaut.runtime.Micronaut.run(Micronaut.java:307)
        at io.micronaut.runtime.Micronaut.run(Micronaut.java:293)
        at com.mycompany.micronautbookapi.Application.main(Application.java:8)
12:33:28.468 [main] ERROR io.micronaut.runtime.Micronaut - Error starting Micronaut server: Bean definition [org.hibernate.SessionFactory] could not be loaded: Error instantiating bean of type  [org.hibernate.boot.registry.StandardServiceRegistry]

Message: Failed to initialize pool: com.mysql.cj.exceptions.CJException cannot be cast to com.mysql.cj.exceptions.WrongArgumentException
Path Taken: SessionFactory.hibernateSessionFactory([SessionFactoryBuilder sessionFactoryBuilder]) --> SessionFactoryBuilder.hibernateSessionFactoryBuilder([MetadataSources metadataSources],ValidatorFactory validatorFactory) --> MetadataSources.hibernateMetadataSources(JpaConfiguration jpaConfiguration,[StandardServiceRegistry standardServiceRegistry]) --> StandardServiceRegistry.hibernateStandardServiceRegistry(String dataSourceName,[DataSource dataSource])
io.micronaut.context.exceptions.BeanInstantiationException: Bean definition [org.hibernate.SessionFactory] could not be loaded: Error instantiating bean of type  [org.hibernate.boot.registry.StandardServiceRegistry]

Message: Failed to initialize pool: com.mysql.cj.exceptions.CJException cannot be cast to com.mysql.cj.exceptions.WrongArgumentException
Path Taken: SessionFactory.hibernateSessionFactory([SessionFactoryBuilder sessionFactoryBuilder]) --> SessionFactoryBuilder.hibernateSessionFactoryBuilder([MetadataSources metadataSources],ValidatorFactory validatorFactory) --> MetadataSources.hibernateMetadataSources(JpaConfiguration jpaConfiguration,[StandardServiceRegistry standardServiceRegistry]) --> StandardServiceRegistry.hibernateStandardServiceRegistry(String dataSourceName,[DataSource dataSource])
        at io.micronaut.context.DefaultBeanContext.initializeContext(DefaultBeanContext.java:1264)
        at io.micronaut.context.DefaultApplicationContext.initializeContext(DefaultApplicationContext.java:236)
        at io.micronaut.context.DefaultBeanContext.readAllBeanDefinitionClasses(DefaultBeanContext.java:2446)
        at io.micronaut.context.DefaultBeanContext.start(DefaultBeanContext.java:200)
        at io.micronaut.context.DefaultApplicationContext.start(DefaultApplicationContext.java:187)
        at io.micronaut.runtime.Micronaut.start(Micronaut.java:69)
        at io.micronaut.runtime.Micronaut.run(Micronaut.java:307)
        at io.micronaut.runtime.Micronaut.run(Micronaut.java:293)
        at com.mycompany.micronautbookapi.Application.main(Application.java:8)
Caused by: io.micronaut.context.exceptions.BeanInstantiationException: Error instantiating bean of type  [org.hibernate.boot.registry.StandardServiceRegistry]

Message: Failed to initialize pool: com.mysql.cj.exceptions.CJException cannot be cast to com.mysql.cj.exceptions.WrongArgumentException
Path Taken: SessionFactory.hibernateSessionFactory([SessionFactoryBuilder sessionFactoryBuilder]) --> SessionFactoryBuilder.hibernateSessionFactoryBuilder([MetadataSources metadataSources],ValidatorFactory validatorFactory) --> MetadataSources.hibernateMetadataSources(JpaConfiguration jpaConfiguration,[StandardServiceRegistry standardServiceRegistry]) --> StandardServiceRegistry.hibernateStandardServiceRegistry(String dataSourceName,[DataSource dataSource])
        at io.micronaut.context.DefaultBeanContext.doCreateBean(DefaultBeanContext.java:1624)
        at io.micronaut.context.DefaultBeanContext.createAndRegisterSingleton(DefaultBeanContext.java:2307)
        at io.micronaut.context.DefaultBeanContext.getBeanForDefinition(DefaultBeanContext.java:1989)
        at io.micronaut.context.DefaultBeanContext.getBeanInternal(DefaultBeanContext.java:1963)
        at io.micronaut.context.DefaultBeanContext.getBean(DefaultBeanContext.java:1082)
        at io.micronaut.context.AbstractBeanDefinition.getBeanForConstructorArgument(AbstractBeanDefinition.java:1007)
        at io.micronaut.data.hibernate.runtime.$DataEntityManagerFactoryBean$HibernateStandardServiceRegistry0Definition.doBuild(Unknown Source)
        at io.micronaut.context.AbstractParametrizedBeanDefinition.build(AbstractParametrizedBeanDefinition.java:117)
        at io.micronaut.context.BeanDefinitionDelegate.build(BeanDefinitionDelegate.java:109)
        at io.micronaut.context.DefaultBeanContext.doCreateBean(DefaultBeanContext.java:1598)
        at io.micronaut.context.DefaultBeanContext.createAndRegisterSingleton(DefaultBeanContext.java:2307)
        at io.micronaut.context.DefaultBeanContext.getBeanForDefinition(DefaultBeanContext.java:1989)
        at io.micronaut.context.DefaultBeanContext.getBeanInternal(DefaultBeanContext.java:1963)
        at io.micronaut.context.DefaultBeanContext.getBean(DefaultBeanContext.java:1082)
        at io.micronaut.context.AbstractBeanDefinition.getBeanForConstructorArgument(AbstractBeanDefinition.java:1007)
        at io.micronaut.configuration.hibernate.jpa.$EntityManagerFactoryBean$HibernateMetadataSources1Definition.doBuild(Unknown Source)
        at io.micronaut.context.AbstractParametrizedBeanDefinition.build(AbstractParametrizedBeanDefinition.java:117)
        at io.micronaut.context.BeanDefinitionDelegate.build(BeanDefinitionDelegate.java:109)
        at io.micronaut.context.DefaultBeanContext.doCreateBean(DefaultBeanContext.java:1598)
        at io.micronaut.context.DefaultBeanContext.createAndRegisterSingleton(DefaultBeanContext.java:2307)
        at io.micronaut.context.DefaultBeanContext.getBeanForDefinition(DefaultBeanContext.java:1989)
        at io.micronaut.context.DefaultBeanContext.getBeanInternal(DefaultBeanContext.java:1963)
        at io.micronaut.context.DefaultBeanContext.getBean(DefaultBeanContext.java:1082)
        at io.micronaut.context.AbstractBeanDefinition.getBeanForConstructorArgument(AbstractBeanDefinition.java:1007)
        at io.micronaut.configuration.hibernate.jpa.$EntityManagerFactoryBean$HibernateSessionFactoryBuilder2Definition.build(Unknown Source)
        at io.micronaut.context.BeanDefinitionDelegate.build(BeanDefinitionDelegate.java:113)
        at io.micronaut.context.DefaultBeanContext.doCreateBean(DefaultBeanContext.java:1598)
        at io.micronaut.context.DefaultBeanContext.createAndRegisterSingleton(DefaultBeanContext.java:2307)
        at io.micronaut.context.DefaultBeanContext.getBeanForDefinition(DefaultBeanContext.java:1989)
        at io.micronaut.context.DefaultBeanContext.getBeanInternal(DefaultBeanContext.java:1963)
        at io.micronaut.context.DefaultBeanContext.getBean(DefaultBeanContext.java:1082)
        at io.micronaut.context.AbstractBeanDefinition.getBeanForConstructorArgument(AbstractBeanDefinition.java:1007)
        at io.micronaut.configuration.hibernate.jpa.$EntityManagerFactoryBean$HibernateSessionFactory3Definition.build(Unknown Source)
        at io.micronaut.context.BeanDefinitionDelegate.build(BeanDefinitionDelegate.java:113)
        at io.micronaut.context.DefaultBeanContext.doCreateBean(DefaultBeanContext.java:1598)
        at io.micronaut.context.DefaultBeanContext.createAndRegisterSingleton(DefaultBeanContext.java:2307)
        at io.micronaut.context.DefaultBeanContext.loadContextScopeBean(DefaultBeanContext.java:1888)
        at io.micronaut.context.DefaultBeanContext.initializeContext(DefaultBeanContext.java:1262)
        ... 8 common frames omitted
Caused by: com.zaxxer.hikari.pool.HikariPool$PoolInitializationException: Failed to initialize pool: com.mysql.cj.exceptions.CJException cannot be cast to com.mysql.cj.exceptions.WrongArgumentException
        at com.zaxxer.hikari.pool.HikariPool.throwPoolInitializationException(HikariPool.java:597)
        at com.zaxxer.hikari.pool.HikariPool.checkFailFast(HikariPool.java:576)
        at com.zaxxer.hikari.pool.HikariPool.<init>(HikariPool.java:115)
        at com.zaxxer.hikari.HikariDataSource.<init>(HikariDataSource.java:81)
        at io.micronaut.configuration.jdbc.hikari.HikariUrlDataSource.<init>(HikariUrlDataSource.java:36)
        at io.micronaut.configuration.jdbc.hikari.DatasourceFactory.dataSource(DatasourceFactory.java:67)
        at io.micronaut.configuration.jdbc.hikari.$DatasourceFactory$DataSource0Definition.build(Unknown Source)
        at io.micronaut.context.BeanDefinitionDelegate.build(BeanDefinitionDelegate.java:113)
        at io.micronaut.context.DefaultBeanContext.doCreateBean(DefaultBeanContext.java:1598)
        ... 45 common frames omitted
Caused by: java.lang.ClassCastException: com.mysql.cj.exceptions.CJException cannot be cast to com.mysql.cj.exceptions.WrongArgumentException
        at com.mysql.cj.util.Util.getInstance(Util.java:169)
        at com.mysql.cj.util.Util.getInstance(Util.java:174)
        at com.mysql.cj.conf.ConnectionUrl.getConnectionUrlInstance(ConnectionUrl.java:200)
        at com.mysql.cj.jdbc.NonRegisteringDriver.connect(NonRegisteringDriver.java:196)
        at com.zaxxer.hikari.util.DriverDataSource.getConnection(DriverDataSource.java:138)
        at com.zaxxer.hikari.pool.PoolBase.newConnection(PoolBase.java:353)
        at com.zaxxer.hikari.pool.PoolBase.newPoolEntry(PoolBase.java:201)
        at com.zaxxer.hikari.pool.HikariPool.createPoolEntry(HikariPool.java:473)
        at com.zaxxer.hikari.pool.HikariPool.checkFailFast(HikariPool.java:562)
        ... 52 common frames omitted
```