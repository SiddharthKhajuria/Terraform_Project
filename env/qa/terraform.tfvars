aws_region  = "ap-south-1"
aws_profile = "default"

vpc_name = "qa-vpc"
vpc_cidr = "10.0.0.0/16"

azs             = ["ap-south-1a", "ap-south-1b"]
public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets = ["10.0.11.0/24", "10.0.12.0/24"]

enable_nat_gateway = true
enable_vpn_gateway = false

sg_name             = "qa-web-sg"
sg_description      = "Security group for QA web server"
ingress_cidr_blocks = ["0.0.0.0/0"]

ec2_name      = "qa-web-ec2"
instance_type = "t3.micro"

tags = {
	Environment = "qa"
	Project     = "terraform-project"
	ManagedBy   = "terraform"
}
