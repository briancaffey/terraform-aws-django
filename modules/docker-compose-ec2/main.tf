###############################################################################
# Variables
###############################################################################
variable "git_tag" {
  description = "Git tag or branch to checkout"
  type        = string
  default     = "main"
}

variable "docker_compose_version" {
  description = "Version of Docker Compose to install"
  type        = string
  default     = "v2.20.0"
}

variable "git_repo" {
  description = "Git repo to use"
  type        = string
  default     = "https://github.com/briancaffey/django-step-by-step.git"
}

###############################################################################
# (Optional) Remove the old ecs_optimized AMI data source if not needed
# data "aws_ami" "ecs_optimized" {
#   most_recent = true
#   owners      = ["amazon"]

#   filter {
#     name   = "name"
#     values = ["amzn2-ami-ecs-hvm-*-x86_64-ebs"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }
# }

###############################################################################
# VPC and Subnet data sources
###############################################################################
data "aws_vpc" "default" {
  default = true
}

data "aws_subnet" "default" {
  vpc_id = data.aws_vpc.default.id

  filter {
    name   = "default-for-az"
    values = ["true"]
  }

  filter {
    name   = "availability-zone"
    values = ["us-east-1a"] # Replace with your desired AZ
  }
}

###############################################################################
# Security Group
###############################################################################
resource "aws_security_group" "app_sg" {
  name        = "app-sg"
  description = "Application security group"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Optional: Remove SSH rule if you don't need it
  # ingress {
  #   from_port   = 22
  #   to_port     = 22
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

###############################################################################
# EBS Volume and Attachment
###############################################################################
resource "aws_ebs_volume" "data_volume" {
  availability_zone = data.aws_subnet.default.availability_zone
  size              = 20
  type              = "gp3"
  tags = {
    Name = "data-volume"
  }
}

resource "aws_volume_attachment" "data_vol_attach" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.data_volume.id
  instance_id = aws_instance.app.id
}

###############################################################################
# IAM Role for SSM
###############################################################################
resource "aws_iam_role" "ssm_role" {
  name = "ssm-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ssm_policy" {
  role       = aws_iam_role.ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ssm_instance_profile" {
  name = "ssm-instance-profile"
  role = aws_iam_role.ssm_role.name
}

###############################################################################
# EC2 Instance (using the fixed AMI)
###############################################################################
resource "aws_instance" "app" {
  ami                    = "ami-001e311816e8c15d1"
  instance_type          = "t3.medium"
  subnet_id              = data.aws_subnet.default.id
  vpc_security_group_ids = [aws_security_group.app_sg.id]
  user_data              = templatefile("${path.module}/user_data.sh.tpl", {
    git_tag                = var.git_tag
    docker_compose_version = var.docker_compose_version
    git_repo               = var.git_repo
  })
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.ssm_instance_profile.name

  # # (Optional) Use spot instances for cost savings
  # instance_market_options {
  #   market_type = "spot"
  #   spot_options {
  #     max_price = "0.03" # Adjust based on instance type and your willingness to pay
  #   }
  # }

  root_block_device {
    volume_size           = 30
    volume_type           = "gp3"
    delete_on_termination = false
  }

  tags = {
    Name = "docker-app-instance"
  }
}

###############################################################################
# Output
###############################################################################
output "ssm_session_command" {
  description = "Command to start an interactive shell on the EC2 instance using AWS SSM Session Manager"
  value       = "aws ssm start-session --target ${aws_instance.app.id} --region ${var.region}"
}
