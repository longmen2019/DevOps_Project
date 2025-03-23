# Define an AWS subnet resource for private zone 1
resource "aws_subnet" "private_zone1" {
  # Associate the subnet with the main VPC (using the ID of the aws_vpc.main resource)
  vpc_id                = aws_vpc.main.id
  # Define the CIDR block for the subnet (IP address range)
  cidr_block            = "10.0.0.0/19"
  # Specify the availability zone for the subnet
  availability_zone = local.zone1

  # Add tags to the subnet for organization and identification
  tags = {
    # Name tag, using local variables to create a descriptive name
    "Name"                                         = "${local.env}-private-${local.zone1}"
    # Tag for Kubernetes internal load balancer role
    "kubernetes.io/role/internal-elb"             = "1"
    # Tag for Kubernetes cluster ownership
    "kubernetes.io/cluster/${local.env}-${local.eks_name}" = "owned"
  }
}

# Define an AWS subnet resource for private zone 2
resource "aws_subnet" "private_zone2" {
  # Associate the subnet with the main VPC
  vpc_id                = aws_vpc.main.id
  # Define the CIDR block for the subnet
  cidr_block            = "10.0.32.0/19"
  # Specify the availability zone for the subnet
  availability_zone = local.zone2

  # Add tags to the subnet
  tags = {
    # Name tag
    "Name"                                         = "${local.env}-private-${local.zone2}"
    # Tag for Kubernetes internal load balancer role
    "kubernetes.io/role/internal-elb"             = "1"
    # Tag for Kubernetes cluster ownership
    "kubernetes.io/cluster/${local.env}-${local.eks_name}" = "owned"
  }
}

# Define an AWS subnet resource for public zone 1
resource "aws_subnet" "public_zone1" {
  # Associate the subnet with the main VPC
  vpc_id                = aws_vpc.main.id
  # Define the CIDR block for the subnet
  cidr_block            = "10.0.64.0/19"
  # Specify the availability zone for the subnet
  availability_zone = local.zone1
  # Automatically assign public IP addresses to instances launched in this subnet
  map_public_ip_on_launch = true

  # Add tags to the subnet
  tags = {
    # Name tag
    "Name"                                         = "${local.env}-public-${local.zone1}"
    # Tag for Kubernetes external load balancer role
    "kubernetes.io/role/elb"                      = "1"
    # Tag for Kubernetes cluster ownership
    "kubernetes.io/cluster/${local.env}-${local.eks_name}" = "owned"
  }
}

# Define an AWS subnet resource for public zone 2
resource "aws_subnet" "public_zone2" {
  # Associate the subnet with the main VPC
  vpc_id                = aws_vpc.main.id
  # Define the CIDR block for the subnet
  cidr_block            = "10.0.96.0/19"
  # Specify the availability zone for the subnet
  availability_zone = local.zone2
  # Automatically assign public IP addresses to instances launched in this subnet
  map_public_ip_on_launch = true

  # Add tags to the subnet
  tags = {
    # Name tag
    "Name"                                         = "${local.env}-public-${local.zone2}"
    # Tag for Kubernetes external load balancer role
    "kubernetes.io/role/elb"                      = "1"
    # Tag for Kubernetes cluster ownership
    "kubernetes.io/cluster/${local.env}-${local.eks_name}" = "owned"
  }
}