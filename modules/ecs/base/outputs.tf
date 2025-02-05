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

# output "service_discovery_namespace_id" {
#   value       = module.sd.service_discovery_namespace_id
#   description = "service discovery namespace id"
# }

output "rds_address" {
  value       = module.rds.address
  description = "address of the RDS instance"
}

output "rds_password_secret_name" {
  value = module.rds.rds_password_secret_name
}

output "redis_service_host" {
  value = module.elasticache.redis_service_host
}


output "domain_name" {
  value = var.domain_name
}

output "base_stack_name" {
  value = terraform.workspace
}
