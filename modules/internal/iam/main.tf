###############################################################################
# IAM - Shared Roles and Policies for Launch Configuration, Task and Service
###############################################################################

resource "aws_iam_role" "ecs_host" {
  name = "${terraform.workspace}-ecs-host"
  assume_role_policy = jsonencode({
    Version = "2008-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = [
            "ecs.amazonaws.com",
            "ec2.amazonaws.com",
            "ecs-tasks.amazonaws.com"
          ]
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution" {
  role       = aws_iam_role.ecs_host.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy" "ecs_host" {
  name = "${terraform.workspace}-ecs-host-role-policy"
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
  role = aws_iam_role.ecs_host.name
}

resource "aws_iam_role" "ecs_task" {
  name = "${terraform.workspace}-ecs-task"
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
  name = "${terraform.workspace}-ecs-task-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ses:SendEmail",
          "ses:SendRawEmail",
          "ses:SendBulkEmail",
          "ses:SendBulkTemplatedEmail"
        ],
        Resource = "*"
      },
      {
        "Effect" : "Allow",
        "Action" : ["sns:ConfirmSubscription"],
        "Resource" : ["arn:aws:sns:*:*:*"]
      },
      {
        Effect = "Allow"
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage"
        ],
        Resource = "*"
      },
      {
        Effect   = "Allow"
        Action   = ["s3:*"]                               # TODO: tighten this down
        Resource = ["arn:aws:s3:::*", "arn:aws:s3:::*/*"] # TODO: tighten this down
      },
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ],
        Resource = ["*"] # TODO: parameterize this with a prefix value
      },
      # used for ECS Exec
      {
        "Effect" : "Allow",
        "Action" : [
          "ssmmessages:CreateControlChannel",
          "ssmmessages:CreateDataChannel",
          "ssmmessages:OpenControlChannel",
          "ssmmessages:OpenDataChannel"
        ],
        "Resource" : "*"
      }
    ]
  })
  role = aws_iam_role.ecs_task.id
}


resource "aws_iam_role_policy" "ecs_host_task_all" {
  name = "${terraform.workspace}-ecs-task-all-policy"
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
  role = aws_iam_role.ecs_task.name
}