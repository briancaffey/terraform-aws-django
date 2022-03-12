variable "region" {
  description = "The region to use"
  default     = "us-east-1"
  type        = string
}

##############################################################################
# Route 53
##############################################################################

variable "zone_name" {
  description = "Name of the hosted zone. Last character should be a period (e.g. example.com.)"
  type        = string
}

variable "record_name" {
  description = "Name of the record to create (e.g. app.example.com)"
  type        = string
}



variable "ecr_be_repo_url" {
  description = "URL of the ECR repository that contains the backend image. Take from output value of bootstrap"
}

variable "be_image_tag" {
  description = "Image tag to use in backend container definitions"
  default     = "latest"
}

variable "ecr_fe_repo_url" {
  description = "URL of the ECR repository that contains the frontend image. Take from output value of bootstrap"
}

variable "fe_image_tag" {
  description = "Image tag to use in frontend container definitions"
  default     = "latest"
}

##############################################################################
# ACM
##############################################################################

variable "acm_certificate_arn" {
  description = "ACM certificate ARN"
}

variable "instance_type" {
  description = "ECS instance type"
  default     = "t3.small"
}

##############################################################################
# Frontend
##############################################################################

variable "frontend_url" {
  type        = string
  description = "Frontend URL"
}
