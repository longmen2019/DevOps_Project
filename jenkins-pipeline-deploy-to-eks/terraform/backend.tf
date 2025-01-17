terraform {
  backend "s3" {
    bucket = "cicd-terraform-eks-longmen"
    region = "us-east-1"
    key = "eks/terraform.tfstate"
  }
}