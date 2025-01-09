# Terraform EKS Project

This project sets up an Amazon EKS (Elastic Kubernetes Service) cluster using Terraform. Follow the steps below to install the necessary tools, configure your environment, and deploy the EKS cluster.

## Prerequisites

- AWS CLI v2
- Terraform
- unzip
- gnupg and software-properties-common (for HashiCorp installation)
- Git

## Install AWS CLI v2

If you have AWS CLI v1 installed, you may want to remove it first:

```sh
sudo yum remove awscli
```

Download and install AWS CLI v2:

```sh
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```

To update AWS CLI v2:

```sh
sudo ./aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli --update
```

Verify the installation:

```sh
which aws
aws --version
```

## Install Terraform

Add the HashiCorp GPG key:

```sh
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint
```

Add the HashiCorp repository:

```sh
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update
```

Install Terraform:

```sh
sudo apt-get install terraform
```

Verify the installation:

```sh
terraform -help
terraform -help plan
```

Enable autocompletion:

```sh
touch ~/.bashrc
terraform -install-autocomplete
```

## Configure AWS CLI

Configure AWS CLI with your credentials:

```sh
aws configure
aws configure list
```

## Clone the Project Repository

Clone the project repository from GitHub:

```sh
git clone https://github.com/longmen2019/DevOps_Project.git
cd DevOps_Project
cd Create_EKS_Cluster_with_VPC_using_Terraform
```

## Deploy the EKS Cluster

Initialize Terraform:

```sh
terraform init
```

Plan the deployment:

```sh
terraform plan
```

Apply the configuration to create the EKS cluster:

```sh
terraform apply
```

## Destroy the EKS Cluster

To delete the EKS cluster and all associated resources:

```sh
terraform destroy
```

## Additional Information

For more details about the project and customization options, refer to the [official documentation](https://github.com/longmen2019/DevOps_Project).
