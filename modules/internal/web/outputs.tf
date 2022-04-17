output "task_family" {
  value       = "${terraform.workspace}-${var.name}"
  description = "Name of the task family"
}

output "service_name" {
  value       = "${terraform.workspace}-${var.name}"
  description = "Name of the service"
}
