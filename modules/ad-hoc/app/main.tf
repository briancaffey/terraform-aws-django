###############################################################################
# ECS
###############################################################################

module "ecs" {
  source = "../../internal/ecs/ad-hoc/cluster"
}

###############################################################################
# IAM
###############################################################################

module "iam" {
  source = "../../internal/iam"
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
    # Environments
    {
      name = "APP_NAME"
      value = terraform.workspace
    },
    {
      name = "BASE_STACK_NAME"
      value = var.base_stack_name
    },
    # Database
    {
      name  = "DB_SECRET_NAME"
      value = var.rds_password_secret_name
    },
    {
      name  = "POSTGRES_SERVICE_HOST"
      value = var.rds_address
    },
    {
      name  = "POSTGRES_NAME"
      value = "${terraform.workspace}-db"
    },
    {
      name  = "REDIS_SERVICE_HOST"
      value = var.redis_service_host
    },
    # Static Files
    {
      name  = "S3_BUCKET_NAME"
      value = var.assets_bucket_name
    },
    # Django settings
    {
      name  = "DJANGO_SETTINGS_MODULE"
      value = var.django_settings_module
    },
    # Domain names
    {
      name  = "FRONTEND_URL"
      value = "https://${terraform.workspace}.${var.domain_name}"
    },
    {
      name  = "DOMAIN_NAME"
      value = var.domain_name
    },
    # email
    {
      name  = "EMAIL_HOST"
      value = var.email_host
    },
    {
      name  = "EMAIL_PORT"
      value = var.email_port
    },
    {
      name  = "EMAIL_HOST_USER"
      value = var.email_host_user
    },
    {
      name  = "EMAIL_HOST_PASSWORD"
      value = var.email_host_password
    },
    # sentry
    {
      name = "SENTRY_DSN"
      value = var.sentry_dsn
    },
    # AI inference API keys
    {
      name = "NVIDIA_API_KEY"
      value = var.nvidia_api_key
    }

  ]
  be_image  = "${data.aws_caller_identity.current.account_id}.dkr.ecr.us-east-1.amazonaws.com/${var.app_name}-backend:latest"
  fe_image  = "${data.aws_caller_identity.current.account_id}.dkr.ecr.us-east-1.amazonaws.com/${var.app_name}-frontend:latest"
  host_name = "${terraform.workspace}.${var.domain_name}"
}

###############################################################################
# Gunicorn ECS Service
###############################################################################

module "api" {
  source             = "../../internal/ecs/ad-hoc/web"
  name               = "gunicorn"
  ecs_cluster_id     = module.ecs.cluster_id
  task_role_arn      = module.iam.task_role_arn
  execution_role_arn = module.iam.execution_role_arn
  app_sg_id          = var.app_sg_id
  command            = var.api_command
  env_vars           = concat(local.env_vars, var.extra_env_vars)
  image              = local.be_image
  cpu                = var.api_cpu
  memory             = var.api_memory
  port               = 8000
  path_patterns      = ["/api/*", "/admin/*", "/graphql/*", "/mtv/*"]
  health_check_path  = "/api/health-check/"
  listener_arn       = var.listener_arn
  vpc_id             = var.vpc_id
  private_subnet_ids = var.private_subnet_ids
  host_name          = local.host_name
  region             = var.region
}

###############################################################################
# Frontend ECS Service
###############################################################################

module "web-ui" {
  source             = "../../internal/ecs/ad-hoc/web"
  name               = "web-ui"
  ecs_cluster_id     = module.ecs.cluster_id
  app_sg_id          = var.app_sg_id
  task_role_arn      = module.iam.task_role_arn
  execution_role_arn = module.iam.execution_role_arn
  command            = var.frontend_command
  env_vars           = [
    {
      name = "NUXT_PUBLIC_API_BASE"
      value = "https://${terraform.workspace}.${var.domain_name}"
    }
  ]
  image              = local.fe_image
  region             = var.region
  cpu                = var.frontend_cpu
  memory             = var.frontend_memory
  port               = 3000
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
  source             = "../../internal/ecs/ad-hoc/celery_worker"
  name               = "default"
  app_sg_id          = var.app_sg_id
  ecs_cluster_id     = module.ecs.cluster_id
  task_role_arn      = module.iam.task_role_arn
  execution_role_arn = module.iam.execution_role_arn
  command            = var.default_celery_worker_command
  env_vars           = concat(local.env_vars, var.extra_env_vars)
  image              = local.be_image
  region             = var.region
  cpu                = var.default_celery_worker_cpu
  memory             = var.default_celery_worker_memory
  private_subnet_ids = var.private_subnet_ids
}

###############################################################################
# Celery Beat
###############################################################################

module "celery_beat" {
  source             = "../../internal/ecs/ad-hoc/celery_beat"
  name               = "beat"
  ecs_cluster_id     = module.ecs.cluster_id
  app_sg_id          = var.app_sg_id
  task_role_arn      = module.iam.task_role_arn
  execution_role_arn = module.iam.execution_role_arn
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
  source             = "../../internal/ecs/ad-hoc/management_command"
  name               = "backend_update"
  ecs_cluster_id     = module.ecs.cluster_id
  app_sg_id          = var.app_sg_id
  task_role_arn      = module.iam.task_role_arn
  execution_role_arn = module.iam.execution_role_arn
  command            = var.backend_update_command
  env_vars           = concat(local.env_vars, var.extra_env_vars)
  image              = local.be_image
  region             = var.region
  cpu                = var.backend_update_cpu
  memory             = var.backend_update_memory
  private_subnet_ids = var.private_subnet_ids
}
