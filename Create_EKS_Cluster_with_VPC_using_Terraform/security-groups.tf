# Outputs the EKS (Elastic Kubernetes Service) cluster ID.
output "cluster_id" {
  # Description of the output variable.
  description = "EKS cluster ID."
  # The value for the output, which retrieves the cluster_id from the EKS module.
  value       = module.eks.cluster_id
}

# Outputs the endpoint for the EKS control plane.
output "cluster_endpoint" {
  # Description of the output variable.
  description = "Endpoint for EKS control plane."
  # The value for the output, which retrieves the cluster_endpoint from the EKS module.
  value       = module.eks.cluster_endpoint
}

# Outputs the security group IDs attached to the EKS cluster control plane.
output "cluster_security_group_id" {
  # Description of the output variable.
  description = "Security group ids attached to the cluster control plane."
  # The value for the output, which retrieves the security group IDs from the EKS module.
  value       = module.eks.cluster_security_group_id
}

# Outputs the AWS region in which the EKS cluster is deployed.
output "region" {
  # Description of the output variable.
  description = "AWS region"
  # The value for the output, which is set to the AWS region variable.
  value       = var.aws_region
}

# Outputs the ARN (Amazon Resource Name) of the OIDC (OpenID Connect) provider associated with the EKS cluster.
output "oidc_provider_arn" {
  # The value for the output, which retrieves the OIDC provider ARN from the EKS module.
  value = module.eks.oidc_provider_arn
}

# Uncomment the following lines if you want to output the command to update the kubeconfig file for the EKS cluster.
# output "zz_update_kubeconfig_command" {
#   # The value for the output, which formats a command to update the kubeconfig file for the EKS cluster.
#   # The format function is used to concatenate the command string and variables.
#   value = format("%s %s %s %s", "aws eks update-kubeconfig --name", module.eks.cluster_id, "--region", var.aws_region)
# }
