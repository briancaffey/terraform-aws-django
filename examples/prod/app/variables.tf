variable "region" {
  type    = string
  default = "us-east-1"
}

variable "ecr_be_repo_url" {
  type = string
}

variable "ecr_fe_repo_url" {
  type = string
}

variable "be_image_tag" {
  type = string
}

variable "frontend_url" {
  type = string
}

variable "domain_name" {
  type = string
}