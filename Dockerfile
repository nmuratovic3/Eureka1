#FROM amazoncorretto:11-alpine-jdk
FROM eclipse-temurin:17-jdk-alpine as build
WORKDIR /workspace/app

COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .
COPY src src

RUN ./mvnw install -DskipTests
RUN mkdir -p target/dependency && (cd target/dependency; jar -xf ../*.jar)
#COPY --from=ghcr.io/ufoscout/docker-compose-wait:latest /wait /wait
#
#COPY entrypoint.sh /srvc/entrypoint.sh
#
#ENTRYPOINT ["/bin/sh", "/srvc/entrypoint.sh"]


FROM eclipse-temurin:17-jdk-alpine
VOLUME /tmp
COPY target/*.jar Eureka.jar
#CMD /wait
ENTRYPOINT ["java","-jar","/Eureka.jar"]