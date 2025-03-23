# Define an AWS VPC resource
resource "aws_vpc" "main" {
  # Define the CIDR block for the VPC (IP address range)
  cidr_block = "10.0.0.0/16"

  # Enable DNS support for the VPC (allows instances to resolve DNS names)
  enable_dns_support  = true
  # Enable DNS hostnames for the VPC (allows instances to have public DNS hostnames)
  enable_dns_hostnames = true

  # Add tags to the VPC for organization and identification
  tags = {
    # Name tag, using the local environment variable to create a descriptive name
    Name = "${local.env}-main"
  }
}