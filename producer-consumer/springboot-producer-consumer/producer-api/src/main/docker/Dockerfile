FROM openjdk:8-jre-alpine

LABEL maintainer="ivangfr@yahoo.com.br"

COPY target/producer-api-*.jar producer-api.jar

CMD ["java", "-jar", "/producer-api.jar"]

EXPOSE 8080