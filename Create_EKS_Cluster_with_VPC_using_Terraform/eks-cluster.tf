# Define a Terraform module for creating an EKS (Elastic Kubernetes Service) cluster
module "eks" {
  # Specify the source of the EKS module, which is a pre-built Terraform module from the AWS Terraform registry
  source          = "terraform-aws-modules/eks/aws"
  
  # Specify the version of the EKS module to use, which ensures consistency and reproducibility
  version         = "20.8.4"
  
  # Set the name of the EKS cluster, which is retrieved from a local variable
  cluster_name    = local.cluster_name
  
  # Set the version of Kubernetes to use for the EKS cluster, which is retrieved from a variable
  cluster_version = var.kubernetes_version
  
  # Specify the IDs of the subnets to use for the EKS cluster, which are retrieved from a VPC module
  subnet_ids      = module.vpc.private_subnets

  # Enable IAM roles for service accounts (IRSA) on the EKS cluster, which allows for more fine-grained access control
  enable_irsa = true

  # Define a set of tags to apply to the EKS cluster, which can be used for organization and filtering
  tags = {
    # Set the value of the "cluster" tag to "demo", which can be used to identify the cluster
    cluster = "demo"
  }

  # Specify the ID of the VPC to use for the EKS cluster, which is retrieved from a VPC module
  vpc_id = module.vpc.vpc_id

  # Define default settings for EKS-managed node groups, which can be overridden by specific node groups
  eks_managed_node_group_defaults = {
    # Set the type of Amazon Machine Image (AMI) to use for the node group, which determines the operating system and configuration
    ami_type               = "AL2_x86_64"
    
    # Specify the types of instances to use for the node group, which determines the compute resources and cost
    instance_types         = ["t3.medium"]
    
    # Specify the IDs of the security groups to use for the node group, which determines the network access and security
    vpc_security_group_ids = [aws_security_group.all_worker_mgmt.id]
  }

  # Define a set of EKS-managed node groups, which can be used to manage the lifecycle of worker nodes
  eks_managed_node_groups = {
    # Define a node group with the name "node_group", which can be used to manage a set of worker nodes
    node_group = {
      # Set the minimum number of nodes to maintain in the node group, which ensures that the cluster has a minimum level of resources
      min_size     = 2
      
      # Set the maximum number of nodes to allow in the node group, which ensures that the cluster does not exceed a maximum level of resources
      max_size     = 6
      
      # Set the desired number of nodes to maintain in the node group, which determines the initial size of the cluster
      desired_size = 2
    }
  }
}
