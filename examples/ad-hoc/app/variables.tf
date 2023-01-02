variable "region" {
  default = "us-east-1"
}


##############################################################################
# Frontend
##############################################################################

variable "extra_env_vars" {
  description = "User-defined environment variables to pass to the backend service and task containers (api, worker, migrate, etc.)"
  type        = list(object({ name = string, value = string }))
  default     = []
}