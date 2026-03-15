resource "aws_security_group" "web_server_sg" {
  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.ingress_ports
    content {
      description = "Allow TCP ${ingress.value}"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = var.ingress_cidr_blocks
    }
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

variable "name" {
  description = "Name of the security group"
  type        = string
}

variable "description" {
  description = "Description for the security group"
  type        = string
  default     = "Security group for web-server with HTTP ports open within VPC"
}

variable "vpc_id" {
  description = "VPC ID where security group will be created"
  type        = string
}

variable "ingress_cidr_blocks" {
  description = "Allowed ingress CIDR blocks"
  type        = list(string)
}

variable "ingress_ports" {
  description = "TCP ports to allow for ingress"
  type        = list(number)
  default     = [22, 80, 8080]
}