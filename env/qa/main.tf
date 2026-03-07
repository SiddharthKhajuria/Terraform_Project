module "vpc" {
  source = "../../modules/vpc"

  name               = var.vpc_name
  cidr               = var.vpc_cidr
  azs                = var.azs
  private_subnets    = var.private_subnets
  public_subnets     = var.public_subnets
  enable_nat_gateway = var.enable_nat_gateway
  enable_vpn_gateway = var.enable_vpn_gateway
  tags               = var.tags
}

module "sg" {
  source = "../../modules/sg"

  name                = var.sg_name
  description         = var.sg_description
  vpc_id              = module.vpc.vpc_id
  ingress_cidr_blocks = var.ingress_cidr_blocks
}

module "ec2" {
  source = "../../modules/ec2"

  name          = var.ec2_name
  instance_type = var.instance_type
  subnet_id     = module.vpc.public_subnets[0]
  tags          = var.tags
}
