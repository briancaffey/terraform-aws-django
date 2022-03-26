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
# ECS & EC2
###############################################################################

# resource "aws_key_pair" "this" {
#   key_name   = "${var.env}_key_pair"
#   public_key = file(var.ssh_pubkey_file)
# }

resource "aws_ecs_cluster" "this" {
  name = "${var.env}-cluster"
}

variable "instance_profile_name" {
  type = string
  description = "instance profile name"
}

resource "aws_launch_configuration" "this" {
  name                 = "${var.env}-launch-config"
  image_id             = lookup(var.amis, var.region)
  instance_type        = var.instance_type
  security_groups      = [aws_security_group.this.id]
  iam_instance_profile = var.instance_profile_name
  # key_name                    = aws_key_pair.this.key_name
  associate_public_ip_address = true
  user_data                   = <<EOT
#!/bin/bash
echo ECS_CLUSTER='${var.env}-cluster' > /etc/ecs/ecs.config
echo ECS_CONTAINER_STOP_TIMEOUT=2 >> /etc/ecs/ecs.config
EOT
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
