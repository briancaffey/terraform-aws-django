###############################################################################
# S3 - TODO add S3 bucket resource for app assets
###############################################################################

module "s3" {
  source        = "../internal/s3"
  bucket_name   = "${replace(var.record_name, ".", "-")}-${terraform.workspace}-bucket"
  force_destroy = var.force_destroy
}

###############################################################################
# Redis
###############################################################################

module "redis" {
  source            = "../internal/redis"
  vpc_id            = var.vpc_id
  private_subnets   = var.private_subnets
  log_group_name    = "/ecs/${terraform.workspace}/web-ui"
  log_stream_prefix = "redis"
  image             = "redis:5.0.3-alpine"
}

###############################################################################
# Route 53
###############################################################################

module "route53" {
  source       = "../internal/route53"
  zone_name    = var.zone_name
  record_name  = var.record_name
  alb_dns_name = module.lb.dns_name
}

###############################################################################
# Common variables for ECS Services and Tasks
###############################################################################

locals {
  env_vars = [
    {
      name  = "REDIS_SERVICE_HOST"
      value = module.elasticache.redis_service_host
    },
    {
      name  = "POSTGRES_SERVICE_HOST"
      value = module.rds.postgres_service_host
    },
    {
      name  = "DJANGO_SETTINGS_MODULE"
      value = var.django_settings_module
    },
    {
      name  = "S3_BUCKET_NAME"
      value = module.s3.bucket_name
    },
    {
      name  = "FRONTEND_URL"
      value = var.frontend_url
    }
  ]
  be_image = "${var.ecr_be_repo_url}:${var.be_image_tag}"
  fe_image = "${var.ecr_fe_repo_url}:${var.fe_image_tag}"
}

###############################################################################
# Frontend ECS Service
###############################################################################

module "web-ui" {
  source             = "../internal/web"
  name               = "web-ui"
  ecs_cluster_id     = module.ecs.cluster_id
  task_role_arn      = var.task_role_arn
  execution_role_arn = var.execution_role_arn
  command            = var.frontend_command
  env_vars           = []
  image              = local.fe_image
  env                = terraform.workspace
  alb_default_tg_arn = module.lb.alb_default_tg_arn
  log_group_name     = "/ecs/${terraform.workspace}/web-ui"
  log_stream_prefix  = "web-ui"
  region             = var.region
  cpu                = var.api_cpu
  memory             = var.api_memory
  port               = 80
  path_patterns      = ["/*"]
  health_check_path  = "/"
  listener_arn       = module.lb.listener_arn
  vpc_id             = module.vpc.vpc_id
  priority           = 2
}

###############################################################################
# Gunicorn ECS Service
###############################################################################

module "api" {
  source             = "../internal/web"
  name               = "gunicorn"
  ecs_cluster_id     = module.ecs.cluster_id
  task_role_arn      = var.task_role_arn
  execution_role_arn = var.execution_role_arn
  command            = var.api_command
  env_vars           = concat(local.env_vars, var.extra_env_vars)
  image              = local.be_image
  env                = terraform.workspace
  alb_default_tg_arn = module.lb.alb_default_tg_arn
  log_group_name     = "/ecs/${terraform.workspace}/api"
  log_stream_prefix  = "api"
  region             = var.region
  cpu                = var.api_cpu
  memory             = var.api_memory
  port               = 8000
  path_patterns      = ["/api/*", "/admin/*", "/graphql/*", "/mtv/*"]
  health_check_path  = "/api/health-check/"
  listener_arn       = module.lb.listener_arn
  vpc_id             = module.vpc.vpc_id
  priority           = 1
}

###############################################################################
# Celery - Default Worker
###############################################################################

module "default_celery_worker" {
  source             = "../internal/celery_worker"
  name               = "default"
  ecs_cluster_id     = module.ecs.cluster_id
  task_role_arn      = var.task_role_arn
  execution_role_arn = var.execution_role_arn
  command            = var.default_celery_worker_command
  env_vars           = concat(local.env_vars, var.extra_env_vars)
  image              = local.be_image
  env                = terraform.workspace
  log_group_name     = "/ecs/${terraform.workspace}/celery-default-worker"
  log_stream_prefix  = "celery-default-worker"
  region             = var.region
  cpu                = var.default_celery_worker_cpu
  memory             = var.default_celery_worker_memory
}

###############################################################################
# Celery Beat
###############################################################################

module "celery_beat" {
  source             = "../internal/celery_beat"
  name               = "beat"
  ecs_cluster_id     = module.ecs.cluster_id
  task_role_arn      = var.task_role_arn
  execution_role_arn = var.execution_role_arn
  command            = var.celery_beat_command
  env_vars           = concat(local.env_vars, var.extra_env_vars)
  image              = local.be_image
  env                = terraform.workspace
  log_group_name     = "/ecs/${terraform.workspace}/celery-beat"
  log_stream_prefix  = "celery-beat"
  region             = var.region
  cpu                = var.celery_beat_cpu
  memory             = var.celery_beat_memory
}

###############################################################################
# Migrate - Database Migrate Task Definition
###############################################################################

module "migrate" {
  name               = "migrate"
  source             = "../internal/management_command"
  ecs_cluster_id     = module.ecs.cluster_id
  task_role_arn      = var.task_role_arn
  execution_role_arn = var.execution_role_arn
  command            = var.migrate_command
  env_vars           = concat(local.env_vars, var.extra_env_vars)
  image              = local.be_image
  env                = terraform.workspace
  log_group_name     = "/ecs/${terraform.workspace}/migrate"
  log_stream_prefix  = "migrate"
  region             = var.region
  cpu                = var.migrate_cpu
  memory             = var.migrate_memory
}

###############################################################################
# collectstatic - collectstatic task
###############################################################################

module "collectstatic" {
  name               = "collectstatic"
  source             = "../internal/management_command"
  ecs_cluster_id     = module.ecs.cluster_id
  task_role_arn      = var.task_role_arn
  execution_role_arn = var.execution_role_arn
  command            = var.collectstatic_command
  env_vars           = concat(local.env_vars, var.extra_env_vars)
  image              = local.be_image
  env                = terraform.workspace
  log_group_name     = "/ecs/${terraform.workspace}/collectstatic"
  log_stream_prefix  = "collectstatic"
  region             = var.region
  cpu                = var.collectstatic_cpu
  memory             = var.collectstatic_memory
}
