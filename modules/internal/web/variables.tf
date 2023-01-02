variable "app_count" {
  description = "Number of Docker containers to run"
  default     = 1
}

variable "ecs_cluster_id" {
  description = "ECS Cluster ID"
  type        = string
}

variable "execution_role_arn" {
  description = "Execution Role ARN"
  type        = string
}

variable "task_role_arn" {
  description = "Task Role ARN"
  type        = string
}

variable "command" {
  default     = null
  type        = list(string)
  description = "Command to run in Docker container"
}

variable "env_vars" {
  type        = list(object({ name = string, value = string }))
  description = "Environment variables to set in Docker container"
}

variable "image" {
  type        = string
  description = "Container image from ECS to run"
}

variable "log_retention_in_days" {
  default = 1
  type    = number
}

variable "region" {
  default     = "us-east-1"
  description = "AWS region"
  type        = string
}

variable "cpu" {
  default     = 1024
  description = "CPU to allocate to container"
  type        = number
}

variable "memory" {
  default     = 2048
  description = "Amount (in MiB) of memory used by the task"
  type        = number
}

variable "name" {
  description = "Name to use for the service and task"
  type        = string
}

variable "port" {
  default     = 80
  description = "Port to expose on the container"
  type        = number
}

variable "path_patterns" {
  description = "Path patterns to match"
  type        = list(string)
}

variable "listener_arn" {
  description = "Listener ARN"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "health_check_path" {
  description = "Path to check for health"
  default     = "/"
  type        = string
}

variable "health_check_healthy_threshold" {
  description = "Number of consecutive health checks successes required"
  default     = 2
  type        = number
}


variable "health_check_interval" {
  description = "Time between health checks"
  default     = 7
  type        = number
}

variable "app_sg_id" {
  description = "ECS Security Group ID"
  type        = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "host_name" {
  description = "Hostname to use for setting up listener rules for the service"
  type        = string
}