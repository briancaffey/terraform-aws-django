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

resource "aws_instance" "this" {
  ami                         = data.aws_ami.amazon-linux-2.id
  associate_public_ip_address = true
  instance_type               = var.instance_type
  key_name                    = var.key_name
  vpc_security_group_ids      = [var.alb_sg_id, var.ecs_sg_id]
  subnet_id                   = var.public_subnets[0]
  user_data                   = <<EOF
    #!/bin/bash
    yum update -y
    yum install -y postgresql mysql
  EOF
  tags = {
    Name = "${terraform.workspace}-bastion"
  }
}
