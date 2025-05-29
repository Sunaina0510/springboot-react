FROM maven:openjdk as build

WORKDIR /app

COPY pom.xml .
COPY src ./src

RUN mvn clean install

COPY . .

FROM openjdk:17-jdk-slim as final

WORKDIR /app

COPY --from=build /app/target/springboot-react-1.0.0.jar app.jar

EXPOSE 9001

ENTRYPOINT ["java", "-jar", "app.jar"]
