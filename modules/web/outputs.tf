output "task_family" {
  value = "${var.env}-${var.name}"
  description = "Name of the task family"
}

output "service_name" {
    value = "${var.env}-${var.name}"
    description = "Name of the service"
}