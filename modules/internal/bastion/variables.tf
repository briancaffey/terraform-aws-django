variable "vpc_id" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "app_sg_id" {
  type = string
}

variable "rds_address" {
  type = string
}
