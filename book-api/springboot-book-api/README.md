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
  ./mvnw clean spring-boot:run
  ```

- A simple test can be done by opening a new terminal and running
  ```
  curl -i -X POST localhost:8080/api/books -H "Content-Type: application/json" \
    -d '{"isbn": "123", "title": "Learn Java"}'
  
  curl -i localhost:8080/api/books
  ```

- To stop the application, press `Ctrl+C` in its terminal

### Docker in JVM Mode

- In a terminal, make sure you are inside `graalvm-quarkus-micronaut-springboot/book-api/springboot-book-api` folder

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

- To stop and remove application Docker container, press `Ctrl+C` in its terminal

### Docker in Native Mode

- In a terminal, make sure you are inside `graalvm-quarkus-micronaut-springboot/book-api/springboot-book-api` folder

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
    -d '{"isbn": "123", "title": "Learn Learn GraalVM"}'
  
  curl -i localhost:9090/api/books
  ```

- To stop and remove application Docker container, press `Ctrl+C` in its terminal

## Issues

When using `spring-boot` version `2.4.0`, it's throwing an exception while building the native image
```
[INFO] Scanning for projects...
[INFO]
[INFO] -----------------< com.mycompany:springboot-book-api >------------------
[INFO] Building springboot-book-api 1.0.0
[INFO] --------------------------------[ jar ]---------------------------------
[INFO]
[INFO] >>> spring-boot-maven-plugin:2.4.0:build-image (default-cli) > package @ springboot-book-api >>>
[INFO]
[INFO] --- maven-resources-plugin:3.2.0:resources (default-resources) @ springboot-book-api ---
[INFO] Using 'UTF-8' encoding to copy filtered resources.
[INFO] Using 'UTF-8' encoding to copy filtered properties files.
[INFO] Copying 1 resource
[INFO] Copying 1 resource
[INFO] The encoding used to copy filtered properties files have not been set. This means that the same encoding will be used to copy filtered properties files as when copying other filtered resources. This might not be what you want! Run your build with --debug to see which files might be affected. Read more at https://maven.apache.org/plugins/maven-resources-plugin/examples/filtering-properties-files.html
[INFO]
[INFO] --- maven-compiler-plugin:3.8.1:compile (default-compile) @ springboot-book-api ---
[INFO] Nothing to compile - all classes are up to date
[INFO]
[INFO] --- hibernate-enhance-maven-plugin:5.4.23.Final:enhance (default) @ springboot-book-api ---
[INFO] Starting Hibernate enhancement for classes on /Users/ivan.franchin/github-projects/graalvm-quarkus-micronaut-springboot/book-api/springboot-book-api/target/classes
Nov 22, 2020 10:56:23 AM org.hibernate.Version logVersion
INFO: HHH000412: Hibernate ORM core version 5.4.23.Final
[INFO]
[INFO] --- maven-resources-plugin:3.2.0:testResources (default-testResources) @ springboot-book-api ---
[INFO] Using 'UTF-8' encoding to copy filtered resources.
[INFO] Using 'UTF-8' encoding to copy filtered properties files.
[INFO] skip non existing resourceDirectory /Users/ivan.franchin/github-projects/graalvm-quarkus-micronaut-springboot/book-api/springboot-book-api/src/test/resources
[INFO]
[INFO] --- maven-compiler-plugin:3.8.1:testCompile (default-testCompile) @ springboot-book-api ---
[INFO] No sources to compile
[INFO]
[INFO] --- maven-surefire-plugin:2.22.2:test (default-test) @ springboot-book-api ---
[INFO] No tests to run.
[INFO]
[INFO] --- maven-jar-plugin:3.2.0:jar (default-jar) @ springboot-book-api ---
[INFO] Building jar: /Users/ivan.franchin/github-projects/graalvm-quarkus-micronaut-springboot/book-api/springboot-book-api/target/springboot-book-api-1.0.0.jar
[INFO]
[INFO] --- spring-boot-maven-plugin:2.4.0:repackage (repackage) @ springboot-book-api ---
[INFO] Replacing main artifact with repackaged archive
[INFO]
[INFO] <<< spring-boot-maven-plugin:2.4.0:build-image (default-cli) < package @ springboot-book-api <<<
[INFO]
[INFO]
[INFO] --- spring-boot-maven-plugin:2.4.0:build-image (default-cli) @ springboot-book-api ---
[INFO] Building image 'docker.mycompany.com/springboot-book-api-native:1.0.0'
[INFO]
[INFO]  > Pulling builder image 'docker.io/paketobuildpacks/builder:tiny' 100%
[INFO]  > Pulled builder image 'paketobuildpacks/builder@sha256:18647a7ec9d1dd4d4a295d7d8a8e77985b796a891196309365cee6376d94cd47'
[INFO]  > Pulling run image 'docker.io/paketobuildpacks/run:tiny-cnb' 100%
[INFO]  > Pulled run image 'paketobuildpacks/run@sha256:2c29acb375a46dc4c27233ccdf85ec62485ddcee1725e72d05f1b04918b1535c'
[INFO]  > Executing lifecycle version v0.9.3
[INFO]  > Using build cache volume 'pack-cache-df47cfb6db74.build'
[INFO]
[INFO]  > Running creator
[INFO]     [creator]     ===> DETECTING
[INFO]     [creator]     4 of 11 buildpacks participating
[INFO]     [creator]     paketo-buildpacks/graalvm                  3.4.0
[INFO]     [creator]     paketo-buildpacks/executable-jar           3.1.3
[INFO]     [creator]     paketo-buildpacks/spring-boot              3.4.0
[INFO]     [creator]     paketo-buildpacks/spring-boot-native-image 1.6.1
[INFO]     [creator]     ===> ANALYZING
[INFO]     [creator]     ===> RESTORING
[INFO]     [creator]     ===> BUILDING
[INFO]     [creator]
[INFO]     [creator]     Paketo GraalVM Buildpack 3.4.0
[INFO]     [creator]       https://github.com/paketo-buildpacks/graalvm
[INFO]     [creator]       Build Configuration:
[INFO]     [creator]         $BP_JVM_VERSION              11.*            the Java version
[INFO]     [creator]       Launch Configuration:
[INFO]     [creator]         $BPL_JVM_HEAD_ROOM           0               the headroom in memory calculation
[INFO]     [creator]         $BPL_JVM_LOADED_CLASS_COUNT  35% of classes  the number of loaded classes in memory calculation
[INFO]     [creator]         $BPL_JVM_THREAD_COUNT        250             the number of threads in memory calculation
[INFO]     [creator]         $JAVA_TOOL_OPTIONS                           the JVM launch flags
[INFO]     [creator]       GraalVM JDK 11.0.9: Contributing to layer
[INFO]     [creator]         Downloading from https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-20.3.0/graalvm-ce-java11-linux-amd64-20.3.0.tar.gz
[INFO]     [creator]         Verifying checksum
[INFO]     [creator]         Expanding to /layers/paketo-buildpacks_graalvm/jdk
[INFO]     [creator]         Adding 138 container CA certificates to JVM truststore
[INFO]     [creator]       GraalVM Native Image Substrate VM 11.0.9
[INFO]     [creator]         Downloading from https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-20.3.0/native-image-installable-svm-java11-linux-amd64-20.3.0.jar
[INFO]     [creator]         Verifying checksum
[INFO]     [creator]         Installing substrate VM
[INFO]     [creator]     Processing Component archive: /tmp/6e67f3c5cc329956fe9bc33d571c2e771eff8f4f541bca275bb62744026d3726/native-image-installable-svm-java11-linux-amd64-20.3.0.jar
[INFO]     [creator]     Installing new component: Native Image (org.graalvm.native-image, version 20.3.0)
[INFO]     [creator]         Writing env.build/JAVA_HOME.override
[INFO]     [creator]         Writing env.build/JDK_HOME.override
[INFO]     [creator]
[INFO]     [creator]     Paketo Spring Boot Buildpack 3.4.0
[INFO]     [creator]       https://github.com/paketo-buildpacks/spring-boot
[INFO]     [creator]       Image labels:
[INFO]     [creator]         org.opencontainers.image.title
[INFO]     [creator]         org.opencontainers.image.version
[INFO]     [creator]         org.springframework.boot.spring-configuration-metadata.json
[INFO]     [creator]         org.springframework.boot.version
[INFO]     [creator]
[INFO]     [creator]     Paketo Spring Boot Native Image Buildpack 1.6.1
[INFO]     [creator]       https://github.com/paketo-buildpacks/spring-boot-native-image
[INFO]     [creator]       Build Configuration:
[INFO]     [creator]         $BP_BOOT_NATIVE_IMAGE                  1                                                                   the build to create a native image (requires GraalVM)
[INFO]     [creator]         $BP_BOOT_NATIVE_IMAGE_BUILD_ARGUMENTS  -Dspring.native.remove-yaml-support=true -Dspring.spel.ignore=true  the arguments to pass to the native-image command
[INFO]     [creator]       Native Image: Contributing to layer
[INFO]     [creator]         GraalVM Version 20.3.0 (Java Version 11.0.9+10-jvmci-20.3-b06)
[INFO]     [creator]         Executing native-image -Dspring.native.remove-yaml-support=true -Dspring.spel.ignore=true -H:+StaticExecutableWithDynamicLibC -H:Name=/layers/paketo-buildpacks_spring-boot-native-image/native-image/com.mycompany.springbootbookapi.SpringbootBookApiApplication -cp /workspace:/workspace/BOOT-INF/classes:/workspace/BOOT-INF/lib/spring-boot-starter-actuator-2.4.0.jar:/workspace/BOOT-INF/lib/spring-boot-starter-2.4.0.jar:/workspace/BOOT-INF/lib/spring-boot-2.4.0.jar:/workspace/BOOT-INF/lib/spring-boot-autoconfigure-2.4.0.jar:/workspace/BOOT-INF/lib/spring-boot-starter-logging-2.4.0.jar:/workspace/BOOT-INF/lib/logback-classic-1.2.3.jar:/workspace/BOOT-INF/lib/logback-core-1.2.3.jar:/workspace/BOOT-INF/lib/log4j-to-slf4j-2.13.3.jar:/workspace/BOOT-INF/lib/log4j-api-2.13.3.jar:/workspace/BOOT-INF/lib/jul-to-slf4j-1.7.30.jar:/workspace/BOOT-INF/lib/jakarta.annotation-api-1.3.5.jar:/workspace/BOOT-INF/lib/snakeyaml-1.27.jar:/workspace/BOOT-INF/lib/spring-boot-actuator-autoconfigure-2.4.0.jar:/workspace/BOOT-INF/lib/spring-boot-actuator-2.4.0.jar:/workspace/BOOT-INF/lib/jackson-databind-2.11.3.jar:/workspace/BOOT-INF/lib/jackson-annotations-2.11.3.jar:/workspace/BOOT-INF/lib/jackson-core-2.11.3.jar:/workspace/BOOT-INF/lib/jackson-datatype-jsr310-2.11.3.jar:/workspace/BOOT-INF/lib/micrometer-core-1.6.1.jar:/workspace/BOOT-INF/lib/HdrHistogram-2.1.12.jar:/workspace/BOOT-INF/lib/LatencyUtils-2.0.3.jar:/workspace/BOOT-INF/lib/spring-boot-starter-data-jpa-2.4.0.jar:/workspace/BOOT-INF/lib/spring-boot-starter-aop-2.4.0.jar:/workspace/BOOT-INF/lib/spring-aop-5.3.1.jar:/workspace/BOOT-INF/lib/aspectjweaver-1.9.6.jar:/workspace/BOOT-INF/lib/spring-boot-starter-jdbc-2.4.0.jar:/workspace/BOOT-INF/lib/HikariCP-3.4.5.jar:/workspace/BOOT-INF/lib/spring-jdbc-5.3.1.jar:/workspace/BOOT-INF/lib/jakarta.transaction-api-1.3.3.jar:/workspace/BOOT-INF/lib/jakarta.persistence-api-2.2.3.jar:/workspace/BOOT-INF/lib/hibernate-core-5.4.23.Final.jar:/workspace/BOOT-INF/lib/jboss-logging-3.4.1.Final.jar:/workspace/BOOT-INF/lib/antlr-2.7.7.jar:/workspace/BOOT-INF/lib/jandex-2.1.3.Final.jar:/workspace/BOOT-INF/lib/classmate-1.5.1.jar:/workspace/BOOT-INF/lib/dom4j-2.1.3.jar:/workspace/BOOT-INF/lib/hibernate-commons-annotations-5.1.2.Final.jar:/workspace/BOOT-INF/lib/jaxb-runtime-2.3.3.jar:/workspace/BOOT-INF/lib/txw2-2.3.3.jar:/workspace/BOOT-INF/lib/istack-commons-runtime-3.0.11.jar:/workspace/BOOT-INF/lib/jakarta.activation-1.2.2.jar:/workspace/BOOT-INF/lib/spring-data-jpa-2.4.1.jar:/workspace/BOOT-INF/lib/spring-data-commons-2.4.1.jar:/workspace/BOOT-INF/lib/spring-orm-5.3.1.jar:/workspace/BOOT-INF/lib/spring-context-5.3.1.jar:/workspace/BOOT-INF/lib/spring-expression-5.3.1.jar:/workspace/BOOT-INF/lib/spring-tx-5.3.1.jar:/workspace/BOOT-INF/lib/spring-beans-5.3.1.jar:/workspace/BOOT-INF/lib/slf4j-api-1.7.30.jar:/workspace/BOOT-INF/lib/spring-aspects-5.3.1.jar:/workspace/BOOT-INF/lib/spring-boot-starter-validation-2.4.0.jar:/workspace/BOOT-INF/lib/jakarta.el-3.0.3.jar:/workspace/BOOT-INF/lib/hibernate-validator-6.1.6.Final.jar:/workspace/BOOT-INF/lib/jakarta.validation-api-2.0.2.jar:/workspace/BOOT-INF/lib/spring-boot-starter-webflux-2.4.0.jar:/workspace/BOOT-INF/lib/spring-boot-starter-json-2.4.0.jar:/workspace/BOOT-INF/lib/jackson-datatype-jdk8-2.11.3.jar:/workspace/BOOT-INF/lib/jackson-module-parameter-names-2.11.3.jar:/workspace/BOOT-INF/lib/spring-boot-starter-reactor-netty-2.4.0.jar:/workspace/BOOT-INF/lib/reactor-netty-http-1.0.1.jar:/workspace/BOOT-INF/lib/netty-codec-http-4.1.54.Final.jar:/workspace/BOOT-INF/lib/netty-common-4.1.54.Final.jar:/workspace/BOOT-INF/lib/netty-buffer-4.1.54.Final.jar:/workspace/BOOT-INF/lib/netty-transport-4.1.54.Final.jar:/workspace/BOOT-INF/lib/netty-codec-4.1.54.Final.jar:/workspace/BOOT-INF/lib/netty-handler-4.1.54.Final.jar:/workspace/BOOT-INF/lib/netty-codec-http2-4.1.54.Final.jar:/workspace/BOOT-INF/lib/netty-resolver-dns-4.1.54.Final.jar:/workspace/BOOT-INF/lib/netty-resolver-4.1.54.Final.jar:/workspace/BOOT-INF/lib/netty-codec-dns-4.1.54.Final.jar:/workspace/BOOT-INF/lib/netty-transport-native-epoll-4.1.54.Final-linux-x86_64.jar:/workspace/BOOT-INF/lib/netty-transport-native-unix-common-4.1.54.Final.jar:/workspace/BOOT-INF/lib/reactor-netty-core-1.0.1.jar:/workspace/BOOT-INF/lib/netty-handler-proxy-4.1.54.Final.jar:/workspace/BOOT-INF/lib/netty-codec-socks-4.1.54.Final.jar:/workspace/BOOT-INF/lib/spring-web-5.3.1.jar:/workspace/BOOT-INF/lib/spring-webflux-5.3.1.jar:/workspace/BOOT-INF/lib/spring-graalvm-native-0.8.2.jar:/workspace/BOOT-INF/lib/mapstruct-1.4.1.Final.jar:/workspace/BOOT-INF/lib/mysql-connector-java-8.0.22.jar:/workspace/BOOT-INF/lib/lombok-1.18.16.jar:/workspace/BOOT-INF/lib/jakarta.xml.bind-api-2.3.3.jar:/workspace/BOOT-INF/lib/jakarta.activation-api-1.2.2.jar:/workspace/BOOT-INF/lib/spring-core-5.3.1.jar:/workspace/BOOT-INF/lib/spring-jcl-5.3.1.jar:/workspace/BOOT-INF/lib/reactor-core-3.4.0.jar:/workspace/BOOT-INF/lib/reactive-streams-1.0.3.jar:/workspace/BOOT-INF/lib/spring-boot-jarmode-layertools-2.4.0.jar com.mycompany.springbootbookapi.SpringbootBookApiApplication
[INFO]     [creator]     [/layers/paketo-buildpacks_spring-boot-native-image/native-image/com.mycompany.springbootbookapi.SpringbootBookApiApplication:156]    classlist:   6,745.71 ms,  1.19 GB
[INFO]     [creator]        ____         _             _____              ___   ____  ___
[INFO]     [creator]       / __/__  ____(_)__  ___ _  / ___/______ ____ _/ / | / /  |/  /
[INFO]     [creator]      _\ \/ _ \/ __/ / _ \/ _ `/ / (_ / __/ _ `/ _ `/ /| |/ / /|_/ /
[INFO]     [creator]     /___/ .__/_/ /_/_//_/\_, /  \___/_/  \_,_/\_,_/_/ |___/_/  /_/
[INFO]     [creator]        /_/__     __  _  /___/
[INFO]     [creator]       / |/ /__ _/ /_(_)  _____
[INFO]     [creator]      /    / _ `/ __/ / |/ / -_)
[INFO]     [creator]     /_/|_/\_,_/\__/_/|___/\__/
[INFO]     [creator]
[INFO]     [creator]     Removing unused configurations
[INFO]     [creator]     Removing Yaml support
[INFO]     [creator]     Removing XML support
[INFO]     [creator]     Removing SpEL support
[INFO]     [creator]     Removing JMX support
[INFO]     [creator]     Use -Dspring.native.verbose=true on native-image call to see more detailed information from the feature
[INFO]     [creator]     [/layers/paketo-buildpacks_spring-boot-native-image/native-image/com.mycompany.springbootbookapi.SpringbootBookApiApplication:156]        (cap):     766.66 ms,  1.19 GB
[INFO]     [creator]     feature operating mode: reflection (spring init active? false)
[INFO]     [creator]     Found #15 types in static reflection list to register
[INFO]     [creator]     Skipping #5 types not on the classpath
[INFO]     [creator]     Attempting proxy registration of #12 proxies
[INFO]     [creator]     Skipped registration of #1 proxies - relevant types not on classpath
[INFO]     [creator]     [/layers/paketo-buildpacks_spring-boot-native-image/native-image/com.mycompany.springbootbookapi.SpringbootBookApiApplication:156]        setup:   3,409.47 ms,  1.19 GB
[INFO]     [creator]     Configuring initialization time for specific types and packages:
[INFO]     [creator]     #139 buildtime-init-classes   #22 buildtime-init-packages   #18 runtime-init-classes    #0 runtime-init-packages
[INFO]     [creator]
[INFO]     [creator]     Warning: class initialization of class org.springframework.boot.logging.log4j2.Log4J2LoggingSystem failed with exception java.lang.NoClassDefFoundError: org/apache/logging/log4j/core/Filter. This class will be initialized at run time because option --allow-incomplete-classpath is used for image building. Use the option --initialize-at-run-time=org.springframework.boot.logging.log4j2.Log4J2LoggingSystem to explicitly request delayed initialization of this class.
[INFO]     [creator]     Warning: class initialization of class org.springframework.boot.web.embedded.tomcat.TomcatServletWebServerFactory failed with exception java.lang.NoClassDefFoundError: org/apache/catalina/Manager. This class will be initialized at run time because option --allow-incomplete-classpath is used for image building. Use the option --initialize-at-run-time=org.springframework.boot.web.embedded.tomcat.TomcatServletWebServerFactory to explicitly request delayed initialization of this class.
[INFO]     [creator]     10:02:23.555 [ForkJoinPool-4-worker-3] DEBUG org.jboss.logging - Logging Provider: org.jboss.logging.Log4j2LoggerProvider
[INFO]     [creator]     10:02:23.556 [ForkJoinPool-4-worker-3] INFO org.hibernate.validator.internal.util.Version - HV000001: Hibernate Validator 6.1.6.Final
[INFO]     [creator]     Registering resources - #0 bundles
[INFO]     [creator]     Processing META-INF/spring.factories files...
[INFO]     [creator]     spring.factories processing, problem adding access for key org.springframework.boot.liquibase.LiquibaseChangelogMissingFailureAnalyzer: liquibase/exception/ChangeLogParseException
[INFO]     [creator]     Processing spring.factories - PropertySourceLoader lists #1 property source loaders
[INFO]     [creator]     Processing spring.factories - EnableAutoConfiguration lists #130 configurations
[INFO]     [creator]     Reducing access on org.springframework.boot.autoconfigure.web.ServerProperties$Undertow because Undertow not around
[INFO]     [creator]     Reducing access on org.springframework.boot.autoconfigure.web.ServerProperties$Tomcat because Tomcat not around
[INFO]     [creator]     Reducing access on org.springframework.boot.autoconfigure.web.ServerProperties$Jetty because WebAppContext not around
[INFO]     [creator]     Reducing access on org.springframework.boot.autoconfigure.web.ServerProperties$Undertow because Undertow not around
[INFO]     [creator]     Reducing access on org.springframework.boot.autoconfigure.web.ServerProperties$Tomcat because Tomcat not around
[INFO]     [creator]     Reducing access on org.springframework.boot.autoconfigure.web.ServerProperties$Jetty because WebAppContext not around
[INFO]     [creator]     Reducing access on org.springframework.boot.autoconfigure.web.ServerProperties$Undertow because Undertow not around
[INFO]     [creator]     Reducing access on org.springframework.boot.autoconfigure.web.ServerProperties$Tomcat because Tomcat not around
[INFO]     [creator]     Reducing access on org.springframework.boot.autoconfigure.web.ServerProperties$Jetty because WebAppContext not around
[INFO]     [creator]     Reducing access on org.springframework.boot.autoconfigure.web.ServerProperties$Undertow because Undertow not around
[INFO]     [creator]     Reducing access on org.springframework.boot.autoconfigure.web.ServerProperties$Tomcat because Tomcat not around
[INFO]     [creator]     Reducing access on org.springframework.boot.autoconfigure.web.ServerProperties$Jetty because WebAppContext not around
[INFO]     [creator]     Excluding 97 auto-configurations from spring.factories file
[INFO]     [creator]     Processing spring.factories - EnableAutoConfiguration lists #96 configurations
[INFO]     [creator]     Excluding 53 auto-configurations from spring.factories file
[INFO]     [creator]     Found no META-INF/spring.components -> synthesizing one...
[INFO]     [creator]     Computed spring.components is
[INFO]     [creator]     vvv
[INFO]     [creator]     com.mycompany.springbootbookapi.mapper.BookMapperImpl=org.springframework.stereotype.Component
[INFO]     [creator]     com.mycompany.springbootbookapi.SpringbootBookApiApplication=org.springframework.stereotype.Component
[INFO]     [creator]     com.mycompany.springbootbookapi.repository.BookRepository=org.springframework.data.repository.Repository
[INFO]     [creator]     com.mycompany.springbootbookapi.rest.BookController=org.springframework.stereotype.Component
[INFO]     [creator]     com.mycompany.springbootbookapi.model.Book=javax.persistence.Entity,javax.persistence.Table
[INFO]     [creator]     com.mycompany.springbootbookapi.config.ErrorAttributesConfig=org.springframework.stereotype.Component
[INFO]     [creator]     com.mycompany.springbootbookapi.service.BookServiceImpl=org.springframework.stereotype.Component
[INFO]     [creator]     ^^^
[INFO]     [creator]     SDCP: Found 1 repositories, 0 custom implementations and registered 0 annotations used by domain types.
[INFO]     [creator]     Number of types dynamically registered for reflective access: #3653
[INFO]     [creator]     10:02:28.218 [ForkJoinPool-4-worker-7] DEBUG io.netty.util.internal.logging.InternalLoggerFactory - Using SLF4J as the default logging framework
[INFO]     [creator]     10:02:28.295 [ForkJoinPool-4-worker-7] DEBUG io.netty.util.internal.InternalThreadLocalMap - -Dio.netty.threadLocalMap.stringBuilder.initialSize: 1024
[INFO]     [creator]     10:02:28.295 [ForkJoinPool-4-worker-7] DEBUG io.netty.util.internal.InternalThreadLocalMap - -Dio.netty.threadLocalMap.stringBuilder.maxSize: 4096
[INFO]     [creator]     10:02:30.098 [ForkJoinPool-4-worker-5] DEBUG io.netty.util.internal.PlatformDependent0 - -Dio.netty.noUnsafe: false
[INFO]     [creator]     10:02:30.098 [ForkJoinPool-4-worker-5] DEBUG io.netty.util.internal.PlatformDependent0 - Java version: 11
[INFO]     [creator]     10:02:30.098 [ForkJoinPool-4-worker-5] DEBUG io.netty.util.internal.PlatformDependent0 - sun.misc.Unsafe.theUnsafe: available
[INFO]     [creator]     10:02:30.099 [ForkJoinPool-4-worker-5] DEBUG io.netty.util.internal.PlatformDependent0 - sun.misc.Unsafe.copyMemory: available
[INFO]     [creator]     10:02:30.099 [ForkJoinPool-4-worker-5] DEBUG io.netty.util.internal.PlatformDependent0 - java.nio.Buffer.address: available
[INFO]     [creator]     10:02:30.099 [ForkJoinPool-4-worker-5] DEBUG io.netty.util.internal.PlatformDependent0 - direct buffer constructor: unavailable
[INFO]     [creator]     java.lang.UnsupportedOperationException: Reflective setAccessible(true) disabled
[INFO]     [creator]     	at io.netty.util.internal.ReflectionUtil.trySetAccessible(ReflectionUtil.java:31)
[INFO]     [creator]     	at io.netty.util.internal.PlatformDependent0$4.run(PlatformDependent0.java:238)
[INFO]     [creator]     	at java.base/java.security.AccessController.doPrivileged(Native Method)
[INFO]     [creator]     	at io.netty.util.internal.PlatformDependent0.<clinit>(PlatformDependent0.java:232)
[INFO]     [creator]     	at io.netty.util.internal.PlatformDependent.isAndroid(PlatformDependent.java:293)
[INFO]     [creator]     	at io.netty.util.internal.PlatformDependent.<clinit>(PlatformDependent.java:92)
[INFO]     [creator]     	at io.netty.util.AsciiString.<init>(AsciiString.java:223)
[INFO]     [creator]     	at io.netty.util.AsciiString.<init>(AsciiString.java:210)
[INFO]     [creator]     	at io.netty.util.AsciiString.cached(AsciiString.java:1401)
[INFO]     [creator]     	at io.netty.util.AsciiString.<clinit>(AsciiString.java:48)
[INFO]     [creator]     	at io.netty.handler.codec.http.HttpResponseStatus.<init>(HttpResponseStatus.java:559)
[INFO]     [creator]     	at io.netty.handler.codec.http.HttpResponseStatus.newStatus(HttpResponseStatus.java:326)
[INFO]     [creator]     	at io.netty.handler.codec.http.HttpResponseStatus.<clinit>(HttpResponseStatus.java:39)
[INFO]     [creator]     	at io.netty.handler.codec.http.HttpObjectAggregator.<clinit>(HttpObjectAggregator.java:90)
[INFO]     [creator]     	at java.base/jdk.internal.misc.Unsafe.ensureClassInitialized0(Native Method)
[INFO]     [creator]     	at java.base/jdk.internal.misc.Unsafe.ensureClassInitialized(Unsafe.java:1042)
[INFO]     [creator]     	at jdk.unsupported/sun.misc.Unsafe.ensureClassInitialized(Unsafe.java:698)
[INFO]     [creator]     	at com.oracle.svm.hosted.classinitialization.ConfigurableClassInitialization.ensureClassInitialized(ConfigurableClassInitialization.java:174)
[INFO]     [creator]     	at com.oracle.svm.hosted.classinitialization.ConfigurableClassInitialization.computeInitKindAndMaybeInitializeClass(ConfigurableClassInitialization.java:607)
[INFO]     [creator]     	at com.oracle.svm.hosted.classinitialization.ConfigurableClassInitialization.computeInitKindAndMaybeInitializeClass(ConfigurableClassInitialization.java:127)
[INFO]     [creator]     	at com.oracle.svm.hosted.classinitialization.ConfigurableClassInitialization.maybeInitializeHosted(ConfigurableClassInitialization.java:165)
[INFO]     [creator]     	at com.oracle.svm.hosted.SVMHost.initializeType(SVMHost.java:265)
[INFO]     [creator]     	at com.oracle.graal.pointsto.meta.AnalysisType.lambda$new$0(AnalysisType.java:227)
[INFO]     [creator]     	at java.base/java.util.concurrent.Executors$RunnableAdapter.call(Executors.java:515)
[INFO]     [creator]     	at java.base/java.util.concurrent.FutureTask.run(FutureTask.java:264)
[INFO]     [creator]     	at java.base/java.util.concurrent.ForkJoinTask$RunnableExecuteAction.exec(ForkJoinTask.java:1426)
[INFO]     [creator]     	at java.base/java.util.concurrent.ForkJoinTask.doExec(ForkJoinTask.java:290)
[INFO]     [creator]     	at java.base/java.util.concurrent.ForkJoinPool$WorkQueue.topLevelExec(ForkJoinPool.java:1020)
[INFO]     [creator]     	at java.base/java.util.concurrent.ForkJoinPool.scan(ForkJoinPool.java:1656)
[INFO]     [creator]     	at java.base/java.util.concurrent.ForkJoinPool.runWorker(ForkJoinPool.java:1594)
[INFO]     [creator]     	at java.base/java.util.concurrent.ForkJoinWorkerThread.run(ForkJoinWorkerThread.java:183)
[INFO]     [creator]     10:02:30.100 [ForkJoinPool-4-worker-5] DEBUG io.netty.util.internal.PlatformDependent0 - java.nio.Bits.unaligned: unavailable true
[INFO]     [creator]     java.lang.UnsupportedOperationException: Reflective setAccessible(true) disabled
[INFO]     [creator]     	at io.netty.util.internal.ReflectionUtil.trySetAccessible(ReflectionUtil.java:31)
[INFO]     [creator]     	at io.netty.util.internal.PlatformDependent0$5.run(PlatformDependent0.java:310)
[INFO]     [creator]     	at java.base/java.security.AccessController.doPrivileged(Native Method)
[INFO]     [creator]     	at io.netty.util.internal.PlatformDependent0.<clinit>(PlatformDependent0.java:284)
[INFO]     [creator]     	at io.netty.util.internal.PlatformDependent.isAndroid(PlatformDependent.java:293)
[INFO]     [creator]     	at io.netty.util.internal.PlatformDependent.<clinit>(PlatformDependent.java:92)
[INFO]     [creator]     	at io.netty.util.AsciiString.<init>(AsciiString.java:223)
[INFO]     [creator]     	at io.netty.util.AsciiString.<init>(AsciiString.java:210)
[INFO]     [creator]     	at io.netty.util.AsciiString.cached(AsciiString.java:1401)
[INFO]     [creator]     	at io.netty.util.AsciiString.<clinit>(AsciiString.java:48)
[INFO]     [creator]     	at io.netty.handler.codec.http.HttpResponseStatus.<init>(HttpResponseStatus.java:559)
[INFO]     [creator]     	at io.netty.handler.codec.http.HttpResponseStatus.newStatus(HttpResponseStatus.java:326)
[INFO]     [creator]     	at io.netty.handler.codec.http.HttpResponseStatus.<clinit>(HttpResponseStatus.java:39)
[INFO]     [creator]     	at io.netty.handler.codec.http.HttpObjectAggregator.<clinit>(HttpObjectAggregator.java:90)
[INFO]     [creator]     	at java.base/jdk.internal.misc.Unsafe.ensureClassInitialized0(Native Method)
[INFO]     [creator]     	at java.base/jdk.internal.misc.Unsafe.ensureClassInitialized(Unsafe.java:1042)
[INFO]     [creator]     	at jdk.unsupported/sun.misc.Unsafe.ensureClassInitialized(Unsafe.java:698)
[INFO]     [creator]     	at com.oracle.svm.hosted.classinitialization.ConfigurableClassInitialization.ensureClassInitialized(ConfigurableClassInitialization.java:174)
[INFO]     [creator]     	at com.oracle.svm.hosted.classinitialization.ConfigurableClassInitialization.computeInitKindAndMaybeInitializeClass(ConfigurableClassInitialization.java:607)
[INFO]     [creator]     	at com.oracle.svm.hosted.classinitialization.ConfigurableClassInitialization.computeInitKindAndMaybeInitializeClass(ConfigurableClassInitialization.java:127)
[INFO]     [creator]     	at com.oracle.svm.hosted.classinitialization.ConfigurableClassInitialization.maybeInitializeHosted(ConfigurableClassInitialization.java:165)
[INFO]     [creator]     	at com.oracle.svm.hosted.SVMHost.initializeType(SVMHost.java:265)
[INFO]     [creator]     	at com.oracle.graal.pointsto.meta.AnalysisType.lambda$new$0(AnalysisType.java:227)
[INFO]     [creator]     	at java.base/java.util.concurrent.Executors$RunnableAdapter.call(Executors.java:515)
[INFO]     [creator]     	at java.base/java.util.concurrent.FutureTask.run(FutureTask.java:264)
[INFO]     [creator]     	at java.base/java.util.concurrent.ForkJoinTask$RunnableExecuteAction.exec(ForkJoinTask.java:1426)
[INFO]     [creator]     	at java.base/java.util.concurrent.ForkJoinTask.doExec(ForkJoinTask.java:290)
[INFO]     [creator]     	at java.base/java.util.concurrent.ForkJoinPool$WorkQueue.topLevelExec(ForkJoinPool.java:1020)
[INFO]     [creator]     	at java.base/java.util.concurrent.ForkJoinPool.scan(ForkJoinPool.java:1656)
[INFO]     [creator]     	at java.base/java.util.concurrent.ForkJoinPool.runWorker(ForkJoinPool.java:1594)
[INFO]     [creator]     	at java.base/java.util.concurrent.ForkJoinWorkerThread.run(ForkJoinWorkerThread.java:183)
[INFO]     [creator]     10:02:30.101 [ForkJoinPool-4-worker-5] DEBUG io.netty.util.internal.PlatformDependent0 - jdk.internal.misc.Unsafe.allocateUninitializedArray(int): unavailable
[INFO]     [creator]     java.lang.IllegalAccessException: class io.netty.util.internal.PlatformDependent0$6 cannot access class jdk.internal.misc.Unsafe (in module java.base) because module java.base does not export jdk.internal.misc to unnamed module @3381c3c
[INFO]     [creator]     	at java.base/jdk.internal.reflect.Reflection.newIllegalAccessException(Reflection.java:361)
[INFO]     [creator]     	at java.base/java.lang.reflect.AccessibleObject.checkAccess(AccessibleObject.java:591)
[INFO]     [creator]     	at java.base/java.lang.reflect.Method.invoke(Method.java:558)
[INFO]     [creator]     	at io.netty.util.internal.PlatformDependent0$6.run(PlatformDependent0.java:352)
[INFO]     [creator]     	at java.base/java.security.AccessController.doPrivileged(Native Method)
[INFO]     [creator]     	at io.netty.util.internal.PlatformDependent0.<clinit>(PlatformDependent0.java:343)
[INFO]     [creator]     	at io.netty.util.internal.PlatformDependent.isAndroid(PlatformDependent.java:293)
[INFO]     [creator]     	at io.netty.util.internal.PlatformDependent.<clinit>(PlatformDependent.java:92)
[INFO]     [creator]     	at io.netty.util.AsciiString.<init>(AsciiString.java:223)
[INFO]     [creator]     	at io.netty.util.AsciiString.<init>(AsciiString.java:210)
[INFO]     [creator]     	at io.netty.util.AsciiString.cached(AsciiString.java:1401)
[INFO]     [creator]     	at io.netty.util.AsciiString.<clinit>(AsciiString.java:48)
[INFO]     [creator]     	at io.netty.handler.codec.http.HttpResponseStatus.<init>(HttpResponseStatus.java:559)
[INFO]     [creator]     	at io.netty.handler.codec.http.HttpResponseStatus.newStatus(HttpResponseStatus.java:326)
[INFO]     [creator]     	at io.netty.handler.codec.http.HttpResponseStatus.<clinit>(HttpResponseStatus.java:39)
[INFO]     [creator]     	at io.netty.handler.codec.http.HttpObjectAggregator.<clinit>(HttpObjectAggregator.java:90)
[INFO]     [creator]     	at java.base/jdk.internal.misc.Unsafe.ensureClassInitialized0(Native Method)
[INFO]     [creator]     	at java.base/jdk.internal.misc.Unsafe.ensureClassInitialized(Unsafe.java:1042)
[INFO]     [creator]     	at jdk.unsupported/sun.misc.Unsafe.ensureClassInitialized(Unsafe.java:698)
[INFO]     [creator]     	at com.oracle.svm.hosted.classinitialization.ConfigurableClassInitialization.ensureClassInitialized(ConfigurableClassInitialization.java:174)
[INFO]     [creator]     	at com.oracle.svm.hosted.classinitialization.ConfigurableClassInitialization.computeInitKindAndMaybeInitializeClass(ConfigurableClassInitialization.java:607)
[INFO]     [creator]     	at com.oracle.svm.hosted.classinitialization.ConfigurableClassInitialization.computeInitKindAndMaybeInitializeClass(ConfigurableClassInitialization.java:127)
[INFO]     [creator]     	at com.oracle.svm.hosted.classinitialization.ConfigurableClassInitialization.maybeInitializeHosted(ConfigurableClassInitialization.java:165)
[INFO]     [creator]     	at com.oracle.svm.hosted.SVMHost.initializeType(SVMHost.java:265)
[INFO]     [creator]     	at com.oracle.graal.pointsto.meta.AnalysisType.lambda$new$0(AnalysisType.java:227)
[INFO]     [creator]     	at java.base/java.util.concurrent.Executors$RunnableAdapter.call(Executors.java:515)
[INFO]     [creator]     	at java.base/java.util.concurrent.FutureTask.run(FutureTask.java:264)
[INFO]     [creator]     	at java.base/java.util.concurrent.ForkJoinTask$RunnableExecuteAction.exec(ForkJoinTask.java:1426)
[INFO]     [creator]     	at java.base/java.util.concurrent.ForkJoinTask.doExec(ForkJoinTask.java:290)
[INFO]     [creator]     	at java.base/java.util.concurrent.ForkJoinPool$WorkQueue.topLevelExec(ForkJoinPool.java:1020)
[INFO]     [creator]     	at java.base/java.util.concurrent.ForkJoinPool.scan(ForkJoinPool.java:1656)
[INFO]     [creator]     	at java.base/java.util.concurrent.ForkJoinPool.runWorker(ForkJoinPool.java:1594)
[INFO]     [creator]     	at java.base/java.util.concurrent.ForkJoinWorkerThread.run(ForkJoinWorkerThread.java:183)
[INFO]     [creator]     10:02:30.103 [ForkJoinPool-4-worker-5] DEBUG io.netty.util.internal.PlatformDependent0 - java.nio.DirectByteBuffer.<init>(long, int): unavailable
[INFO]     [creator]     10:02:30.104 [ForkJoinPool-4-worker-5] DEBUG io.netty.util.internal.PlatformDependent - sun.misc.Unsafe: available
[INFO]     [creator]     10:02:30.108 [ForkJoinPool-4-worker-5] DEBUG io.netty.util.internal.PlatformDependent - maxDirectMemory: 5937561600 bytes (maybe)
[INFO]     [creator]     10:02:30.108 [ForkJoinPool-4-worker-5] DEBUG io.netty.util.internal.PlatformDependent - -Dio.netty.tmpdir: /tmp (java.io.tmpdir)
[INFO]     [creator]     10:02:30.109 [ForkJoinPool-4-worker-5] DEBUG io.netty.util.internal.PlatformDependent - -Dio.netty.bitMode: 64 (sun.arch.data.model)
[INFO]     [creator]     10:02:30.111 [ForkJoinPool-4-worker-5] DEBUG io.netty.util.internal.PlatformDependent - -Dio.netty.maxDirectMemory: -1 bytes
[INFO]     [creator]     10:02:30.111 [ForkJoinPool-4-worker-5] DEBUG io.netty.util.internal.PlatformDependent - -Dio.netty.uninitializedArrayAllocationThreshold: -1
[INFO]     [creator]     10:02:30.114 [ForkJoinPool-4-worker-5] DEBUG io.netty.util.internal.CleanerJava9 - java.nio.ByteBuffer.cleaner(): available
[INFO]     [creator]     10:02:30.114 [ForkJoinPool-4-worker-5] DEBUG io.netty.util.internal.PlatformDependent - -Dio.netty.noPreferDirect: false
[INFO]     [creator]     10:02:30.125 [ForkJoinPool-4-worker-5] DEBUG io.netty.util.ResourceLeakDetector - -Dio.netty.leakDetection.level: simple
[INFO]     [creator]     10:02:30.125 [ForkJoinPool-4-worker-5] DEBUG io.netty.util.ResourceLeakDetector - -Dio.netty.leakDetection.targetRecords: 4
[INFO]     [creator]     To see how the classes got initialized, use --trace-class-initialization=org.springframework.boot.logging.logback.LogbackLoggingSystem$Factory,org.springframework.boot.logging.java.JavaLoggingSystem$Factory
[INFO]     [creator]     [/layers/paketo-buildpacks_spring-boot-native-image/native-image/com.mycompany.springbootbookapi.SpringbootBookApiApplication:156]     analysis:  15,443.09 ms,  1.98 GB
[INFO]     [creator]     Error: Classes that should be initialized at run time got initialized during image building:
[INFO]     [creator]      org.springframework.boot.logging.logback.LogbackLoggingSystem$Factory was unintentionally initialized at build time. To see why org.springframework.boot.logging.logback.LogbackLoggingSystem$Factory got initialized use --trace-class-initialization=org.springframework.boot.logging.logback.LogbackLoggingSystem$Factory
[INFO]     [creator]     org.springframework.boot.logging.java.JavaLoggingSystem$Factory was unintentionally initialized at build time. To see why org.springframework.boot.logging.java.JavaLoggingSystem$Factory got initialized use --trace-class-initialization=org.springframework.boot.logging.java.JavaLoggingSystem$Factory
[INFO]     [creator]
[INFO]     [creator]     Error: Use -H:+ReportExceptionStackTraces to print stacktrace of underlying exception
[INFO]     [creator]     Error: Image build request failed with exit status 1
[INFO]     [creator]     unable to invoke layer creator
[INFO]     [creator]     unable to contribute native-image layer
[INFO]     [creator]     error running build
[INFO]     [creator]     exit status 1
[INFO]     [creator]     ERROR: failed to build: exit status 1
[INFO] ------------------------------------------------------------------------
[INFO] BUILD FAILURE
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  06:18 min
[INFO] Finished at: 2020-11-22T11:02:41+01:00
[INFO] ------------------------------------------------------------------------
[ERROR] Failed to execute goal org.springframework.boot:spring-boot-maven-plugin:2.4.0:build-image (default-cli) on project springboot-book-api: Execution default-cli of goal org.springframework.boot:spring-boot-maven-plugin:2.4.0:build-image failed: Builder lifecycle 'creator' failed with status code 145 -> [Help 1]
[ERROR]
[ERROR] To see the full stack trace of the errors, re-run Maven with the -e switch.
[ERROR] Re-run Maven using the -X switch to enable full debug logging.
[ERROR]
[ERROR] For more information about the errors and possible solutions, please read the following articles:
[ERROR] [Help 1] http://cwiki.apache.org/confluence/display/MAVEN/PluginExecutionException
```