variable "region" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "private_subnets" {
  type = list(string)
}

variable "port" {
  type    = number
  default = 6379
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

variable "image" {
  type        = string
  description = "Container image from ECS to run"
}

variable "log_group_name" {
  type        = string
  description = "Name of the CloudWatch Logs group"
}

variable "log_stream_prefix" {
  type        = string
  description = "Name of the CloudWatch Logs stream"
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