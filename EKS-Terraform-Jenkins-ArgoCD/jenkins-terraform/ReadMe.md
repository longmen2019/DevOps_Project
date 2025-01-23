Here is a README.md file based on the provided command lines:

---

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

### Remove Existing Project Directory

```bash
cd ..
rm -rf DevOps_Project
```

### Re-clone the Repository

```bash
git clone https://github.com/longmen2019/DevOps_Project.git
cd DevOps_Project/EKS-Terraform-Jenkins-ArgoCD/jenkins-terraform
```

### Re-initialize and Apply Terraform Configuration

1. **Initialize Terraform**

    ```bash
    terraform init
    ```

2. **Apply Terraform Configuration**

    ```bash
    terraform apply --auto-approve
    ```

### Additional Terraform Commands

- **Deploy using `terraform deploy`**

    ```bash
    terraform deploy --auto-approve
    ```

- **Validate and plan with specific variable file**

    ```bash
    terraform plan -var-file=variables.tfvars
    terraform apply -var-file=variables.tfvars --auto-approve
    ```

### Managing IAM Role

1. **View IAM Role Configuration**

    ```bash
    cat iam-role.tf
    ```

2. **Edit IAM Role Configuration**

    ```bash
    nano iam-role.tf
    ```

### Additional Information

Ensure you have valid AWS credentials configured. You can configure them using the AWS CLI:

```bash
aws configure
```

---

Feel free to adjust the content as needed! Let me know if there's anything else you need assistance with.