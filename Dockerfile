# Use an official OpenJDK runtime as a parent image
FROM  openjdk:17-jdk-slim

# Set the working directory in the container
WORKDIR /app

# Copy the Spring Boot application JAR from the application module to the container
COPY application/target/application-0.0.1-SNAPSHOT.jar /app/application.jar

# Expose port 8080 for the application
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "/app/application.jar"]
