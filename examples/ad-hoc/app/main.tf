terraform {
  required_version = ">=1.3.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.48.0"
    }
  }

  backend "local" {}
}

provider "aws" {
  region = var.region
}

data "terraform_remote_state" "this" {
  backend = "local"

  config = {
    path = "../base/terraform.tfstate"
  }
}

module "main" {
  source = "../../../modules/ad-hoc/app"

  vpc_id                         = data.terraform_remote_state.this.outputs.vpc_id
  assets_bucket_name             = data.terraform_remote_state.this.outputs.assets_bucket_name
  private_subnet_ids             = data.terraform_remote_state.this.outputs.private_subnet_ids
  app_sg_id                      = data.terraform_remote_state.this.outputs.app_sg_id
  alb_sg_id                      = data.terraform_remote_state.this.outputs.alb_sg_id
  listener_arn                   = data.terraform_remote_state.this.outputs.listener_arn
  alb_dns_name                   = data.terraform_remote_state.this.outputs.alb_dns_name
  service_discovery_namespace_id = data.terraform_remote_state.this.outputs.service_discovery_namespace_id
  rds_address                    = data.terraform_remote_state.this.outputs.rds_address
  domain_name                    = data.terraform_remote_state.this.outputs.domain_name
  base_stack_name                = data.terraform_remote_state.this.outputs.base_stack_name
  region                         = var.region
}