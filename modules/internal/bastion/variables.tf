variable "vpc_id" {
  type = string
}

variable "public_subnets" {
  type = list(string)
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "key_name" {
  type = string
}

variable "alb_sg_id" {
  type = string
}

variable "ecs_sg_id" {
  type = string
}
