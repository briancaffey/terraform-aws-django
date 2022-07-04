##############################################################################
# VPC
##############################################################################

variable "cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "azs" {
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
  description = "AZs to use for VPC"
  type        = list(string)
}

variable "private_subnets" {
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  description = "Private subnets to use for VPC"
  type        = list(string)
}

variable "public_subnets" {
  default     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  description = "Public subnets to use for VPC"
  type        = list(string)
}

variable "certificate_arn" {
  description = "ARN of the certificate to use for the ALB"
  type        = string
}

##############################################################################
# Bastion host
##############################################################################

variable "key_name" {
  type = string
}

##############################################################################
# RDS (Optional Variables for RDS configuration - defaults to Postgres 13.4)
##############################################################################

variable "port" {
  type    = string
  default = "5432"
}

variable "engine" {
  type    = string
  default = "postgres"
}

variable "engine_version" {
  type    = string
  default = "13.4"
}

variable "rds_db_name" {
  type    = string
  default = "postgres"
}

variable "rds_username" {
  type    = string
  default = "postgres"
}

variable "rds_password" {
  type    = string
  default = "postgres"
}
