module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  count   = var.instance_count

  name = "${var.name}-${count.index + 1}"

  instance_type               = var.instance_type
  monitoring                  = true
  subnet_id                   = var.subnet_id
  key_name                    = var.key_name
  vpc_security_group_ids      = var.vpc_security_group_ids
  associate_public_ip_address = var.associate_public_ip_address

  tags = var.tags
}

variable "name" {
  description = "Name of the EC2 instance"
  type        = string
}

variable "instance_count" {
  description = "Number of EC2 instances"
  type        = number
  default     = 1
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "subnet_id" {
  description = "Subnet ID where EC2 instance will be launched"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "List of security group IDs to attach to EC2 instance"
  type        = list(string)
  default     = []
}

variable "associate_public_ip_address" {
  description = "Whether to associate a public IP address with the instance"
  type        = bool
  default     = false
}

variable "key_name" {
  description = "Name of the AWS key pair to attach to EC2 instance"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags to apply to EC2 instance"
  type        = map(string)
  default     = {}
}