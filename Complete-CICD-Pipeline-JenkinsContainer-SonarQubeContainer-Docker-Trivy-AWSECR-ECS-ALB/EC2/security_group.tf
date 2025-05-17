resource "aws_security_group" "allow_all" {
  name        = "allow_all_traffic"
  description = "Security group that allows all inbound and outbound traffic"

  # Allow all incoming traffic (⚠️ Security Risk: Opens access to everyone)
  ingress {
    from_port   = 0  # Starting port (0 means all ports)
    to_port     = 0  # Ending port (0 means all ports)
    protocol    = "-1"  # Allows all protocols (TCP, UDP, ICMP, etc.)
    cidr_blocks = ["0.0.0.0/0"]  # Grants access to entire internet (⚠️ Consider restricting this)
  }

  # Allow all outgoing traffic (⚠️ Opens full access to any destination)
  egress {
    from_port   = 0  # Starting port (0 means all ports)
    to_port     = 0  # Ending port (0 means all ports)
    protocol    = "-1"  # Allows all protocols (TCP, UDP, ICMP, etc.)
    cidr_blocks = ["0.0.0.0/0"]  # Grants access to entire internet (⚠️ Consider restricting this)
  }
}