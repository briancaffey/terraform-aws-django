terraform {
  required_version = ">=1.1.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.4.0"
    }
  }
}

provider "aws" {
  region = var.region
}

module "main" {
  source          = "../../../modules/prod/base"
  certificate_arn = var.certificate_arn
  key_name        = var.key_name
}