#!/bin/bash
set -e

# Update package list and install dependencies
sudo apt-get update
sudo apt-get install -y ca-certificates curl

# Create keyrings directory if it doesn't exist
sudo install -m 0755 -d /etc/apt/keyrings

# Download Docker's official GPG key
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add Docker repository to Apt sources
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
$(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package list and install Docker components
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "Docker installation completed!"

# Add user to Docker group and refresh permissions
sudo usermod -aG docker $USER
newgrp docker

# Ensure the Jenkins image is available locally
docker pull jenkins/jenkins:lts

# Run Jenkins Docker container
docker run -d --name jenkins-dind \
-p 8080:8080 -p 50000:50000 \
-v /var/run/docker.sock:/var/run/docker.sock \
-v $(which docker):/usr/bin/docker \
-u root \
-e DOCKER_GID=$(getent group docker | cut -d: -f3) \
jenkins/jenkins:lts

echo "Jenkins container is now running!"
