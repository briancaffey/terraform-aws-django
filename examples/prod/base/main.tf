terraform {
  required_version = ">=1.10.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.84.0"
    }
  }
}

provider "aws" {
  region = var.region
}

module "main" {
  source          = "../../../modules/prod/base"
  certificate_arn = var.certificate_arn
  domain_name     = var.domain_name
}