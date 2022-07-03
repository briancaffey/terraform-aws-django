###############################################################################
# ECS
###############################################################################

module "ecs" {
  source = "../../internal/ecs"
}

###############################################################################
# Route 53
###############################################################################

module "route53" {
  source       = "../../internal/route53"
  alb_dns_name = var.alb_dns_name
  domain_name  = var.domain_name
}

###############################################################################
# Common variables for ECS Services and Tasks
###############################################################################

locals {
  env_vars = [
    {
      name  = "REDIS_SERVICE_HOST"
      value = var.redis_service_host
    },
    {
      name  = "POSTGRES_SERVICE_HOST"
      value = var.rds_address
    },
    {
      name  = "POSTGRES_NAME"
      value = var.db_name
    },
    {
      name  = "DJANGO_SETTINGS_MODULE"
      value = var.django_settings_module
    },
    {
      name  = "S3_BUCKET_NAME"
      value = var.s3_bucket_name
    },
    {
      name  = "FRONTEND_URL"
      value = "https://${terraform.workspace}.${var.domain_name}"
    },
    {
      name  = "DOMAIN_NAME"
      value = var.domain_name
    }
  ]
  be_image = "${var.ecr_be_repo_url}:${var.be_image_tag}"
  fe_image = "${var.ecr_fe_repo_url}:${var.fe_image_tag}"
  host_name = "${terraform.workspace}.${var.domain_name}"
}

###############################################################################
# Gunicorn ECS Service
###############################################################################

module "api" {
  source             = "../../internal/app/prod/web"
  name               = "gunicorn"
  ecs_cluster_id     = module.ecs.cluster_id
  task_role_arn      = var.task_role_arn
  execution_role_arn = var.execution_role_arn
  ecs_sg_id          = var.ecs_sg_id
  command            = var.api_command
  env_vars           = concat(local.env_vars, var.extra_env_vars)
  image              = local.be_image
  alb_default_tg_arn = var.alb_default_tg_arn
  log_group_name     = "/ecs/${terraform.workspace}/api"
  log_stream_prefix  = "api"
  region             = var.region
  cpu                = var.api_cpu
  memory             = var.api_memory
  port               = 8000
  path_patterns      = ["/api/*", "/admin/*", "/graphql/*", "/mtv/*"]
  health_check_path  = "/api/health-check/"
  listener_arn       = var.listener_arn
  vpc_id             = var.vpc_id
  private_subnets    = var.private_subnets
  host_name          = local.host_name
}


###############################################################################
# Frontend ECS Service
###############################################################################

module "web-ui" {
  source             = "../../internal/app/prod/web"
  name               = "web-ui"
  ecs_cluster_id     = module.ecs.cluster_id
  ecs_sg_id          = var.ecs_sg_id
  task_role_arn      = var.task_role_arn
  execution_role_arn = var.execution_role_arn
  command            = var.frontend_command
  env_vars           = []
  image              = local.fe_image
  alb_default_tg_arn = var.alb_default_tg_arn
  log_group_name     = "/ecs/${terraform.workspace}/web-ui"
  log_stream_prefix  = "web-ui"
  region             = var.region
  cpu                = var.api_cpu
  memory             = var.api_memory
  port               = 80
  path_patterns      = ["/*"]
  health_check_path  = "/"
  listener_arn       = var.listener_arn
  vpc_id             = var.vpc_id
  private_subnets    = var.private_subnets
  host_name          = local.host_name

  # this is needed in order to for the listener rule priorities to work correctly
  # without explicitly being set
  depends_on = [module.api]
}

###############################################################################
# Celery - Default Worker
###############################################################################

module "default_celery_worker" {
  source             = "../../internal/app/prod/celery_worker"
  name               = "default"
  ecs_sg_id          = var.ecs_sg_id
  ecs_cluster_id     = module.ecs.cluster_id
  task_role_arn      = var.task_role_arn
  execution_role_arn = var.execution_role_arn
  command            = var.default_celery_worker_command
  env_vars           = concat(local.env_vars, var.extra_env_vars)
  image              = local.be_image
  log_group_name     = "/ecs/${terraform.workspace}/celery-default-worker"
  log_stream_prefix  = "celery-default-worker"
  region             = var.region
  cpu                = var.default_celery_worker_cpu
  memory             = var.default_celery_worker_memory
  private_subnets    = var.private_subnets
}

###############################################################################
# Celery Beat
###############################################################################

module "celery_beat" {
  source             = "../../internal/app/prod/celery_beat"
  name               = "beat"
  ecs_cluster_id     = module.ecs.cluster_id
  ecs_sg_id          = var.ecs_sg_id
  task_role_arn      = var.task_role_arn
  execution_role_arn = var.execution_role_arn
  command            = var.celery_beat_command
  env_vars           = concat(local.env_vars, var.extra_env_vars)
  image              = local.be_image
  log_group_name     = "/ecs/${terraform.workspace}/celery-beat"
  log_stream_prefix  = "celery-beat"
  region             = var.region
  cpu                = var.celery_beat_cpu
  memory             = var.celery_beat_memory
  private_subnets    = var.private_subnets
}

###############################################################################
# Backend update commands
###############################################################################

module "backend_update" {
  name               = "backend_update"
  source             = "../../internal/app/prod/management_command"
  ecs_cluster_id     = module.ecs.cluster_id
  ecs_sg_id          = var.ecs_sg_id
  task_role_arn      = var.task_role_arn
  execution_role_arn = var.execution_role_arn
  command            = var.backend_update_command
  env_vars           = concat(local.env_vars, var.extra_env_vars)
  image              = local.be_image
  log_group_name     = "/ecs/${terraform.workspace}/backend_update"
  log_stream_prefix  = "backend_update"
  region             = var.region
  cpu                = var.backend_update_cpu
  memory             = var.backend_update_memory
  private_subnets    = var.private_subnets
}
