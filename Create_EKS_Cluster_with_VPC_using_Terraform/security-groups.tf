# Create a security group resource named "all_worker_mgmt" for worker node management
resource "aws_security_group" "all_worker_mgmt" {
  # Prefix for the name of the security group
  name_prefix = "all_worker_management"
  
  # ID of the VPC where the security group will be created, taken from the VPC module
  vpc_id      = module.vpc.vpc_id
}

# Define an ingress (inbound) rule for the "all_worker_mgmt" security group
resource "aws_security_group_rule" "all_worker_mgmt_ingress" {
  # Description of the security group rule
  description       = "allow inbound traffic from eks"
  
  # Starting port for the ingress rule (0 means all ports)
  from_port         = 0
  
  # Protocol type (all protocols)
  protocol          = "-1"
  
  # Ending port for the ingress rule (0 means all ports)
  to_port           = 0
  
  # ID of the security group to which this rule will be applied
  security_group_id = aws_security_group.all_worker_mgmt.id
  
  # Type of rule (inbound)
  type              = "ingress"
  
  # List of CIDR blocks that are allowed to access the security group
  cidr_blocks = [
    "10.0.0.0/8",
    "172.16.0.0/12",
    "192.168.0.0/16",
  ]
}

# Define an egress (outbound) rule for the "all_worker_mgmt" security group
resource "aws_security_group_rule" "all_worker_mgmt_egress" {
  # Description of the security group rule
  description       = "allow outbound traffic to anywhere"
  
  # Starting port for the egress rule (0 means all ports)
  from_port         = 0
  
  # Protocol type (all protocols)
  protocol          = "-1"
  
  # ID of the security group to which this rule will be applied
  security_group_id = aws_security_group.all_worker_mgmt.id
  
  # Ending port for the egress rule (0 means all ports)
  to_port           = 0
  
  # Type of rule (outbound)
  type              = "egress"
  
  # List of CIDR blocks that are allowed to be accessed by the security group (anywhere)
  cidr_blocks       = ["0.0.0.0/0"]
}
