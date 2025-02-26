terraform {
  backend "s3" {
    bucket = "longmen-sslbucket" # Replace with your actual S3 bucket name
    key    = "EKS-longmen/terraform.tfstate"
    region = "us-east-1"
  }
}
