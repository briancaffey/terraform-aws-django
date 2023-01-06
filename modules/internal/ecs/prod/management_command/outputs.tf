output "task_arn" {
  value = aws_ecs_task_definition.this.arn
}

output "task_execution_command" {
  description = "The script to use for executing this ECS task in an automation pipelne. Executes command and then reads results from CloudWatch logs."
  value       = <<EOT
START_TIME=$(date +%s000)

TASK_ID=$(aws ecs run-task --cluster ${var.ecs_cluster_id} --task-definition ${aws_ecs_task_definition.this.arn} --network-configuration "awsvpcConfiguration={subnets=[${join(",", var.private_subnet_ids)}],securityGroups=[${var.app_sg_id}],assignPublicIp=ENABLED}" | jq -r '.tasks[0].taskArn')

aws ecs wait tasks-stopped --tasks $TASK_ID --cluster ${var.ecs_cluster_id}

END_TIME=$(date +%s000)

aws logs get-log-events --log-group-name ${aws_cloudwatch_log_group.this.name} --log-stream-name ${var.name}/${var.name}/$${TASK_ID##*/} --start-time $START_TIME --end-time $END_TIME | jq -r '.events[].message'
  EOT
}