# Configuring the AWS provider.
provider "aws" {
  # Setting the AWS region to the value of the aws_region variable.
  region = var.aws_region
}

# Data source to get the list of available AWS availability zones.
data "aws_availability_zones" "available" {}

# Declaring local values for the configuration.
locals {
  # Creating a local variable for the cluster name, using a random string suffix.
  cluster_name = "long-men-eks-${random_string.suffix.result}"
}

# Resource to generate a random string for the suffix.
resource "random_string" "suffix" {
  # Setting the length of the random string to 8 characters.
  length  = 8
  # Ensuring the random string does not include special characters.
  special = false
}

# Using a Terraform module to create a VPC.
module "vpc" {
  # Source of the VPC module from the Terraform registry.
  source  = "terraform-aws-modules/vpc/aws"
  # Version of the VPC module to use.
  version = "5.7.0"

  # Name of the VPC.
  name                 = "abhi-eks-vpc"
  # CIDR block for the VPC, taken from the vpc_cidr variable.
  cidr                 = var.vpc_cidr
  # Availability zones for the VPC subnets, retrieved from the data source.
  azs                  = data.aws_availability_zones.available.names
  # CIDR blocks for the private subnets within the VPC.
  private_subnets      = ["10.0.1.0/24", "10.0.2.0/24"]
  # CIDR blocks for the public subnets within the VPC.
  public_subnets       = ["10.0.4.0/24", "10.0.5.0/24"]
  # Enablement of NAT gateways in the VPC.
  enable_nat_gateway   = true
  # Use of a single NAT gateway for all private subnets.
  single_nat_gateway   = true
  # Enablement of DNS hostnames in the VPC.
  enable_dns_hostnames = true
  # Enablement of DNS support in the VPC.
  enable_dns_support   = true

  # Tags to assign to resources within the VPC.
  tags = {
    # Tag to identify the cluster associated with the VPC.
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }

  # Tags to assign to the public subnets within the VPC.
  public_subnet_tags = {
    # Tag to identify the cluster associated with the public subnets.
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    # Tag to designate the role of the subnet for ELB (Elastic Load Balancer).
    "kubernetes.io/role/elb"                      = "1"
  }

  # Tags to assign to the private subnets within the VPC.
  private_subnet_tags = {
    # Tag to identify the cluster associated with the private subnets.
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    # Tag to designate the role of the subnet for internal ELB.
    "kubernetes.io/role/internal-elb"             = "1"
  }
}
