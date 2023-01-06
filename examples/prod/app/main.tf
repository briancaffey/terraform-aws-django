terraform {
  required_version = ">=1.3.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.48.0"
    }
  }
}

provider "aws" {
  region = var.region
}

data "terraform_remote_state" "shared" {
  backend = "local"
  config = {
    path = "${path.module}/../base/terraform.tfstate"
  }
}

module "main" {
  source = "../../../modules/prod/app"

  # remote state from local module
  vpc_id             = data.terraform_remote_state.shared.outputs.vpc_id
  assets_bucket_name = data.terraform_remote_state.shared.outputs.assets_bucket_name
  domain_name        = data.terraform_remote_state.shared.outputs.domain_name
  rds_address        = data.terraform_remote_state.shared.outputs.rds_address
  redis_service_host = data.terraform_remote_state.shared.outputs.redis_service_host
  task_role_arn      = data.terraform_remote_state.shared.outputs.task_role_arn
  execution_role_arn = data.terraform_remote_state.shared.outputs.execution_role_arn
  listener_arn       = data.terraform_remote_state.shared.outputs.listener_arn
  alb_dns_name       = data.terraform_remote_state.shared.outputs.alb_dns_name
  app_sg_id          = data.terraform_remote_state.shared.outputs.app_sg_id
  private_subnet_ids = data.terraform_remote_state.shared.outputs.private_subnet_ids
}
