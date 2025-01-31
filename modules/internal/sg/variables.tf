variable "vpc_id" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "region" {
  type = string
  default = "us-east-1"
}