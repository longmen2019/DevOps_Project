resource "aws_instance" "ec2" {
  # Define a resource block to create an AWS EC2 instance

  ami = data.aws_ami.ami.image_id
  # Specify the Amazon Machine Image (AMI) ID for the instance, retrieved from data source

  instance_type = "t2.2xlarge"
  # Define the type of instance to be created (t2.2xlarge)

  key_name = var.key-name
  # Use the SSH key pair name specified in the variable

  subnet_id = aws_subnet.public-subnet.id
  # Attach the instance to the specified subnet

  vpc_security_group_ids = [aws_security_group.security-group.id]
  # Associate the instance with the specified security group(s)

  iam_instance_profile = aws_iam_instance_profile.instance-profile.name
  # Attach the specified IAM instance profile to the instance

  root_block_device {
    volume_size = 30
    # Configure the root block device with a volume size of 30 GB
  }

  user_data = templatefile("./tools-install.sh", {})
  # Provide user data script to configure the instance at launch using a template file

  tags = {
    Name = var.instance-name
    # Assign tags to the instance, using a variable for the instance name
  }
}
