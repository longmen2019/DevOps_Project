terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.92.0"
    }
  }

  backend "s3" {
    bucket = "terraform-remote-backend-s3-longmen"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"
  
}

}

provider "aws" {
  region = "us-east-1"
}