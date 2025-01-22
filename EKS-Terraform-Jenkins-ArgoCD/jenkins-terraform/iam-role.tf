resource "aws_iam_role" "iam-role" {
  # Define a resource block to create an AWS IAM role

  name = var.iam-role
  # Specify the name of the IAM role, retrieved from a variable

  assume_role_policy = <<EOF
  # Define the assume role policy for the IAM role, using a heredoc for the policy document

{
  "Version": "2012-10-17",
  # Specify the version of the policy language (date-based version)

  "Statement": [
    # Define the policy statement(s)

    {
      "Effect": "Allow",
      # Specify that the effect of this statement is to allow the action

      "Principal": {
        "Service": "ec2.amazonaws.com"
        # Allow the EC2 service to assume this role
      },

      "Action": "sts:AssumeRole"
      # Specify the action that is allowed, in this case, sts:AssumeRole
    }
  ]
}
EOF
  # End the assume role policy definition
}
