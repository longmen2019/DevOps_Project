// Declares the package name, which is used to organize related classes.
package com.antonputra;

// Defines a public class named Device, which represents a device with specific properties.
public class Device {

    // Public instance variable to store the unique identifier (UUID) of the device.
    public String uuid;

    // Public instance variable to store the MAC address of the device.
    public String mac;

    // Public instance variable to store the firmware version of the device.
    public String firmware;

    // Default constructor (no-argument constructor).
    // This allows creating a Device object without providing any initial values.
    public Device() {
    }

    // Parameterized constructor to initialize a Device object with specific values.
    public Device(String uuid, String mac, String firmware) {
        this.uuid = uuid;         // Assigns the provided UUID to the instance variable.
        this.mac = mac;           // Assigns the provided MAC address to the instance variable.
        this.firmware = firmware; // Assigns the provided firmware version to the instance variable.
    }
}
