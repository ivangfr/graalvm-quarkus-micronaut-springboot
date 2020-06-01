FROM openjdk:8-jre-alpine

LABEL maintainer="ivangfr@yahoo.com.br"

COPY target/springboot-elasticsearch-*.jar springboot-elasticsearch.jar

CMD ["java", "-jar", "/springboot-elasticsearch.jar"]

EXPOSE 8080