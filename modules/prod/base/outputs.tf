output "vpc_id" {
  value = module.vpc.vpc_id
}

output "assets_bucket_name" {
  value       = module.s3.bucket_name
  description = "Bucket name used for S3 assets"
}

output "private_subnet_ids" {
  value = module.vpc.private_subnets
}

output "app_sg_id" {
  value = module.sg.app_sg_id
}

output "alb_sg_id" {
  value = module.sg.alb_sg_id
}

output "listener_arn" {
  value = module.lb.listener_arn
}

output "alb_dns_name" {
  value = module.lb.alb_dns_name
}

output "task_role_arn" {
  value       = module.iam.task_role_arn
  description = "arn of the role that is used by the application code to access AWS resources"
}

output "execution_role_arn" {
  value       = module.iam.execution_role_arn
  description = "arn of the role that is used by the ECS agent to access AWS resources"
}

output "rds_address" {
  value       = module.rds.address
  description = "address of the RDS instance"
}

output "redis_service_host" {
  value = module.elasticache.redis_service_host
}
