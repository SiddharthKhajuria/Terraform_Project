module "web_server_sg" {
  source = "terraform-aws-modules/security-group/aws//modules/http-80"

  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id

  ingress_cidr_blocks = var.ingress_cidr_blocks
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
  description = "Allowed ingress CIDR blocks for HTTP"
  type        = list(string)
}