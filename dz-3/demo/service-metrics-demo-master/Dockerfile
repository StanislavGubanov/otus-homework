FROM maven:3.8.3-openjdk-17 as builder
WORKDIR /build
ADD pom.xml ./pom.xml
ADD src ./src
RUN mvn install

FROM bellsoft/liberica-openjdk-alpine:17
COPY --from=builder build/target/demo-0.0.1-SNAPSHOT.jar /app/

ENTRYPOINT ["java", "-XX:+UseContainerSupport", "-jar", "/app/demo-0.0.1-SNAPSHOT.jar"]
