data "aws_ami" "ami" {
  # Define a data block to fetch information about an AWS AMI (Amazon Machine Image)

  most_recent = true
  # Ensure that the most recent AMI matching the filter criteria is used

  filter {
    name = "name"
    # Specify the filter for the AMI name

    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
    # Provide the filter value to match Ubuntu AMIs with this naming pattern
  }

  owners = ["099720109477"]
  # Restrict the search to AMIs owned by a specific AWS account (Canonical's account ID for official Ubuntu images)
}
