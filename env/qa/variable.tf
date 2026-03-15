variable "aws_region" {
  description = "AWS region for QA environment"
  type        = string
}

variable "aws_profile" {
  description = "AWS CLI profile for QA environment"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "10.0.0."
  type        = string
}

variable "azs" {
  description = "Availability zones for subnets"
  type        = list(string)
}

variable "private_subnets" {
  description = "Private subnet CIDR blocks"
  type        = list(string)
}

variable "public_subnets" {
  description = "Public subnet CIDR blocks"
  type        = list(string)
}

variable "enable_nat_gateway" {
  description = "Enable NAT gateway"
  type        = bool
}

variable "enable_vpn_gateway" {
  description = "Enable VPN gateway"
  type        = bool
}

variable "tags" {
  description = "Common tags for resources"
  type        = map(string)
}

variable "sg_name" {
  description = "Name of security group"
  type        = string
}

variable "sg_description" {
  description = "Description of security group"
  type        = string
}

variable "ingress_cidr_blocks" {
  description = "Allowed CIDR blocks for ingress"
  type        = list(string)
}

variable "ingress_ports" {
  description = "Inbound TCP ports for EC2 security group"
  type        = list(number)
}

variable "ec2_name" {
  description = "Name of EC2 instance"
  type        = string
}

variable "ec2_public_instance_count" {
  description = "Number of EC2 instances to create in public subnet(s) in QA"
  type        = number
  default     = 2
}

variable "ec2_private_instance_count" {
  description = "Number of EC2 instances to create in private subnet(s) in QA"
  type        = number
  default     = 2
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "key_name" {
  description = "Name of the AWS key pair for EC2 SSH access"
  type        = string
}
