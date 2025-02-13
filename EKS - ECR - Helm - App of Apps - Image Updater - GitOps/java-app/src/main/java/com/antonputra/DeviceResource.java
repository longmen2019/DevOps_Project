// Defines the package for this class, which helps in organizing related classes.
package com.antonputra;

import java.util.Collections; // Provides utility methods for working with collections.
import java.util.LinkedHashMap; // Maintains insertion order for map elements.
import java.util.Set; // Represents a collection of unique elements.

import jakarta.ws.rs.ApplicationPath; // Defines the base URI for RESTful APIs.
import jakarta.ws.rs.core.Application; // Represents a JAX-RS application.
import jakarta.ws.rs.GET; // Annotation to define an HTTP GET endpoint.
import jakarta.ws.rs.Path; // Specifies the URL path for a RESTful resource.
import jakarta.ws.rs.Produces; // Specifies the response media type.
import jakarta.ws.rs.core.MediaType; // Defines media type constants, such as JSON or XML.

// Defines the base path for accessing this resource: "/devices"
@Path("/devices")
public class DeviceResource {

    // Specifies the base application path for all REST endpoints: "/api"
    @ApplicationPath("/api")
    public static class MyApplication extends Application {
    }

    // Defines a thread-safe set to store Device objects.
    // Uses a synchronized LinkedHashMap to maintain insertion order.
    private Set<Device> devices = Collections.newSetFromMap(Collections.synchronizedMap(new LinkedHashMap<>()));

    // Constructor to initialize the device set with some sample data.
    public DeviceResource() {
        // Adds a Device instance with a UUID, MAC address, and firmware version.
        devices.add(new Device("b0e42fe7-31a5-4894-a441-007e5256afea", "5F-33-CC-1F-43-82", "2.1.6"));
        // Adds another Device instance with different values.
        devices.add(new Device("0c3242f5-ae1f-4e0c-a31b-5ec93825b3e7", "EF-2B-C4-F5-D6-34", "2.1.5"));
    }

    // Defines an HTTP GET endpoint that returns the list of devices in JSON format.
    @GET
    @Produces(MediaType.APPLICATION_JSON) // Specifies that the response should be in JSON format.
    public Set<Device> list() {
        return devices; // Returns the set of devices.
    }
}
