###############################################################################
# Security Group (traffic ALB -> ECS, ssh -> ECS)
###############################################################################

resource "aws_security_group" "this" {
  name        = "ecs_security_group"
  description = "Allows inbound access from the ALB only"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [var.alb_sg_id]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

###############################################################################
# IAM - Shared Roles and Policies for Launch Configuration, Task and Service
###############################################################################

# assume role
resource "aws_iam_role" "ecs_host" {
  name               = "ecs_host_role_prod"
  assume_role_policy = jsonencode({
    "Version": "2008-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": [
            "ecs.amazonaws.com",
            "ec2.amazonaws.com"
          ]
        },
        "Action": "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "ecs_instance" {
  name   = "ecs_instance_role_policy"
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
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
        ],
        "Resource": "*"
      }
    ]
  })
  role   = aws_iam_role.ecs_host.id
}

resource "aws_iam_role" "ecs_task" {
  name               = "ecs_task_role"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "",
        "Effect": "Allow",
        "Principal": {
          "Service": "ecs-tasks.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "ecs_task" {
  name   = "ecs_task_role_policy"
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "s3:*"
        ],
        "Resource": [
          "*"
        ]
      }
    ]
  }
)
  role   = aws_iam_role.ecs_task.id
}

resource "aws_iam_role" "ecs_service" {
  name               = "ecs_service_role_prod"
  assume_role_policy = jsonencode({
    "Version": "2008-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": [
            "ecs.amazonaws.com",
            "ec2.amazonaws.com"
          ]
        },
        "Effect": "Allow"
      }
    ]
  })
}

resource "aws_iam_role_policy" "ecs_service" {
  name   = "ecs_service_role_policy"
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "elasticloadbalancing:Describe*",
          "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
          "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
          "ec2:Describe*",
          "ec2:AuthorizeSecurityGroupIngress",
          "elasticloadbalancing:RegisterTargets",
          "elasticloadbalancing:DeregisterTargets"
        ],
        "Resource": [
          "*"
        ]
      }
    ]
  })
  role   = aws_iam_role.ecs_service.id
}

resource "aws_iam_instance_profile" "this" {
  name = "ecs_instance_profile_prod"
  path = "/"
  role = aws_iam_role.ecs_host.name
}

###############################################################################
# ECS & EC2
###############################################################################

# resource "aws_key_pair" "this" {
#   key_name   = "${var.env}_key_pair"
#   public_key = file(var.ssh_pubkey_file)
# }

resource "aws_ecs_cluster" "this" {
  name = "${var.env}-cluster"
}

resource "aws_launch_configuration" "this" {
  name                        = "${var.env}-launch-config"
  image_id                    = lookup(var.amis, var.region)
  instance_type               = var.instance_type
  security_groups             = [aws_security_group.this.id]
  iam_instance_profile        = aws_iam_instance_profile.this.name
  # key_name                    = aws_key_pair.this.key_name
  associate_public_ip_address = true
  user_data                   = "#!/bin/bash\necho ECS_CLUSTER='${var.env}-cluster' > /etc/ecs/ecs.config"
}


###############################################################################
# ASG
###############################################################################

resource "aws_autoscaling_group" "this" {
  name                 = "${var.env}_auto_scaling_group"
  min_size             = var.autoscale_min
  max_size             = var.autoscale_max
  desired_capacity     = var.autoscale_desired
  health_check_type    = "EC2"
  launch_configuration = aws_launch_configuration.this.name
  vpc_zone_identifier  = var.private_subnets
}
