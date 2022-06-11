output "migrate_command" {
  value = module.migrate.task_execution_command
}

output "collectstatic_command" {
  value = module.collectstatic.task_execution_command
}

output "ecs_exec_command" {
  value = <<EOT
TASK_ARN=$(aws ecs list-tasks \
  --cluster ${terraform.workspace}-cluster \
  --service-name  ${terraform.workspace}-gunicorn | jq -r '.taskArns | .[0]' \
)
aws ecs execute-command --cluster ${terraform.workspace}-cluster \
    --task $TASK_ARN \
    --container gunicorn \
    --interactive \
    --command "/bin/bash"
EOT
}