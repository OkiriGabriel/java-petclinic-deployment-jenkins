# Use an official Maven image to build the application
FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app

# Copy the project files
COPY . .

# Build the application using Maven without relying on mvnw
RUN mvn -B clean package

# Use an official Jetty image to run the application
FROM jetty:11.0.11-jdk17
WORKDIR /var/lib/jetty/webapps

# Copy the WAR file from the build stage to the Jetty webapps directory
COPY --from=build /app/target/*.war /var/lib/jetty/webapps/root.war

# Expose the port Jetty will run on
EXPOSE 8080

# Jetty automatically runs with the WAR file, so no CMD needed
