provider "aws" {
  region = "us-east-1"
}

resource "aws_cloudwatch_log_group" "this" {
  name = "/aws/eks/my-eks-cluster/cluster"

  lifecycle {
    prevent_destroy = true
  }
}