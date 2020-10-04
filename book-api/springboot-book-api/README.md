# graalvm-quarkus-micronaut-springboot
## `> book-api > springboot-book-api`

## Application

- **springboot-book-api**

  [`Spring Boot`](https://docs.spring.io/spring-boot/docs/current/reference/htmlsingle/) Java Web application that exposes a REST API for managing books.

  It has the following endpoints:
  ```
  GET /api/books
  GET /api/books/{id}
  POST /api/books {"isbn": "...", "title": "..."}
  ```

## Running application

> **Note:** `MySQL` container must be running and initialized as explained [here](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/book-api#start-environment)

### Development Mode

- Open a terminal and navigate to `graalvm-quarkus-micronaut-springboot/book-api/springboot-book-api` folder

- Run the command below to start the application
  ```
  ./gradlew clean bootRun
  ```

- A simple test can be done by opening a new terminal and running
  ```
  curl -i -X POST localhost:8080/api/books -H "Content-Type: application/json" \
    -d '{"isbn": "123", "title": "Learn Java"}'
  
  curl -i localhost:8080/api/books
  ```

- To stop the application, press `Ctrl+C` in its terminals

### Docker in JVM Mode

- In a terminal, make sure you are inside `graalvm-quarkus-micronaut-springboot/book-api/springboot-book-api` folder

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
  docker run --rm --name springboot-book-api-jvm \
    -p 9089:8080 -e MYSQL_HOST=mysql --network book-api_default \
    docker.mycompany.com/springboot-book-api-jvm:1.0.0
  ```

- A simple test can be done by opening a new terminal and running
  ```
  curl -i -X POST localhost:9089/api/books -H "Content-Type: application/json" \
    -d '{"isbn": "123", "title": "Learn Docker"}'
  
  curl -i localhost:9089/api/books
  ```

- To stop and remove application Docker container, press `Ctrl+C` in its terminals

### Docker in Native Mode

- In a terminal, make sure you are inside `graalvm-quarkus-micronaut-springboot/book-api/springboot-book-api` folder

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
  docker run --rm --name springboot-book-api-native \
    -p 9090:8080 -e MYSQL_HOST=mysql --network book-api_default \
    docker.mycompany.com/springboot-book-api-native:1.0.0
  ```

- A simple test can be done by opening a new terminal and running
  ```
  curl -i -X POST localhost:9090/api/books -H "Content-Type: application/json" \
    -d '{"isbn": "123", "title": "Learn Docker"}'
  
  curl -i localhost:9090/api/books
  ```

- To stop and remove application Docker container, press `Ctrl+C` in its terminals

## Issues

- The native Docker image builds successfully but an exception is thrown at runtime
  ```
  2020-10-04 14:00:59.659  WARN 1 --- [           main] onfigReactiveWebServerApplicationContext :   Exception encountered during context initialization - cancelling refresh attempt: org.springframework.  beans.factory.BeanCreationException: Error creating bean with name 'org.springframework.boot.actuate.  autoconfigure.metrics.orm.jpa.HibernateMetricsAutoConfiguration': Injection of autowired dependencies   failed; nested exception is java.lang.IllegalStateException: Failed to asynchronously initialize native   EntityManagerFactory: java.lang.ExceptionInInitializerError
  2020-10-04 14:00:59.659  INFO 1 --- [           main] j.LocalContainerEntityManagerFactoryBean : Closing   JPA EntityManagerFactory for persistence unit 'default'
  2020-10-04 14:00:59.659  WARN 1 --- [           main] o.s.b.f.support.DisposableBeanAdapter    :   Invocation of destroy method failed on bean with name 'entityManagerFactory': java.lang.  IllegalStateException: Failed to asynchronously initialize native EntityManagerFactory: java.lang.  ExceptionInInitializerError
  2020-10-04 14:00:59.659  INFO 1 --- [           main] o.s.s.concurrent.ThreadPoolTaskExecutor  :   Shutting down ExecutorService 'applicationTaskExecutor'
  2020-10-04 14:00:59.663  INFO 1 --- [           main] ConditionEvaluationReportLoggingListener :
  
  Error starting ApplicationContext. To display the conditions report re-run your application with 'debug'   enabled.
  2020-10-04 14:00:59.665 ERROR 1 --- [           main] o.s.boot.SpringApplication               :   Application run failed
  
  org.springframework.beans.factory.BeanCreationException: Error creating bean with name 'org.  springframework.boot.actuate.autoconfigure.metrics.orm.jpa.HibernateMetricsAutoConfiguration': Injection   of autowired dependencies failed; nested exception is java.lang.IllegalStateException: Failed to   asynchronously initialize native EntityManagerFactory: java.lang.ExceptionInInitializerError
  	at org.springframework.beans.factory.annotation.AutowiredAnnotationBeanPostProcessor.  postProcessProperties(AutowiredAnnotationBeanPostProcessor.java:405) ~[com.mycompany.springbootbookapi.  SpringbootBookApiApplication:na]
  	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.populateBean  (AbstractAutowireCapableBeanFactory.java:1415) ~[na:na]
  	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.doCreateBean  (AbstractAutowireCapableBeanFactory.java:608) ~[na:na]
  	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.createBean  (AbstractAutowireCapableBeanFactory.java:531) ~[na:na]
  	at org.springframework.beans.factory.support.AbstractBeanFactory.lambda$doGetBean$0  (AbstractBeanFactory.java:335) ~[na:na]
  	at org.springframework.beans.factory.support.DefaultSingletonBeanRegistry.getSingleton  (DefaultSingletonBeanRegistry.java:234) ~[na:na]
  	at org.springframework.beans.factory.support.AbstractBeanFactory.doGetBean(AbstractBeanFactory.  java:333) ~[na:na]
  	at org.springframework.beans.factory.support.AbstractBeanFactory.getBean(AbstractBeanFactory.java:208)   ~[na:na]
  	at org.springframework.beans.factory.support.DefaultListableBeanFactory.preInstantiateSingletons  (DefaultListableBeanFactory.java:944) ~[na:na]
  	at org.springframework.context.support.AbstractApplicationContext.finishBeanFactoryInitialization  (AbstractApplicationContext.java:925) ~[na:na]
  	at org.springframework.context.support.AbstractApplicationContext.refresh(AbstractApplicationContext.  java:588) ~[na:na]
  	at org.springframework.boot.web.reactive.context.ReactiveWebServerApplicationContext.refresh  (ReactiveWebServerApplicationContext.java:63) ~[na:na]
  	at org.springframework.boot.SpringApplication.refresh(SpringApplication.java:770) ~[com.mycompany.  springbootbookapi.SpringbootBookApiApplication:na]
  	at org.springframework.boot.SpringApplication.refresh(SpringApplication.java:762) ~[com.mycompany.  springbootbookapi.SpringbootBookApiApplication:na]
  	at org.springframework.boot.SpringApplication.refreshContext(SpringApplication.java:421) ~[com.  mycompany.springbootbookapi.SpringbootBookApiApplication:na]
  	at org.springframework.boot.SpringApplication.run(SpringApplication.java:329) ~[com.mycompany.  springbootbookapi.SpringbootBookApiApplication:na]
  	at org.springframework.boot.SpringApplication.run(SpringApplication.java:1302) ~[com.mycompany.  springbootbookapi.SpringbootBookApiApplication:na]
  	at org.springframework.boot.SpringApplication.run(SpringApplication.java:1291) ~[com.mycompany.  springbootbookapi.SpringbootBookApiApplication:na]
  	at com.mycompany.springbootbookapi.SpringbootBookApiApplication.main(SpringbootBookApiApplication.  java:10) ~[com.mycompany.springbootbookapi.SpringbootBookApiApplication:na]
  Caused by: java.lang.IllegalStateException: Failed to asynchronously initialize native   EntityManagerFactory: java.lang.ExceptionInInitializerError
  	at org.springframework.orm.jpa.AbstractEntityManagerFactoryBean.getNativeEntityManagerFactory  (AbstractEntityManagerFactoryBean.java:573) ~[com.mycompany.springbootbookapi.  SpringbootBookApiApplication:na]
  	at org.springframework.orm.jpa.AbstractEntityManagerFactoryBean.invokeProxyMethod  (AbstractEntityManagerFactoryBean.java:516) ~[com.mycompany.springbootbookapi.  SpringbootBookApiApplication:na]
  	at org.springframework.orm.jpa.  AbstractEntityManagerFactoryBean$ManagedEntityManagerFactoryInvocationHandler.invoke  (AbstractEntityManagerFactoryBean.java:731) ~[na:na]
  	at com.sun.proxy.$Proxy332.getStatistics(Unknown Source) ~[na:na]
  	at io.micrometer.core.instrument.binder.jpa.HibernateMetrics.<init>(HibernateMetrics.java:110) ~[na:na]
  	at org.springframework.boot.actuate.autoconfigure.metrics.orm.jpa.HibernateMetricsAutoConfiguration.  bindEntityManagerFactoryToRegistry(HibernateMetricsAutoConfiguration.java:68) ~[com.mycompany.  springbootbookapi.SpringbootBookApiApplication:na]
  	at org.springframework.boot.actuate.autoconfigure.metrics.orm.jpa.HibernateMetricsAutoConfiguration.  lambda$bindEntityManagerFactoriesToRegistry$0(HibernateMetricsAutoConfiguration.java:60) ~[com.  mycompany.springbootbookapi.SpringbootBookApiApplication:na]
  	at java.util.LinkedHashMap.forEach(LinkedHashMap.java:684) ~[na:na]
  	at org.springframework.boot.actuate.autoconfigure.metrics.orm.jpa.HibernateMetricsAutoConfiguration.  bindEntityManagerFactoriesToRegistry(HibernateMetricsAutoConfiguration.java:60) ~[com.mycompany.  springbootbookapi.SpringbootBookApiApplication:na]
  	at java.lang.reflect.Method.invoke(Method.java:566) ~[na:na]
  	at org.springframework.beans.factory.annotation.  AutowiredAnnotationBeanPostProcessor$AutowiredMethodElement.inject  (AutowiredAnnotationBeanPostProcessor.java:755) ~[na:na]
  	at org.springframework.beans.factory.annotation.InjectionMetadata.inject(InjectionMetadata.java:130) ~  [na:na]
  	at org.springframework.beans.factory.annotation.AutowiredAnnotationBeanPostProcessor.  postProcessProperties(AutowiredAnnotationBeanPostProcessor.java:399) ~[com.mycompany.springbootbookapi.  SpringbootBookApiApplication:na]
  	... 18 common frames omitted
  Caused by: java.lang.ExceptionInInitializerError: null
  	at com.oracle.svm.core.classinitialization.ClassInitializationInfo.initialize(ClassInitializationInfo.  java:291) ~[na:na]
  	at net.bytebuddy.implementation.bind.annotation.TargetMethodAnnotationDrivenBinder$ParameterBinder.  <clinit>(TargetMethodAnnotationDrivenBinder.java:164) ~[na:na]
  	at com.oracle.svm.core.classinitialization.ClassInitializationInfo.invokeClassInitializer  (ClassInitializationInfo.java:351) ~[na:na]
  	at com.oracle.svm.core.classinitialization.ClassInitializationInfo.initialize(ClassInitializationInfo.  java:271) ~[na:na]
  	at net.bytebuddy.implementation.MethodDelegation.withDefaultConfiguration(MethodDelegation.java:601) ~  [na:na]
  	at net.bytebuddy.implementation.MethodDelegation.to(MethodDelegation.java:271) ~[na:na]
  	at org.hibernate.bytecode.internal.bytebuddy.ByteBuddyState$ProxyDefinitionHelpers$1.run  (ByteBuddyState.java:263) ~[na:na]
  	at org.hibernate.bytecode.internal.bytebuddy.ByteBuddyState$ProxyDefinitionHelpers$1.run  (ByteBuddyState.java:259) ~[na:na]
  	at org.hibernate.bytecode.internal.bytebuddy.ByteBuddyState$ProxyDefinitionHelpers.<init>  (ByteBuddyState.java:269) ~[na:na]
  	at org.hibernate.bytecode.internal.bytebuddy.ByteBuddyState$ProxyDefinitionHelpers.<init>  (ByteBuddyState.java:244) ~[na:na]
  	at org.hibernate.bytecode.internal.bytebuddy.ByteBuddyState.<init>(ByteBuddyState.java:86) ~[na:na]
  	at org.hibernate.bytecode.internal.bytebuddy.BytecodeProviderImpl.<init>(BytecodeProviderImpl.java:53)   ~[na:na]
  	at org.hibernate.cfg.Environment.buildBytecodeProvider(Environment.java:345) ~[na:na]
  	at org.hibernate.cfg.Environment.buildBytecodeProvider(Environment.java:337) ~[na:na]
  	at org.hibernate.cfg.Environment.<clinit>(Environment.java:230) ~[na:na]
  	at com.oracle.svm.core.classinitialization.ClassInitializationInfo.invokeClassInitializer  (ClassInitializationInfo.java:351) ~[na:na]
  	at com.oracle.svm.core.classinitialization.ClassInitializationInfo.initialize(ClassInitializationInfo.  java:271) ~[na:na]
  	at org.hibernate.jpa.boot.internal.EntityManagerFactoryBuilderImpl$MergedSettings.<init>  (EntityManagerFactoryBuilderImpl.java:1355) ~[na:na]
  	at org.hibernate.jpa.boot.internal.EntityManagerFactoryBuilderImpl$MergedSettings.<init>  (EntityManagerFactoryBuilderImpl.java:1345) ~[na:na]
  	at org.hibernate.jpa.boot.internal.EntityManagerFactoryBuilderImpl.mergeSettings  (EntityManagerFactoryBuilderImpl.java:478) ~[na:na]
  	at org.hibernate.jpa.boot.internal.EntityManagerFactoryBuilderImpl.<init>  (EntityManagerFactoryBuilderImpl.java:217) ~[na:na]
  	at org.hibernate.jpa.boot.internal.EntityManagerFactoryBuilderImpl.<init>  (EntityManagerFactoryBuilderImpl.java:168) ~[na:na]
  	at org.springframework.orm.jpa.vendor.SpringHibernateJpaPersistenceProvider.  createContainerEntityManagerFactory(SpringHibernateJpaPersistenceProvider.java:52) ~[na:na]
  	at org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean.createNativeEntityManagerFactory  (LocalContainerEntityManagerFactoryBean.java:365) ~[com.mycompany.springbootbookapi.  SpringbootBookApiApplication:na]
  	at org.springframework.orm.jpa.AbstractEntityManagerFactoryBean.buildNativeEntityManagerFactory  (AbstractEntityManagerFactoryBean.java:409) ~[com.mycompany.springbootbookapi.  SpringbootBookApiApplication:na]
  	at java.util.concurrent.FutureTask.run(FutureTask.java:264) ~[na:na]
  	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1128) ~[na:na]
  	at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:628) ~[na:na]
  	at java.lang.Thread.run(Thread.java:834) ~[na:na]
  	at com.oracle.svm.core.thread.JavaThreads.threadStartRoutine(JavaThreads.java:517) ~[na:na]
  	at com.oracle.svm.core.posix.thread.PosixJavaThreads.pthreadStartRoutine(PosixJavaThreads.java:192) ~  [na:na]
  Caused by: java.lang.IllegalStateException: size = 0
	at net.bytebuddy.matcher.FilterableList$AbstractBase.getOnly(FilterableList.java:139) ~[na:na]
	at net.bytebuddy.implementation.bind.annotation.Super$Binder.<clinit>(Super.java:223) ~[na:na]
	at com.oracle.svm.core.classinitialization.ClassInitializationInfo.invokeClassInitializer(ClassInitializationInfo.java:351) ~[na:na]
	at com.oracle.svm.core.classinitialization.ClassInitializationInfo.initialize(ClassInitializationInfo.java:271) ~[na:na]
	... 30 common frames omitted
  ```