// Declares the package for the Course class, organizing it within the "dto" (Data Transfer Object) layer
package com.javatechie.dto;

// Importing Lombok's @AllArgsConstructor annotation to automatically generate a constructor with all fields as parameters
import lombok.AllArgsConstructor;

// Importing Lombok's @Data annotation to automatically generate getter, setter, toString, equals, and hashCode methods
import lombok.Data;

// Importing Lombok's @NoArgsConstructor annotation to automatically generate a default constructor (no parameters)
import lombok.NoArgsConstructor;

// Lombok's @Data annotation is used to generate boilerplate code such as getters, setters, etc.
@Data
// Lombok's @AllArgsConstructor annotation is used to generate a constructor with all fields
@AllArgsConstructor
// Lombok's @NoArgsConstructor annotation is used to generate a no-args constructor
@NoArgsConstructor
public class Course {

    // Field to represent the course's unique identifier
    private int id;

    // Field to represent the name of the course
    private String name;

    // Field to represent the price of the course
    private double price;
}
