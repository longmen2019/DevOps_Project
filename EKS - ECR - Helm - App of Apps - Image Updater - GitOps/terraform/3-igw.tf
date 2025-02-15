# Define an AWS Internet Gateway resource
resource "aws_internet_gateway" "igw" {
  # Attach the Internet Gateway to the main VPC (using the ID of the aws_vpc.main resource)
  vpc_id = aws_vpc.main.id

  # Add tags to the Internet Gateway for organization and identification
  tags = {
    # Name tag, using the local environment variable to create a descriptive name
    Name = "${local.env}-igw"
  }
}