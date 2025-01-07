# Define the Kubernetes version variable.
variable "kubernetes_version" {
  # Set the default value for this variable to 1.27.
  default     = 1.27
  # Provide a description for this variable.
  description = "kubernetes version"
}

# Define the VPC CIDR range variable.
variable "vpc_cidr" {
  # Set the default value for this variable to "10.0.0.0/16".
  default     = "10.0.0.0/16"
  # Provide a description for this variable.
  description = "default CIDR range of the VPC"
}

# Define the AWS region variable.
variable "aws_region" {
  # Set the default value for this variable to "us-west-1".
  default = "us-west-1"
  # Provide a description for this variable.
  description = "aws region"
}
