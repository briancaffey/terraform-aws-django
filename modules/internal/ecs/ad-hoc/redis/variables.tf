variable "region" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "port" {
  type    = number
  default = 6379
}

variable "cpu" {
  default     = 256
  description = "CPU to allocate to container"
  type        = number
}

variable "memory" {
  default     = 512
  description = "Amount (in MiB) of memory used by the task"
  type        = number
}

variable "image" {
  type        = string
  description = "Container image from ECS to run"
}

variable "log_retention_in_days" {
  default = 1
  type    = number
}

variable "name" {
  type        = string
  description = "Name to use for container"
}

variable "command" {
  type        = list(string)
  default     = null
  description = "command used to start the container"
}

variable "ecs_cluster_id" {
  description = "ECS Cluster ID"
  type        = string
}

variable "service_discovery_namespace_id" {
  type        = string
  description = "Service discovery namespace ID"
}

variable "execution_role_arn" {
  type        = string
  description = "Execution role ARN"
}

variable "task_role_arn" {
  description = "Task Role ARN"
  type        = string
}

variable "app_sg_id" {
  description = "App Security Group ID"
  type        = string
}
