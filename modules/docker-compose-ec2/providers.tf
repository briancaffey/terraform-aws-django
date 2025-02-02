terraform {
  required_version = ">=1.10.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.84.0"
    }
  }

  backend "local" {}
}

provider "aws" {
  region = var.region
}