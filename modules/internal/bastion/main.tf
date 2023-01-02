# Based on https://docs.aws.amazon.com/cdk/api/v2/docs/aws-cdk-lib.aws_ec2.BastionHostLinux.html

data "aws_ami" "amazon-linux-2" {
  most_recent = true

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }

  owners = ["amazon"]
}

resource "aws_iam_policy" "this" {
  name        = "${terraform.workspace}-iam-policy"
  path        = "/"
  description = "Policy for ${terraform.workspace} Bastion"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ssmmessages:*",
          "ssm:UpdateInstanceInformation",
          "ec2messages:*"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role" "this" {
  name = "${terraform.workspace}-bastion-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}


resource "aws_iam_policy_attachment" "this" {
  name       = "${terraform.workspace}-iam-policy-attachment"
  roles      = [aws_iam_role.this.name]
  policy_arn = aws_iam_policy.this.arn
}

resource "aws_iam_instance_profile" "this" {
  name = "${terraform.workspace}-bastion-instance-profile"
  role = aws_iam_role.this.name
}

resource "aws_instance" "this" {
  ami                         = data.aws_ami.amazon-linux-2.id
  associate_public_ip_address = true
  instance_type               = var.instance_type
  user_data_replace_on_change = true
  iam_instance_profile        = aws_iam_instance_profile.this.name
  vpc_security_group_ids      = [var.app_sg_id]
  subnet_id                   = var.private_subnet_ids[0]
  user_data                   = templatefile("${path.module}/cloud-init.yml.tftpl", { rds_address = var.rds_address })
  tags = {
    Name = "${terraform.workspace}-bastion"
  }
}
