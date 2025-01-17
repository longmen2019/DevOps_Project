# DevOps Project: AWS EKS Cluster with Jenkins Integration

This project demonstrates setting up an AWS EKS cluster using Terraform, deploying a Jenkins server on it, and managing Kubernetes resources. This guide will walk you through the setup, deployment, and cleanup processes.

## Prerequisites

- **AWS CLI v2**
- **Terraform**
- **Git**
- **An AWS account with appropriate permissions**
- **Jenkins**

## Table of Contents

1. [Setup Instructions](#setup-instructions)
2. [Terraform Instructions](#terraform-instructions)
3. [Deploying Jenkins](#deploying-jenkins)
4. [Kubernetes Resources](#kubernetes-resources)
5. [Cleaning Up](#cleaning-up)
6. [Notes](#notes)
7. [Contributions](#contributions)
8. [License](#license)

## Setup Instructions

1. **Clone the Repository**
    ```sh
    git clone https://github.com/longmen2019/DevOps_Project.git
    cd DevOps_Project
    ```

2. **Configure AWS CLI**
    ```sh
    aws configure
    ```

3. **Install Terraform**
    ```sh
    sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
    wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
    sudo apt update
    sudo apt-get install terraform
    ```

4. **Install Jenkins and Java**
    ```sh
    sudo apt-get update
    sudo apt-get install jenkins
    sudo apt update
    sudo apt install fontconfig openjdk-17-jre
    java -version
    ```

5. **Enable and Start Jenkins**
    ```sh
    sudo systemctl enable jenkins
    sudo systemctl start jenkins
    sudo systemctl status jenkins
    ```

## Terraform Instructions

1. **Navigate to the Terraform Directory**
    ```sh
    cd Terraform-Jenkins-AWSEks/EKS
    ```

2. **Initialize Terraform**
    ```sh
    terraform init
    ```

3. **Format Terraform Files**
    ```sh
    terraform fmt
    ```

4. **Validate Terraform Configuration**
    ```sh
    terraform validate
    ```

5. **Preview the Infrastructure Changes**
    ```sh
    terraform plan
    ```

6. **Apply the Terraform Configuration**
    ```sh
    terraform apply --auto-approve
    ```

## Deploying Jenkins

1. **Navigate to the Jenkins Server Directory**
    ```sh
    cd ../Jenkins-Server
    ```

2. **Apply the Terraform Configuration for Jenkins**
    ```sh
    terraform apply --auto-approve
    ```

## Kubernetes Resources

1. **Update kubeconfig**
    ```sh
    aws eks update-kubeconfig --region us-east-1 --name my-eks-cluster
    ```

2. **Deploy Kubernetes Resources**
    ```sh
    kubectl apply --validate=false -f Terraform-Jenkins-AWSEks/EKS/ConfigurationFiles/deployment.yaml
    kubectl apply --validate=false -f Terraform-Jenkins-AWSEks/EKS/ConfigurationFiles/service.yaml
    ```

## Cleaning Up

1. **Destroy the Terraform Resources**
    ```sh
    terraform destroy --auto-approve
    ```

2. **Additional Cleanup Commands**
    ```sh
    aws logs describe-log-groups --log-group-name-prefix /aws/eks/my-eks-cluster/cluster
    aws logs delete-log-group --log-group-name /aws/eks/my-eks-cluster/cluster
    mv $HOME/.kube/config $HOME/.kube/config.old
    ```

## Notes

- Ensure your AWS credentials are correctly configured.
- If you encounter issues with EKS cluster deletion, ensure node groups are deleted first.
- Adjust the Terraform scripts as needed to fit your specific use case.

## Contributions

Feel free to contribute to this project by creating pull requests or submitting issues.

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.
