terraform {
  backend "s3" {
    bucket = "cicd-terraform-eks-longmen"
    key    = "jenkins/terraform.tfstate"
    region = "us-east-1"
  }
}