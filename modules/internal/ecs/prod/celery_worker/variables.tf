variable "app_count" {
  description = "Number of Docker containers to run"
  default     = 1
}

variable "ecs_cluster_id" {
  description = "ECS Cluster ID"
  type        = string
}

variable "task_role_arn" {
  description = "Task Role ARN"
  type        = string
}

variable "name" {
  description = "Name"
  type        = string
}

variable "command" {
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

variable "app_sg_id" {
  description = "ECS Security Group ID"
  type        = string
}

variable "execution_role_arn" {
  description = "Execution Role ARN"
  type        = string
}

variable "private_subnet_ids" {
  type = list(string)
}