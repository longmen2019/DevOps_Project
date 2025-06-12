resource "aws_instance" "Jenkin-sonar" {
  ami             = "ami-084568db4383264d4"
  instance_type   = "t2.large"
  key_name        = "devsecops-project"
  security_groups = [aws_security_group.allow_all.name]

  root_block_device {
    volume_size = 30
  }

  tags = {
    Name = "Jenkin-sonar"
  }

  # Upload setup.sh to the EC2 instance
  provisioner "file" {
    source      = "setup.sh"
    destination = "/home/ubuntu/setup.sh"
  }

  # Run setup.sh after the instance is ready
  provisioner "remote-exec" {
    
    inline = [
      "chmod +x /home/ubuntu/setup.sh",
      "sudo /home/ubuntu/setup.sh"
    ]
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/devsecops-project.pem")
    host        = self.public_ip
  }
}