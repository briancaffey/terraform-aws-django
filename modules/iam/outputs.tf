output "service_iam_role_arn" {
  value = aws_iam_role.ecs_service.arn
}

output "task_role_arn" {
  value = aws_iam_role.ecs_task.arn
}

output "instance_profile_name" {
  value = aws_iam_instance_profile.this.name
}
