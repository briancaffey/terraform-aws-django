###############################################################################
# IAM - Shared Roles and Policies for Launch Configuration, Task and Service
###############################################################################

# assume role
resource "aws_iam_role" "ecs_host" {
  name = "${var.env}-ecs-host"
  assume_role_policy = jsonencode({
    Version = "2008-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = [
            "ecs.amazonaws.com",
            "ec2.amazonaws.com"
          ]
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "ecs_instance" {
  name = "${var.env}-ecs-instance"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ecs:*",
          "ec2:*",
          "elasticloadbalancing:*",
          "ecr:*",
          "cloudwatch:*",
          "s3:*",
          "rds:*",
          "logs:*",
          "elasticache:*",
          "secretsmanager:*"
        ]
        Resource = "*"
      }
    ]
  })
  role = aws_iam_role.ecs_host.id
}

resource "aws_iam_role" "ecs_task" {
  name = "${var.env}-ecs-task"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = ""
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "ecs_task" {
  name = "${var.env}-ecs-task-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["s3:*"] # TODO: tighten this down
        Resource = ["*"]
      }
    ]
  })
  role = aws_iam_role.ecs_task.id
}

resource "aws_iam_role" "ecs_service" {
  name = "${var.env}-ecs-service"
  assume_role_policy = jsonencode({
    Version = "2008-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = [
            "ecs.amazonaws.com",
            "ec2.amazonaws.com"
          ]
        }
        Effect = "Allow"
      }
    ]
  })
}

resource "aws_iam_role_policy" "ecs_service" {
  name = "${var.env}-ecs-service-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "elasticloadbalancing:Describe*",
          "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
          "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
          "ec2:Describe*",
          "ec2:AuthorizeSecurityGroupIngress",
          "elasticloadbalancing:RegisterTargets",
          "elasticloadbalancing:DeregisterTargets"
        ]
        Resource = ["*"]
      }
    ]
  })
  role = aws_iam_role.ecs_service.id
}

resource "aws_iam_instance_profile" "this" {
  name = "${var.env}-ecs-instance-profile"
  path = "/"
  role = aws_iam_role.ecs_host.name
}