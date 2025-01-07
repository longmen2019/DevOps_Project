# Define an output variable to expose the EKS cluster ID, which can be used by other Terraform configurations or external tools
output "cluster_id" {
  # Provide a brief description of the output variable, which helps users understand its purpose and usage
  # In this case, the description indicates that this output variable will return the ID of the EKS cluster
  description = "EKS cluster ID."
  
  # Set the value of the output variable to the cluster ID returned by the EKS module, which provides a unique identifier for the cluster
  # The module.eks.cluster_id syntax refers to the cluster_id attribute of the EKS module, which is a pre-built Terraform module for creating EKS clusters
  value       = module.eks.cluster_id
}

# Define an output variable to expose the endpoint of the EKS control plane, which can be used to access the cluster's API server
output "cluster_endpoint" {
  # Provide a brief description of the output variable, which helps users understand its purpose and usage
  # In this case, the description indicates that this output variable will return the endpoint URL of the EKS control plane
  description = "Endpoint for EKS control plane."
  
  # Set the value of the output variable to the cluster endpoint returned by the EKS module, which provides the URL of the cluster's API server
  # The module.eks.cluster_endpoint syntax refers to the cluster_endpoint attribute of the EKS module, which returns the endpoint URL of the EKS control plane
  value       = module.eks.cluster_endpoint
}

# Define an output variable to expose the security group ID attached to the cluster control plane, which can be used to manage network access to the cluster
output "cluster_security_group_id" {
  # Provide a brief description of the output variable, which helps users understand its purpose and usage
  # In this case, the description indicates that this output variable will return the ID of the security group attached to the cluster control plane
  description = "Security group ids attached to the cluster control plane."
  
  # Set the value of the output variable to the security group ID returned by the EKS module, which provides the ID of the security group attached to the cluster control plane
  # The module.eks.cluster_security_group_id syntax refers to the cluster_security_group_id attribute of the EKS module, which returns the ID of the security group attached to the cluster control plane
  value       = module.eks.cluster_security_group_id
}

# Define an output variable to expose the AWS region where the EKS cluster is deployed, which can be used to manage regional resources and services
output "region" {
  # Provide a brief description of the output variable, which helps users understand its purpose and usage
  # In this case, the description indicates that this output variable will return the AWS region where the EKS cluster is deployed
  description = "AWS region"
  
  # Set the value of the output variable to the AWS region variable, which provides the region where the EKS cluster is deployed
  # The var.aws_region syntax refers to a variable named aws_region, which is expected to be defined elsewhere in the Terraform configuration
  value       = var.aws_region
}

# Define an output variable to expose the ARN of the OIDC provider, which can be used to manage identity and access to the cluster
output "oidc_provider_arn" {
  # Set the value of the output variable to the OIDC provider ARN returned by the EKS module, which provides the ARN of the OIDC provider
  # The module.eks.oidc_provider_arn syntax refers to the oidc_provider_arn attribute of the EKS module, which returns the ARN of the OIDC provider
  value = module.eks.oidc_provider_arn
}

# Define a commented-out output variable to generate a command to update the kubeconfig file with the EKS cluster details
#output "zz_update_kubeconfig_command" {
  # Set the value of the output variable to a string that concatenates the command and cluster ID using the "+" operator
  # This command can be used to update the kubeconfig file with the EKS cluster details, including the cluster ID and endpoint
  # value = "aws eks update-kubeconfig --name " + module.eks.cluster_id
  
  # Alternatively, set the value of the output variable to a formatted string that generates the command to update the kubeconfig file
  # This command includes the cluster ID, region, and other details, and can be used to update the kubeconfig file with the EKS cluster details
  # value = format("%s %s %s %s", "aws eks update-kubeconfig --name", module.eks.cluster_id, "--region", var.aws_region)
#}
