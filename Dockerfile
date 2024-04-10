FROM maven:3.8.5-openjdk-17 AS build
COPY src /usr/src/app/src
COPY pom.xml /usr/src/app
RUN mvn -f /usr/src/app/pom.xml clean package

FROM openjdk:17
# environment variable with default value
ENV SPRING_PROFILE=mysql
COPY --from=build /usr/src/app/target/*.jar /usr/app/flighttracker-1.0.0-SNAPSHOT.jar 
EXPOSE 8080
ENTRYPOINT ["java","-jar","/usr/app/flighttracker-1.0.0-SNAPSHOT.jar"]