output "migrate_command" {
  value = module.migrate.task_execution_command
}

output "collectstatic_command" {
  value = module.collectstatic.task_execution_command
}