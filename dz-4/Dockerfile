FROM ghcr.io/graalvm/native-image:ol8-java17-22 AS builder
RUN useradd springuser
RUN microdnf update \
 && microdnf install --nodocs \
    findutils \
 && microdnf clean all \
 && rm -rf /var/cache/yum

WORKDIR /src
COPY ./gradlew /src/gradlew
COPY ./gradle /src/gradle
COPY ./settings.gradle /src/settings.gradle
COPY ./build.gradle /src/build.gradle
COPY ./src /src/src
RUN ./gradlew nativeCompile

FROM docker.io/oraclelinux:8-slim
ARG VER="0"
ENV MY_VER $VER
COPY --from=builder /etc/passwd /etc/passwd
USER springuser
EXPOSE 8080
COPY --from=builder /src/build/native/nativeCompile/demo .
ENTRYPOINT ["./demo"]
