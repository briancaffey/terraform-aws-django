###############################################################################
# ECS
###############################################################################

module "ecs" {
  source = "../../internal/ecs/prod/cluster"
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

data "aws_caller_identity" "current" {}

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
      value = var.assets_bucket_name
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
  be_image  = "${data.aws_caller_identity.current.account_id}.dkr.ecr.us-east-1.amazonaws.com/backend:latest"
  fe_image  = "${data.aws_caller_identity.current.account_id}.dkr.ecr.us-east-1.amazonaws.com/frontend:latest"
  host_name = "${terraform.workspace}.${var.domain_name}"
}

###############################################################################
# Gunicorn ECS Service
###############################################################################

module "api" {
  source             = "../../internal/ecs/prod/web"
  name               = "gunicorn"
  ecs_cluster_id     = module.ecs.cluster_id
  task_role_arn      = var.task_role_arn
  execution_role_arn = var.execution_role_arn
  app_sg_id          = var.app_sg_id
  command            = var.api_command
  env_vars           = concat(local.env_vars, var.extra_env_vars)
  image              = local.be_image
  region             = var.region
  cpu                = var.api_cpu
  memory             = var.api_memory
  port               = 8000
  path_patterns      = ["/api/*", "/admin/*", "/graphql/*", "/mtv/*"]
  health_check_path  = "/api/health-check/"
  listener_arn       = var.listener_arn
  vpc_id             = var.vpc_id
  private_subnet_ids = var.private_subnet_ids
  host_name          = local.host_name
}

module "api_autoscaling" {
  source       = "../../internal/autoscaling"
  cluster_name = "${terraform.workspace}-cluster"
  service_name = "${terraform.workspace}-gunicorn"
  depends_on   = [module.api]
}


###############################################################################
# Frontend ECS Service
###############################################################################

module "web-ui" {
  source             = "../../internal/ecs/prod/web"
  name               = "web-ui"
  ecs_cluster_id     = module.ecs.cluster_id
  app_sg_id          = var.app_sg_id
  task_role_arn      = var.task_role_arn
  execution_role_arn = var.execution_role_arn
  command            = var.frontend_command
  env_vars           = []
  image              = local.fe_image
  region             = var.region
  cpu                = var.frontend_cpu
  memory             = var.frontend_memory
  port               = 80
  path_patterns      = ["/*"]
  health_check_path  = "/"
  listener_arn       = var.listener_arn
  vpc_id             = var.vpc_id
  private_subnet_ids = var.private_subnet_ids
  host_name          = local.host_name

  # this is needed in order to for the listener rule priorities to work correctly
  # without explicitly being set
  depends_on = [module.api]
}

###############################################################################
# Celery - Default Worker
###############################################################################

module "default_celery_worker" {
  source             = "../../internal/ecs/prod/celery_worker"
  name               = "default"
  app_sg_id          = var.app_sg_id
  ecs_cluster_id     = module.ecs.cluster_id
  task_role_arn      = var.task_role_arn
  execution_role_arn = var.execution_role_arn
  command            = var.default_celery_worker_command
  env_vars           = concat(local.env_vars, var.extra_env_vars)
  image              = local.be_image
  region             = var.region
  cpu                = var.default_celery_worker_cpu
  memory             = var.default_celery_worker_memory
  private_subnet_ids = var.private_subnet_ids
}

module "default_celery_worker_autoscaling" {
  source       = "../../internal/autoscaling"
  cluster_name = "${terraform.workspace}-cluster"
  service_name = "${terraform.workspace}-default"
  depends_on   = [module.default_celery_worker]
}


###############################################################################
# Celery Beat
###############################################################################

module "celery_beat" {
  source             = "../../internal/ecs/prod/celery_beat"
  name               = "beat"
  ecs_cluster_id     = module.ecs.cluster_id
  app_sg_id          = var.app_sg_id
  task_role_arn      = var.task_role_arn
  execution_role_arn = var.execution_role_arn
  command            = var.celery_beat_command
  env_vars           = concat(local.env_vars, var.extra_env_vars)
  image              = local.be_image
  region             = var.region
  cpu                = var.celery_beat_cpu
  memory             = var.celery_beat_memory
  private_subnet_ids = var.private_subnet_ids
}

###############################################################################
# Backend update commands
###############################################################################

module "backend_update" {
  name               = "backend_update"
  source             = "../../internal/ecs/prod/management_command"
  ecs_cluster_id     = module.ecs.cluster_id
  app_sg_id          = var.app_sg_id
  task_role_arn      = var.task_role_arn
  execution_role_arn = var.execution_role_arn
  command            = var.backend_update_command
  env_vars           = concat(local.env_vars, var.extra_env_vars)
  image              = local.be_image
  region             = var.region
  cpu                = var.backend_update_cpu
  memory             = var.backend_update_memory
  private_subnet_ids = var.private_subnet_ids
}
