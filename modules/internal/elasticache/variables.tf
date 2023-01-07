variable "vpc_id" {
  description = "value of the VPC ID"
  type        = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "app_sg_id" {
  type = string
}
