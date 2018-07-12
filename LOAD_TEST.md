# Usage

```bash
./load-test.sh
```

This spins up Zipkin using docker-compose.

It also runs a Spring Boot app that listens on port 3380 and exposes HTTP endpoints that create Zipkin spans.

Then it runs a JMeter test plan that makes 100,000 HTTP calls to create lots of Zipkin spans.

Then it gets the Zipkin metrics which has dropped spans.

But the Zipkin debug logs are empty.

# Example output

Important parts:

```
-----------------------
ES_TIMEOUT      = 5000
ES_MAX_REQUESTS = 64
NumberOfThreads = 200
LoopCount       = 500
+ curl --silent http://localhost:9411/metrics
{"counter.zipkin_collector.messages.http":10.0,"counter.zipkin_collector.spans_dropped.http":4508.0,"gauge.zipkin_collector.message_bytes.http":261878.0,"counter.zipkin_collector.bytes.http":7548847.0,"gauge.zipkin_collector.message_spans.http":834.0,"counter.zipkin_collector.spans.http":21731.0,"counter.zipkin_collector.messages_dropped.http":0.0}+ set +x
-----------------------
```

Note the spans dropped:

> "counter.zipkin\_collector.spans\_dropped.http":4508.0

Note the lack of debug output:

```
zipkin                      | 2018-07-12 15:17:19.875 DEBUG 1 --- [           main] z.s.ZipkinServer                         : Running with Spring Boot v2.0.3.RELEASE, Spring v5.0.7.RELEASE
zipkin                      | 2018-07-12 15:17:30.559 DEBUG 1 --- [           main] z.a.u.ZipkinUiAutoConfiguration$1        : Initializing filter 'characterEncodingFilter'
zipkin                      | 2018-07-12 15:17:30.559 DEBUG 1 --- [           main] z.a.u.ZipkinUiAutoConfiguration$1        : Filter 'characterEncodingFilter' configured successfully
```

-----

Entire output:

```
$ ./load-test.sh
+ git submodule init
+ git submodule update --depth 1
+ cp ./application.zipkin-enabled.yml spring-cloud-sleuth/spring-cloud-sleuth-samples/spring-cloud-sleuth-sample-zipkin/src/main/resources/application.yml
+ cp ./SampleController.quiet.java spring-cloud-sleuth/spring-cloud-sleuth-samples/spring-cloud-sleuth-sample-zipkin/src/main/java/sample/SampleController.java
+ cd ./spring-cloud-sleuth
+ ./mvnw install -DskipTests
Running version check
The found version is [2.0.1.BUILD-SNAPSHOT]
Deactivating "milestone" profile for version="2.0.1.BUILD-SNAPSHOT"
Deactivating "central" profile for version="2.0.1.BUILD-SNAPSHOT"
[INFO] Scanning for projects...
[INFO] ------------------------------------------------------------------------
[INFO] Reactor Build Order:
[INFO]
[INFO] spring-cloud-sleuth-dependencies
[INFO] Spring Cloud Sleuth
[INFO] Spring Cloud Sleuth Core
[INFO] Spring Cloud Sleuth Zipkin
[INFO] spring-cloud-starter-sleuth
[INFO] Spring Cloud Starter Zipkin
[INFO] Spring Cloud Sleuth Samples
[INFO] Spring Cloud Sleuth Sample
[INFO] Spring Cloud Sleuth Sample Test Core
[INFO] spring-cloud-sleuth-sample-messaging
[INFO] spring-cloud-sleuth-sample-websocket
[INFO] spring-cloud-sleuth-sample-feign
[INFO] spring-cloud-sleuth-sample-ribbon
[INFO] spring-cloud-sleuth-sample-zipkin
[INFO] Spring Cloud Sleuth Docs
[INFO]
[INFO] ------------------------------------------------------------------------
[INFO] Building spring-cloud-sleuth-dependencies 2.0.1.BUILD-SNAPSHOT
[INFO] ------------------------------------------------------------------------
[INFO]
[INFO] --- maven-install-plugin:2.4:install (default-install) @ spring-cloud-sleuth-dependencies ---
[INFO] Installing /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-dependencies/pom.xml to /Users/modille/.m2/repository/org/springframework/cloud/spring-cloud-sleuth-dependencies/2.0.1.BUILD-SNAPSHOT/spring-cloud-sleuth-dependencies-2.0.1.BUILD-SNAPSHOT.pom
[INFO]
[INFO] ------------------------------------------------------------------------
[INFO] Building Spring Cloud Sleuth 2.0.1.BUILD-SNAPSHOT
[INFO] ------------------------------------------------------------------------
[INFO]
[INFO] --- maven-checkstyle-plugin:2.17:check (validate) @ spring-cloud-sleuth ---
[INFO] Starting audit...
Audit done.
[INFO]
[INFO] --- maven-javadoc-plugin:2.10.4:jar (javadoc) @ spring-cloud-sleuth ---
[INFO] Not executing Javadoc as the project is not a Java classpath-capable package
[INFO]
[INFO] >>> maven-source-plugin:2.4:jar (attach-sources) > generate-sources @ spring-cloud-sleuth >>>
[INFO]
[INFO] --- maven-checkstyle-plugin:2.17:check (validate) @ spring-cloud-sleuth ---
[INFO] Starting audit...
Audit done.
[INFO]
[INFO] <<< maven-source-plugin:2.4:jar (attach-sources) < generate-sources @ spring-cloud-sleuth <<<
[INFO]
[INFO]
[INFO] --- maven-source-plugin:2.4:jar (attach-sources) @ spring-cloud-sleuth ---
[INFO]
[INFO] --- maven-install-plugin:2.4:install (default-install) @ spring-cloud-sleuth ---
[INFO] Installing /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/pom.xml to /Users/modille/.m2/repository/org/springframework/cloud/spring-cloud-sleuth/2.0.1.BUILD-SNAPSHOT/spring-cloud-sleuth-2.0.1.BUILD-SNAPSHOT.pom
[INFO]
[INFO] ------------------------------------------------------------------------
[INFO] Building Spring Cloud Sleuth Core 2.0.1.BUILD-SNAPSHOT
[INFO] ------------------------------------------------------------------------
[INFO]
[INFO] --- maven-checkstyle-plugin:2.17:check (validate) @ spring-cloud-sleuth-core ---
[INFO] Starting audit...
Audit done.
[INFO]
[INFO] --- maven-resources-plugin:2.6:resources (default-resources) @ spring-cloud-sleuth-core ---
[INFO] Using 'UTF-8' encoding to copy filtered resources.
[INFO] Copying 0 resource
[INFO] Copying 2 resources
[INFO]
[INFO] --- maven-compiler-plugin:3.1:compile (default-compile) @ spring-cloud-sleuth-core ---
[INFO] Changes detected - recompiling the module!
[INFO] Compiling 107 source files to /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/target/classes
[WARNING] /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/src/main/java/org/springframework/cloud/sleuth/instrument/messaging/TracingChannelInterceptor.java:[38,45] org.springframework.messaging.support.ChannelInterceptorAdapter in org.springframework.messaging.support has been deprecated
[WARNING] /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/src/main/java/org/springframework/cloud/sleuth/instrument/web/client/TraceWebAsyncClientAutoConfiguration.java:[34,39] org.springframework.http.client.AsyncClientHttpRequestFactory in org.springframework.http.client has been deprecated
[WARNING] /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/src/main/java/org/springframework/cloud/sleuth/instrument/web/client/TraceWebAsyncClientAutoConfiguration.java:[35,39] org.springframework.http.client.AsyncClientHttpRequestInterceptor in org.springframework.http.client has been deprecated
[WARNING] /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/src/main/java/org/springframework/cloud/sleuth/instrument/web/client/TraceWebAsyncClientAutoConfiguration.java:[36,38] org.springframework.web.client.AsyncRestTemplate in org.springframework.web.client has been deprecated
[WARNING] /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/src/main/java/org/springframework/cloud/sleuth/instrument/messaging/websocket/TraceWebSocketAutoConfiguration.java:[28,56] org.springframework.web.socket.config.annotation.AbstractWebSocketMessageBrokerConfigurer in org.springframework.web.socket.config.annotation has been deprecated
[WARNING] /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/src/main/java/org/springframework/cloud/sleuth/instrument/messaging/TracingChannelInterceptor.java:[38,45] org.springframework.messaging.support.ChannelInterceptorAdapter in org.springframework.messaging.support has been deprecated
[WARNING] /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/src/main/java/org/springframework/cloud/sleuth/instrument/web/client/TraceWebAsyncClientAutoConfiguration.java:[34,39] org.springframework.http.client.AsyncClientHttpRequestFactory in org.springframework.http.client has been deprecated
[WARNING] /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/src/main/java/org/springframework/cloud/sleuth/instrument/web/client/TraceWebAsyncClientAutoConfiguration.java:[35,39] org.springframework.http.client.AsyncClientHttpRequestInterceptor in org.springframework.http.client has been deprecated
[WARNING] /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/src/main/java/org/springframework/cloud/sleuth/instrument/web/client/TraceWebAsyncClientAutoConfiguration.java:[36,38] org.springframework.web.client.AsyncRestTemplate in org.springframework.web.client has been deprecated
[WARNING] /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/src/main/java/org/springframework/cloud/sleuth/instrument/messaging/websocket/TraceWebSocketAutoConfiguration.java:[28,56] org.springframework.web.socket.config.annotation.AbstractWebSocketMessageBrokerConfigurer in org.springframework.web.socket.config.annotation has been deprecated
[WARNING] /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/src/main/java/org/springframework/cloud/sleuth/instrument/messaging/TracingChannelInterceptor.java:[38,45] org.springframework.messaging.support.ChannelInterceptorAdapter in org.springframework.messaging.support has been deprecated
[WARNING] /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/src/main/java/org/springframework/cloud/sleuth/instrument/web/client/TraceWebAsyncClientAutoConfiguration.java:[34,39] org.springframework.http.client.AsyncClientHttpRequestFactory in org.springframework.http.client has been deprecated
[WARNING] /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/src/main/java/org/springframework/cloud/sleuth/instrument/web/client/TraceWebAsyncClientAutoConfiguration.java:[35,39] org.springframework.http.client.AsyncClientHttpRequestInterceptor in org.springframework.http.client has been deprecated
[WARNING] /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/src/main/java/org/springframework/cloud/sleuth/instrument/web/client/TraceWebAsyncClientAutoConfiguration.java:[36,38] org.springframework.web.client.AsyncRestTemplate in org.springframework.web.client has been deprecated
[WARNING] /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/src/main/java/org/springframework/cloud/sleuth/instrument/messaging/websocket/TraceWebSocketAutoConfiguration.java:[28,56] org.springframework.web.socket.config.annotation.AbstractWebSocketMessageBrokerConfigurer in org.springframework.web.socket.config.annotation has been deprecated
[WARNING] /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/src/main/java/org/springframework/cloud/sleuth/instrument/web/TraceHttpAutoConfiguration.java:[46,33] org.springframework.cloud.sleuth.instrument.web.TraceKeys in org.springframework.cloud.sleuth.instrument.web has been deprecated
[WARNING] /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/src/main/java/org/springframework/cloud/sleuth/instrument/web/TraceHttpAutoConfiguration.java:[82,49] org.springframework.cloud.sleuth.instrument.web.TraceKeys in org.springframework.cloud.sleuth.instrument.web has been deprecated
[WARNING] /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/src/main/java/org/springframework/cloud/sleuth/instrument/web/TraceHttpAutoConfiguration.java:[100,49] org.springframework.cloud.sleuth.instrument.web.TraceKeys in org.springframework.cloud.sleuth.instrument.web has been deprecated
[WARNING] /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/src/main/java/org/springframework/cloud/sleuth/instrument/messaging/TracingChannelInterceptor.java:[56,54] org.springframework.messaging.support.ChannelInterceptorAdapter in org.springframework.messaging.support has been deprecated
[WARNING] /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/src/main/java/org/springframework/cloud/sleuth/instrument/web/client/TraceWebAsyncClientAutoConfiguration.java:[49,21] org.springframework.web.client.AsyncRestTemplate in org.springframework.web.client has been deprecated
[WARNING] /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/src/main/java/org/springframework/cloud/sleuth/instrument/web/client/TraceWebAsyncClientAutoConfiguration.java:[54,28] org.springframework.web.client.AsyncRestTemplate in org.springframework.web.client has been deprecated
[WARNING] /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/src/main/java/org/springframework/cloud/sleuth/instrument/web/client/TraceWebAsyncClientAutoConfiguration.java:[66,44] org.springframework.web.client.AsyncRestTemplate in org.springframework.web.client has been deprecated
[WARNING] /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/src/main/java/org/springframework/cloud/sleuth/instrument/web/client/TraceWebAsyncClientAutoConfiguration.java:[74,46] org.springframework.web.client.AsyncRestTemplate in org.springframework.web.client has been deprecated
[WARNING] /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/src/main/java/org/springframework/cloud/sleuth/instrument/web/client/TraceWebAsyncClientAutoConfiguration.java:[75,54] org.springframework.http.client.AsyncClientHttpRequestInterceptor in org.springframework.http.client has been deprecated
[WARNING] /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/src/main/java/org/springframework/cloud/sleuth/instrument/web/SleuthHttpClientParser.java:[39,23] org.springframework.cloud.sleuth.instrument.web.TraceKeys in org.springframework.cloud.sleuth.instrument.web has been deprecated
[WARNING] /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/src/main/java/org/springframework/cloud/sleuth/instrument/web/SleuthHttpClientParser.java:[41,32] org.springframework.cloud.sleuth.instrument.web.TraceKeys in org.springframework.cloud.sleuth.instrument.web has been deprecated
[WARNING] /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/src/main/java/org/springframework/cloud/sleuth/instrument/rxjava/SleuthRxJavaSchedulersHook.java:[52,54] getInstance() in rx.plugins.RxJavaPlugins has been deprecated
[WARNING] /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/src/main/java/org/springframework/cloud/sleuth/instrument/rxjava/SleuthRxJavaSchedulersHook.java:[56,72] getInstance() in rx.plugins.RxJavaPlugins has been deprecated
[WARNING] /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/src/main/java/org/springframework/cloud/sleuth/instrument/rxjava/SleuthRxJavaSchedulersHook.java:[58,48] getInstance() in rx.plugins.RxJavaPlugins has been deprecated
[WARNING] /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/src/main/java/org/springframework/cloud/sleuth/instrument/rxjava/SleuthRxJavaSchedulersHook.java:[60,38] getInstance() in rx.plugins.RxJavaPlugins has been deprecated
[WARNING] /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/src/main/java/org/springframework/cloud/sleuth/instrument/rxjava/SleuthRxJavaSchedulersHook.java:[61,38] getInstance() in rx.plugins.RxJavaPlugins has been deprecated
[WARNING] /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/src/main/java/org/springframework/cloud/sleuth/instrument/rxjava/SleuthRxJavaSchedulersHook.java:[62,38] getInstance() in rx.plugins.RxJavaPlugins has been deprecated
[WARNING] /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/src/main/java/org/springframework/cloud/sleuth/instrument/rxjava/SleuthRxJavaSchedulersHook.java:[63,38] getInstance() in rx.plugins.RxJavaPlugins has been deprecated
[WARNING] /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/src/main/java/org/springframework/cloud/sleuth/instrument/rxjava/SleuthRxJavaSchedulersHook.java:[82,24] onSchedule(rx.functions.Action0) in rx.plugins.RxJavaSchedulersHook has been deprecated
[WARNING] /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/src/main/java/org/springframework/cloud/sleuth/instrument/rxjava/SleuthRxJavaSchedulersHook.java:[87,40] onSchedule(rx.functions.Action0) in rx.plugins.RxJavaSchedulersHook has been deprecated
[WARNING] /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/src/main/java/org/springframework/cloud/sleuth/instrument/rxjava/SleuthRxJavaSchedulersHook.java:[91,29] onSchedule(rx.functions.Action0) in rx.plugins.RxJavaSchedulersHook has been deprecated
[WARNING] /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/src/main/java/org/springframework/cloud/sleuth/instrument/messaging/websocket/TraceWebSocketAutoConfiguration.java:[46,25] org.springframework.web.socket.config.annotation.AbstractWebSocketMessageBrokerConfigurer in org.springframework.web.socket.config.annotation has been deprecated
[WARNING] /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/src/main/java/org/springframework/cloud/sleuth/instrument/messaging/websocket/TraceWebSocketAutoConfiguration.java:[58,50] setInterceptors(org.springframework.messaging.support.ChannelInterceptor...) in org.springframework.messaging.simp.config.ChannelRegistration has been deprecated
[WARNING] /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/src/main/java/org/springframework/cloud/sleuth/instrument/messaging/websocket/TraceWebSocketAutoConfiguration.java:[63,29] setInterceptors(org.springframework.messaging.support.ChannelInterceptor...) in org.springframework.messaging.simp.config.ChannelRegistration has been deprecated
[WARNING] /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/src/main/java/org/springframework/cloud/sleuth/instrument/messaging/websocket/TraceWebSocketAutoConfiguration.java:[68,29] setInterceptors(org.springframework.messaging.support.ChannelInterceptor...) in org.springframework.messaging.simp.config.ChannelRegistration has been deprecated
[WARNING] /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/src/main/java/org/springframework/cloud/sleuth/instrument/web/SleuthHttpServerParser.java:[40,32] org.springframework.cloud.sleuth.instrument.web.TraceKeys in org.springframework.cloud.sleuth.instrument.web has been deprecated
[WARNING] /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/src/main/java/org/springframework/cloud/sleuth/instrument/messaging/TraceMessagingAutoConfiguration.java: Some input files use unchecked or unsafe operations.
[WARNING] /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/src/main/java/org/springframework/cloud/sleuth/instrument/messaging/TraceMessagingAutoConfiguration.java: Recompile with -Xlint:unchecked for details.
[INFO]
[INFO] --- maven-resources-plugin:2.6:testResources (default-testResources) @ spring-cloud-sleuth-core ---
[INFO] Using 'UTF-8' encoding to copy filtered resources.
[INFO] Copying 6 resources
[INFO]
[INFO] --- maven-compiler-plugin:3.1:testCompile (default-testCompile) @ spring-cloud-sleuth-core ---
[INFO] Nothing to compile - all classes are up to date
[INFO]
[INFO] --- maven-surefire-plugin:2.12.4:test (default-test) @ spring-cloud-sleuth-core ---
[INFO] Tests are skipped.
[INFO]
[INFO] --- maven-jar-plugin:3.0.0:jar (default-jar) @ spring-cloud-sleuth-core ---
[INFO] Building jar: /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/target/spring-cloud-sleuth-core-2.0.1.BUILD-SNAPSHOT.jar
[INFO]
[INFO] --- maven-javadoc-plugin:2.10.4:jar (javadoc) @ spring-cloud-sleuth-core ---
[INFO]
22 warnings
[WARNING] Javadoc Warnings
[WARNING] /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/src/main/java/org/springframework/cloud/sleuth/instrument/web/TraceWebAspect.java:65: warning - Tag @link: reference not found: org.springframework.stereotype.Controller
[WARNING] /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/src/main/java/org/springframework/cloud/sleuth/instrument/web/TraceWebAspect.java:65: warning - Tag @link: reference not found: org.springframework.stereotype.Controller
[WARNING] /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/src/main/java/org/springframework/cloud/sleuth/instrument/web/TraceWebAspect.java:65: warning - Tag @see: reference not found: org.springframework.stereotype.Controller
[WARNING] /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/src/main/java/org/springframework/cloud/sleuth/instrument/messaging/TracingChannelInterceptor.java:56: warning - Tag @link: reference not found: Span.Kind#PRODUCER
[WARNING] /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/src/main/java/org/springframework/cloud/sleuth/instrument/messaging/TracingChannelInterceptor.java:56: warning - Tag @link: reference not found: Span.Kind#CONSUMER
[WARNING] /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/src/main/java/org/springframework/cloud/sleuth/instrument/messaging/TracingChannelInterceptor.java:127: warning - Tag @link: reference not found: Span.Kind#PRODUCER
[WARNING] /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/src/main/java/org/springframework/cloud/sleuth/instrument/messaging/TracingChannelInterceptor.java:127: warning - Tag @link: reference not found: Span.Kind#PRODUCER
[WARNING] /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/src/main/java/org/springframework/cloud/sleuth/SpanAdjuster.java:32: warning - Tag @link:illegal character: "60" in "zipkin2.reporter.Reporter<zipkin2.Span>"
[WARNING] /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/src/main/java/org/springframework/cloud/sleuth/SpanAdjuster.java:32: warning - Tag @link:illegal character: "62" in "zipkin2.reporter.Reporter<zipkin2.Span>"
[WARNING] /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/src/main/java/org/springframework/cloud/sleuth/SpanAdjuster.java:32: warning - Tag @link: reference not found: zipkin2.reporter.Reporter<zipkin2.Span>
[WARNING] /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/src/main/java/org/springframework/cloud/sleuth/SpanName.java:67: warning - Missing closing '}' character for inline tag: "{@code"
[WARNING] /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/src/main/java/org/springframework/cloud/sleuth/SpanName.java:67: warning - @SpanName("custom-operation") is an unknown tag.
[WARNING] /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/src/main/java/org/springframework/cloud/sleuth/SpanName.java:67: warning - @Override is an unknown tag.
[WARNING] /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/src/main/java/org/springframework/cloud/sleuth/SpanName.java:67: warning - @Override is an unknown tag.
[WARNING] /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/src/main/java/org/springframework/cloud/sleuth/instrument/messaging/TracingChannelInterceptor.java:56: warning - Tag @link: reference not found: Span.Kind#PRODUCER
[WARNING] /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/src/main/java/org/springframework/cloud/sleuth/instrument/web/TraceWebAspect.java:65: warning - Tag @link: reference not found: org.springframework.stereotype.Controller
[WARNING] /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/src/main/java/org/springframework/cloud/sleuth/instrument/web/TraceWebAspect.java:65: warning - Tag @link: reference not found: org.springframework.stereotype.Controller
[WARNING] /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/src/main/java/org/springframework/cloud/sleuth/instrument/messaging/TracingChannelInterceptor.java:56: warning - Tag @link: reference not found: Span.Kind#PRODUCER
[WARNING] /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/src/main/java/org/springframework/cloud/sleuth/instrument/messaging/TracingChannelInterceptor.java:127: warning - Tag @link: reference not found: Span.Kind#PRODUCER
[WARNING] /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/src/main/java/org/springframework/cloud/sleuth/instrument/web/TraceWebAspect.java:65: warning - Tag @link: reference not found: org.springframework.stereotype.Controller
[WARNING] /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/src/main/java/org/springframework/cloud/sleuth/instrument/web/TraceWebAspect.java:65: warning - Tag @link: reference not found: org.springframework.stereotype.Controller
[WARNING] /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/src/main/java/org/springframework/cloud/sleuth/instrument/messaging/TracingChannelInterceptor.java:56: warning - Tag @link: reference not found: Span.Kind#PRODUCER
[INFO] Building jar: /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/target/spring-cloud-sleuth-core-2.0.1.BUILD-SNAPSHOT-javadoc.jar
[INFO]
[INFO] >>> maven-source-plugin:2.4:jar (attach-sources) > generate-sources @ spring-cloud-sleuth-core >>>
[INFO]
[INFO] --- maven-checkstyle-plugin:2.17:check (validate) @ spring-cloud-sleuth-core ---
[INFO] Starting audit...
Audit done.
[INFO]
[INFO] <<< maven-source-plugin:2.4:jar (attach-sources) < generate-sources @ spring-cloud-sleuth-core <<<
[INFO]
[INFO]
[INFO] --- maven-source-plugin:2.4:jar (attach-sources) @ spring-cloud-sleuth-core ---
[INFO] Building jar: /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/target/spring-cloud-sleuth-core-2.0.1.BUILD-SNAPSHOT-sources.jar
[INFO]
[INFO] --- maven-install-plugin:2.4:install (default-install) @ spring-cloud-sleuth-core ---
[INFO] Installing /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/target/spring-cloud-sleuth-core-2.0.1.BUILD-SNAPSHOT.jar to /Users/modille/.m2/repository/org/springframework/cloud/spring-cloud-sleuth-core/2.0.1.BUILD-SNAPSHOT/spring-cloud-sleuth-core-2.0.1.BUILD-SNAPSHOT.jar
[INFO] Installing /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/pom.xml to /Users/modille/.m2/repository/org/springframework/cloud/spring-cloud-sleuth-core/2.0.1.BUILD-SNAPSHOT/spring-cloud-sleuth-core-2.0.1.BUILD-SNAPSHOT.pom
[INFO] Installing /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/target/spring-cloud-sleuth-core-2.0.1.BUILD-SNAPSHOT-javadoc.jar to /Users/modille/.m2/repository/org/springframework/cloud/spring-cloud-sleuth-core/2.0.1.BUILD-SNAPSHOT/spring-cloud-sleuth-core-2.0.1.BUILD-SNAPSHOT-javadoc.jar
[INFO] Installing /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-core/target/spring-cloud-sleuth-core-2.0.1.BUILD-SNAPSHOT-sources.jar to /Users/modille/.m2/repository/org/springframework/cloud/spring-cloud-sleuth-core/2.0.1.BUILD-SNAPSHOT/spring-cloud-sleuth-core-2.0.1.BUILD-SNAPSHOT-sources.jar
[INFO]
[INFO] ------------------------------------------------------------------------
[INFO] Building Spring Cloud Sleuth Zipkin 2.0.1.BUILD-SNAPSHOT
[INFO] ------------------------------------------------------------------------
[INFO]
[INFO] --- maven-checkstyle-plugin:2.17:check (validate) @ spring-cloud-sleuth-zipkin ---
[INFO] Starting audit...
Audit done.
[INFO]
[INFO] --- maven-resources-plugin:2.6:resources (default-resources) @ spring-cloud-sleuth-zipkin ---
[INFO] Using 'UTF-8' encoding to copy filtered resources.
[INFO] Copying 0 resource
[INFO] Copying 1 resource
[INFO]
[INFO] --- maven-compiler-plugin:3.1:compile (default-compile) @ spring-cloud-sleuth-zipkin ---
[INFO] Nothing to compile - all classes are up to date
[INFO]
[INFO] --- maven-resources-plugin:2.6:testResources (default-testResources) @ spring-cloud-sleuth-zipkin ---
[INFO] Using 'UTF-8' encoding to copy filtered resources.
[INFO] skip non existing resourceDirectory /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-zipkin/src/test/resources
[INFO]
[INFO] --- maven-compiler-plugin:3.1:testCompile (default-testCompile) @ spring-cloud-sleuth-zipkin ---
[INFO] Nothing to compile - all classes are up to date
[INFO]
[INFO] --- maven-surefire-plugin:2.12.4:test (default-test) @ spring-cloud-sleuth-zipkin ---
[INFO] Tests are skipped.
[INFO]
[INFO] --- maven-jar-plugin:3.0.0:jar (default-jar) @ spring-cloud-sleuth-zipkin ---
[INFO]
[INFO] --- maven-javadoc-plugin:2.10.4:jar (javadoc) @ spring-cloud-sleuth-zipkin ---
[INFO] Building jar: /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-zipkin/target/spring-cloud-sleuth-zipkin-2.0.1.BUILD-SNAPSHOT-javadoc.jar
[INFO]
[INFO] >>> maven-source-plugin:2.4:jar (attach-sources) > generate-sources @ spring-cloud-sleuth-zipkin >>>
[INFO]
[INFO] --- maven-checkstyle-plugin:2.17:check (validate) @ spring-cloud-sleuth-zipkin ---
[INFO] Starting audit...
Audit done.
[INFO]
[INFO] <<< maven-source-plugin:2.4:jar (attach-sources) < generate-sources @ spring-cloud-sleuth-zipkin <<<
[INFO]
[INFO]
[INFO] --- maven-source-plugin:2.4:jar (attach-sources) @ spring-cloud-sleuth-zipkin ---
[INFO] Building jar: /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-zipkin/target/spring-cloud-sleuth-zipkin-2.0.1.BUILD-SNAPSHOT-sources.jar
[INFO]
[INFO] --- maven-install-plugin:2.4:install (default-install) @ spring-cloud-sleuth-zipkin ---
[INFO] Installing /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-zipkin/target/spring-cloud-sleuth-zipkin-2.0.1.BUILD-SNAPSHOT.jar to /Users/modille/.m2/repository/org/springframework/cloud/spring-cloud-sleuth-zipkin/2.0.1.BUILD-SNAPSHOT/spring-cloud-sleuth-zipkin-2.0.1.BUILD-SNAPSHOT.jar
[INFO] Installing /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-zipkin/pom.xml to /Users/modille/.m2/repository/org/springframework/cloud/spring-cloud-sleuth-zipkin/2.0.1.BUILD-SNAPSHOT/spring-cloud-sleuth-zipkin-2.0.1.BUILD-SNAPSHOT.pom
[INFO] Installing /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-zipkin/target/spring-cloud-sleuth-zipkin-2.0.1.BUILD-SNAPSHOT-javadoc.jar to /Users/modille/.m2/repository/org/springframework/cloud/spring-cloud-sleuth-zipkin/2.0.1.BUILD-SNAPSHOT/spring-cloud-sleuth-zipkin-2.0.1.BUILD-SNAPSHOT-javadoc.jar
[INFO] Installing /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-zipkin/target/spring-cloud-sleuth-zipkin-2.0.1.BUILD-SNAPSHOT-sources.jar to /Users/modille/.m2/repository/org/springframework/cloud/spring-cloud-sleuth-zipkin/2.0.1.BUILD-SNAPSHOT/spring-cloud-sleuth-zipkin-2.0.1.BUILD-SNAPSHOT-sources.jar
[INFO]
[INFO] ------------------------------------------------------------------------
[INFO] Building spring-cloud-starter-sleuth 2.0.1.BUILD-SNAPSHOT
[INFO] ------------------------------------------------------------------------
[INFO]
[INFO] --- maven-checkstyle-plugin:2.17:check (validate) @ spring-cloud-starter-sleuth ---
[INFO] Starting audit...
Audit done.
[INFO]
[INFO] --- maven-resources-plugin:2.6:resources (default-resources) @ spring-cloud-starter-sleuth ---
[INFO] Using 'UTF-8' encoding to copy filtered resources.
[INFO] Copying 0 resource
[INFO] Copying 1 resource
[INFO]
[INFO] --- maven-compiler-plugin:3.1:compile (default-compile) @ spring-cloud-starter-sleuth ---
[INFO] No sources to compile
[INFO]
[INFO] --- maven-resources-plugin:2.6:testResources (default-testResources) @ spring-cloud-starter-sleuth ---
[INFO] Using 'UTF-8' encoding to copy filtered resources.
[INFO] skip non existing resourceDirectory /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-starter-sleuth/src/test/resources
[INFO]
[INFO] --- maven-compiler-plugin:3.1:testCompile (default-testCompile) @ spring-cloud-starter-sleuth ---
[INFO] No sources to compile
[INFO]
[INFO] --- maven-surefire-plugin:2.12.4:test (default-test) @ spring-cloud-starter-sleuth ---
[INFO] Tests are skipped.
[INFO]
[INFO] --- maven-jar-plugin:3.0.0:jar (default-jar) @ spring-cloud-starter-sleuth ---
[INFO]
[INFO] --- maven-javadoc-plugin:2.10.4:jar (javadoc) @ spring-cloud-starter-sleuth ---
[INFO]
[INFO] >>> maven-source-plugin:2.4:jar (attach-sources) > generate-sources @ spring-cloud-starter-sleuth >>>
[INFO]
[INFO] --- maven-checkstyle-plugin:2.17:check (validate) @ spring-cloud-starter-sleuth ---
[INFO] Starting audit...
Audit done.
[INFO]
[INFO] <<< maven-source-plugin:2.4:jar (attach-sources) < generate-sources @ spring-cloud-starter-sleuth <<<
[INFO]
[INFO]
[INFO] --- maven-source-plugin:2.4:jar (attach-sources) @ spring-cloud-starter-sleuth ---
[INFO] Building jar: /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-starter-sleuth/target/spring-cloud-starter-sleuth-2.0.1.BUILD-SNAPSHOT-sources.jar
[INFO]
[INFO] --- maven-install-plugin:2.4:install (default-install) @ spring-cloud-starter-sleuth ---
[INFO] Installing /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-starter-sleuth/target/spring-cloud-starter-sleuth-2.0.1.BUILD-SNAPSHOT.jar to /Users/modille/.m2/repository/org/springframework/cloud/spring-cloud-starter-sleuth/2.0.1.BUILD-SNAPSHOT/spring-cloud-starter-sleuth-2.0.1.BUILD-SNAPSHOT.jar
[INFO] Installing /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-starter-sleuth/pom.xml to /Users/modille/.m2/repository/org/springframework/cloud/spring-cloud-starter-sleuth/2.0.1.BUILD-SNAPSHOT/spring-cloud-starter-sleuth-2.0.1.BUILD-SNAPSHOT.pom
[INFO] Installing /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-starter-sleuth/target/spring-cloud-starter-sleuth-2.0.1.BUILD-SNAPSHOT-sources.jar to /Users/modille/.m2/repository/org/springframework/cloud/spring-cloud-starter-sleuth/2.0.1.BUILD-SNAPSHOT/spring-cloud-starter-sleuth-2.0.1.BUILD-SNAPSHOT-sources.jar
[INFO]
[INFO] ------------------------------------------------------------------------
[INFO] Building Spring Cloud Starter Zipkin 2.0.1.BUILD-SNAPSHOT
[INFO] ------------------------------------------------------------------------
[INFO]
[INFO] --- maven-checkstyle-plugin:2.17:check (validate) @ spring-cloud-starter-zipkin ---
[INFO] Starting audit...
Audit done.
[INFO]
[INFO] --- maven-resources-plugin:2.6:resources (default-resources) @ spring-cloud-starter-zipkin ---
[INFO] Using 'UTF-8' encoding to copy filtered resources.
[INFO] Copying 0 resource
[INFO] Copying 1 resource
[INFO]
[INFO] --- maven-compiler-plugin:3.1:compile (default-compile) @ spring-cloud-starter-zipkin ---
[INFO] No sources to compile
[INFO]
[INFO] --- maven-resources-plugin:2.6:testResources (default-testResources) @ spring-cloud-starter-zipkin ---
[INFO] Using 'UTF-8' encoding to copy filtered resources.
[INFO] skip non existing resourceDirectory /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-starter-zipkin/src/test/resources
[INFO]
[INFO] --- maven-compiler-plugin:3.1:testCompile (default-testCompile) @ spring-cloud-starter-zipkin ---
[INFO] No sources to compile
[INFO]
[INFO] --- maven-surefire-plugin:2.12.4:test (default-test) @ spring-cloud-starter-zipkin ---
[INFO] Tests are skipped.
[INFO]
[INFO] --- maven-jar-plugin:3.0.0:jar (default-jar) @ spring-cloud-starter-zipkin ---
[INFO]
[INFO] --- maven-javadoc-plugin:2.10.4:jar (javadoc) @ spring-cloud-starter-zipkin ---
[INFO]
[INFO] >>> maven-source-plugin:2.4:jar (attach-sources) > generate-sources @ spring-cloud-starter-zipkin >>>
[INFO]
[INFO] --- maven-checkstyle-plugin:2.17:check (validate) @ spring-cloud-starter-zipkin ---
[INFO] Starting audit...
Audit done.
[INFO]
[INFO] <<< maven-source-plugin:2.4:jar (attach-sources) < generate-sources @ spring-cloud-starter-zipkin <<<
[INFO]
[INFO]
[INFO] --- maven-source-plugin:2.4:jar (attach-sources) @ spring-cloud-starter-zipkin ---
[INFO] Building jar: /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-starter-zipkin/target/spring-cloud-starter-zipkin-2.0.1.BUILD-SNAPSHOT-sources.jar
[INFO]
[INFO] --- maven-install-plugin:2.4:install (default-install) @ spring-cloud-starter-zipkin ---
[INFO] Installing /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-starter-zipkin/target/spring-cloud-starter-zipkin-2.0.1.BUILD-SNAPSHOT.jar to /Users/modille/.m2/repository/org/springframework/cloud/spring-cloud-starter-zipkin/2.0.1.BUILD-SNAPSHOT/spring-cloud-starter-zipkin-2.0.1.BUILD-SNAPSHOT.jar
[INFO] Installing /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-starter-zipkin/pom.xml to /Users/modille/.m2/repository/org/springframework/cloud/spring-cloud-starter-zipkin/2.0.1.BUILD-SNAPSHOT/spring-cloud-starter-zipkin-2.0.1.BUILD-SNAPSHOT.pom
[INFO] Installing /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-starter-zipkin/target/spring-cloud-starter-zipkin-2.0.1.BUILD-SNAPSHOT-sources.jar to /Users/modille/.m2/repository/org/springframework/cloud/spring-cloud-starter-zipkin/2.0.1.BUILD-SNAPSHOT/spring-cloud-starter-zipkin-2.0.1.BUILD-SNAPSHOT-sources.jar
[INFO]
[INFO] ------------------------------------------------------------------------
[INFO] Building Spring Cloud Sleuth Samples 2.0.1.BUILD-SNAPSHOT
[INFO] ------------------------------------------------------------------------
[INFO]
[INFO] --- maven-checkstyle-plugin:2.17:check (validate) @ spring-cloud-sleuth-samples ---
[INFO] Starting audit...
Audit done.
[INFO]
[INFO] --- maven-javadoc-plugin:2.10.4:jar (javadoc) @ spring-cloud-sleuth-samples ---
[INFO] Not executing Javadoc as the project is not a Java classpath-capable package
[INFO]
[INFO] >>> maven-source-plugin:2.4:jar (attach-sources) > generate-sources @ spring-cloud-sleuth-samples >>>
[INFO]
[INFO] --- maven-checkstyle-plugin:2.17:check (validate) @ spring-cloud-sleuth-samples ---
[INFO] Starting audit...
Audit done.
[INFO]
[INFO] <<< maven-source-plugin:2.4:jar (attach-sources) < generate-sources @ spring-cloud-sleuth-samples <<<
[INFO]
[INFO]
[INFO] --- maven-source-plugin:2.4:jar (attach-sources) @ spring-cloud-sleuth-samples ---
[INFO]
[INFO] --- maven-install-plugin:2.4:install (default-install) @ spring-cloud-sleuth-samples ---
[INFO] Installing /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-samples/pom.xml to /Users/modille/.m2/repository/org/springframework/cloud/spring-cloud-sleuth-samples/2.0.1.BUILD-SNAPSHOT/spring-cloud-sleuth-samples-2.0.1.BUILD-SNAPSHOT.pom
[INFO]
[INFO] ------------------------------------------------------------------------
[INFO] Building Spring Cloud Sleuth Sample 2.0.1.BUILD-SNAPSHOT
[INFO] ------------------------------------------------------------------------
[INFO]
[INFO] --- maven-checkstyle-plugin:2.17:check (validate) @ spring-cloud-sleuth-sample ---
[INFO] Starting audit...
Audit done.
[INFO]
[INFO] --- maven-resources-plugin:2.6:resources (default-resources) @ spring-cloud-sleuth-sample ---
[INFO] Using 'UTF-8' encoding to copy filtered resources.
[INFO] Copying 1 resource
[INFO] Copying 0 resource
[INFO]
[INFO] --- maven-compiler-plugin:3.1:compile (default-compile) @ spring-cloud-sleuth-sample ---
[INFO] Nothing to compile - all classes are up to date
[INFO]
[INFO] --- maven-resources-plugin:2.6:testResources (default-testResources) @ spring-cloud-sleuth-sample ---
[INFO] Using 'UTF-8' encoding to copy filtered resources.
[INFO] skip non existing resourceDirectory /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-samples/spring-cloud-sleuth-sample/src/test/resources
[INFO]
[INFO] --- maven-compiler-plugin:3.1:testCompile (default-testCompile) @ spring-cloud-sleuth-sample ---
[INFO] Nothing to compile - all classes are up to date
[INFO]
[INFO] --- maven-surefire-plugin:2.12.4:test (default-test) @ spring-cloud-sleuth-sample ---
[INFO] Tests are skipped.
[INFO]
[INFO] --- maven-jar-plugin:3.0.0:jar (default-jar) @ spring-cloud-sleuth-sample ---
[INFO] Building jar: /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-samples/spring-cloud-sleuth-sample/target/spring-cloud-sleuth-sample-2.0.1.BUILD-SNAPSHOT.jar
[INFO]
[INFO] --- maven-javadoc-plugin:2.10.4:jar (javadoc) @ spring-cloud-sleuth-sample ---
[INFO] Building jar: /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-samples/spring-cloud-sleuth-sample/target/spring-cloud-sleuth-sample-2.0.1.BUILD-SNAPSHOT-javadoc.jar
[INFO]
[INFO] >>> maven-source-plugin:2.4:jar (attach-sources) > generate-sources @ spring-cloud-sleuth-sample >>>
[INFO]
[INFO] --- maven-checkstyle-plugin:2.17:check (validate) @ spring-cloud-sleuth-sample ---
[INFO] Starting audit...
Audit done.
[INFO]
[INFO] <<< maven-source-plugin:2.4:jar (attach-sources) < generate-sources @ spring-cloud-sleuth-sample <<<
[INFO]
[INFO]
[INFO] --- maven-source-plugin:2.4:jar (attach-sources) @ spring-cloud-sleuth-sample ---
[INFO] Building jar: /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-samples/spring-cloud-sleuth-sample/target/spring-cloud-sleuth-sample-2.0.1.BUILD-SNAPSHOT-sources.jar
[INFO]
[INFO] --- spring-boot-maven-plugin:2.0.3.RELEASE:repackage (default) @ spring-cloud-sleuth-sample ---
[INFO]
[INFO] --- maven-install-plugin:2.4:install (default-install) @ spring-cloud-sleuth-sample ---
[INFO] Installing /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-samples/spring-cloud-sleuth-sample/target/spring-cloud-sleuth-sample-2.0.1.BUILD-SNAPSHOT.jar to /Users/modille/.m2/repository/org/springframework/cloud/spring-cloud-sleuth-sample/2.0.1.BUILD-SNAPSHOT/spring-cloud-sleuth-sample-2.0.1.BUILD-SNAPSHOT.jar
[INFO] Installing /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-samples/spring-cloud-sleuth-sample/pom.xml to /Users/modille/.m2/repository/org/springframework/cloud/spring-cloud-sleuth-sample/2.0.1.BUILD-SNAPSHOT/spring-cloud-sleuth-sample-2.0.1.BUILD-SNAPSHOT.pom
[INFO] Installing /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-samples/spring-cloud-sleuth-sample/target/spring-cloud-sleuth-sample-2.0.1.BUILD-SNAPSHOT-javadoc.jar to /Users/modille/.m2/repository/org/springframework/cloud/spring-cloud-sleuth-sample/2.0.1.BUILD-SNAPSHOT/spring-cloud-sleuth-sample-2.0.1.BUILD-SNAPSHOT-javadoc.jar
[INFO] Installing /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-samples/spring-cloud-sleuth-sample/target/spring-cloud-sleuth-sample-2.0.1.BUILD-SNAPSHOT-sources.jar to /Users/modille/.m2/repository/org/springframework/cloud/spring-cloud-sleuth-sample/2.0.1.BUILD-SNAPSHOT/spring-cloud-sleuth-sample-2.0.1.BUILD-SNAPSHOT-sources.jar
[INFO]
[INFO] ------------------------------------------------------------------------
[INFO] Building Spring Cloud Sleuth Sample Test Core 2.0.1.BUILD-SNAPSHOT
[INFO] ------------------------------------------------------------------------
[INFO]
[INFO] --- maven-checkstyle-plugin:2.17:check (validate) @ spring-cloud-sleuth-sample-test-core ---
[INFO] Starting audit...
Audit done.
[INFO]
[INFO] --- maven-resources-plugin:2.6:resources (default-resources) @ spring-cloud-sleuth-sample-test-core ---
[INFO] Using 'UTF-8' encoding to copy filtered resources.
[INFO] skip non existing resourceDirectory /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-samples/spring-cloud-sleuth-sample-test-core/src/main/resources
[INFO] skip non existing resourceDirectory /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-samples/spring-cloud-sleuth-sample-test-core/src/main/resources
[INFO]
[INFO] --- maven-compiler-plugin:3.1:compile (default-compile) @ spring-cloud-sleuth-sample-test-core ---
[INFO] Nothing to compile - all classes are up to date
[INFO]
[INFO] --- maven-resources-plugin:2.6:testResources (default-testResources) @ spring-cloud-sleuth-sample-test-core ---
[INFO] Using 'UTF-8' encoding to copy filtered resources.
[INFO] skip non existing resourceDirectory /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-samples/spring-cloud-sleuth-sample-test-core/src/test/resources
[INFO]
[INFO] --- maven-compiler-plugin:3.1:testCompile (default-testCompile) @ spring-cloud-sleuth-sample-test-core ---
[INFO] No sources to compile
[INFO]
[INFO] --- maven-surefire-plugin:2.12.4:test (default-test) @ spring-cloud-sleuth-sample-test-core ---
[INFO] Tests are skipped.
[INFO]
[INFO] --- maven-jar-plugin:3.0.0:jar (default-jar) @ spring-cloud-sleuth-sample-test-core ---
[INFO]
[INFO] --- maven-javadoc-plugin:2.10.4:jar (javadoc) @ spring-cloud-sleuth-sample-test-core ---
[INFO] Building jar: /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-samples/spring-cloud-sleuth-sample-test-core/target/spring-cloud-sleuth-sample-test-core-2.0.1.BUILD-SNAPSHOT-javadoc.jar
[INFO]
[INFO] >>> maven-source-plugin:2.4:jar (attach-sources) > generate-sources @ spring-cloud-sleuth-sample-test-core >>>
[INFO]
[INFO] --- maven-checkstyle-plugin:2.17:check (validate) @ spring-cloud-sleuth-sample-test-core ---
[INFO] Starting audit...
Audit done.
[INFO]
[INFO] <<< maven-source-plugin:2.4:jar (attach-sources) < generate-sources @ spring-cloud-sleuth-sample-test-core <<<
[INFO]
[INFO]
[INFO] --- maven-source-plugin:2.4:jar (attach-sources) @ spring-cloud-sleuth-sample-test-core ---
[INFO]
[INFO] --- maven-install-plugin:2.4:install (default-install) @ spring-cloud-sleuth-sample-test-core ---
[INFO] Installing /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-samples/spring-cloud-sleuth-sample-test-core/target/spring-cloud-sleuth-sample-test-core-2.0.1.BUILD-SNAPSHOT.jar to /Users/modille/.m2/repository/org/springframework/cloud/spring-cloud-sleuth-sample-test-core/2.0.1.BUILD-SNAPSHOT/spring-cloud-sleuth-sample-test-core-2.0.1.BUILD-SNAPSHOT.jar
[INFO] Installing /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-samples/spring-cloud-sleuth-sample-test-core/pom.xml to /Users/modille/.m2/repository/org/springframework/cloud/spring-cloud-sleuth-sample-test-core/2.0.1.BUILD-SNAPSHOT/spring-cloud-sleuth-sample-test-core-2.0.1.BUILD-SNAPSHOT.pom
[INFO] Installing /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-samples/spring-cloud-sleuth-sample-test-core/target/spring-cloud-sleuth-sample-test-core-2.0.1.BUILD-SNAPSHOT-javadoc.jar to /Users/modille/.m2/repository/org/springframework/cloud/spring-cloud-sleuth-sample-test-core/2.0.1.BUILD-SNAPSHOT/spring-cloud-sleuth-sample-test-core-2.0.1.BUILD-SNAPSHOT-javadoc.jar
[INFO] Installing /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-samples/spring-cloud-sleuth-sample-test-core/target/spring-cloud-sleuth-sample-test-core-2.0.1.BUILD-SNAPSHOT-sources.jar to /Users/modille/.m2/repository/org/springframework/cloud/spring-cloud-sleuth-sample-test-core/2.0.1.BUILD-SNAPSHOT/spring-cloud-sleuth-sample-test-core-2.0.1.BUILD-SNAPSHOT-sources.jar
[INFO]
[INFO] ------------------------------------------------------------------------
[INFO] Building spring-cloud-sleuth-sample-messaging 2.0.1.BUILD-SNAPSHOT
[INFO] ------------------------------------------------------------------------
[INFO]
[INFO] --- maven-checkstyle-plugin:2.17:check (validate) @ spring-cloud-sleuth-sample-messaging ---
[INFO] Starting audit...
Audit done.
[INFO]
[INFO] --- maven-resources-plugin:2.6:resources (default-resources) @ spring-cloud-sleuth-sample-messaging ---
[INFO] Using 'UTF-8' encoding to copy filtered resources.
[INFO] Copying 1 resource
[INFO] Copying 0 resource
[INFO]
[INFO] --- maven-compiler-plugin:3.1:compile (default-compile) @ spring-cloud-sleuth-sample-messaging ---
[INFO] Nothing to compile - all classes are up to date
[INFO]
[INFO] --- maven-resources-plugin:2.6:testResources (default-testResources) @ spring-cloud-sleuth-sample-messaging ---
[INFO] Using 'UTF-8' encoding to copy filtered resources.
[INFO] skip non existing resourceDirectory /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-samples/spring-cloud-sleuth-sample-messaging/src/test/resources
[INFO]
[INFO] --- maven-compiler-plugin:3.1:testCompile (default-testCompile) @ spring-cloud-sleuth-sample-messaging ---
[INFO] Nothing to compile - all classes are up to date
[INFO]
[INFO] --- maven-surefire-plugin:2.12.4:test (default-test) @ spring-cloud-sleuth-sample-messaging ---
[INFO] Tests are skipped.
[INFO]
[INFO] --- maven-jar-plugin:3.0.0:jar (default-jar) @ spring-cloud-sleuth-sample-messaging ---
[INFO] Building jar: /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-samples/spring-cloud-sleuth-sample-messaging/target/spring-cloud-sleuth-sample-messaging-2.0.1.BUILD-SNAPSHOT.jar
[INFO]
[INFO] --- maven-javadoc-plugin:2.10.4:jar (javadoc) @ spring-cloud-sleuth-sample-messaging ---
[INFO] Building jar: /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-samples/spring-cloud-sleuth-sample-messaging/target/spring-cloud-sleuth-sample-messaging-2.0.1.BUILD-SNAPSHOT-javadoc.jar
[INFO]
[INFO] >>> maven-source-plugin:2.4:jar (attach-sources) > generate-sources @ spring-cloud-sleuth-sample-messaging >>>
[INFO]
[INFO] --- maven-checkstyle-plugin:2.17:check (validate) @ spring-cloud-sleuth-sample-messaging ---
[INFO] Starting audit...
Audit done.
[INFO]
[INFO] <<< maven-source-plugin:2.4:jar (attach-sources) < generate-sources @ spring-cloud-sleuth-sample-messaging <<<
[INFO]
[INFO]
[INFO] --- maven-source-plugin:2.4:jar (attach-sources) @ spring-cloud-sleuth-sample-messaging ---
[INFO] Building jar: /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-samples/spring-cloud-sleuth-sample-messaging/target/spring-cloud-sleuth-sample-messaging-2.0.1.BUILD-SNAPSHOT-sources.jar
[INFO]
[INFO] --- spring-boot-maven-plugin:2.0.3.RELEASE:repackage (default) @ spring-cloud-sleuth-sample-messaging ---
[INFO]
[INFO] --- maven-install-plugin:2.4:install (default-install) @ spring-cloud-sleuth-sample-messaging ---
[INFO] Installing /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-samples/spring-cloud-sleuth-sample-messaging/target/spring-cloud-sleuth-sample-messaging-2.0.1.BUILD-SNAPSHOT.jar to /Users/modille/.m2/repository/org/springframework/cloud/spring-cloud-sleuth-sample-messaging/2.0.1.BUILD-SNAPSHOT/spring-cloud-sleuth-sample-messaging-2.0.1.BUILD-SNAPSHOT.jar
[INFO] Installing /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-samples/spring-cloud-sleuth-sample-messaging/pom.xml to /Users/modille/.m2/repository/org/springframework/cloud/spring-cloud-sleuth-sample-messaging/2.0.1.BUILD-SNAPSHOT/spring-cloud-sleuth-sample-messaging-2.0.1.BUILD-SNAPSHOT.pom
[INFO] Installing /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-samples/spring-cloud-sleuth-sample-messaging/target/spring-cloud-sleuth-sample-messaging-2.0.1.BUILD-SNAPSHOT-javadoc.jar to /Users/modille/.m2/repository/org/springframework/cloud/spring-cloud-sleuth-sample-messaging/2.0.1.BUILD-SNAPSHOT/spring-cloud-sleuth-sample-messaging-2.0.1.BUILD-SNAPSHOT-javadoc.jar
[INFO] Installing /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-samples/spring-cloud-sleuth-sample-messaging/target/spring-cloud-sleuth-sample-messaging-2.0.1.BUILD-SNAPSHOT-sources.jar to /Users/modille/.m2/repository/org/springframework/cloud/spring-cloud-sleuth-sample-messaging/2.0.1.BUILD-SNAPSHOT/spring-cloud-sleuth-sample-messaging-2.0.1.BUILD-SNAPSHOT-sources.jar
[INFO]
[INFO] ------------------------------------------------------------------------
[INFO] Building spring-cloud-sleuth-sample-websocket 2.0.1.BUILD-SNAPSHOT
[INFO] ------------------------------------------------------------------------
[INFO]
[INFO] --- maven-checkstyle-plugin:2.17:check (validate) @ spring-cloud-sleuth-sample-websocket ---
[INFO] Starting audit...
Audit done.
[INFO]
[INFO] --- maven-resources-plugin:2.6:resources (default-resources) @ spring-cloud-sleuth-sample-websocket ---
[INFO] Using 'UTF-8' encoding to copy filtered resources.
[INFO] Copying 1 resource
[INFO] Copying 3 resources
[INFO]
[INFO] --- maven-compiler-plugin:3.1:compile (default-compile) @ spring-cloud-sleuth-sample-websocket ---
[INFO] Nothing to compile - all classes are up to date
[INFO]
[INFO] --- maven-resources-plugin:2.6:testResources (default-testResources) @ spring-cloud-sleuth-sample-websocket ---
[INFO] Using 'UTF-8' encoding to copy filtered resources.
[INFO] skip non existing resourceDirectory /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-samples/spring-cloud-sleuth-sample-websocket/src/test/resources
[INFO]
[INFO] --- maven-compiler-plugin:3.1:testCompile (default-testCompile) @ spring-cloud-sleuth-sample-websocket ---
[INFO] Nothing to compile - all classes are up to date
[INFO]
[INFO] --- maven-surefire-plugin:2.12.4:test (default-test) @ spring-cloud-sleuth-sample-websocket ---
[INFO] Tests are skipped.
[INFO]
[INFO] --- maven-jar-plugin:3.0.0:jar (default-jar) @ spring-cloud-sleuth-sample-websocket ---
[INFO] Building jar: /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-samples/spring-cloud-sleuth-sample-websocket/target/spring-cloud-sleuth-sample-websocket-2.0.1.BUILD-SNAPSHOT.jar
[INFO]
[INFO] --- maven-javadoc-plugin:2.10.4:jar (javadoc) @ spring-cloud-sleuth-sample-websocket ---
[INFO] Building jar: /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-samples/spring-cloud-sleuth-sample-websocket/target/spring-cloud-sleuth-sample-websocket-2.0.1.BUILD-SNAPSHOT-javadoc.jar
[INFO]
[INFO] >>> maven-source-plugin:2.4:jar (attach-sources) > generate-sources @ spring-cloud-sleuth-sample-websocket >>>
[INFO]
[INFO] --- maven-checkstyle-plugin:2.17:check (validate) @ spring-cloud-sleuth-sample-websocket ---
[INFO] Starting audit...
Audit done.
[INFO]
[INFO] <<< maven-source-plugin:2.4:jar (attach-sources) < generate-sources @ spring-cloud-sleuth-sample-websocket <<<
[INFO]
[INFO]
[INFO] --- maven-source-plugin:2.4:jar (attach-sources) @ spring-cloud-sleuth-sample-websocket ---
[INFO]
[INFO] --- spring-boot-maven-plugin:2.0.3.RELEASE:repackage (default) @ spring-cloud-sleuth-sample-websocket ---
[INFO]
[INFO] --- maven-install-plugin:2.4:install (default-install) @ spring-cloud-sleuth-sample-websocket ---
[INFO] Installing /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-samples/spring-cloud-sleuth-sample-websocket/target/spring-cloud-sleuth-sample-websocket-2.0.1.BUILD-SNAPSHOT.jar to /Users/modille/.m2/repository/org/springframework/cloud/spring-cloud-sleuth-sample-websocket/2.0.1.BUILD-SNAPSHOT/spring-cloud-sleuth-sample-websocket-2.0.1.BUILD-SNAPSHOT.jar
[INFO] Installing /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-samples/spring-cloud-sleuth-sample-websocket/pom.xml to /Users/modille/.m2/repository/org/springframework/cloud/spring-cloud-sleuth-sample-websocket/2.0.1.BUILD-SNAPSHOT/spring-cloud-sleuth-sample-websocket-2.0.1.BUILD-SNAPSHOT.pom
[INFO] Installing /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-samples/spring-cloud-sleuth-sample-websocket/target/spring-cloud-sleuth-sample-websocket-2.0.1.BUILD-SNAPSHOT-javadoc.jar to /Users/modille/.m2/repository/org/springframework/cloud/spring-cloud-sleuth-sample-websocket/2.0.1.BUILD-SNAPSHOT/spring-cloud-sleuth-sample-websocket-2.0.1.BUILD-SNAPSHOT-javadoc.jar
[INFO] Installing /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-samples/spring-cloud-sleuth-sample-websocket/target/spring-cloud-sleuth-sample-websocket-2.0.1.BUILD-SNAPSHOT-sources.jar to /Users/modille/.m2/repository/org/springframework/cloud/spring-cloud-sleuth-sample-websocket/2.0.1.BUILD-SNAPSHOT/spring-cloud-sleuth-sample-websocket-2.0.1.BUILD-SNAPSHOT-sources.jar
[INFO]
[INFO] ------------------------------------------------------------------------
[INFO] Building spring-cloud-sleuth-sample-feign 2.0.1.BUILD-SNAPSHOT
[INFO] ------------------------------------------------------------------------
[INFO]
[INFO] --- maven-checkstyle-plugin:2.17:check (validate) @ spring-cloud-sleuth-sample-feign ---
[INFO] Starting audit...
Audit done.
[INFO]
[INFO] --- maven-resources-plugin:2.6:resources (default-resources) @ spring-cloud-sleuth-sample-feign ---
[INFO] Using 'UTF-8' encoding to copy filtered resources.
[INFO] Copying 1 resource
[INFO] Copying 0 resource
[INFO]
[INFO] --- maven-compiler-plugin:3.1:compile (default-compile) @ spring-cloud-sleuth-sample-feign ---
[INFO] Nothing to compile - all classes are up to date
[INFO]
[INFO] --- maven-resources-plugin:2.6:testResources (default-testResources) @ spring-cloud-sleuth-sample-feign ---
[INFO] Using 'UTF-8' encoding to copy filtered resources.
[INFO] skip non existing resourceDirectory /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-samples/spring-cloud-sleuth-sample-feign/src/test/resources
[INFO]
[INFO] --- maven-compiler-plugin:3.1:testCompile (default-testCompile) @ spring-cloud-sleuth-sample-feign ---
[INFO] Nothing to compile - all classes are up to date
[INFO]
[INFO] --- maven-surefire-plugin:2.12.4:test (default-test) @ spring-cloud-sleuth-sample-feign ---
[INFO] Tests are skipped.
[INFO]
[INFO] --- maven-jar-plugin:3.0.0:jar (default-jar) @ spring-cloud-sleuth-sample-feign ---
[INFO] Building jar: /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-samples/spring-cloud-sleuth-sample-feign/target/spring-cloud-sleuth-sample-feign-2.0.1.BUILD-SNAPSHOT.jar
[INFO]
[INFO] --- maven-javadoc-plugin:2.10.4:jar (javadoc) @ spring-cloud-sleuth-sample-feign ---
[INFO] Building jar: /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-samples/spring-cloud-sleuth-sample-feign/target/spring-cloud-sleuth-sample-feign-2.0.1.BUILD-SNAPSHOT-javadoc.jar
[INFO]
[INFO] >>> maven-source-plugin:2.4:jar (attach-sources) > generate-sources @ spring-cloud-sleuth-sample-feign >>>
[INFO]
[INFO] --- maven-checkstyle-plugin:2.17:check (validate) @ spring-cloud-sleuth-sample-feign ---
[INFO] Starting audit...
Audit done.
[INFO]
[INFO] <<< maven-source-plugin:2.4:jar (attach-sources) < generate-sources @ spring-cloud-sleuth-sample-feign <<<
[INFO]
[INFO]
[INFO] --- maven-source-plugin:2.4:jar (attach-sources) @ spring-cloud-sleuth-sample-feign ---
[INFO] Building jar: /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-samples/spring-cloud-sleuth-sample-feign/target/spring-cloud-sleuth-sample-feign-2.0.1.BUILD-SNAPSHOT-sources.jar
[INFO]
[INFO] --- spring-boot-maven-plugin:2.0.3.RELEASE:repackage (default) @ spring-cloud-sleuth-sample-feign ---
[INFO]
[INFO] --- maven-install-plugin:2.4:install (default-install) @ spring-cloud-sleuth-sample-feign ---
[INFO] Installing /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-samples/spring-cloud-sleuth-sample-feign/target/spring-cloud-sleuth-sample-feign-2.0.1.BUILD-SNAPSHOT.jar to /Users/modille/.m2/repository/org/springframework/cloud/spring-cloud-sleuth-sample-feign/2.0.1.BUILD-SNAPSHOT/spring-cloud-sleuth-sample-feign-2.0.1.BUILD-SNAPSHOT.jar
[INFO] Installing /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-samples/spring-cloud-sleuth-sample-feign/pom.xml to /Users/modille/.m2/repository/org/springframework/cloud/spring-cloud-sleuth-sample-feign/2.0.1.BUILD-SNAPSHOT/spring-cloud-sleuth-sample-feign-2.0.1.BUILD-SNAPSHOT.pom
[INFO] Installing /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-samples/spring-cloud-sleuth-sample-feign/target/spring-cloud-sleuth-sample-feign-2.0.1.BUILD-SNAPSHOT-javadoc.jar to /Users/modille/.m2/repository/org/springframework/cloud/spring-cloud-sleuth-sample-feign/2.0.1.BUILD-SNAPSHOT/spring-cloud-sleuth-sample-feign-2.0.1.BUILD-SNAPSHOT-javadoc.jar
[INFO] Installing /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-samples/spring-cloud-sleuth-sample-feign/target/spring-cloud-sleuth-sample-feign-2.0.1.BUILD-SNAPSHOT-sources.jar to /Users/modille/.m2/repository/org/springframework/cloud/spring-cloud-sleuth-sample-feign/2.0.1.BUILD-SNAPSHOT/spring-cloud-sleuth-sample-feign-2.0.1.BUILD-SNAPSHOT-sources.jar
[INFO]
[INFO] ------------------------------------------------------------------------
[INFO] Building spring-cloud-sleuth-sample-ribbon 2.0.1.BUILD-SNAPSHOT
[INFO] ------------------------------------------------------------------------
[INFO]
[INFO] --- maven-checkstyle-plugin:2.17:check (validate) @ spring-cloud-sleuth-sample-ribbon ---
[INFO] Starting audit...
Audit done.
[INFO]
[INFO] --- maven-resources-plugin:2.6:resources (default-resources) @ spring-cloud-sleuth-sample-ribbon ---
[INFO] Using 'UTF-8' encoding to copy filtered resources.
[INFO] Copying 1 resource
[INFO] Copying 0 resource
[INFO]
[INFO] --- maven-compiler-plugin:3.1:compile (default-compile) @ spring-cloud-sleuth-sample-ribbon ---
[INFO] Nothing to compile - all classes are up to date
[INFO]
[INFO] --- maven-resources-plugin:2.6:testResources (default-testResources) @ spring-cloud-sleuth-sample-ribbon ---
[INFO] Using 'UTF-8' encoding to copy filtered resources.
[INFO] skip non existing resourceDirectory /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-samples/spring-cloud-sleuth-sample-ribbon/src/test/resources
[INFO]
[INFO] --- maven-compiler-plugin:3.1:testCompile (default-testCompile) @ spring-cloud-sleuth-sample-ribbon ---
[INFO] Nothing to compile - all classes are up to date
[INFO]
[INFO] --- maven-surefire-plugin:2.12.4:test (default-test) @ spring-cloud-sleuth-sample-ribbon ---
[INFO] Tests are skipped.
[INFO]
[INFO] --- maven-jar-plugin:3.0.0:jar (default-jar) @ spring-cloud-sleuth-sample-ribbon ---
[INFO] Building jar: /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-samples/spring-cloud-sleuth-sample-ribbon/target/spring-cloud-sleuth-sample-ribbon-2.0.1.BUILD-SNAPSHOT.jar
[INFO]
[INFO] --- maven-javadoc-plugin:2.10.4:jar (javadoc) @ spring-cloud-sleuth-sample-ribbon ---
[INFO] Building jar: /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-samples/spring-cloud-sleuth-sample-ribbon/target/spring-cloud-sleuth-sample-ribbon-2.0.1.BUILD-SNAPSHOT-javadoc.jar
[INFO]
[INFO] >>> maven-source-plugin:2.4:jar (attach-sources) > generate-sources @ spring-cloud-sleuth-sample-ribbon >>>
[INFO]
[INFO] --- maven-checkstyle-plugin:2.17:check (validate) @ spring-cloud-sleuth-sample-ribbon ---
[INFO] Starting audit...
Audit done.
[INFO]
[INFO] <<< maven-source-plugin:2.4:jar (attach-sources) < generate-sources @ spring-cloud-sleuth-sample-ribbon <<<
[INFO]
[INFO]
[INFO] --- maven-source-plugin:2.4:jar (attach-sources) @ spring-cloud-sleuth-sample-ribbon ---
[INFO] Building jar: /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-samples/spring-cloud-sleuth-sample-ribbon/target/spring-cloud-sleuth-sample-ribbon-2.0.1.BUILD-SNAPSHOT-sources.jar
[INFO]
[INFO] --- spring-boot-maven-plugin:2.0.3.RELEASE:repackage (default) @ spring-cloud-sleuth-sample-ribbon ---
[INFO]
[INFO] --- maven-install-plugin:2.4:install (default-install) @ spring-cloud-sleuth-sample-ribbon ---
[INFO] Installing /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-samples/spring-cloud-sleuth-sample-ribbon/target/spring-cloud-sleuth-sample-ribbon-2.0.1.BUILD-SNAPSHOT.jar to /Users/modille/.m2/repository/org/springframework/cloud/spring-cloud-sleuth-sample-ribbon/2.0.1.BUILD-SNAPSHOT/spring-cloud-sleuth-sample-ribbon-2.0.1.BUILD-SNAPSHOT.jar
[INFO] Installing /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-samples/spring-cloud-sleuth-sample-ribbon/pom.xml to /Users/modille/.m2/repository/org/springframework/cloud/spring-cloud-sleuth-sample-ribbon/2.0.1.BUILD-SNAPSHOT/spring-cloud-sleuth-sample-ribbon-2.0.1.BUILD-SNAPSHOT.pom
[INFO] Installing /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-samples/spring-cloud-sleuth-sample-ribbon/target/spring-cloud-sleuth-sample-ribbon-2.0.1.BUILD-SNAPSHOT-javadoc.jar to /Users/modille/.m2/repository/org/springframework/cloud/spring-cloud-sleuth-sample-ribbon/2.0.1.BUILD-SNAPSHOT/spring-cloud-sleuth-sample-ribbon-2.0.1.BUILD-SNAPSHOT-javadoc.jar
[INFO] Installing /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-samples/spring-cloud-sleuth-sample-ribbon/target/spring-cloud-sleuth-sample-ribbon-2.0.1.BUILD-SNAPSHOT-sources.jar to /Users/modille/.m2/repository/org/springframework/cloud/spring-cloud-sleuth-sample-ribbon/2.0.1.BUILD-SNAPSHOT/spring-cloud-sleuth-sample-ribbon-2.0.1.BUILD-SNAPSHOT-sources.jar
[INFO]
[INFO] ------------------------------------------------------------------------
[INFO] Building spring-cloud-sleuth-sample-zipkin 2.0.1.BUILD-SNAPSHOT
[INFO] ------------------------------------------------------------------------
[INFO]
[INFO] --- maven-checkstyle-plugin:2.17:check (validate) @ spring-cloud-sleuth-sample-zipkin ---
[INFO] Starting audit...
Audit done.
[INFO]
[INFO] --- maven-resources-plugin:2.6:resources (default-resources) @ spring-cloud-sleuth-sample-zipkin ---
[INFO] Using 'UTF-8' encoding to copy filtered resources.
[INFO] Copying 1 resource
[INFO] Copying 0 resource
[INFO]
[INFO] --- maven-compiler-plugin:3.1:compile (default-compile) @ spring-cloud-sleuth-sample-zipkin ---
[INFO] Changes detected - recompiling the module!
[INFO] Compiling 3 source files to /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-samples/spring-cloud-sleuth-sample-zipkin/target/classes
[INFO]
[INFO] --- maven-resources-plugin:2.6:testResources (default-testResources) @ spring-cloud-sleuth-sample-zipkin ---
[INFO] Using 'UTF-8' encoding to copy filtered resources.
[INFO] skip non existing resourceDirectory /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-samples/spring-cloud-sleuth-sample-zipkin/src/test/resources
[INFO]
[INFO] --- maven-compiler-plugin:3.1:testCompile (default-testCompile) @ spring-cloud-sleuth-sample-zipkin ---
[INFO] Nothing to compile - all classes are up to date
[INFO]
[INFO] --- maven-surefire-plugin:2.12.4:test (default-test) @ spring-cloud-sleuth-sample-zipkin ---
[INFO] Tests are skipped.
[INFO]
[INFO] --- maven-jar-plugin:3.0.0:jar (default-jar) @ spring-cloud-sleuth-sample-zipkin ---
[INFO] Building jar: /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-samples/spring-cloud-sleuth-sample-zipkin/target/spring-cloud-sleuth-sample-zipkin-2.0.1.BUILD-SNAPSHOT.jar
[INFO]
[INFO] --- maven-javadoc-plugin:2.10.4:jar (javadoc) @ spring-cloud-sleuth-sample-zipkin ---
[INFO] Building jar: /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-samples/spring-cloud-sleuth-sample-zipkin/target/spring-cloud-sleuth-sample-zipkin-2.0.1.BUILD-SNAPSHOT-javadoc.jar
[INFO]
[INFO] >>> maven-source-plugin:2.4:jar (attach-sources) > generate-sources @ spring-cloud-sleuth-sample-zipkin >>>
[INFO]
[INFO] --- maven-checkstyle-plugin:2.17:check (validate) @ spring-cloud-sleuth-sample-zipkin ---
[INFO] Starting audit...
Audit done.
[INFO]
[INFO] <<< maven-source-plugin:2.4:jar (attach-sources) < generate-sources @ spring-cloud-sleuth-sample-zipkin <<<
[INFO]
[INFO]
[INFO] --- maven-source-plugin:2.4:jar (attach-sources) @ spring-cloud-sleuth-sample-zipkin ---
[INFO] Building jar: /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-samples/spring-cloud-sleuth-sample-zipkin/target/spring-cloud-sleuth-sample-zipkin-2.0.1.BUILD-SNAPSHOT-sources.jar
[INFO]
[INFO] --- spring-boot-maven-plugin:2.0.3.RELEASE:repackage (default) @ spring-cloud-sleuth-sample-zipkin ---
[INFO]
[INFO] --- maven-install-plugin:2.4:install (default-install) @ spring-cloud-sleuth-sample-zipkin ---
[INFO] Installing /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-samples/spring-cloud-sleuth-sample-zipkin/target/spring-cloud-sleuth-sample-zipkin-2.0.1.BUILD-SNAPSHOT.jar to /Users/modille/.m2/repository/org/springframework/cloud/spring-cloud-sleuth-sample-zipkin/2.0.1.BUILD-SNAPSHOT/spring-cloud-sleuth-sample-zipkin-2.0.1.BUILD-SNAPSHOT.jar
[INFO] Installing /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-samples/spring-cloud-sleuth-sample-zipkin/pom.xml to /Users/modille/.m2/repository/org/springframework/cloud/spring-cloud-sleuth-sample-zipkin/2.0.1.BUILD-SNAPSHOT/spring-cloud-sleuth-sample-zipkin-2.0.1.BUILD-SNAPSHOT.pom
[INFO] Installing /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-samples/spring-cloud-sleuth-sample-zipkin/target/spring-cloud-sleuth-sample-zipkin-2.0.1.BUILD-SNAPSHOT-javadoc.jar to /Users/modille/.m2/repository/org/springframework/cloud/spring-cloud-sleuth-sample-zipkin/2.0.1.BUILD-SNAPSHOT/spring-cloud-sleuth-sample-zipkin-2.0.1.BUILD-SNAPSHOT-javadoc.jar
[INFO] Installing /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-samples/spring-cloud-sleuth-sample-zipkin/target/spring-cloud-sleuth-sample-zipkin-2.0.1.BUILD-SNAPSHOT-sources.jar to /Users/modille/.m2/repository/org/springframework/cloud/spring-cloud-sleuth-sample-zipkin/2.0.1.BUILD-SNAPSHOT/spring-cloud-sleuth-sample-zipkin-2.0.1.BUILD-SNAPSHOT-sources.jar
[INFO]
[INFO] ------------------------------------------------------------------------
[INFO] Building Spring Cloud Sleuth Docs 2.0.1.BUILD-SNAPSHOT
[INFO] ------------------------------------------------------------------------
[INFO]
[INFO] --- maven-checkstyle-plugin:2.17:check (validate) @ spring-cloud-sleuth-docs ---
[INFO] Starting audit...
Audit done.
[INFO]
[INFO] --- maven-javadoc-plugin:2.10.4:jar (javadoc) @ spring-cloud-sleuth-docs ---
[INFO] Not executing Javadoc as the project is not a Java classpath-capable package
[INFO]
[INFO] >>> maven-source-plugin:2.4:jar (attach-sources) > generate-sources @ spring-cloud-sleuth-docs >>>
[INFO]
[INFO] --- maven-checkstyle-plugin:2.17:check (validate) @ spring-cloud-sleuth-docs ---
[INFO] Starting audit...
Audit done.
[INFO]
[INFO] <<< maven-source-plugin:2.4:jar (attach-sources) < generate-sources @ spring-cloud-sleuth-docs <<<
[INFO]
[INFO]
[INFO] --- maven-source-plugin:2.4:jar (attach-sources) @ spring-cloud-sleuth-docs ---
[INFO]
[INFO] --- maven-install-plugin:2.4:install (default-install) @ spring-cloud-sleuth-docs ---
[INFO] Installing /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/docs/pom.xml to /Users/modille/.m2/repository/org/springframework/cloud/spring-cloud-sleuth-docs/2.0.1.BUILD-SNAPSHOT/spring-cloud-sleuth-docs-2.0.1.BUILD-SNAPSHOT.pom
[INFO] ------------------------------------------------------------------------
[INFO] Reactor Summary:
[INFO]
[INFO] spring-cloud-sleuth-dependencies ................... SUCCESS [  0.137 s]
[INFO] Spring Cloud Sleuth ................................ SUCCESS [  1.173 s]
[INFO] Spring Cloud Sleuth Core ........................... SUCCESS [  5.542 s]
[INFO] Spring Cloud Sleuth Zipkin ......................... SUCCESS [  1.287 s]
[INFO] spring-cloud-starter-sleuth ........................ SUCCESS [  0.104 s]
[INFO] Spring Cloud Starter Zipkin ........................ SUCCESS [  0.098 s]
[INFO] Spring Cloud Sleuth Samples ........................ SUCCESS [  0.080 s]
[INFO] Spring Cloud Sleuth Sample ......................... SUCCESS [  1.358 s]
[INFO] Spring Cloud Sleuth Sample Test Core ............... SUCCESS [  1.093 s]
[INFO] spring-cloud-sleuth-sample-messaging ............... SUCCESS [  1.204 s]
[INFO] spring-cloud-sleuth-sample-websocket ............... SUCCESS [  1.090 s]
[INFO] spring-cloud-sleuth-sample-feign ................... SUCCESS [  1.249 s]
[INFO] spring-cloud-sleuth-sample-ribbon .................. SUCCESS [  1.350 s]
[INFO] spring-cloud-sleuth-sample-zipkin .................. SUCCESS [  1.512 s]
[INFO] Spring Cloud Sleuth Docs ........................... SUCCESS [  0.064 s]
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time: 17.723 s
[INFO] Finished at: 2018-07-12T11:17:02-04:00
[INFO] Final Memory: 77M/467M
[INFO] ------------------------------------------------------------------------
+ MVNW_PID=12715
+ cd ..
+ sleep 15s
+ ./mvnw --projects spring-cloud-sleuth-samples/spring-cloud-sleuth-sample-zipkin spring-boot:run
Running version check
The found version is [2.0.1.BUILD-SNAPSHOT]
Deactivating "milestone" profile for version="2.0.1.BUILD-SNAPSHOT"
Deactivating "central" profile for version="2.0.1.BUILD-SNAPSHOT"
[INFO] Scanning for projects...
[INFO]
[INFO] ------------------------------------------------------------------------
[INFO] Building spring-cloud-sleuth-sample-zipkin 2.0.1.BUILD-SNAPSHOT
[INFO] ------------------------------------------------------------------------
[INFO]
[INFO] >>> spring-boot-maven-plugin:2.0.3.RELEASE:run (default-cli) > test-compile @ spring-cloud-sleuth-sample-zipkin >>>
[INFO]
[INFO] --- maven-checkstyle-plugin:2.17:check (validate) @ spring-cloud-sleuth-sample-zipkin ---
[INFO] Starting audit...
Audit done.
[INFO]
[INFO] --- maven-resources-plugin:2.6:resources (default-resources) @ spring-cloud-sleuth-sample-zipkin ---
[INFO] Using 'UTF-8' encoding to copy filtered resources.
[INFO] Copying 1 resource
[INFO] Copying 0 resource
[INFO]
[INFO] --- maven-compiler-plugin:3.1:compile (default-compile) @ spring-cloud-sleuth-sample-zipkin ---
[INFO] Nothing to compile - all classes are up to date
[INFO]
[INFO] --- maven-resources-plugin:2.6:testResources (default-testResources) @ spring-cloud-sleuth-sample-zipkin ---
[INFO] Using 'UTF-8' encoding to copy filtered resources.
[INFO] skip non existing resourceDirectory /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-samples/spring-cloud-sleuth-sample-zipkin/src/test/resources
[INFO]
[INFO] --- maven-compiler-plugin:3.1:testCompile (default-testCompile) @ spring-cloud-sleuth-sample-zipkin ---
[INFO] Nothing to compile - all classes are up to date
[INFO]
[INFO] <<< spring-boot-maven-plugin:2.0.3.RELEASE:run (default-cli) < test-compile @ spring-cloud-sleuth-sample-zipkin <<<
[INFO]
[INFO]
[INFO] --- spring-boot-maven-plugin:2.0.3.RELEASE:run (default-cli) @ spring-cloud-sleuth-sample-zipkin ---

  .   ____          _            __ _ _
 /\\ / ___'_ __ _ _(_)_ __  __ _ \ \ \ \
( ( )\___ | '_ | '_| | '_ \/ _` | \ \ \ \
 \\/  ___)| |_)| | | | | || (_| |  ) ) ) )
  '  |____| .__|_| |_|_| |_\__, | / / / /
 =========|_|==============|___/=/_/_/_/
 :: Spring Boot ::        (v2.0.3.RELEASE)

2018-07-12 11:17:05.957  INFO [testsleuthzipkin,,,] 12715 --- [           main] sample.SampleZipkinApplication           : Starting SampleZipkinApplication on MattBook-Pro.local with PID 12715 (/Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth/spring-cloud-sleuth-samples/spring-cloud-sleuth-sample-zipkin/target/classes started by modille in /Users/modille/git/github.com/modille/docker-zipkin/spring-cloud-sleuth)
2018-07-12 11:17:05.959  INFO [testsleuthzipkin,,,] 12715 --- [           main] sample.SampleZipkinApplication           : No active profile set, falling back to default profiles: default
2018-07-12 11:17:05.993  INFO [testsleuthzipkin,,,] 12715 --- [           main] ConfigServletWebServerApplicationContext : Refreshing org.springframework.boot.web.servlet.context.AnnotationConfigServletWebServerApplicationContext@395ea517: startup date [Thu Jul 12 11:17:05 EDT 2018]; root of context hierarchy
2018-07-12 11:17:07.504  INFO [testsleuthzipkin,,,] 12715 --- [           main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat initialized with port(s): 3380 (http)
2018-07-12 11:17:07.527  INFO [testsleuthzipkin,,,] 12715 --- [           main] o.apache.catalina.core.StandardService   : Starting service [Tomcat]
2018-07-12 11:17:07.527  INFO [testsleuthzipkin,,,] 12715 --- [           main] org.apache.catalina.core.StandardEngine  : Starting Servlet Engine: Apache Tomcat/8.5.31
2018-07-12 11:17:07.536  INFO [testsleuthzipkin,,,] 12715 --- [ost-startStop-1] o.a.catalina.core.AprLifecycleListener   : The APR based Apache Tomcat Native library which allows optimal performance in production environments was not found on the java.library.path: [/Users/modille/Library/Java/Extensions:/Library/Java/Extensions:/Network/Library/Java/Extensions:/System/Library/Java/Extensions:/usr/lib/java:.]
2018-07-12 11:17:07.603  INFO [testsleuthzipkin,,,] 12715 --- [ost-startStop-1] o.a.c.c.C.[Tomcat].[localhost].[/]       : Initializing Spring embedded WebApplicationContext
2018-07-12 11:17:07.604  INFO [testsleuthzipkin,,,] 12715 --- [ost-startStop-1] o.s.web.context.ContextLoader            : Root WebApplicationContext: initialization completed in 1611 ms
2018-07-12 11:17:08.488  INFO [testsleuthzipkin,,,] 12715 --- [ost-startStop-1] o.s.b.w.servlet.FilterRegistrationBean   : Mapping filter: 'characterEncodingFilter' to: [/*]
2018-07-12 11:17:08.489  INFO [testsleuthzipkin,,,] 12715 --- [ost-startStop-1] o.s.b.w.servlet.FilterRegistrationBean   : Mapping filter: 'tracingFilter' to: [/*]
2018-07-12 11:17:08.489  INFO [testsleuthzipkin,,,] 12715 --- [ost-startStop-1] o.s.b.w.servlet.FilterRegistrationBean   : Mapping filter: 'exceptionLoggingFilter' to: [/*]
2018-07-12 11:17:08.489  INFO [testsleuthzipkin,,,] 12715 --- [ost-startStop-1] o.s.b.w.servlet.FilterRegistrationBean   : Mapping filter: 'hiddenHttpMethodFilter' to: [/*]
2018-07-12 11:17:08.489  INFO [testsleuthzipkin,,,] 12715 --- [ost-startStop-1] o.s.b.w.servlet.FilterRegistrationBean   : Mapping filter: 'httpPutFormContentFilter' to: [/*]
2018-07-12 11:17:08.489  INFO [testsleuthzipkin,,,] 12715 --- [ost-startStop-1] o.s.b.w.servlet.FilterRegistrationBean   : Mapping filter: 'requestContextFilter' to: [/*]
2018-07-12 11:17:08.489  INFO [testsleuthzipkin,,,] 12715 --- [ost-startStop-1] o.s.b.w.servlet.FilterRegistrationBean   : Mapping filter: 'httpTraceFilter' to: [/*]
2018-07-12 11:17:08.489  INFO [testsleuthzipkin,,,] 12715 --- [ost-startStop-1] o.s.b.w.servlet.FilterRegistrationBean   : Mapping filter: 'webMvcMetricsFilter' to: [/*]
2018-07-12 11:17:08.490  INFO [testsleuthzipkin,,,] 12715 --- [ost-startStop-1] o.s.b.w.servlet.ServletRegistrationBean  : Servlet dispatcherServlet mapped to [/]
2018-07-12 11:17:08.659  INFO [testsleuthzipkin,,,] 12715 --- [           main] o.s.w.s.handler.SimpleUrlHandlerMapping  : Mapped URL path [/**/favicon.ico] onto handler of type [class org.springframework.web.servlet.resource.ResourceHttpRequestHandler]
2018-07-12 11:17:08.866  INFO [testsleuthzipkin,,,] 12715 --- [           main] s.w.s.m.m.a.RequestMappingHandlerAdapter : Looking for @ControllerAdvice: org.springframework.boot.web.servlet.context.AnnotationConfigServletWebServerApplicationContext@395ea517: startup date [Thu Jul 12 11:17:05 EDT 2018]; root of context hierarchy
2018-07-12 11:17:08.933  INFO [testsleuthzipkin,,,] 12715 --- [           main] s.w.s.m.m.a.RequestMappingHandlerMapping : Mapped "{[/start]}" onto public java.lang.String sample.SampleController.start() throws java.lang.InterruptedException
2018-07-12 11:17:08.934  INFO [testsleuthzipkin,,,] 12715 --- [           main] s.w.s.m.m.a.RequestMappingHandlerMapping : Mapped "{[/call]}" onto public java.util.concurrent.Callable<java.lang.String> sample.SampleController.call()
2018-07-12 11:17:08.935  INFO [testsleuthzipkin,,,] 12715 --- [           main] s.w.s.m.m.a.RequestMappingHandlerMapping : Mapped "{[/]}" onto public java.lang.String sample.SampleController.hi() throws java.lang.InterruptedException
2018-07-12 11:17:08.935  INFO [testsleuthzipkin,,,] 12715 --- [           main] s.w.s.m.m.a.RequestMappingHandlerMapping : Mapped "{[/async]}" onto public java.lang.String sample.SampleController.async() throws java.lang.InterruptedException
2018-07-12 11:17:08.935  INFO [testsleuthzipkin,,,] 12715 --- [           main] s.w.s.m.m.a.RequestMappingHandlerMapping : Mapped "{[/hi2]}" onto public java.lang.String sample.SampleController.hi2() throws java.lang.InterruptedException
2018-07-12 11:17:08.935  INFO [testsleuthzipkin,,,] 12715 --- [           main] s.w.s.m.m.a.RequestMappingHandlerMapping : Mapped "{[/traced]}" onto public java.lang.String sample.SampleController.traced() throws java.lang.InterruptedException
2018-07-12 11:17:08.938  INFO [testsleuthzipkin,,,] 12715 --- [           main] s.w.s.m.m.a.RequestMappingHandlerMapping : Mapped "{[/error]}" onto public org.springframework.http.ResponseEntity<java.util.Map<java.lang.String, java.lang.Object>> org.springframework.boot.autoconfigure.web.servlet.error.BasicErrorController.error(javax.servlet.http.HttpServletRequest)
2018-07-12 11:17:08.938  INFO [testsleuthzipkin,,,] 12715 --- [           main] s.w.s.m.m.a.RequestMappingHandlerMapping : Mapped "{[/error],produces=[text/html]}" onto public org.springframework.web.servlet.ModelAndView org.springframework.boot.autoconfigure.web.servlet.error.BasicErrorController.errorHtml(javax.servlet.http.HttpServletRequest,javax.servlet.http.HttpServletResponse)
2018-07-12 11:17:08.981  INFO [testsleuthzipkin,,,] 12715 --- [           main] o.s.w.s.handler.SimpleUrlHandlerMapping  : Mapped URL path [/webjars/**] onto handler of type [class org.springframework.web.servlet.resource.ResourceHttpRequestHandler]
2018-07-12 11:17:08.981  INFO [testsleuthzipkin,,,] 12715 --- [           main] o.s.w.s.handler.SimpleUrlHandlerMapping  : Mapped URL path [/**] onto handler of type [class org.springframework.web.servlet.resource.ResourceHttpRequestHandler]
2018-07-12 11:17:09.394  INFO [testsleuthzipkin,,,] 12715 --- [           main] o.s.b.a.e.web.EndpointLinksResolver      : Exposing 2 endpoint(s) beneath base path '/actuator'
2018-07-12 11:17:09.402  INFO [testsleuthzipkin,,,] 12715 --- [           main] s.b.a.e.w.s.WebMvcEndpointHandlerMapping : Mapped "{[/actuator/health],methods=[GET],produces=[application/vnd.spring-boot.actuator.v2+json || application/json]}" onto public java.lang.Object org.springframework.boot.actuate.endpoint.web.servlet.AbstractWebMvcEndpointHandlerMapping$OperationHandler.handle(javax.servlet.http.HttpServletRequest,java.util.Map<java.lang.String, java.lang.String>)
2018-07-12 11:17:09.402  INFO [testsleuthzipkin,,,] 12715 --- [           main] s.b.a.e.w.s.WebMvcEndpointHandlerMapping : Mapped "{[/actuator/info],methods=[GET],produces=[application/vnd.spring-boot.actuator.v2+json || application/json]}" onto public java.lang.Object org.springframework.boot.actuate.endpoint.web.servlet.AbstractWebMvcEndpointHandlerMapping$OperationHandler.handle(javax.servlet.http.HttpServletRequest,java.util.Map<java.lang.String, java.lang.String>)
2018-07-12 11:17:09.403  INFO [testsleuthzipkin,,,] 12715 --- [           main] s.b.a.e.w.s.WebMvcEndpointHandlerMapping : Mapped "{[/actuator],methods=[GET],produces=[application/vnd.spring-boot.actuator.v2+json || application/json]}" onto protected java.util.Map<java.lang.String, java.util.Map<java.lang.String, org.springframework.boot.actuate.endpoint.web.Link>> org.springframework.boot.actuate.endpoint.web.servlet.WebMvcEndpointHandlerMapping.links(javax.servlet.http.HttpServletRequest,javax.servlet.http.HttpServletResponse)
2018-07-12 11:17:09.459  INFO [testsleuthzipkin,,,] 12715 --- [           main] o.s.j.e.a.AnnotationMBeanExporter        : Registering beans for JMX exposure on startup
2018-07-12 11:17:09.507  INFO [testsleuthzipkin,,,] 12715 --- [           main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat started on port(s): 3380 (http) with context path ''
2018-07-12 11:17:09.518  INFO [testsleuthzipkin,,,] 12715 --- [           main] sample.SampleZipkinApplication           : Started SampleZipkinApplication in 3.858 seconds (JVM running for 6.943)
+ run_load_test 200 500
+ docker-compose -f docker-compose.yml -f docker-compose-elasticsearch.yml up -d
Creating network "docker-zipkin_default" with the default driver
Creating elasticsearch ... done
Creating prometheus    ... done
Creating zipkin        ... done
Creating dependencies  ... done
Creating grafana       ... done
Creating setup_grafana_datasource ... done
+ sleep 45s
++ date -u +%Y-%m-%dT%H-%M-%SZ
+ timestamp=2018-07-12T15-18-07Z
+ jmeter -n -t ./spring_cloud_sleuth_zipkin.jmx -l jmeter-results-2018-07-12T15-18-07Z.txt -e -o jmeter-report-2018-07-12T15-18-07Z -JNumberOfThreads=200 -JLoopCount=500
Creating summariser <summary>
Created the tree successfully using ./spring_cloud_sleuth_zipkin.jmx
Starting the test @ Thu Jul 12 11:18:08 EDT 2018 (1531408688896)
Waiting for possible Shutdown/StopTestNow/Heapdump message on port 4445
2018-07-12 11:18:09.504  INFO [testsleuthzipkin,,,] 12715 --- [io-3380-exec-14] o.a.c.c.C.[Tomcat].[localhost].[/]       : Initializing Spring FrameworkServlet 'dispatcherServlet'
2018-07-12 11:18:09.505  INFO [testsleuthzipkin,,,] 12715 --- [io-3380-exec-14] o.s.web.servlet.DispatcherServlet        : FrameworkServlet 'dispatcherServlet': initialization started
2018-07-12 11:18:09.524  INFO [testsleuthzipkin,,,] 12715 --- [io-3380-exec-14] o.s.web.servlet.DispatcherServlet        : FrameworkServlet 'dispatcherServlet': initialization completed in 19 ms
summary +  46550 in 00:00:21 = 2240.7/s Avg:    83 Min:     0 Max:  6049 Err:     0 (0.00%) Active: 200 Started: 200 Finished: 0
summary +  53450 in 00:00:22 = 2453.3/s Avg:    68 Min:     0 Max: 16894 Err:     0 (0.00%) Active: 0 Started: 200 Finished: 200
summary = 100000 in 00:00:43 = 2349.5/s Avg:    75 Min:     0 Max: 16894 Err:     0 (0.00%)
Tidying up ...    @ Thu Jul 12 11:18:51 EDT 2018 (1531408731787)
... end of run
+ sleep 15s
+ set +x
-----------------------
ES_TIMEOUT      = 5000
ES_MAX_REQUESTS = 64
NumberOfThreads = 200
LoopCount       = 500
+ curl --silent http://localhost:9411/metrics
{"counter.zipkin_collector.messages.http":10.0,"counter.zipkin_collector.spans_dropped.http":4508.0,"gauge.zipkin_collector.message_bytes.http":261878.0,"counter.zipkin_collector.bytes.http":7548847.0,"gauge.zipkin_collector.message_spans.http":834.0,"counter.zipkin_collector.spans.http":21731.0,"counter.zipkin_collector.messages_dropped.http":0.0}+ set +x
-----------------------
+ docker-compose -f docker-compose.yml -f docker-compose-elasticsearch.yml logs zipkin
Attaching to zipkin
zipkin                      | Elasticsearch hosts: elasticsearch
zipkin                      |                                     ********
zipkin                      |                                   **        **
zipkin                      |                                  *            *
zipkin                      |                                 **            **
zipkin                      |                                 **            **
zipkin                      |                                  **          **
zipkin                      |                                   **        **
zipkin                      |                                     ********
zipkin                      |                                       ****
zipkin                      |                                       ****
zipkin                      |         ****                          ****
zipkin                      |      ******                           ****                                 ***
zipkin                      |   ****************************************************************************
zipkin                      |     *******                           ****                                 ***
zipkin                      |         ****                          ****
zipkin                      |                                        **
zipkin                      |                                        **
zipkin                      |
zipkin                      |
zipkin                      |              *****      **     *****     ** **       **     **   **
zipkin                      |                **       **     **  *     ***         **     **** **
zipkin                      |               **        **     *****     ****        **     **  ***
zipkin                      |              ******     **     **        **  **      **     **   **
zipkin                      |
zipkin                      | :: Powered by Spring Boot ::         (v2.0.3.RELEASE)
zipkin                      |
zipkin                      | 2018-07-12 15:17:19.864  INFO 1 --- [           main] z.s.ZipkinServer                         : Starting ZipkinServer on e92550167df2 with PID 1 (/zipkin/BOOT-INF/classes started by root in /zipkin)
zipkin                      | 2018-07-12 15:17:19.875 DEBUG 1 --- [           main] z.s.ZipkinServer                         : Running with Spring Boot v2.0.3.RELEASE, Spring v5.0.7.RELEASE
zipkin                      | 2018-07-12 15:17:19.875  INFO 1 --- [           main] z.s.ZipkinServer                         : The following profiles are active: shared
zipkin                      | 2018-07-12 15:17:20.113  INFO 1 --- [           main] ConfigServletWebServerApplicationContext : Refreshing org.springframework.boot.web.servlet.context.AnnotationConfigServletWebServerApplicationContext@7f9a81e8: startup date [Thu Jul 12 15:17:20 GMT 2018]; root of context hierarchy
zipkin                      | 2018-07-12 15:17:22.399  INFO 1 --- [           main] o.s.b.f.s.DefaultListableBeanFactory     : Overriding bean definition for bean 'characterEncodingFilter' with a different definition: replacing [Root bean: class [null]; scope=; abstract=false; lazyInit=false; autowireMode=3; dependencyCheck=0; autowireCandidate=true; primary=false; factoryBeanName=org.springframework.boot.autoconfigure.web.servlet.HttpEncodingAutoConfiguration; factoryMethodName=characterEncodingFilter; initMethodName=null; destroyMethodName=(inferred); defined in class path resource [org/springframework/boot/autoconfigure/web/servlet/HttpEncodingAutoConfiguration.class]] with [Root bean: class [null]; scope=; abstract=false; lazyInit=false; autowireMode=3; dependencyCheck=0; autowireCandidate=true; primary=false; factoryBeanName=zipkin.autoconfigure.ui.ZipkinUiAutoConfiguration; factoryMethodName=characterEncodingFilter; initMethodName=null; destroyMethodName=(inferred); defined in class path resource [zipkin/autoconfigure/ui/ZipkinUiAutoConfiguration.class]]
zipkin                      | 2018-07-12 15:17:25.801  INFO 1 --- [           main] o.xnio                                   : XNIO version 3.3.8.Final
zipkin                      | 2018-07-12 15:17:25.845  INFO 1 --- [           main] o.x.nio                                  : XNIO NIO Implementation Version 3.3.8.Final
zipkin                      | 2018-07-12 15:17:25.982  WARN 1 --- [           main] i.u.w.jsr                                : UT026009: XNIO worker was not set on WebSocketDeploymentInfo, the default worker will be used
zipkin                      | 2018-07-12 15:17:25.982  WARN 1 --- [           main] i.u.w.jsr                                : UT026010: Buffer pool was not set on WebSocketDeploymentInfo, the default pool will be used
zipkin                      | 2018-07-12 15:17:26.058  INFO 1 --- [           main] i.u.servlet                              : Initializing Spring embedded WebApplicationContext
zipkin                      | 2018-07-12 15:17:26.060  INFO 1 --- [           main] o.s.w.c.ContextLoader                    : Root WebApplicationContext: initialization completed in 5978 ms
zipkin                      | 2018-07-12 15:17:27.231  INFO 1 --- [           main] o.s.b.w.s.ServletRegistrationBean        : Servlet dispatcherServlet mapped to [/]
zipkin                      | 2018-07-12 15:17:27.242  INFO 1 --- [           main] o.s.b.w.s.FilterRegistrationBean         : Mapping filter: 'hiddenHttpMethodFilter' to: [/*]
zipkin                      | 2018-07-12 15:17:27.244  INFO 1 --- [           main] o.s.b.w.s.FilterRegistrationBean         : Mapping filter: 'httpPutFormContentFilter' to: [/*]
zipkin                      | 2018-07-12 15:17:27.245  INFO 1 --- [           main] o.s.b.w.s.FilterRegistrationBean         : Mapping filter: 'requestContextFilter' to: [/*]
zipkin                      | 2018-07-12 15:17:27.245  INFO 1 --- [           main] o.s.b.w.s.FilterRegistrationBean         : Mapping filter: 'httpTraceFilter' to: [/*]
zipkin                      | 2018-07-12 15:17:27.246  INFO 1 --- [           main] o.s.b.w.s.FilterRegistrationBean         : Mapping filter: 'webMvcMetricsFilter' to: [/*]
zipkin                      | 2018-07-12 15:17:27.246  INFO 1 --- [           main] o.s.b.w.s.FilterRegistrationBean         : Mapping filter: 'characterEncodingFilter' to: [/*]
zipkin                      | 2018-07-12 15:17:27.837  INFO 1 --- [           main] s.w.s.m.m.a.RequestMappingHandlerAdapter : Looking for @ControllerAdvice: org.springframework.boot.web.servlet.context.AnnotationConfigServletWebServerApplicationContext@7f9a81e8: startup date [Thu Jul 12 15:17:20 GMT 2018]; root of context hierarchy
zipkin                      | 2018-07-12 15:17:28.128  INFO 1 --- [           main] s.w.s.m.m.a.RequestMappingHandlerMapping : Mapped "{[/metrics],methods=[GET]}" onto public com.fasterxml.jackson.databind.node.ObjectNode zipkin.server.internal.MetricsHealthController.fetchMetricsFromMicrometer()
zipkin                      | 2018-07-12 15:17:28.182  INFO 1 --- [           main] s.w.s.m.m.a.RequestMappingHandlerMapping : Mapped "{[/health],methods=[GET]}" onto public org.springframework.http.ResponseEntity<java.util.Map> zipkin.server.internal.MetricsHealthController.getHealth()
zipkin                      | 2018-07-12 15:17:28.186  INFO 1 --- [           main] s.w.s.m.m.a.RequestMappingHandlerMapping : Mapped "{[/api/v2/trace/{traceIdHex}],methods=[GET],produces=[application/json]}" onto public java.lang.String zipkin.server.internal.ZipkinQueryApiV2.getTrace(java.lang.String,org.springframework.web.context.request.WebRequest) throws java.io.IOException
zipkin                      | 2018-07-12 15:17:28.186  INFO 1 --- [           main] s.w.s.m.m.a.RequestMappingHandlerMapping : Mapped "{[/api/v2/dependencies],methods=[GET],produces=[application/json]}" onto public byte[] zipkin.server.internal.ZipkinQueryApiV2.getDependencies(long,java.lang.Long) throws java.io.IOException
zipkin                      | 2018-07-12 15:17:28.187  INFO 1 --- [           main] s.w.s.m.m.a.RequestMappingHandlerMapping : Mapped "{[/api/v2/services],methods=[GET]}" onto public org.springframework.http.ResponseEntity<java.util.List<java.lang.String>> zipkin.server.internal.ZipkinQueryApiV2.getServiceNames() throws java.io.IOException
zipkin                      | 2018-07-12 15:17:28.187  INFO 1 --- [           main] s.w.s.m.m.a.RequestMappingHandlerMapping : Mapped "{[/api/v2/spans],methods=[GET]}" onto public org.springframework.http.ResponseEntity<java.util.List<java.lang.String>> zipkin.server.internal.ZipkinQueryApiV2.getSpanNames(java.lang.String) throws java.io.IOException
zipkin                      | 2018-07-12 15:17:28.188  INFO 1 --- [           main] s.w.s.m.m.a.RequestMappingHandlerMapping : Mapped "{[/api/v2/traces],methods=[GET],produces=[application/json]}" onto public java.lang.String zipkin.server.internal.ZipkinQueryApiV2.getTraces(java.lang.String,java.lang.String,java.lang.String,java.lang.Long,java.lang.Long,java.lang.Long,java.lang.Long,int) throws java.io.IOException
zipkin                      | 2018-07-12 15:17:28.193  INFO 1 --- [           main] s.w.s.m.m.a.RequestMappingHandlerMapping : Mapped "{[/error],produces=[text/html]}" onto public org.springframework.web.servlet.ModelAndView org.springframework.boot.autoconfigure.web.servlet.error.BasicErrorController.errorHtml(javax.servlet.http.HttpServletRequest,javax.servlet.http.HttpServletResponse)
zipkin                      | 2018-07-12 15:17:28.199  INFO 1 --- [           main] s.w.s.m.m.a.RequestMappingHandlerMapping : Mapped "{[/error]}" onto public org.springframework.http.ResponseEntity<java.util.Map<java.lang.String, java.lang.Object>> org.springframework.boot.autoconfigure.web.servlet.error.BasicErrorController.error(javax.servlet.http.HttpServletRequest)
zipkin                      | 2018-07-12 15:17:28.203  INFO 1 --- [           main] s.w.s.m.m.a.RequestMappingHandlerMapping : Mapped "{[/zipkin/config.json],methods=[GET]}" onto public org.springframework.http.ResponseEntity<zipkin.autoconfigure.ui.ZipkinUiProperties> zipkin.autoconfigure.ui.ZipkinUiAutoConfiguration.serveUiConfig()
zipkin                      | 2018-07-12 15:17:28.204  INFO 1 --- [           main] s.w.s.m.m.a.RequestMappingHandlerMapping : Mapped "{[/zipkin/ || /zipkin/traces/{id} || /zipkin/dependency || /zipkin/traceViewer],methods=[GET]}" onto public org.springframework.web.servlet.ModelAndView zipkin.autoconfigure.ui.ZipkinUiAutoConfiguration.forwardUiEndpoints()
zipkin                      | 2018-07-12 15:17:28.205  INFO 1 --- [           main] s.w.s.m.m.a.RequestMappingHandlerMapping : Mapped "{[/zipkin/api/**],methods=[GET]}" onto public org.springframework.web.servlet.ModelAndView zipkin.autoconfigure.ui.ZipkinUiAutoConfiguration.forwardApi(javax.servlet.http.HttpServletRequest)
zipkin                      | 2018-07-12 15:17:28.205  INFO 1 --- [           main] s.w.s.m.m.a.RequestMappingHandlerMapping : Mapped "{[/zipkin/index.html],methods=[GET]}" onto public org.springframework.http.ResponseEntity<?> zipkin.autoconfigure.ui.ZipkinUiAutoConfiguration.serveIndex() throws java.io.IOException
zipkin                      | 2018-07-12 15:17:28.206  INFO 1 --- [           main] s.w.s.m.m.a.RequestMappingHandlerMapping : Mapped "{[/favicon.ico],methods=[GET]}" onto public org.springframework.web.servlet.ModelAndView zipkin.autoconfigure.ui.ZipkinUiAutoConfiguration.favicon()
zipkin                      | 2018-07-12 15:17:28.206  INFO 1 --- [           main] s.w.s.m.m.a.RequestMappingHandlerMapping : Mapped "{[/],methods=[GET]}" onto public void zipkin.autoconfigure.ui.ZipkinUiAutoConfiguration.redirectRoot(javax.servlet.http.HttpServletResponse) throws java.io.IOException
zipkin                      | 2018-07-12 15:17:28.291  INFO 1 --- [           main] o.s.w.s.h.SimpleUrlHandlerMapping        : Mapped URL path [/prometheus] onto handler of type [class org.springframework.web.servlet.mvc.ParameterizableViewController]
zipkin                      | 2018-07-12 15:17:28.291  INFO 1 --- [           main] o.s.w.s.h.SimpleUrlHandlerMapping        : Mapped URL path [/info] onto handler of type [class org.springframework.web.servlet.mvc.ParameterizableViewController]
zipkin                      | 2018-07-12 15:17:28.351  INFO 1 --- [           main] o.s.w.s.h.SimpleUrlHandlerMapping        : Mapped URL path [/webjars/**] onto handler of type [class org.springframework.web.servlet.resource.ResourceHttpRequestHandler]
zipkin                      | 2018-07-12 15:17:28.351  INFO 1 --- [           main] o.s.w.s.h.SimpleUrlHandlerMapping        : Mapped URL path [/**] onto handler of type [class org.springframework.web.servlet.resource.ResourceHttpRequestHandler]
zipkin                      | 2018-07-12 15:17:28.352  INFO 1 --- [           main] o.s.w.s.h.SimpleUrlHandlerMapping        : Mapped URL path [/zipkin/**] onto handler of type [class org.springframework.web.servlet.resource.ResourceHttpRequestHandler]
zipkin                      | 2018-07-12 15:17:29.437  INFO 1 --- [           main] c.d.d.core                               : DataStax Java driver 3.5.0 for Apache Cassandra
zipkin                      | 2018-07-12 15:17:29.464  INFO 1 --- [           main] c.d.d.c.GuavaCompatibility               : Detected Guava >= 19 in the classpath, using modern compatibility layer
zipkin                      | 2018-07-12 15:17:30.054  INFO 1 --- [           main] c.d.d.c.ClockFactory                     : Using native clock to generate timestamps.
zipkin                      | 2018-07-12 15:17:30.390  INFO 1 --- [           main] o.s.b.a.e.w.EndpointLinksResolver        : Exposing 15 endpoint(s) beneath base path '/actuator'
zipkin                      | 2018-07-12 15:17:30.408  INFO 1 --- [           main] s.b.a.e.w.s.WebMvcEndpointHandlerMapping : Mapped "{[/actuator/auditevents],methods=[GET],produces=[application/vnd.spring-boot.actuator.v2+json || application/json]}" onto public java.lang.Object org.springframework.boot.actuate.endpoint.web.servlet.AbstractWebMvcEndpointHandlerMapping$OperationHandler.handle(javax.servlet.http.HttpServletRequest,java.util.Map<java.lang.String, java.lang.String>)
zipkin                      | 2018-07-12 15:17:30.410  INFO 1 --- [           main] s.b.a.e.w.s.WebMvcEndpointHandlerMapping : Mapped "{[/actuator/beans],methods=[GET],produces=[application/vnd.spring-boot.actuator.v2+json || application/json]}" onto public java.lang.Object org.springframework.boot.actuate.endpoint.web.servlet.AbstractWebMvcEndpointHandlerMapping$OperationHandler.handle(javax.servlet.http.HttpServletRequest,java.util.Map<java.lang.String, java.lang.String>)
zipkin                      | 2018-07-12 15:17:30.410  INFO 1 --- [           main] s.b.a.e.w.s.WebMvcEndpointHandlerMapping : Mapped "{[/actuator/health],methods=[GET],produces=[application/vnd.spring-boot.actuator.v2+json || application/json]}" onto public java.lang.Object org.springframework.boot.actuate.endpoint.web.servlet.AbstractWebMvcEndpointHandlerMapping$OperationHandler.handle(javax.servlet.http.HttpServletRequest,java.util.Map<java.lang.String, java.lang.String>)
zipkin                      | 2018-07-12 15:17:30.411  INFO 1 --- [           main] s.b.a.e.w.s.WebMvcEndpointHandlerMapping : Mapped "{[/actuator/conditions],methods=[GET],produces=[application/vnd.spring-boot.actuator.v2+json || application/json]}" onto public java.lang.Object org.springframework.boot.actuate.endpoint.web.servlet.AbstractWebMvcEndpointHandlerMapping$OperationHandler.handle(javax.servlet.http.HttpServletRequest,java.util.Map<java.lang.String, java.lang.String>)
zipkin                      | 2018-07-12 15:17:30.411  INFO 1 --- [           main] s.b.a.e.w.s.WebMvcEndpointHandlerMapping : Mapped "{[/actuator/configprops],methods=[GET],produces=[application/vnd.spring-boot.actuator.v2+json || application/json]}" onto public java.lang.Object org.springframework.boot.actuate.endpoint.web.servlet.AbstractWebMvcEndpointHandlerMapping$OperationHandler.handle(javax.servlet.http.HttpServletRequest,java.util.Map<java.lang.String, java.lang.String>)
zipkin                      | 2018-07-12 15:17:30.412  INFO 1 --- [           main] s.b.a.e.w.s.WebMvcEndpointHandlerMapping : Mapped "{[/actuator/env/{toMatch}],methods=[GET],produces=[application/vnd.spring-boot.actuator.v2+json || application/json]}" onto public java.lang.Object org.springframework.boot.actuate.endpoint.web.servlet.AbstractWebMvcEndpointHandlerMapping$OperationHandler.handle(javax.servlet.http.HttpServletRequest,java.util.Map<java.lang.String, java.lang.String>)
zipkin                      | 2018-07-12 15:17:30.412  INFO 1 --- [           main] s.b.a.e.w.s.WebMvcEndpointHandlerMapping : Mapped "{[/actuator/env],methods=[GET],produces=[application/vnd.spring-boot.actuator.v2+json || application/json]}" onto public java.lang.Object org.springframework.boot.actuate.endpoint.web.servlet.AbstractWebMvcEndpointHandlerMapping$OperationHandler.handle(javax.servlet.http.HttpServletRequest,java.util.Map<java.lang.String, java.lang.String>)
zipkin                      | 2018-07-12 15:17:30.430  INFO 1 --- [           main] s.b.a.e.w.s.WebMvcEndpointHandlerMapping : Mapped "{[/actuator/info],methods=[GET],produces=[application/vnd.spring-boot.actuator.v2+json || application/json]}" onto public java.lang.Object org.springframework.boot.actuate.endpoint.web.servlet.AbstractWebMvcEndpointHandlerMapping$OperationHandler.handle(javax.servlet.http.HttpServletRequest,java.util.Map<java.lang.String, java.lang.String>)
zipkin                      | 2018-07-12 15:17:30.431  INFO 1 --- [           main] s.b.a.e.w.s.WebMvcEndpointHandlerMapping : Mapped "{[/actuator/loggers],methods=[GET],produces=[application/vnd.spring-boot.actuator.v2+json || application/json]}" onto public java.lang.Object org.springframework.boot.actuate.endpoint.web.servlet.AbstractWebMvcEndpointHandlerMapping$OperationHandler.handle(javax.servlet.http.HttpServletRequest,java.util.Map<java.lang.String, java.lang.String>)
zipkin                      | 2018-07-12 15:17:30.432  INFO 1 --- [           main] s.b.a.e.w.s.WebMvcEndpointHandlerMapping : Mapped "{[/actuator/loggers/{name}],methods=[GET],produces=[application/vnd.spring-boot.actuator.v2+json || application/json]}" onto public java.lang.Object org.springframework.boot.actuate.endpoint.web.servlet.AbstractWebMvcEndpointHandlerMapping$OperationHandler.handle(javax.servlet.http.HttpServletRequest,java.util.Map<java.lang.String, java.lang.String>)
zipkin                      | 2018-07-12 15:17:30.433  INFO 1 --- [           main] s.b.a.e.w.s.WebMvcEndpointHandlerMapping : Mapped "{[/actuator/loggers/{name}],methods=[POST],consumes=[application/vnd.spring-boot.actuator.v2+json || application/json]}" onto public java.lang.Object org.springframework.boot.actuate.endpoint.web.servlet.AbstractWebMvcEndpointHandlerMapping$OperationHandler.handle(javax.servlet.http.HttpServletRequest,java.util.Map<java.lang.String, java.lang.String>)
zipkin                      | 2018-07-12 15:17:30.433  INFO 1 --- [           main] s.b.a.e.w.s.WebMvcEndpointHandlerMapping : Mapped "{[/actuator/heapdump],methods=[GET],produces=[application/octet-stream]}" onto public java.lang.Object org.springframework.boot.actuate.endpoint.web.servlet.AbstractWebMvcEndpointHandlerMapping$OperationHandler.handle(javax.servlet.http.HttpServletRequest,java.util.Map<java.lang.String, java.lang.String>)
zipkin                      | 2018-07-12 15:17:30.434  INFO 1 --- [           main] s.b.a.e.w.s.WebMvcEndpointHandlerMapping : Mapped "{[/actuator/threaddump],methods=[GET],produces=[application/vnd.spring-boot.actuator.v2+json || application/json]}" onto public java.lang.Object org.springframework.boot.actuate.endpoint.web.servlet.AbstractWebMvcEndpointHandlerMapping$OperationHandler.handle(javax.servlet.http.HttpServletRequest,java.util.Map<java.lang.String, java.lang.String>)
zipkin                      | 2018-07-12 15:17:30.434  INFO 1 --- [           main] s.b.a.e.w.s.WebMvcEndpointHandlerMapping : Mapped "{[/actuator/prometheus],methods=[GET],produces=[text/plain;version=0.0.4;charset=utf-8]}" onto public java.lang.Object org.springframework.boot.actuate.endpoint.web.servlet.AbstractWebMvcEndpointHandlerMapping$OperationHandler.handle(javax.servlet.http.HttpServletRequest,java.util.Map<java.lang.String, java.lang.String>)
zipkin                      | 2018-07-12 15:17:30.435  INFO 1 --- [           main] s.b.a.e.w.s.WebMvcEndpointHandlerMapping : Mapped "{[/actuator/metrics/{requiredMetricName}],methods=[GET],produces=[application/vnd.spring-boot.actuator.v2+json || application/json]}" onto public java.lang.Object org.springframework.boot.actuate.endpoint.web.servlet.AbstractWebMvcEndpointHandlerMapping$OperationHandler.handle(javax.servlet.http.HttpServletRequest,java.util.Map<java.lang.String, java.lang.String>)
zipkin                      | 2018-07-12 15:17:30.435  INFO 1 --- [           main] s.b.a.e.w.s.WebMvcEndpointHandlerMapping : Mapped "{[/actuator/metrics],methods=[GET],produces=[application/vnd.spring-boot.actuator.v2+json || application/json]}" onto public java.lang.Object org.springframework.boot.actuate.endpoint.web.servlet.AbstractWebMvcEndpointHandlerMapping$OperationHandler.handle(javax.servlet.http.HttpServletRequest,java.util.Map<java.lang.String, java.lang.String>)
zipkin                      | 2018-07-12 15:17:30.436  INFO 1 --- [           main] s.b.a.e.w.s.WebMvcEndpointHandlerMapping : Mapped "{[/actuator/scheduledtasks],methods=[GET],produces=[application/vnd.spring-boot.actuator.v2+json || application/json]}" onto public java.lang.Object org.springframework.boot.actuate.endpoint.web.servlet.AbstractWebMvcEndpointHandlerMapping$OperationHandler.handle(javax.servlet.http.HttpServletRequest,java.util.Map<java.lang.String, java.lang.String>)
zipkin                      | 2018-07-12 15:17:30.436  INFO 1 --- [           main] s.b.a.e.w.s.WebMvcEndpointHandlerMapping : Mapped "{[/actuator/httptrace],methods=[GET],produces=[application/vnd.spring-boot.actuator.v2+json || application/json]}" onto public java.lang.Object org.springframework.boot.actuate.endpoint.web.servlet.AbstractWebMvcEndpointHandlerMapping$OperationHandler.handle(javax.servlet.http.HttpServletRequest,java.util.Map<java.lang.String, java.lang.String>)
zipkin                      | 2018-07-12 15:17:30.437  INFO 1 --- [           main] s.b.a.e.w.s.WebMvcEndpointHandlerMapping : Mapped "{[/actuator/mappings],methods=[GET],produces=[application/vnd.spring-boot.actuator.v2+json || application/json]}" onto public java.lang.Object org.springframework.boot.actuate.endpoint.web.servlet.AbstractWebMvcEndpointHandlerMapping$OperationHandler.handle(javax.servlet.http.HttpServletRequest,java.util.Map<java.lang.String, java.lang.String>)
zipkin                      | 2018-07-12 15:17:30.438  INFO 1 --- [           main] s.b.a.e.w.s.WebMvcEndpointHandlerMapping : Mapped "{[/actuator],methods=[GET],produces=[application/vnd.spring-boot.actuator.v2+json || application/json]}" onto protected java.util.Map<java.lang.String, java.util.Map<java.lang.String, org.springframework.boot.actuate.endpoint.web.Link>> org.springframework.boot.actuate.endpoint.web.servlet.WebMvcEndpointHandlerMapping.links(javax.servlet.http.HttpServletRequest,javax.servlet.http.HttpServletResponse)
zipkin                      | 2018-07-12 15:17:30.518  INFO 1 --- [           main] o.s.j.e.a.AnnotationMBeanExporter        : Registering beans for JMX exposure on startup
zipkin                      | 2018-07-12 15:17:30.559 DEBUG 1 --- [           main] z.a.u.ZipkinUiAutoConfiguration$1        : Initializing filter 'characterEncodingFilter'
zipkin                      | 2018-07-12 15:17:30.559 DEBUG 1 --- [           main] z.a.u.ZipkinUiAutoConfiguration$1        : Filter 'characterEncodingFilter' configured successfully
zipkin                      | 2018-07-12 15:17:30.796  INFO 1 --- [           main] o.s.b.w.e.u.UndertowServletWebServer     : Undertow started on port(s) 9411 (http) with context path ''
zipkin                      | 2018-07-12 15:17:30.802  INFO 1 --- [           main] z.s.ZipkinServer                         : Started ZipkinServer in 13.244 seconds (JVM running for 15.021)
zipkin                      | 2018-07-12 15:17:33.788  INFO 1 --- [  XNIO-2 task-1] i.u.servlet                              : Initializing Spring FrameworkServlet 'dispatcherServlet'
zipkin                      | 2018-07-12 15:17:33.788  INFO 1 --- [  XNIO-2 task-1] o.s.w.s.DispatcherServlet                : FrameworkServlet 'dispatcherServlet': initialization started
zipkin                      | 2018-07-12 15:17:33.810  INFO 1 --- [  XNIO-2 task-1] o.s.w.s.DispatcherServlet                : FrameworkServlet 'dispatcherServlet': initialization completed in 22 ms
+ docker-compose -f docker-compose.yml -f docker-compose-elasticsearch.yml down
Stopping grafana       ... done
Stopping prometheus    ... done
Stopping dependencies  ... done
Stopping zipkin        ... done
Stopping elasticsearch ... done
Removing setup_grafana_datasource ... done
Removing grafana                  ... done
Removing prometheus               ... done
Removing dependencies             ... done
Removing zipkin                   ... done
Removing elasticsearch            ... done
Removing network docker-zipkin_default
+ kill 12715
+ cp ./application.original.yml spring-cloud-sleuth/spring-cloud-sleuth-samples/spring-cloud-sleuth-sample-zipkin/src/main/resources/application.yml
2018-07-12 11:19:25.267  INFO [testsleuthzipkin,,,] 12715 --- [       Thread-7] ConfigServletWebServerApplicationContext : Closing org.springframework.boot.web.servlet.context.AnnotationConfigServletWebServerApplicationContext@395ea517: startup date [Thu Jul 12 11:17:05 EDT 2018]; root of context hierarchy
+ cp ./SampleController.original.java spring-cloud-sleuth/spring-cloud-sleuth-samples/spring-cloud-sleuth-sample-zipkin/src/main/java/sample/SampleController.java
2018-07-12 11:19:25.270  INFO [testsleuthzipkin,,,] 12715 --- [       Thread-7] o.s.j.e.a.AnnotationMBeanExporter        : Unregistering JMX-exposed beans on shutdown
```
