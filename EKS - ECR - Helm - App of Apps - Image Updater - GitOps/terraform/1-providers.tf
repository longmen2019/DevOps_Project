# Configure the AWS provider
provider "aws" {
  # Set the AWS region using the local variable defined earlier
  region = local.region
}

# Configure Terraform settings
terraform {
  # Specify the minimum required Terraform version
  required_version = ">= 1.0"

  # Define required providers and their versions
  required_providers {
    # Specify the AWS provider
    aws = {
      # Source of the AWS provider (HashiCorp's official provider)
      source  = "hashicorp/aws"
      # Version constraint for the AWS provider (approximately version 5.60)
      version = "~> 5.60"
    }
  }
}