# Use the official OpenJDK 17 image as the base image. This image includes the Java runtime environment.
FROM openjdk:17

# Set the working directory inside the container to "/app". All subsequent commands and actions will be relative to this directory.
WORKDIR /app

# Copy the compiled Java application JAR file from the local machine to the working directory inside the container.
COPY ./target/course-service.jar /app

# Expose port 8080 to allow external access to the Spring Boot application when it runs. 
EXPOSE 8080

# Define the command to start the Java application. It runs the JAR file using the Java runtime.
CMD ["java", "-jar", "course-service.jar"]
