#
# Build
#
# This section of the Dockerfile is responsible for building the Java application.
# It uses the Debian 10 image as a base and installs Maven to manage the build process.
FROM debian:10 AS build

# RUN apt-get update && apt-get -y install maven:
# This line updates the package list and installs Maven on the Debian 10 image.
# Maven is a build automation tool for Java projects, and it's used here to manage the build process.
RUN apt-get update && apt-get -y install maven

# WORKDIR /opt/shipping:
# This line sets the working directory in the container to /opt/shipping.
# All subsequent commands will be executed from this directory.
WORKDIR /opt/shipping

# COPY pom.xml /opt/shipping/:
# This line copies the pom.xml file from the current directory (i.e., the directory containing the Dockerfile) into the container at the /opt/shipping/ path.
# The pom.xml file is used by Maven to manage the build process and dependencies.
COPY pom.xml /opt/shipping/

# RUN mvn dependency:resolve:
# This line runs the Maven command to resolve the dependencies specified in the pom.xml file.
# This command downloads the necessary dependencies and makes them available for the build process.
RUN mvn dependency:resolve

# COPY src /opt/shipping/src/:
# This line copies the source code (i.e., the Java files) from the current directory into the container at the /opt/shipping/src/ path.
COPY src /opt/shipping/src/

# RUN mvn package:
# This line runs the Maven command to package the Java application into a JAR file.
# The resulting JAR file will be used to run the application.
RUN mvn package

#
# Run
#
# This section of the Dockerfile is responsible for running the Java application.
# It uses the OpenJDK 8 image as a base and configures the environment to run the application.
FROM openjdk:8-jdk

# EXPOSE 8080:
# This line exposes port 8080 from the container to the host machine.
# This means that any traffic sent to port 8080 on the host machine will be forwarded to port 8080 inside the container.
EXPOSE 8080

# WORKDIR /opt/shipping:
# This line sets the working directory in the container to /opt/shipping.
# All subsequent commands will be executed from this directory.
WORKDIR /opt/shipping

# ENV CART_ENDPOINT=cart:8080:
# This line sets an environment variable named CART_ENDPOINT to the value "cart:8080".
# This variable will be used by the application to communicate with the cart service.
ENV CART_ENDPOINT=cart:8080

# ENV DB_HOST=mysql:
# This line sets an environment variable named DB_HOST to the value "mysql".
# This variable will be used by the application to communicate with the MySQL database.
ENV DB_HOST=mysql

# COPY --from=build /opt/shipping/target/shipping-1.0.jar shipping.jar:
# This line copies the shipping-1.0.jar file from the build stage into the current stage.
# The --from=build option specifies that the file should be copied from the build stage.
# The resulting file will be used to run the application.
COPY --from=build /opt/shipping/target/shipping-1.0.jar shipping.jar

# CMD [ "java", "-Xmn256m", "-Xmx768m", "-jar", "shipping.jar" ]:
# This line sets the default command to run when the container is started.
# The command runs the Java application with the specified options and arguments.
# The -Xmn256m option sets the initial heap size to 256MB, and the -Xmx768m option sets the maximum heap size to 768MB.
# The -jar option specifies that the application should be run from the shipping.jar file.
CMD [ "java", "-Xmn256m", "-Xmx768m", "-jar", "shipping.jar" ]
