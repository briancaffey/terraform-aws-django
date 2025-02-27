###############################################################################
# VPC
###############################################################################

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${terraform.workspace}-vpc"
  cidr = var.cidr

  azs             = var.azs
  private_subnets = var.private_subnet_ids
  public_subnets  = var.public_subnets

  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

  # DNS settings
  enable_dns_hostnames = true
  enable_dns_support   = true
}

###############################################################################
# ElastiCache
###############################################################################

module "elasticache" {
  source             = "../../internal/elasticache"
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnets
  app_sg_id          = module.sg.app_sg_id
}

###############################################################################
# S3 - TODO add S3 bucket resource for app assets
###############################################################################

module "s3" {
  source        = "../../internal/s3"
  bucket_name   = "${replace(var.domain_name, ".", "-")}-${terraform.workspace}-assets-bucket"
  force_destroy = var.force_destroy
}

###############################################################################
# Security groups
###############################################################################

module "sg" {
  source             = "../../internal/sg"
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnets
  route_table_ids    = module.vpc.private_route_table_ids
}

###############################################################################
# Load Balancer
###############################################################################

module "lb" {
  source          = "../../internal/alb"
  vpc_id          = module.vpc.vpc_id
  public_subnets  = module.vpc.public_subnets
  alb_sg_id       = module.sg.alb_sg_id
  certificate_arn = var.certificate_arn
}

###############################################################################
# RDS
###############################################################################

module "rds" {
  source             = "../../internal/rds"
  app_sg_id          = module.sg.app_sg_id
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnets
  port               = var.port
  engine             = var.engine
  engine_version     = var.engine_version
  rds_db_name        = var.rds_db_name
  rds_username       = var.rds_username
  rds_password       = var.rds_password
}

###############################################################################
# RDS
###############################################################################

module "ses" {
  source      = "../../internal/ses"
  domain_name = var.domain_name
}
