resource "aws_cloudwatch_log_group" "this" {
  name              = "/ecs/${terraform.workspace}/${var.name}"
  retention_in_days = var.log_retention_in_days
}

resource "aws_cloudwatch_log_stream" "this" {
  name           = var.name
  log_group_name = aws_cloudwatch_log_group.this.name
}

resource "aws_ecs_task_definition" "this" {
  family                   = "${terraform.workspace}-${var.name}"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu
  memory                   = var.memory
  container_definitions = jsonencode([
    {
      name        = var.name
      image       = var.image
      essential   = true
      links       = []
      environment = var.env_vars
      command     = var.command
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.this.name
          "awslogs-region"        = var.region
          "awslogs-stream-prefix" = var.name
        }
      }
      portMappings = [
        {
          containerPort = var.port
          hostPort      = var.port
          protocol      = "tcp"
        }
      ]
    }
  ])
  task_role_arn      = var.task_role_arn
  execution_role_arn = var.execution_role_arn
}

resource "aws_ecs_service" "this" {
  name                   = "${terraform.workspace}-${var.name}"
  cluster                = var.ecs_cluster_id
  enable_execute_command = true
  task_definition        = aws_ecs_task_definition.this.arn
  desired_count          = var.app_count

  capacity_provider_strategy {
    capacity_provider = "FARGATE_SPOT"
    weight            = 0
  }

  capacity_provider_strategy {
    capacity_provider = "FARGATE"
    weight            = 100
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.this.arn
    container_name   = var.name
    container_port   = var.port
  }

  network_configuration {
    assign_public_ip = true
    security_groups  = [var.app_sg_id]
    subnets          = var.private_subnet_ids
  }

  lifecycle {
    ignore_changes = [task_definition, desired_count]
  }
}

resource "aws_lb_target_group" "this" {
  port                 = var.port
  protocol             = "HTTP"
  target_type          = "ip"
  vpc_id               = var.vpc_id
  deregistration_delay = 5

  health_check {
    healthy_threshold   = var.health_check_healthy_threshold
    unhealthy_threshold = 3
    interval            = var.health_check_interval
    matcher             = "200-399"
    path                = var.health_check_path
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = "5"
  }
  tags = {
    Name = "${terraform.workspace}-${var.name}-tg" #* https://github.com/hashicorp/terraform-provider-aws/issues/636#issuecomment-397459646
  }

  lifecycle {
    create_before_destroy = true
  }

}

resource "aws_lb_listener_rule" "this" {
  listener_arn = var.listener_arn

  condition {
    path_pattern {
      values = var.path_patterns
    }
  }

  condition {
    host_header {
      values = [var.host_name]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}
