# Build
FROM maven:3.6.0-jdk-8-slim AS build

COPY back /home/app/back
COPY ui /home/app/ui
COPY pom.xml /home/app

RUN mvn -f /home/app/pom.xml clean package -pl back

# Run
FROM openjdk:8-jre-slim
COPY --from=build /home/app/back/target/onSiteManagement.jar /usr/local/lib/onSiteManagement.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/usr/local/lib/onSiteManagement.jar"]