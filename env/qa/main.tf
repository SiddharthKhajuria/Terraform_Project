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
  ingress_ports       = var.ingress_ports
}

module "ec2_public" {
  source = "../../modules/ec2"

  name                        = "${var.ec2_name}-public"
  instance_count              = var.ec2_public_instance_count
  instance_type               = var.instance_type
  subnet_id                   = module.vpc.public_subnets[0]
  vpc_security_group_ids      = [module.sg.security_group_id]
  associate_public_ip_address = true
  key_name                    = var.key_name
  tags                        = var.tags
}

module "ec2_private" {
  source = "../../modules/ec2"

  name          = "${var.ec2_name}-private"
  instance_count = var.ec2_private_instance_count
  instance_type = var.instance_type
  subnet_id     = module.vpc.private_subnets[0]
  vpc_security_group_ids = [module.sg.security_group_id]
  key_name                    = var.key_name
  tags                        = var.tags
}
