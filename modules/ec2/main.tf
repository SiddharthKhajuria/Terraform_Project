module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  count   = var.instance_count

  name = "${var.name}-${count.index + 1}"

  instance_type = var.instance_type
  monitoring    = true
  subnet_id     = var.subnet_id

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

variable "tags" {
  description = "Tags to apply to EC2 instance"
  type        = map(string)
  default     = {}
}