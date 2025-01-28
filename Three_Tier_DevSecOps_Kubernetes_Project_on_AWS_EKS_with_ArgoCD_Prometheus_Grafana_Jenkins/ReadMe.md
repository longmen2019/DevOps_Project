# Jenkins and SonarQube Setup Guide

This document provides step-by-step instructions to set up Jenkins and SonarQube using Docker. It also includes commands for managing clusters with `eksctl`.

## Table of Contents
- [Jenkins Setup](#jenkins-setup)
- [SonarQube Setup](#sonarqube-setup)
- [Docker Management](#docker-management)
- [EKS Cluster Management](#eks-cluster-management)

## Jenkins Setup
1. Set the hostname for the Jenkins server:
    ```sh
    sudo hostnamectl hostname jenkinserver
    ```

2. Check the status of Jenkins service:
    ```sh
    sudo systemctl status jenkins
    ```

## SonarQube Setup
1. Check the status of SonarQube service:
    ```sh
    sudo systemctl status sonarqube
    ```

2. Reload the systemd manager configuration:
    ```sh
    sudo systemctl daemon-reload
    ```

3. Start the SonarQube service:
    ```sh
    sudo systemctl start sonarqube
    ```

4. Check the status of SonarQube service again:
    ```sh
    sudo systemctl status sonarqube
    ```

## Docker Management
1. Run SonarQube Docker container:
    ```sh
    docker run -d --name sonar -p 9000:9000 sonarqube:lts-community
    ```

2. List all Docker containers:
    ```sh
    docker ps -a
    ```

3. Remove a Docker container:
    ```sh
    docker rm -f sonar
    ```

4. Rename a Docker container:
    ```sh
    docker rename sonar sonar_old
    ```

5. Build a Docker image for the backend:
    ```sh
    docker build -t backend .
    ```

6. Login to AWS ECR:
    ```sh
    aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 471112503258.dkr.ecr.us-east-1.amazonaws.com
    ```

## EKS Cluster Management
1. Create an EKS cluster:
    ```sh
    eksctl create cluster --name three-tier-k8s-eks-cluster --region us-east-1 --node-type t2.medium --nodes-min 2 --nodes-max 2
    ```

2. Delete an EKS cluster:
    ```sh
    eksctl delete cluster --name three-tier-k8s-eks-cluster --region us-east-1
    ```

## Miscellaneous Commands
- List directory contents:
    ```sh
    ls
    ```

- View command history:
    ```sh
    history
    ```



