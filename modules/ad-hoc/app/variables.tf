variable "vpc_id" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "app_sg_id" {
  type        = string
  description = "App Security Group ID"
}

variable "alb_sg_id" {
  type        = string
  description = "ALB Security Group ID"
}

# Load balancer

variable "listener_arn" {
  type = string
}

variable "alb_dns_name" {
  type        = string
  description = "DNS name of the shared ALB"
}

# Service Discovery

variable "service_discovery_namespace_id" {
  type = string
}

# RDS

variable "rds_address" {
  type = string
}


##############################################################################
# AWS
##############################################################################

variable "region" {
  default = "us-east-1"
}


################################################
# Per-environment variables
#
# These variables can be accept custom values
# per ad hoc environment
#################################################

# Application

##############################################################################
# Route 53
##############################################################################

variable "domain_name" {
  description = "Domain name to be used for Route 53 records (e.g. example.com)"
  type        = string
}

##############################################################################
# Application Services - Gunicorn, Celery, Beat, frontend SPA, etc.
##############################################################################

# Shared

variable "extra_env_vars" {
  description = "User-defined environment variables to pass to the backend service and task containers (api, worker, migrate, etc.)"
  type        = list(object({ name = string, value = string }))
  default     = []
}

variable "s3_bucket_name" {
  default     = "s3-bucket-dev"
  description = "S3 bucket name for backend assets (media and static assets)"
}

variable "django_settings_module" {
  description = "Django settings module"
  default     = "backend.settings.production"
}

# frontend

variable "frontend_command" {
  description = "Command to run in the frontend container"
  default     = ["nginx", "-g", "daemon off;"]
  type        = list(string)
}

variable "frontend_cpu" {
  default     = 1024
  description = "CPU to allocate to container for the frontend task"
  type        = number
}

variable "frontend_memory" {
  default     = 2048
  description = "Amount (in MiB) of memory used by the frontend task"
  type        = number
}

# Celery beat

variable "celery_beat_command" {
  default     = ["celery", "--app=backend.celery_app:app", "beat", "--loglevel=INFO"]
  description = "Command used to start celery beat"
  type        = list(string)
}

variable "celery_beat_cpu" {
  default     = 1024
  description = "CPU to allocate to container"
  type        = number
}

variable "celery_beat_memory" {
  default     = 2048
  description = "Amount (in MiB) of memory used by the task"
  type        = number
}

# default celery worker

variable "default_celery_worker_command" {
  description = "Command used to start celery worker"
  default     = ["celery", "--app=backend.celery_app:app", "worker", "--loglevel=INFO", "-Q", "default"]
  type        = list(string)
}

variable "default_celery_worker_cpu" {
  default     = 1024
  description = "CPU to allocate to container"
  type        = number
}

variable "default_celery_worker_memory" {
  default     = 2048
  description = "Amount (in MiB) of memory used by the task"
  type        = number
}

# api

variable "api_command" {
  description = "Command used to start backend API container"
  default     = ["gunicorn", "-t", "1000", "-b", "0.0.0.0:8000", "--log-level", "info", "backend.wsgi"]
  type        = list(string)
}

variable "api_cpu" {
  default     = 1024
  description = "CPU to allocate to container"
  type        = number
}

variable "api_memory" {
  default     = 2048
  description = "Amount (in MiB) of memory used by the task"
  type        = number
}

# backend_update commands (migrate, collectstatic)

variable "backend_update_command" {
  description = "Command used to run database migrations and collectstatic"
  default     = ["python", "manage.py", "pre_update"]
  type        = list(string)
}

variable "backend_update_cpu" {
  default     = 1024
  description = "CPU to allocate to container"
  type        = number
}

variable "backend_update_memory" {
  default     = 2048
  description = "Amount (in MiB) of memory used by the task"
  type        = number
}

variable "assets_bucket_name" {
  description = "S3 bucket name for assets"
  type        = string
}

variable "base_stack_name" {
  description = "Name of the base stack that the ad hoc env is created in."
  type        = string
}
