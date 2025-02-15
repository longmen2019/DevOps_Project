# Define local variables for configuration
locals {
  # Environment name (e.g., prod, dev, staging)
  env          = "prod"
  # AWS region
  region       = "us-east-2"
  # Availability Zone 1
  zone1        = "us-east-2a"
  # Availability Zone 2
  zone2        = "us-east-2b"
  # Name of the EKS cluster
  eks_name    = "demo"
  # Kubernetes version for the EKS cluster
  eks_version = "1.30"
}