resource "aws_iam_instance_profile" "instance-profile" {
  # Define a resource block to create an AWS IAM instance profile

  name = "Jenkins-instance-profile"
  # Specify the name of the IAM instance profile

  role = aws_iam_role.iam-role.name
  # Attach the specified IAM role to the instance profile
}
