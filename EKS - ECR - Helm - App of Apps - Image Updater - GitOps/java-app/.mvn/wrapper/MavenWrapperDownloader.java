/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements. See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership. The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *  http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

import java.io.IOException; // Handles input/output exceptions
import java.io.InputStream; // Represents an input stream for reading data
import java.net.Authenticator; // Used for handling authentication requests
import java.net.PasswordAuthentication; // Encapsulates username and password authentication
import java.net.URL; // Represents a Uniform Resource Locator (URL)
import java.nio.file.Files; // Provides file-related operations
import java.nio.file.Path; // Represents a file path in the filesystem
import java.nio.file.Paths; // Provides methods for working with file paths
import java.nio.file.StandardCopyOption; // Defines options for copying or moving files

// This class is responsible for downloading the Maven Wrapper JAR file.
public final class MavenWrapperDownloader {

    // Defines the Maven Wrapper version to be downloaded.
    private static final String WRAPPER_VERSION = "3.2.0";

    // Reads the environment variable "MVNW_VERBOSE" to determine whether to enable verbose logging.
    private static final boolean VERBOSE = Boolean.parseBoolean(System.getenv("MVNW_VERBOSE"));

    // Main entry point of the application.
    public static void main(String[] args) {
        log("Apache Maven Wrapper Downloader " + WRAPPER_VERSION); // Log the downloader version.

        // Check if exactly two arguments are provided (wrapper URL and JAR path).
        if (args.length != 2) {
            System.err.println(" - ERROR wrapperUrl or wrapperJarPath parameter missing");
            System.exit(1); // Exit with an error code if parameters are missing.
        }

        try {
            log(" - Downloader started"); // Log the start of the download process.

            // Create a URL object from the first argument (the URL of the wrapper JAR).
            final URL wrapperUrl = new URL(args[0]);

            // Sanitize the file path by removing occurrences of ".." to prevent directory traversal attacks.
            final String jarPath = args[1].replace("..", "");

            // Convert the sanitized path to an absolute and normalized Path object.
            final Path wrapperJarPath = Paths.get(jarPath).toAbsolutePath().normalize();

            // Download the file from the provided URL to the specified path.
            downloadFileFromURL(wrapperUrl, wrapperJarPath);

            log("Done"); // Log completion of the download.
        } catch (IOException e) {
            // Print an error message if an exception occurs during the download.
            System.err.println("- Error downloading: " + e.getMessage());

            // If verbose logging is enabled, print the full stack trace for debugging.
            if (VERBOSE) {
                e.printStackTrace();
            }
            System.exit(1); // Exit with an error code.
        }
    }

    // Downloads a file from a given URL and saves it to the specified path.
    private static void downloadFileFromURL(URL wrapperUrl, Path wrapperJarPath) throws IOException {
        log(" - Downloading to: " + wrapperJarPath); // Log the target file path.

        // Check if environment variables for authentication are set.
        if (System.getenv("MVNW_USERNAME") != null && System.getenv("MVNW_PASSWORD") != null) {
            final String username = System.getenv("MVNW_USERNAME"); // Retrieve username from environment variable.
            final char[] password = System.getenv("MVNW_PASSWORD").toCharArray(); // Retrieve password securely.

            // Set up authentication using the provided credentials.
            Authenticator.setDefault(new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(username, password);
                }
            });
        }

        // Open an input stream to read the file from the URL and copy it to the target path.
        try (InputStream inStream = wrapperUrl.openStream()) {
            Files.copy(inStream, wrapperJarPath, StandardCopyOption.REPLACE_EXISTING);
        }

        log(" - Downloader complete"); // Log completion of the download.
    }

    // Logs messages to the console if verbose logging is enabled.
    private static void log(String msg) {
        if (VERBOSE) {
            System.out.println(msg); // Print message if VERBOSE mode is enabled.
        }
    }
}
