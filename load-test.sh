#!/usr/bin/env bash

# 1) Clone Spring Cloud Sleuth submodule
# 2) Use mvnw to start Zipkin sample Spring Boot app from Spring Cloud Sleuth repo (in the background)
# 3) Use docker-compose to bring up Zipkin, ES, and dependencies
# 4) Use JMeter to run a test plan that makes HTTP calls to Spring Boot app, which creates zipkin spans
# 5) Use curl to get Zipkin server metrics, including dropped span count
# 6) Use docker-compose to bring down Zipkin, ES, and dependencies
# 7) Kill mvnw process to stop Spring Boot app

set -x

run_load_test() {
  # Start Zipkin with ES for storage
  docker-compose -f docker-compose.yml -f docker-compose-elasticsearch.yml up -d
  sleep 45s

  # Run JMeter test plan with thread/loop count from function args
  timestamp=$(date -u +'%Y-%m-%dT%H-%M-%SZ')
  jmeter -n \
    -t ./spring_cloud_sleuth_zipkin.jmx \
    -l "jmeter-results-$timestamp.txt" \
    -e \
    -o "jmeter-report-$timestamp" \
    -JNumberOfThreads="$1" \
    -JLoopCount="$2"
  sleep 15s

  # Print config
  set +x
  echo '-----------------------'
  echo "ES_TIMEOUT      = 5000"
  echo "ES_MAX_REQUESTS = 64"
  echo "NumberOfThreads = $1"
  echo "LoopCount       = $2"
  set -x

  # Get Zipkin metrics
  curl --silent http://localhost:9411/metrics
  set +x
  echo '-----------------------'
  set -x

  # Get Zipkin logs
  docker-compose -f docker-compose.yml -f docker-compose-elasticsearch.yml logs zipkin

  # Stop Zipkin
  docker-compose -f docker-compose.yml -f docker-compose-elasticsearch.yml down
}

# Clone the spring-cloud-sleuth repo which has sample Spring Boot apps
git submodule init
git submodule update --depth 1

# Enable zipkin and disable logging
cp ./application.zipkin-enabled.yml spring-cloud-sleuth/spring-cloud-sleuth-samples/spring-cloud-sleuth-sample-zipkin/src/main/resources/application.yml
cp ./SampleController.quiet.java    spring-cloud-sleuth/spring-cloud-sleuth-samples/spring-cloud-sleuth-sample-zipkin/src/main/java/sample/SampleController.java

# Run the sample Spring Boot app in the background
cd ./spring-cloud-sleuth || exit 1
./mvnw install -DskipTests
./mvnw --projects spring-cloud-sleuth-samples/spring-cloud-sleuth-sample-zipkin spring-boot:run &
MVNW_PID=$!
cd .. || exit 1
sleep 15s

# Run test with 200 threads and 500 loops per thread
run_load_test '200' '500'

# Kill mvnw process
kill $MVNW_PID

# Restore original application.yml and SampleApplication.java
cp ./application.original.yml       spring-cloud-sleuth/spring-cloud-sleuth-samples/spring-cloud-sleuth-sample-zipkin/src/main/resources/application.yml
cp ./SampleController.original.java spring-cloud-sleuth/spring-cloud-sleuth-samples/spring-cloud-sleuth-sample-zipkin/src/main/java/sample/SampleController.java
