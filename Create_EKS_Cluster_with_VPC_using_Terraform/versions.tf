# Terraform block sets the required version of Terraform and specifies the required providers.
terraform {
  # Specify the minimum required version of Terraform to be 0.12 or higher.
  required_version = ">= 0.12"

  # Define the required providers and their versions.
  required_providers {
    # Define the random provider with its source and version.
    random = {
      # The source of the provider.
      source  = "hashicorp/random"
      # The version of the provider, specified using the ~> operator for compatible versions.
      version = "~> 3.1.0"
    }

    # Define the kubernetes provider with its source and version.
    kubernetes = {
      # The source of the provider.
      source  = "hashicorp/kubernetes"
      # The version of the provider, specified using the >= operator for versions 2.7.1 and above.
      version = ">=2.7.1"
    }

    # Define the aws provider with its source and version.
    aws = {
      # The source of the provider.
      source  = "hashicorp/aws"
      # The version of the provider, specified using the >= operator for versions 3.68.0 and above.
      version = ">= 3.68.0"
    }

    # Define the local provider with its source and version.
    local = {
      # The source of the provider.
      source  = "hashicorp/local"
      # The version of the provider, specified using the ~> operator for compatible versions.
      version = "~> 2.1.0"
    }

    # Define the null provider with its source and version.
    null = {
      # The source of the provider.
      source  = "hashicorp/null"
      # The version of the provider, specified using the ~> operator for compatible versions.
      version = "~> 3.1.0"
    }

    # Define the cloudinit provider with its source and version.
    cloudinit = {
      # The source of the provider.
      source  = "hashicorp/cloudinit"
      # The version of the provider, specified using the ~> operator for compatible versions.
      version = "~> 2.2.0"
    }
  }
}
