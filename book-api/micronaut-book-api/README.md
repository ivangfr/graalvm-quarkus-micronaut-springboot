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
  > **Important:** Unable to run with `Java 8`. Using `Java 11` worked!
  ```
  ./gradlew clean run
  ```

- A simple test can be done by opening a new terminal and running
  ```
  curl localhost:8080/api/books
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
  curl localhost:9087/api/books
  ```

- To stop and remove application Docker container, press `Ctrl+C` in its terminals

### Docker in Native Mode

- In a terminal, make sure you are inside `graalvm-quarkus-micronaut-springboot/book-api/micronaut-book-api` folder

- Package the application `jar` file
  ```
  ./gradlew clean assemble
  ```

- Run the script below to build the Docker image
  > **Important:** Unable to build the Docker Native Image! I've tried with `Java 8` and `Java 11`. Exception log in [Issues](#issues)
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
  curl localhost:9088/api/books
  ```

- To stop and remove application Docker container, press `Ctrl+C` in its terminals

## Issues

- Unable to build the Docker Native Image
  ```
  Fatal error: java.lang.SecurityException: java.lang.SecurityException: Prohibited package name: java.lang
    at java.base/jdk.internal.reflect.NativeConstructorAccessorImpl.newInstance0(Native Method)
    at java.base/jdk.internal.reflect.NativeConstructorAccessorImpl.newInstance(NativeConstructorAccessorImpl.java:62)
    at java.base/jdk.internal.reflect.DelegatingConstructorAccessorImpl.newInstance(DelegatingConstructorAccessorImpl.java:45)
    at java.base/java.lang.reflect.Constructor.newInstance(Constructor.java:490)
    at java.base/java.util.concurrent.ForkJoinTask.getThrowableException(ForkJoinTask.java:600)
    at java.base/java.util.concurrent.ForkJoinTask.get(ForkJoinTask.java:1006)
    at com.oracle.svm.hosted.NativeImageGenerator.run(NativeImageGenerator.java:462)
    at com.oracle.svm.hosted.NativeImageGeneratorRunner.buildImage(NativeImageGeneratorRunner.java:357)
    at com.oracle.svm.hosted.NativeImageGeneratorRunner.build(NativeImageGeneratorRunner.java:501)
    at com.oracle.svm.hosted.NativeImageGeneratorRunner.main(NativeImageGeneratorRunner.java:115)
    at com.oracle.svm.hosted.NativeImageGeneratorRunner$JDK9Plus.main(NativeImageGeneratorRunner.java:528)
  Caused by: java.lang.SecurityException: Prohibited package name: java.lang
    at java.base/java.lang.ClassLoader.preDefineClass(ClassLoader.java:898)
    at java.base/java.lang.ClassLoader.defineClass(ClassLoader.java:1014)
    at java.base/java.security.SecureClassLoader.defineClass(SecureClassLoader.java:174)
    at java.base/java.net.URLClassLoader.defineClass(URLClassLoader.java:550)
    at java.base/java.net.URLClassLoader$1.run(URLClassLoader.java:458)
    at java.base/java.net.URLClassLoader$1.run(URLClassLoader.java:452)
    at java.base/java.security.AccessController.doPrivileged(Native Method)
    at java.base/java.net.URLClassLoader.findClass(URLClassLoader.java:451)
    at java.base/java.lang.ClassLoader.loadClass(ClassLoader.java:588)
    at java.base/java.lang.ClassLoader.loadClass(ClassLoader.java:521)
    at java.base/java.lang.Class.forName0(Native Method)
    at java.base/java.lang.Class.forName(Class.java:398)
    at com.oracle.svm.hosted.ImageClassLoader.forName(ImageClassLoader.java:459)
    at com.oracle.svm.hosted.ImageClassLoader.findClassByName(ImageClassLoader.java:449)
    at com.oracle.svm.hosted.FeatureImpl$FeatureAccessImpl.findClassByName(FeatureImpl.java:108)
    at com.oracle.svm.hosted.ServiceLoaderFeature.handleType(ServiceLoaderFeature.java:201)
    at com.oracle.svm.hosted.ServiceLoaderFeature.duringAnalysis(ServiceLoaderFeature.java:112)
    at com.oracle.svm.hosted.NativeImageGenerator.lambda$runPointsToAnalysis$8(NativeImageGenerator.java:715)
    at com.oracle.svm.hosted.FeatureHandler.forEachFeature(FeatureHandler.java:63)
    at com.oracle.svm.hosted.NativeImageGenerator.runPointsToAnalysis(NativeImageGenerator.java:715)
    at com.oracle.svm.hosted.NativeImageGenerator.doRun(NativeImageGenerator.java:530)
    at com.oracle.svm.hosted.NativeImageGenerator.lambda$run$0(NativeImageGenerator.java:445)
    at java.base/java.util.concurrent.ForkJoinTask$AdaptedRunnableAction.exec(ForkJoinTask.java:1407)
    at java.base/java.util.concurrent.ForkJoinTask.doExec(ForkJoinTask.java:290)
    at java.base/java.util.concurrent.ForkJoinPool$WorkQueue.topLevelExec(ForkJoinPool.java:1020)
    at java.base/java.util.concurrent.ForkJoinPool.scan(ForkJoinPool.java:1656)
    at java.base/java.util.concurrent.ForkJoinPool.runWorker(ForkJoinPool.java:1594)
    at java.base/java.util.concurrent.ForkJoinWorkerThread.run(ForkJoinWorkerThread.java:177)
  Error: Image build request failed with exit status 1
  ```