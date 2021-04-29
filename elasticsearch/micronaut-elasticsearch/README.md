# graalvm-quarkus-micronaut-springboot
## `> elasticsearch > micronaut-elasticsearch`

## Application

- ### micronaut-elasticsearch

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

- To stop the application, press `Ctrl+C` in its terminal

### Docker in JVM Mode

- In a terminal, make sure you are inside `graalvm-quarkus-micronaut-springboot/elasticsearch/micronaut-elasticsearch` folder

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
  docker run --rm --name micronaut-elasticsearch-jvm \
    -p 9114:8080 -e ELASTICSEARCH_HOST=elasticsearch \
    --network elasticsearch_default \
    docker.mycompany.com/micronaut-elasticsearch-jvm:1.0.0
  ```

- A simple test can be done by opening a new terminal and running
  ```
  curl -i -X POST "localhost:9114/api/movies" -H "Content-type: application/json" \
    -d '{"imdb": "456", "title": "American Pie"}'
  
  curl -i "localhost:9114/api/movies?title=american"
  ```

- To stop and remove application Docker container, press `Ctrl+C` in its terminal

### Docker in Native Mode

- In a terminal, make sure you are inside `graalvm-quarkus-micronaut-springboot/elasticsearch/micronaut-elasticsearch` folder

- Clean the application
  ```
  ./mvnw clean
  ```

- Run the script below to build the Docker image (See [Issues](#issues))
  ```
  ./docker-build.sh native
  ```

- Run the following command to start the Docker container
  ```
  docker run --rm --name micronaut-elasticsearch-native \
    -p 9115:8080 -e MICRONAUT_ENVIRONMENTS=native -e ELASTICSEARCH_HOST=elasticsearch \
    --network elasticsearch_default \
    docker.mycompany.com/micronaut-elasticsearch-native:1.0.0
  ```

- A simple test can be done by opening a new terminal and running
  ```
  curl -i -X POST "localhost:9115/api/movies" -H "Content-type: application/json" \
    -d '{"imdb": "789", "title": "Resident Evil"}'
  
  curl -i "localhost:9115/api/movies?title=evil"
  ```

- To stop and remove application Docker container, press `Ctrl+C` in its terminal

## Issues

When building **Docker in Native Mode**, there is this [Issue #4585](https://github.com/micronaut-projects/micronaut-core/issues/4585)
```
[INFO] Fatal error:
[INFO] com.oracle.graal.pointsto.util.AnalysisError$ParsingError: Error encountered while parsing org.graalvm.home.HomeFinder.getInstance()
Parsing context:
	parsing org.graalvm.polyglot.Engine.getVersion(Engine.java:203)
	parsing com.oracle.truffle.js.scriptengine.GraalJSEngineFactory.getEngineVersion(GraalJSEngineFactory.java:132)
	parsing com.oracle.truffle.js.scriptengine.GraalJSEngineFactory.getParameter(GraalJSEngineFactory.java:168)
	parsing org.apache.logging.log4j.core.script.ScriptManager.<init>(ScriptManager.java:84)
	parsing org.apache.logging.log4j.core.config.AbstractConfiguration.initialize(AbstractConfiguration.java:219)
	parsing org.apache.logging.log4j.core.config.AbstractConfiguration.start(AbstractConfiguration.java:288)
	parsing org.apache.logging.log4j.core.LoggerContext.setConfiguration(LoggerContext.java:618)
	parsing org.apache.logging.log4j.core.LoggerContext.reconfigure(LoggerContext.java:691)
	parsing org.apache.logging.log4j.core.LoggerContext.reconfigure(LoggerContext.java:708)
	parsing org.apache.logging.log4j.core.LoggerContext.start(LoggerContext.java:263)
	parsing org.apache.logging.log4j.core.impl.Log4jContextFactory.getContext(Log4jContextFactory.java:153)
	parsing org.apache.logging.log4j.core.impl.Log4jContextFactory.getContext(Log4jContextFactory.java:45)
	parsing org.apache.logging.log4j.LogManager.getContext(LogManager.java:194)
	parsing org.apache.logging.log4j.LogManager.getLogger(LogManager.java:602)
	parsing org.apache.logging.log4j.LogManager.getLogger(LogManager.java:669)
	parsing io.micronaut.management.endpoint.loggers.impl.Log4jLoggingSystem.getLogger(Log4jLoggingSystem.java:61)
	parsing io.micronaut.management.endpoint.loggers.impl.DefaultLoggersManager.getLogger(DefaultLoggersManager.java:55)
	parsing io.micronaut.management.endpoint.loggers.impl.$DefaultLoggersManagerDefinition$$exec1.invokeInternal(Unknown Source)
	parsing io.micronaut.context.AbstractExecutableMethod.invoke(AbstractExecutableMethod.java:151)
	parsing io.micronaut.validation.validator.DefaultValidator.validateBean(DefaultValidator.java:1743)
	parsing io.micronaut.inject.ValidatedBeanDefinition.validate(ValidatedBeanDefinition.java:44)
	parsing io.micronaut.context.BeanDefinitionDelegate$ProxyValidatingBeanDefinition.validate(BeanDefinitionDelegate.java:281)
	parsing io.micronaut.context.DefaultBeanContext.doCreateBean(DefaultBeanContext.java:2009)
	parsing io.micronaut.context.DefaultBeanContext.createAndRegisterSingletonInternal(DefaultBeanContext.java:2724)
	parsing io.micronaut.context.DefaultBeanContext.createAndRegisterSingleton(DefaultBeanContext.java:2710)
	parsing io.micronaut.context.DefaultBeanContext.initializeEventListeners(DefaultBeanContext.java:1499)
	parsing io.micronaut.context.DefaultBeanContext.readAllBeanDefinitionClasses(DefaultBeanContext.java:2856)
	parsing io.micronaut.context.DefaultBeanContext.start(DefaultBeanContext.java:231)
	parsing io.micronaut.context.DefaultApplicationContext.start(DefaultApplicationContext.java:165)
	parsing io.micronaut.runtime.Micronaut.start(Micronaut.java:71)
	parsing io.micronaut.runtime.Micronaut.run(Micronaut.java:311)
	parsing io.micronaut.runtime.Micronaut.run(Micronaut.java:297)
	parsing com.mycompany.micronautelasticsearch.Application.main(Application.java:8)
	parsing com.oracle.svm.core.JavaMainWrapper.runCore(JavaMainWrapper.java:146)
	parsing com.oracle.svm.core.JavaMainWrapper.run(JavaMainWrapper.java:182)
	parsing com.oracle.svm.core.code.IsolateEnterStub.JavaMainWrapper_run_5087f5482cc9a6abc971913ece43acb471d2631b(generated:0)


[INFO] 	at com.oracle.graal.pointsto.util.AnalysisError.parsingError(AnalysisError.java:138)

[INFO] 	at com.oracle.graal.pointsto.flow.MethodTypeFlow.doParse(MethodTypeFlow.java:331)

[INFO] 	at com.oracle.graal.pointsto.flow.MethodTypeFlow.ensureParsed(MethodTypeFlow.java:302)
	at com.oracle.graal.pointsto.flow.MethodTypeFlow.addContext(MethodTypeFlow.java:103)

[INFO] 	at com.oracle.graal.pointsto.flow.StaticInvokeTypeFlow.update(InvokeTypeFlow.java:434)
[INFO]
	at com.oracle.graal.pointsto.BigBang$2.run(BigBang.java:547)

[INFO] 	at com.oracle.graal.pointsto.util.CompletionExecutor.lambda$execute$0(CompletionExecutor.java:173)
[INFO]
	at java.base/java.util.concurrent.ForkJoinTask$RunnableExecuteAction.exec(ForkJoinTask.java:1426)
	at java.base/java.util.concurrent.ForkJoinTask.doExec(ForkJoinTask.java:290)
	at java.base/java.util.concurrent.ForkJoinPool$WorkQueue.topLevelExec(ForkJoinPool.java:1020)

[INFO] 	at java.base/java.util.concurrent.ForkJoinPool.scan(ForkJoinPool.java:1656)
	at java.base/java.util.concurrent.ForkJoinPool.runWorker(ForkJoinPool.java:1594)
	at java.base/java.util.concurrent.ForkJoinWorkerThread.run(ForkJoinWorkerThread.java:183)

[INFO] Caused by: com.oracle.svm.core.util.UserError$UserException: ImageSingletons do not contain key org.graalvm.home.HomeFinder
	at com.oracle.svm.core.util.UserError.abort(UserError.java:68)
	at com.oracle.svm.hosted.ImageSingletonsSupportImpl$HostedManagement.doLookup(ImageSingletonsSupportImpl.java:119)
	at com.oracle.svm.hosted.ImageSingletonsSupportImpl.lookup(ImageSingletonsSupportImpl.java:44)
	at org.graalvm.sdk/org.graalvm.nativeimage.ImageSingletons.lookup(ImageSingletons.java:86)
	at com.oracle.svm.hosted.snippets.SubstrateGraphBuilderPlugins$43.apply(SubstrateGraphBuilderPlugins.java:1012)
[INFO]
	at jdk.internal.vm.compiler/org.graalvm.compiler.nodes.graphbuilderconf.InvocationPlugin.execute(InvocationPlugin.java:189)
	at jdk.internal.vm.compiler/org.graalvm.compiler.java.BytecodeParser.applyInvocationPlugin(BytecodeParser.java:2204)
[INFO]
	at jdk.internal.vm.compiler/org.graalvm.compiler.java.BytecodeParser.tryInvocationPlugin(BytecodeParser.java:2190)
	at com.oracle.svm.hosted.phases.AnalysisGraphBuilderPhase$AnalysisBytecodeParser.tryInvocationPlugin(AnalysisGraphBuilderPhase.java:67)
	at jdk.internal.vm.compiler/org.graalvm.compiler.java.BytecodeParser.appendInvoke(BytecodeParser.java:1895)
	at jdk.internal.vm.compiler/org.graalvm.compiler.java.BytecodeParser.genInvokeStatic(BytecodeParser.java:1654)
	at jdk.internal.vm.compiler/org.graalvm.compiler.java.BytecodeParser.genInvokeStatic(BytecodeParser.java:1634)
	at jdk.internal.vm.compiler/org.graalvm.compiler.java.BytecodeParser.processBytecode(BytecodeParser.java:5406)
	at jdk.internal.vm.compiler/org.graalvm.compiler.java.BytecodeParser.iterateBytecodesForBlock(BytecodeParser.java:3436)

[INFO] 	at jdk.internal.vm.compiler/org.graalvm.compiler.java.BytecodeParser.processBlock(BytecodeParser.java:3243)

[INFO] 	at jdk.internal.vm.compiler/org.graalvm.compiler.java.BytecodeParser.build(BytecodeParser.java:1109)
[INFO]
	at jdk.internal.vm.compiler/org.graalvm.compiler.java.BytecodeParser.buildRootMethod(BytecodeParser.java:1003)
[INFO]

[INFO] 	at jdk.internal.vm.compiler/org.graalvm.compiler.java.GraphBuilderPhase$Instance.run(GraphBuilderPhase.java:84)
[INFO]

[INFO] 	at com.oracle.svm.hosted.phases.SharedGraphBuilderPhase.run(SharedGraphBuilderPhase.java:76)

[INFO] 	at jdk.internal.vm.compiler/org.graalvm.compiler.phases.Phase.run(Phase.java:49)
[INFO]
	at jdk.internal.vm.compiler/org.graalvm.compiler.phases.BasePhase.apply(BasePhase.java:212)
[INFO]

[INFO] 	at jdk.internal.vm.compiler/org.graalvm.compiler.phases.Phase.apply(Phase.java:42)

[INFO] 	at jdk.internal.vm.compiler/org.graalvm.compiler.phases.Phase.apply(Phase.java:38)
[INFO]

[INFO] 	at com.oracle.graal.pointsto.flow.MethodTypeFlowBuilder.parse(MethodTypeFlowBuilder.java:223)
[INFO]

[INFO] 	at com.oracle.graal.pointsto.flow.MethodTypeFlowBuilder.apply(MethodTypeFlowBuilder.java:357)
[INFO]

[INFO] 	at com.oracle.graal.pointsto.flow.MethodTypeFlow.doParse(MethodTypeFlow.java:313)
[INFO]

[INFO] 	... 11 more
[INFO]

[INFO] Error: Image build request failed with exit status 1
```