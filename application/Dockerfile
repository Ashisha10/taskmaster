# Build stage
FROM maven:3.9.9-amazoncorretto-17-alpine as builder

WORKDIR /app

# Copy pom.xml and download dependencies without building the app
COPY pom.xml ./
RUN mvn dependency:go-offline

# Copy source code and build the app
COPY src ./src
RUN mvn clean package -DskipTests

# Runtime stage
FROM gcr.io/distroless/java17-debian11:latest

WORKDIR /app

# Copy the generated JAR from the builder stage
COPY --from=builder /app/target/*.jar app.jar

# Expose the app's port
EXPOSE 8080

# Run the Spring Boot application
ENTRYPOINT ["java", "-jar", "app.jar"]
