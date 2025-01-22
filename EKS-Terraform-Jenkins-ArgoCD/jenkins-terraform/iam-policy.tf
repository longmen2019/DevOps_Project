resource "aws_iam_role_policy_attachment" "iam-policy" {
  # Define a resource block to attach an IAM policy to an IAM role

  role = aws_iam_role.iam-role.name
  # Specify the IAM role to which the policy will be attached

  # Just for testing purpose, don't try to give administrator access

  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  # ARN of the IAM policy to attach (AdministratorAccess policy)
}
