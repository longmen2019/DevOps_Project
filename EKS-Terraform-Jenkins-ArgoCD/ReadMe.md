

# EKS-Terraform-Jenkins-ArgoCD

This project sets up Jenkins and ArgoCD on Amazon Elastic Kubernetes Service (EKS) using Terraform.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) installed
- AWS account with proper IAM permissions
- SSH key pair for connecting to EC2 instances
- Git installed

## Setup Instructions

### Clone the Repository

```bash
git clone https://github.com/longmen2019/DevOps_Project.git
cd DevOps_Project/EKS-Terraform-Jenkins-ArgoCD/jenkins-terraform
```

### Format, Initialize, Validate, and Apply Terraform Configuration

1. **Format the Terraform code**

    ```bash
    terraform fmt
    ```

2. **Initialize the Terraform configuration**

    ```bash
    terraform init
    ```

3. **Validate the Terraform configuration**

    ```bash
    terraform validate
    ```

4. **Plan the Terraform deployment**

    ```bash
    terraform plan
    ```

5. **Apply the Terraform deployment**

    ```bash
    terraform apply --auto-approve
    ```

### Jenkins and ArgoCD Setup

1. **Set hostname for Jenkins**

    ```bash
    sudo hostnamectl set-hostname JenkinServer
    ```

2. **Switch to Jenkins user**

    ```bash
    sudo su jenkins
    ```

3. **Check Jenkins and Docker versions**

    ```bash
    jenkins --version
    docker --version
    ```

4. **Check Jenkins service status**

    ```bash
    systemctl status jenkins
    ```

5. **Configure AWS CLI**

    ```bash
    aws configure
    ```

6. **Update kubeconfig for EKS**

    ```bash
    aws eks update-kubeconfig --region us-east-1 --name Tetris-EKS-Cluster
    ```

7. **Check Kubernetes nodes and services**

    ```bash
    kubectl get nodes
    kubectl get svc
    ```

8. **Create namespaces for Tetris and ArgoCD**

    ```bash
    kubectl create namespace tetris
    kubectl create namespace argocd
    ```

9. **Install ArgoCD**

    ```bash
    kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/v2.4.7/manifests/install.yaml
    ```

10. **Retrieve ArgoCD initial admin password**

    ```bash
    kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
    ```

11. **Patch ArgoCD server service to use LoadBalancer**

    ```bash
    kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
    ```

### Additional Information

Ensure you have valid AWS credentials configured. You can configure them using the AWS CLI:

```bash
aws configure
```

