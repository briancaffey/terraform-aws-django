###############################################################################
# VPC
###############################################################################

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${terraform.workspace}-vpc"
  cidr = var.cidr

  azs             = var.azs
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

  # DNS settings
  enable_dns_hostnames = true
  enable_dns_support   = true
}

###############################################################################
# SG
###############################################################################

module "sg" {
  source = "../../internal/sg"
  vpc_id = module.vpc.vpc_id
}

###############################################################################
# Load Balancer
###############################################################################

module "lb" {
  source          = "../../internal/lb"
  vpc_id          = module.vpc.vpc_id
  public_subnets  = module.vpc.public_subnets
  alb_sg_id       = module.sg.alb_sg_id
  certificate_arn = var.certificate_arn
}

###############################################################################
# IAM
###############################################################################

module "iam" {
  source = "../../internal/iam"
}

###############################################################################
# RDS
###############################################################################

module "rds" {
  source          = "../../internal/rds"
  ecs_sg_id       = module.sg.ecs_sg_id
  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
  port            = var.port
  engine          = var.engine
  engine_version  = var.engine_version
  rds_db_name     = var.rds_db_name
  rds_username    = var.rds_username
  rds_password    = var.rds_password
}

###############################################################################
# ElastiCache
###############################################################################

module "elasticache" {
  source          = "../../internal/elasticache"
  vpc_id          = module.vpc.vpc_id
  azs             = module.vpc.azs
  private_subnets = module.vpc.private_subnets
  ecs_sg_id       = module.sg.ecs_sg_id
}

###############################################################################
# Bastion Host
###############################################################################

module "bastion" {
  source         = "../../internal/bastion"
  vpc_id         = module.vpc.vpc_id
  key_name       = var.key_name
  alb_sg_id      = module.sg.alb_sg_id
  ecs_sg_id      = module.sg.ecs_sg_id
  public_subnets = module.vpc.public_subnets
}
