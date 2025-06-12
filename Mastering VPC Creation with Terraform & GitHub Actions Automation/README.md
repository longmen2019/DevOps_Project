
# Terraform VPC with Application Load Balancer and EC2 Instances

This Terraform project deploys a Virtual Private Cloud (VPC) with the following components:

* **VPC:** A custom VPC with a CIDR block of 10.0.0.0/16.
* **Subnets:** Two public subnets in different availability zones (us-east-1a and us-east-1b) with CIDR blocks 10.0.1.0/24 and 10.0.2.0/24 respectively.  Both subnets have `map_public_ip_on_launch` enabled.
* **Internet Gateway:** An internet gateway for internet connectivity.
* **Route Table:** A route table associating the subnets with the internet gateway.
* **Security Group:** A security group allowing inbound traffic on ports 80 (HTTP) and 22 (SSH) from anywhere (0.0.0.0/0). Outbound traffic is allowed to anywhere on all ports.
* **EC2 Instances:** Two t2.micro EC2 instances, one in each public subnet, running an Amazon Linux 2 AMI.  Both instances have public IPs assigned.
* **Application Load Balancer (ALB):** An internet-facing application load balancer distributing traffic across the two EC2 instances on port 80.
* **Target Group:** A target group for the ALB to register the EC2 instances.
* **Listener:** An HTTP listener on port 80 for the ALB.


## Prerequisites

* **AWS Account:** You'll need an active AWS account.
* **AWS Credentials:** Configure your AWS credentials using one of the supported methods (environment variables, AWS config files, etc.).
* **Terraform Installed:** Ensure you have Terraform installed on your local machine.


## Usage

1. **Clone the repository:**

```bash
git clone https://github.com/your-username/vpc-terraform-github-actions.git
```

2. **Navigate to the project directory:**

```bash
cd vpc-terraform-github-actions/terraform-vpc
```

3. **Initialize Terraform:**

```bash
terraform init
```

4. **Plan the deployment:**

```bash
terraform plan
```

5. **Apply the changes:**

```bash
terraform apply
```

6. **Destroy the infrastructure (optional):**

```bash
terraform destroy
```


## Variables

This project uses the following variables (which can be customized in a `terraform.tfvars` file):


None explicitly defined in the plan output, indicating default values are being used. Consider adding variables for instance type, AMI ID, desired capacity, and other customizable parameters.  This would allow for greater flexibility and reusability.


## Outputs

This project doesn't explicitly define outputs. Consider adding outputs for the ALB DNS name, instance IDs, and other relevant information.  This will make it easier to access the deployed resources after applying the Terraform configuration.  For example:

```terraform
output "alb_dns_name" {
  value = aws_lb.alb.dns_name
}

output "instance_ids" {
  value = aws_instance.web[*].id
}
```



## GitHub Actions (Optional)

This project can be integrated with GitHub Actions for automated deployments.  You would need to create a workflow file (e.g., `.github/workflows/main.yml`) to define the deployment steps.  This typically includes checking out the code, initializing Terraform, running `terraform plan` and `terraform apply`.


## Note

This README assumes you are deploying to the `us-east-1` region.  If you want to deploy to a different region, you'll need to configure the `provider` block in your Terraform configuration.
