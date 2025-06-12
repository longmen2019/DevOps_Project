// Defines the package where this service class resides, within the "service" layer
package com.javatechie.service;

// Imports the Course class (DTO) to handle course data
import com.javatechie.dto.Course;

// Imports the @Service annotation to mark this class as a Spring service component
import org.springframework.stereotype.Service;

// Imports necessary classes for working with lists and optional values
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

// Indicates that this class is a service component in the Spring application
@Service
public class CourseService {

    // Simulates a database by using an in-memory list to store courses
    private final List<Course> courses = new ArrayList<>();

    // Adds a new course to the list
    public void addCourse(Course course) {
        courses.add(course);
    }

    // Retrieves all courses stored in the list
    public List<Course> getAllCourses() {
        return courses;
    }

    // Retrieves a specific course by its ID, returning an Optional to handle cases where the course may not exist
    public Optional<Course> getCourseById(int id) {
        return courses.stream()
                .filter(course -> course.getId() == id) // Filters the list to find a course matching the given ID
                .findFirst(); // Returns the first match, wrapped in an Optional
    }

    // Updates an existing course by its ID, replacing it with the new course data if found
    public boolean updateCourse(int id, Course newCourse) {
        // Checks if the course exists using getCourseById, and if found, updates it
        return getCourseById(id).map(existingCourse -> {
            courses.remove(existingCourse); // Removes the old course
            courses.add(newCourse); // Adds the updated course
            return true; // Returns true if the update is successful
        }).orElse(false); // Returns false if the course was not found
    }

    // Deletes a course by its ID, removing it from the list if it exists
    public boolean deleteCourse(int id) {
        return courses
                .removeIf(course -> course.getId() == id); // Removes the course if the ID matches
    }
}
