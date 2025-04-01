// This declares the package name. It organizes related classes together.
package com.javatechie;

// Import the SpringApplication class, which is used to bootstrap and launch a Spring application.
import org.springframework.boot.SpringApplication;

// Import the SpringBootApplication annotation, which is a convenience annotation that adds 
// @Configuration, @EnableAutoConfiguration, and @ComponentScan.
import org.springframework.boot.autoconfigure.SpringBootApplication;

// This annotation marks the class as a Spring Boot application. It serves as the starting point for Spring Boot configurations.
@SpringBootApplication
public class CourseServiceApplication {

    // The main method serves as the entry point for the Java application.
    public static void main(String[] args) {
        // This line starts the Spring application by passing the main class and command-line arguments to SpringApplication.run.
        SpringApplication.run(CourseServiceApplication.class, args);
    }
}
