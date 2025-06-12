#!/bin/bash

# Update package lists
echo "Updating package lists..."
sudo apt update -y

# Install Java 21
echo "Installing OpenJDK 21..."
sudo apt install -y fontconfig openjdk-21-jre

# Verify Java installation
echo "Checking Java version..."
java -version

# Add Jenkins repository
echo "Adding Jenkins repository..."
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

echo "Configuring Jenkins repository..."
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# Update package lists again
echo "Updating package lists after adding Jenkins repo..."
sudo apt-get update -y

# Install Jenkins (auto-approve)
echo "Installing Jenkins..."
sudo apt-get install -y jenkins


# Install Trivy (auto-approve)
echo "Installing Trivy..."
sudo apt install -y wget apt-transport-https gnupg lsb-release
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
echo "deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main" | sudo tee -a /etc/apt/sources.list.d/trivy.list
sudo apt update -y
sudo apt install -y trivy


# Install Docker (auto-approve)
echo "Installing Docker..."
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update -y
sudo apt install -y docker-ce
sudo usermod -aG docker ${USER}
newgrp docker
sudo chmod 777 /var/run/docker.sock



echo "Setup completed successfully!"