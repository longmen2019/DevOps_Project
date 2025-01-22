resource "aws_vpc" "vpc" {
  # Define a resource block to create an AWS VPC (Virtual Private Cloud)

  cidr_block = "10.0.0.0/16"
  # Set the CIDR block for the VPC to 10.0.0.0/16, providing a range of IP addresses

  tags = {
    Name = var.vpc-name
    # Tag the VPC with a name, using the value from the variable vpc-name
  }
}

resource "aws_internet_gateway" "igw" {
  # Define a resource block to create an AWS Internet Gateway

  vpc_id = aws_vpc.vpc.id
  # Associate the Internet Gateway with the VPC created earlier

  tags = {
    Name = var.igw-name
    # Tag the Internet Gateway with a name, using the value from the variable igw-name
  }
}

resource "aws_subnet" "public-subnet" {
  # Define a resource block to create an AWS subnet

  vpc_id = aws_vpc.vpc.id
  # Associate the subnet with the VPC created earlier

  cidr_block = "10.0.1.0/24"
  # Set the CIDR block for the subnet to 10.0.1.0/24, providing a range of IP addresses

  availability_zone = "us-east-1a"
  # Specify the availability zone for the subnet (us-east-1a)

  map_public_ip_on_launch = true
  # Enable public IP assignment for instances launched in this subnet

  tags = {
    Name = var.subnet-name
    # Tag the subnet with a name, using the value from the variable subnet-name
  }
}

resource "aws_route_table" "rt" {
  # Define a resource block to create an AWS route table

  vpc_id = aws_vpc.vpc.id
  # Associate the route table with the VPC created earlier

  route {
    cidr_block = "0.0.0.0/0"
    # Specify the destination CIDR block for the route (all IP addresses)

    gateway_id = aws_internet_gateway.igw.id
    # Route traffic to the Internet Gateway
  }

  tags = {
    Name = var.rt-name
    # Tag the route table with a name, using the value from the variable rt-name
  }
}

resource "aws_route_table_association" "rt-association" {
  # Define a resource block to associate the route table with a subnet

  route_table_id = aws_route_table.rt.id
  # Specify the route table to associate with the subnet

  subnet_id = aws_subnet.public-subnet.id
  # Specify the subnet to associate with the route table
}

resource "aws_security_group" "security-group" {
  # Define a resource block to create an AWS security group

  vpc_id = aws_vpc.vpc.id
  # Associate the security group with the VPC created earlier

  description = "Allowing Jenkins, Sonarqube, SSH Access"
  # Set a description for the security group

  ingress = [
    for port in [22, 8080, 9000] : {
      description      = "TLS from VPC"
      from_port        = port
      to_port          = port
      protocol         = "tcp"
      ipv6_cidr_blocks = ["::/0"]
      self             = false
      prefix_list_ids  = []
      security_groups  = []
      cidr_blocks      = ["0.0.0.0/0"]
      # Define inbound rules for the security group, allowing TCP traffic on ports 22, 8080, and 9000 from any IPv6 address
    }
  ]

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    # Define outbound rules for the security group, allowing all traffic to any destination
  }

  tags = {
    Name = var.sg-name
    # Tag the security group with a name, using the value from the variable sg-name
  }
}
