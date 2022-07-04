# VPC

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

# security groups

output "ecs_sg_id" {
  value = module.sg.ecs_sg_id
}

output "alb_sg_id" {
  value = module.sg.alb_sg_id
}

# Load balancer

output "listener_arn" {
  value = module.lb.listener_arn
}

output "alb_default_tg_arn" {
  value = module.lb.alb_default_tg_arn
}

output "alb_dns_name" {
  value = module.lb.alb_dns_name
}

# Service Discovery

output "service_discovery_namespace_id" {
  value       = module.sd.service_discovery_namespace_id
  description = "service discovery namespace id"
}

# IAM

output "task_role_arn" {
  value       = module.iam.task_role_arn
  description = "arn of the role that is used by the application code to access AWS resources"
}

output "execution_role_arn" {
  value       = module.iam.execution_role_arn
  description = "arn of the role that is used by the ECS agent to access AWS resources"
}

# RDS

output "rds_address" {
  value       = module.rds.address
  description = "address of the RDS instance"
}

# Bastion

output "bastion_public_ip" {
  value       = module.bastion.public_ip
  description = "bastion host public ip"
}

output "ssh_command" {
  value = <<EOT
ssh -o StrictHostKeyChecking=no -t -t  \
    -i ~/.ssh/${var.key_name}.pem "ec2-user@${module.bastion.public_ip}" \
    -L "5432:${module.rds.address}:5432" &
EOT
}
