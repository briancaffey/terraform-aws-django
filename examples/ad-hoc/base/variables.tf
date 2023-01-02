variable "region" {
  type    = string
  default = "us-east-1"
}

variable "certificate_arn" {
  type = string
}

variable "domain_name" {
  description = "Route53 domain name (e.g. example.com)"
  type        = string
}
