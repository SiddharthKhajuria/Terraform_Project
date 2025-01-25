terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region     = "us-west-2"
  access_key = "AQ________"
  secret_key = "_________"
}

resource "tls_private_key" "sid" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

variable "key_name" {
  default = "siddharth"
}

resource "aws_key_pair" "key_pair" {
  key_name   = var.key_name
  public_key = tls_private_key.sid.public_key_openssh
}

resource "local_file" "private_key" {
  content  = tls_private_key.sid.private_key_pem
  filename = "${var.key_name}_private_key.pem"
}

resource "aws_instance" "public_instance" {
  ami           = "ami-0423fca164888b941"
  instance_type = "t2.micro"
  key_name      = 

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              EOF

  tags = {
    Name = "terraform_instance"
  }
}

output "instance_public_ip" {
  description = "The public IP of the EC2 instance"
  value       = aws_instance.public_instance.public_ip
}
