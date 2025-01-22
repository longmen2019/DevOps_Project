terraform { 
  # Define the Terraform block

  backend "s3" { 
    # Configure the backend to use Amazon S3 for storing the state file
    
    bucket = "devops-tetris-project"
    # Name of the S3 bucket to store the state file

    region = "us-east-1"
    # AWS region where the S3 bucket is located

    key = "devops-demo/jenkins/terraform.tfstate"
    # The path within the bucket where the state file will be stored

    dynamodb_table = "dynamodb-state-locking"
    # DynamoDB table used for state locking and consistency checking

    encrypt = true
    # Enable encryption of the state file in S3
  }

  required_version = ">=0.13.0"
  # Specify the minimum required version of Terraform

  required_providers {
    aws = {
      version = ">= 2.7.0"
      # Specify the required version of the AWS provider
      
      source = "hashicorp/aws"
      # Source of the AWS provider (HashiCorp's provider registry)
    }
  }
}
