# graalvm-quarkus-micronaut-springboot
## `> elasticsearch > springboot-elasticsearch`

## Application

- ### springboot-elasticsearch

  [`Spring Boot`](https://docs.spring.io/spring-boot/docs/current/reference/htmlsingle/) Java Web application that expose a simple REST API for indexing and searching movies in `Elasticsearch`.
  
  It has the following endpoint:
  ```
  POST /api/movies -d {"imdb": "...", "title": "..."}
  GET /api/movies[?title=...]
  ```

## Running application

> **Note:** `Elasticsearch` container must be running and initialized as explained [here](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/elasticsearch#start-environment)

### Development Mode

- Open a terminal and navigate to `graalvm-quarkus-micronaut-springboot/elasticsearch/springboot-elasticsearch` folder

- Run the command below to start the application
  ```
  ./mvnw clean spring-boot:run
  ```

- A simple test can be done by opening a new terminal and running
  ```
  curl -i -X POST "localhost:8080/api/movies" -H "Content-type: application/json" \
    -d '{"imdb": "123", "title": "I, Tonya"}'
  
  curl -i "localhost:8080/api/movies?title=tonya"
  ```

- To stop the application, press `Ctrl+C` in its terminal

### Docker in JVM Mode

- In a terminal, make sure you are inside `graalvm-quarkus-micronaut-springboot/elasticsearch/springboot-elasticsearch` folder

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
  docker run --rm --name springboot-elasticsearch-jvm \
    -p 9109:8080 -e ELASTICSEARCH_HOST=elasticsearch --network elasticsearch_default \
    docker.mycompany.com/springboot-elasticsearch-jvm:1.0.0
  ```

- A simple test can be done by opening a new terminal and running
  ```
  curl -i -X POST "localhost:9109/api/movies" -H "Content-type: application/json" \
    -d '{"imdb": "456", "title": "American Pie"}'
  
  curl -i "localhost:9109/api/movies?title=american"
  ```

- To stop and remove application Docker container, press `Ctrl+C` in its terminal

### Docker in Native Mode

- In a terminal, make sure you are inside `graalvm-quarkus-micronaut-springboot/elasticsearch/springboot-elasticsearch` folder

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
  docker run --rm --name springboot-elasticsearch-native \
    -p 9110:8080 -e ELASTICSEARCH_HOST=elasticsearch --network elasticsearch_default \
    docker.mycompany.com/springboot-elasticsearch-native:1.0.0
  ```

- A simple test can be done by opening a new terminal and running
  ```
  curl -i -X POST "localhost:9110/api/movies" -H "Content-type: application/json" \
    -d '{"imdb": "789", "title": "Resident Evil"}'
  
  curl -i "localhost:9110/api/movies?title=evil"
  ```

- To stop and remove application Docker container, press `Ctrl+C` in its terminal

## Issues

[Issue #387](https://github.com/spring-projects-experimental/spring-graalvm-native/issues/387) After building successfully the docker native image, the following exception is thrown during the application startup
```
  .   ____          _            __ _ _
 /\\ / ___'_ __ _ _(_)_ __  __ _ \ \ \ \
( ( )\___ | '_ | '_| | '_ \/ _` | \ \ \ \
 \\/  ___)| |_)| | | | | || (_| |  ) ) ) )
  '  |____| .__|_| |_|_| |_\__, | / / / /
 =========|_|==============|___/=/_/_/_/
 :: Spring Boot ::                (v2.4.0)

2020-11-25 08:59:18.956  INFO 1 --- [           main] c.m.s.SpringbootElasticsearchApplication : Starting SpringbootElasticsearchApplication using Java 11.0.9 on 3d51f13e799b with PID 1 (/workspace/com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication started by cnb in /workspace)
2020-11-25 08:59:18.956  INFO 1 --- [           main] c.m.s.SpringbootElasticsearchApplication : No active profile set, falling back to default profiles: default
2020-11-25 08:59:19.026  INFO 1 --- [           main] .s.d.r.c.RepositoryConfigurationDelegate : Bootstrapping Spring Data Elasticsearch repositories in DEFAULT mode.
2020-11-25 08:59:19.026  INFO 1 --- [           main] .s.d.r.c.RepositoryConfigurationDelegate : Finished Spring Data repository scanning in 0 ms. Found 0 Elasticsearch repository interfaces.
2020-11-25 08:59:19.027  INFO 1 --- [           main] .s.d.r.c.RepositoryConfigurationDelegate : Bootstrapping Spring Data Reactive Elasticsearch repositories in DEFAULT mode.
2020-11-25 08:59:19.027  INFO 1 --- [           main] .s.d.r.c.RepositoryConfigurationDelegate : Finished Spring Data repository scanning in 0 ms. Found 0 Reactive Elasticsearch repository interfaces.
2020-11-25 08:59:19.048  WARN 1 --- [           main] onfigReactiveWebServerApplicationContext : Exception encountered during context initialization - cancelling refresh attempt: org.springframework.beans.factory.UnsatisfiedDependencyException: Error creating bean with name 'movieServiceImpl' defined in class path resource [com/mycompany/springbootelasticsearch/service/MovieServiceImpl.class]: Unsatisfied dependency expressed through constructor parameter 0; nested exception is org.springframework.beans.factory.BeanCreationException: Error creating bean with name 'elasticsearchRestHighLevelClient' defined in class path resource [org/springframework/boot/autoconfigure/elasticsearch/ElasticsearchRestClientAutoConfiguration$RestHighLevelClientConfiguration.class]: Bean instantiation via factory method failed; nested exception is org.springframework.beans.BeanInstantiationException: Failed to instantiate [org.elasticsearch.client.RestHighLevelClient]: Factory method 'elasticsearchRestHighLevelClient' threw exception; nested exception is java.lang.IllegalStateException: could not create the default ssl context
2020-11-25 08:59:19.051  INFO 1 --- [           main] ConditionEvaluationReportLoggingListener :

Error starting ApplicationContext. To display the conditions report re-run your application with 'debug' enabled.
2020-11-25 08:59:19.052 ERROR 1 --- [           main] o.s.boot.SpringApplication               : Application run failed

org.springframework.beans.factory.UnsatisfiedDependencyException: Error creating bean with name 'movieServiceImpl' defined in class path resource [com/mycompany/springbootelasticsearch/service/MovieServiceImpl.class]: Unsatisfied dependency expressed through constructor parameter 0; nested exception is org.springframework.beans.factory.BeanCreationException: Error creating bean with name 'elasticsearchRestHighLevelClient' defined in class path resource [org/springframework/boot/autoconfigure/elasticsearch/ElasticsearchRestClientAutoConfiguration$RestHighLevelClientConfiguration.class]: Bean instantiation via factory method failed; nested exception is org.springframework.beans.BeanInstantiationException: Failed to instantiate [org.elasticsearch.client.RestHighLevelClient]: Factory method 'elasticsearchRestHighLevelClient' threw exception; nested exception is java.lang.IllegalStateException: could not create the default ssl context
	at org.springframework.beans.factory.support.ConstructorResolver.createArgumentArray(ConstructorResolver.java:798) ~[na:na]
	at org.springframework.beans.factory.support.ConstructorResolver.autowireConstructor(ConstructorResolver.java:228) ~[na:na]
	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.autowireConstructor(AbstractAutowireCapableBeanFactory.java:1356) ~[na:na]
	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.createBeanInstance(AbstractAutowireCapableBeanFactory.java:1206) ~[na:na]
	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.doCreateBean(AbstractAutowireCapableBeanFactory.java:571) ~[na:na]
	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.createBean(AbstractAutowireCapableBeanFactory.java:531) ~[na:na]
	at org.springframework.beans.factory.support.AbstractBeanFactory.lambda$doGetBean$0(AbstractBeanFactory.java:335) ~[na:na]
	at org.springframework.beans.factory.support.DefaultSingletonBeanRegistry.getSingleton(DefaultSingletonBeanRegistry.java:234) ~[na:na]
	at org.springframework.beans.factory.support.AbstractBeanFactory.doGetBean(AbstractBeanFactory.java:333) ~[na:na]
	at org.springframework.beans.factory.support.AbstractBeanFactory.getBean(AbstractBeanFactory.java:208) ~[na:na]
	at org.springframework.beans.factory.support.DefaultListableBeanFactory.preInstantiateSingletons(DefaultListableBeanFactory.java:944) ~[na:na]
	at org.springframework.context.support.AbstractApplicationContext.finishBeanFactoryInitialization(AbstractApplicationContext.java:925) ~[na:na]
	at org.springframework.context.support.AbstractApplicationContext.refresh(AbstractApplicationContext.java:588) ~[na:na]
	at org.springframework.boot.web.reactive.context.ReactiveWebServerApplicationContext.refresh(ReactiveWebServerApplicationContext.java:63) ~[na:na]
	at org.springframework.boot.SpringApplication.refresh(SpringApplication.java:767) ~[na:na]
	at org.springframework.boot.SpringApplication.refresh(SpringApplication.java:759) ~[na:na]
	at org.springframework.boot.SpringApplication.refreshContext(SpringApplication.java:426) ~[na:na]
	at org.springframework.boot.SpringApplication.run(SpringApplication.java:326) ~[na:na]
	at org.springframework.boot.SpringApplication.run(SpringApplication.java:1309) ~[na:na]
	at org.springframework.boot.SpringApplication.run(SpringApplication.java:1298) ~[na:na]
	at com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication.main(SpringbootElasticsearchApplication.java:10) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:na]
Caused by: org.springframework.beans.factory.BeanCreationException: Error creating bean with name 'elasticsearchRestHighLevelClient' defined in class path resource [org/springframework/boot/autoconfigure/elasticsearch/ElasticsearchRestClientAutoConfiguration$RestHighLevelClientConfiguration.class]: Bean instantiation via factory method failed; nested exception is org.springframework.beans.BeanInstantiationException: Failed to instantiate [org.elasticsearch.client.RestHighLevelClient]: Factory method 'elasticsearchRestHighLevelClient' threw exception; nested exception is java.lang.IllegalStateException: could not create the default ssl context
	at org.springframework.beans.factory.support.ConstructorResolver.instantiate(ConstructorResolver.java:656) ~[na:na]
	at org.springframework.beans.factory.support.ConstructorResolver.instantiateUsingFactoryMethod(ConstructorResolver.java:636) ~[na:na]
	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.instantiateUsingFactoryMethod(AbstractAutowireCapableBeanFactory.java:1336) ~[na:na]
	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.createBeanInstance(AbstractAutowireCapableBeanFactory.java:1179) ~[na:na]
	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.doCreateBean(AbstractAutowireCapableBeanFactory.java:571) ~[na:na]
	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.createBean(AbstractAutowireCapableBeanFactory.java:531) ~[na:na]
	at org.springframework.beans.factory.support.AbstractBeanFactory.lambda$doGetBean$0(AbstractBeanFactory.java:335) ~[na:na]
	at org.springframework.beans.factory.support.DefaultSingletonBeanRegistry.getSingleton(DefaultSingletonBeanRegistry.java:234) ~[na:na]
	at org.springframework.beans.factory.support.AbstractBeanFactory.doGetBean(AbstractBeanFactory.java:333) ~[na:na]
	at org.springframework.beans.factory.support.AbstractBeanFactory.getBean(AbstractBeanFactory.java:208) ~[na:na]
	at org.springframework.beans.factory.config.DependencyDescriptor.resolveCandidate(DependencyDescriptor.java:276) ~[na:na]
	at org.springframework.beans.factory.support.DefaultListableBeanFactory.doResolveDependency(DefaultListableBeanFactory.java:1367) ~[na:na]
	at org.springframework.beans.factory.support.DefaultListableBeanFactory.resolveDependency(DefaultListableBeanFactory.java:1287) ~[na:na]
	at org.springframework.beans.factory.support.ConstructorResolver.resolveAutowiredArgument(ConstructorResolver.java:885) ~[na:na]
	at org.springframework.beans.factory.support.ConstructorResolver.createArgumentArray(ConstructorResolver.java:789) ~[na:na]
	... 20 common frames omitted
Caused by: org.springframework.beans.BeanInstantiationException: Failed to instantiate [org.elasticsearch.client.RestHighLevelClient]: Factory method 'elasticsearchRestHighLevelClient' threw exception; nested exception is java.lang.IllegalStateException: could not create the default ssl context
	at org.springframework.beans.factory.support.SimpleInstantiationStrategy.instantiate(SimpleInstantiationStrategy.java:185) ~[na:na]
	at org.springframework.beans.factory.support.ConstructorResolver.instantiate(ConstructorResolver.java:651) ~[na:na]
	... 34 common frames omitted
Caused by: java.lang.IllegalStateException: could not create the default ssl context
	at org.elasticsearch.client.RestClientBuilder.createHttpClient(RestClientBuilder.java:221) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:7.9.3]
	at java.security.AccessController.doPrivileged(AccessController.java:84) ~[na:na]
	at org.elasticsearch.client.RestClientBuilder.build(RestClientBuilder.java:191) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:7.9.3]
	at org.elasticsearch.client.RestHighLevelClient.<init>(RestHighLevelClient.java:287) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:7.9.3]
	at org.elasticsearch.client.RestHighLevelClient.<init>(RestHighLevelClient.java:279) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:7.9.3]
	at org.springframework.boot.autoconfigure.elasticsearch.ElasticsearchRestClientAutoConfiguration$RestHighLevelClientConfiguration.elasticsearchRestHighLevelClient(ElasticsearchRestClientAutoConfiguration.java:113) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:2.4.0]
	at java.lang.reflect.Method.invoke(Method.java:566) ~[na:na]
	at org.springframework.beans.factory.support.SimpleInstantiationStrategy.instantiate(SimpleInstantiationStrategy.java:154) ~[na:na]
	... 35 common frames omitted
Caused by: java.security.NoSuchAlgorithmException: class configured for SSLContext (provider: SunJSSE) cannot be found.
	at java.security.Provider$Service.getImplClass(Provider.java:1933) ~[na:na]
	at java.security.Provider$Service.newInstance(Provider.java:1894) ~[na:na]
	at sun.security.jca.GetInstance.getInstance(GetInstance.java:236) ~[na:na]
	at sun.security.jca.GetInstance.getInstance(GetInstance.java:164) ~[na:na]
	at javax.net.ssl.SSLContext.getInstance(SSLContext.java:168) ~[na:na]
	at javax.net.ssl.SSLContext.getDefault(SSLContext.java:99) ~[na:na]
	at org.elasticsearch.client.RestClientBuilder.createHttpClient(RestClientBuilder.java:212) ~[com.mycompany.springbootelasticsearch.SpringbootElasticsearchApplication:7.9.3]
	... 42 common frames omitted
Caused by: java.lang.ClassNotFoundException: sun.security.ssl.SSLContextImpl$DefaultSSLContext
	at com.oracle.svm.core.hub.ClassForNameSupport.forName(ClassForNameSupport.java:60) ~[na:na]
	at java.lang.Class.forName(DynamicHub.java:1279) ~[na:na]
	at java.security.Provider$Service.getImplClass(Provider.java:1918) ~[na:na]
	... 48 common frames omitted
```