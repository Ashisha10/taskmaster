# Use the Maven image for building the application
FROM maven:3.9.9-amazoncorretto-17-alpine AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy the root pom.xml and application submodule pom.xml into the container
COPY pom.xml ./pom.xml
COPY application/pom.xml ./application/pom.xml

# Copy the source code of the application submodule
COPY application/src ./application/src

# Run Maven dependency resolution and build
RUN mvn dependency:go-offline
RUN mvn clean package -DskipTests

# Runtime image based on distroless Java 17 image
FROM gcr.io/distroless/java17-debian11:latest

# Set the working directory inside the container
WORKDIR /app

# Copy the packaged JAR file from the builder stage
COPY --from=builder /app/application/target/application-0.0.1-SNAPSHOT.jar app.jar

# Expose the application port (default 8080)
EXPOSE 8080
EXPOSE 9090  # Prometheus
EXPOSE 3000  # Grafana

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
