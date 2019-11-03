FROM openjdk:8-jre-alpine

LABEL maintainer="ivangfr@yahoo.com.br"

COPY target/consumer-api-*.jar consumer-api.jar

CMD ["java", "-jar", "/consumer-api.jar"]

EXPOSE 8080