// Defines the package where this controller class resides
package com.javatechie.controller;

// Imports the Course class used as a Data Transfer Object (DTO) for course data
import com.javatechie.dto.Course;

// Imports the CourseService class to handle business logic related to courses
import com.javatechie.service.CourseService;

// Spring framework annotations and classes for dependency injection and REST API management
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

// Imports for working with lists and optional values
import java.util.List;
import java.util.Optional;

// Marks this class as a REST controller, allowing it to handle HTTP requests
@RestController
// Maps all incoming requests with the base URL "/courses" to this controller
@RequestMapping("/courses")
public class CourseController {

    // Automatically injects an instance of CourseService into this controller
    @Autowired
    private CourseService courseService;

    // Handles HTTP POST requests to create a new course
    // Specifies JSON as the format for request and response data
    @PostMapping(produces = "application/json", consumes = "application/json")
    public ResponseEntity<Course> addCourse(@RequestBody Course course) {
        // Calls the service to save the new course
        courseService.addCourse(course);
        // Returns the saved course with a 201 CREATED status
        return new ResponseEntity<>(course, HttpStatus.CREATED);
    }

    // Handles HTTP GET requests to retrieve all courses
    // Specifies JSON as the format for the response data
    @GetMapping(produces = "application/json")
    public ResponseEntity<List<Course>> getAllCourses() {
        // Calls the service to retrieve all courses
        List<Course> courses = courseService.getAllCourses();
        // Returns the list of courses with a 200 OK status
        return new ResponseEntity<>(courses, HttpStatus.OK);
    }

    // Handles HTTP GET requests to retrieve a course by its ID
    // The {id} in the URL is extracted using the @PathVariable annotation
    @GetMapping(value = "/{id}", produces = "application/json")
    public ResponseEntity<Course> getCourseById(@PathVariable int id) {
        // Calls the service to find a course by ID, wrapped in an Optional
        Optional<Course> course = courseService.getCourseById(id);
        // If the course is found, returns it with a 200 OK status; otherwise, returns 404 NOT FOUND
        return course.map(value -> new ResponseEntity<>(value, HttpStatus.OK))
                .orElseGet(() -> new ResponseEntity<>(HttpStatus.NOT_FOUND));
    }

    // Handles HTTP PUT requests to update an existing course by its ID
    // Specifies JSON as the format for both request and response data
    @PutMapping(value = "/{id}", produces = "application/json", consumes = "application/json")
    public ResponseEntity<Course> updateCourse(@PathVariable int id, @RequestBody Course newCourse) {
        // Calls the service to update the course
        boolean updated = courseService.updateCourse(id, newCourse);
        // If the update is successful, returns the updated course with a 200 OK status
        if (updated) {
            return new ResponseEntity<>(newCourse, HttpStatus.OK);
        } else {
            // If the course ID is not found, returns 404 NOT FOUND
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    // Handles HTTP DELETE requests to delete a course by its ID
    @DeleteMapping(value = "/{id}", produces = "application/json")
    public ResponseEntity<Void> deleteCourse(@PathVariable int id) {
        // Calls the service to delete the course
        boolean deleted = courseService.deleteCourse(id);
        // If the deletion is successful, returns a 204 NO CONTENT status
        if (deleted) {
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } else {
            // If the course ID is not found, returns 404 NOT FOUND
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    // Health check endpoint to confirm that the service is running
    @GetMapping("/health")
    public String healthCheck() {
        // Returns a simple "UP" message
        return "UP";
    }

    // A welcome endpoint to display a custom greeting message
    @GetMapping("/welcome")
    public String greetings() {
        // Returns a greeting message
        return "Hello Techie , AWS CICD Example working fine !";
    }
}
