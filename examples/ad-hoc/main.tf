# terraform_remote_state

terraform {
  required_version = ">=1.1.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.4.0"
    }
  }

  backend "s3" {}
}

provider "aws" {
  region = var.region
}

# shared resources
# see https://github.com/briancaffey/terraform-aws-ad-hoc-environments

data "terraform_remote_state" "shared" {
  backend = "s3"
  config = {
    bucket = var.s3_bucket
    key    = var.key
    region = var.region
  }
}

# main

module "main" {
  source = "../../modules/ad-hoc"

  # shared resources -- taken from terraform_remote_state data source above

  vpc_id                         = data.terraform_remote_state.shared.outputs.vpc_id
  private_subnets                = data.terraform_remote_state.shared.outputs.private_subnets
  public_subnets                 = data.terraform_remote_state.shared.outputs.public_subnets
  listener_arn                   = data.terraform_remote_state.shared.outputs.listener_arn
  alb_dns_name                   = data.terraform_remote_state.shared.outputs.alb_dns_name
  service_discovery_namespace_id = data.terraform_remote_state.shared.outputs.service_discovery_namespace_id
  task_role_arn                  = data.terraform_remote_state.shared.outputs.task_role_arn
  execution_role_arn             = data.terraform_remote_state.shared.outputs.execution_role_arn
  rds_address                    = data.terraform_remote_state.shared.outputs.rds_address
  alb_default_tg_arn             = data.terraform_remote_state.shared.outputs.alb_default_tg_arn
  ecs_sg_id                      = data.terraform_remote_state.shared.outputs.ecs_sg_id

  # per environment settings -- taken from .tfvars files

  ecr_be_repo_url = var.ecr_be_repo_url
  ecr_fe_repo_url = var.ecr_fe_repo_url
  region          = var.region
  frontend_url    = var.frontend_url
  zone_name       = var.zone_name
  record_name     = var.record_name
}