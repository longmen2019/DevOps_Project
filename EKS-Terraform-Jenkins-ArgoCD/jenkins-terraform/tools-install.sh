#!/bin/bash
# This line specifies the script interpreter to be Bash

# For Ubuntu 22.04
# Installing Java
sudo apt update -y
# Update the package lists for upgrades, new packages, and package dependencies

sudo apt install openjdk-17-jre -y
# Install Java Runtime Environment (JRE) version 17

sudo apt install openjdk-17-jdk -y
# Install Java Development Kit (JDK) version 17

java --version
# Display the installed Java version

# Installing Jenkins
curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
# Download and add Jenkins GPG key to the keyring

echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
# Add Jenkins package repository to the sources list

sudo apt-get update -y
# Update the package lists again to include Jenkins repository

sudo apt-get install jenkins -y
# Install Jenkins

# Installing Docker
sudo apt update
# Update the package lists again

sudo apt install docker.io -y
# Install Docker

sudo usermod -aG docker jenkins
# Add Jenkins user to the Docker group

sudo usermod -aG docker ubuntu
# Add Ubuntu user to the Docker group

sudo systemctl restart docker
# Restart Docker service

sudo chmod 777 /var/run/docker.sock
# Change permissions for Docker socket

# If you don't want to install Jenkins, you can create a container of Jenkins
# docker run -d -p 8080:8080 -p 50000:50000 --name jenkins-container jenkins/jenkins:lts
# Run Jenkins in a Docker container instead of installing it directly

# Run Docker Container of Sonarqube
docker run -d --name sonar -p 9000:9000 sonarqube:lts-community
# Run SonarQube in a Docker container on port 9000

# Installing AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
# Download AWS CLI v2 installation package

sudo apt install unzip -y
# Install unzip utility

unzip awscliv2.zip
# Unzip the AWS CLI installation package

sudo ./aws/install
# Run the AWS CLI installation script

# Installing Kubectl
sudo apt update
# Update the package lists again

sudo apt install curl -y
# Install curl utility

sudo curl -LO "https://dl.k8s.io/release/v1.28.4/bin/linux/amd64/kubectl"
# Download Kubectl binary

sudo chmod +x kubectl
# Make Kubectl binary executable

sudo mv kubectl /usr/local/bin/
# Move Kubectl binary to a directory in the PATH

kubectl version --client
# Display the installed Kubectl version

# Installing Terraform
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
# Download and add HashiCorp GPG key to the keyring

echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
# Add HashiCorp repository to the sources list

sudo apt update
# Update the package lists again to include HashiCorp repository

sudo apt install terraform -y
# Install Terraform
