resource "aws_security_group" "alb" {
  name        = "${terraform.workspace}-alb-sg"
  description = "Controls access to the ALB"
  vpc_id      = var.vpc_id

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

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "app" {
  name        = "${terraform.workspace}-app-sg"
  description = "Allows inbound access from the ALB only"
  vpc_id      = var.vpc_id

  # https://github.com/aws/aws-cli/issues/5348
  # https://docs.aws.amazon.com/cli/latest/reference/ec2/describe-security-groups.html#synopsis
  tags = {
    Name = "${terraform.workspace}-ecs-sg"
  }
}

# Allow all traffic from ALB security group
resource "aws_vpc_security_group_ingress_rule" "alb_ingress" {
  ip_protocol                  = "-1"
  referenced_security_group_id = aws_security_group.alb.id
  security_group_id            = aws_security_group.app.id
}

# Allow self-referencing traffic
resource "aws_vpc_security_group_ingress_rule" "self_ingress" {
  description                  = "Allow traffic from this SG"
  ip_protocol                  = "-1"
  referenced_security_group_id = aws_security_group.app.id
  security_group_id            = aws_security_group.app.id
}

# Allow all outbound traffic
resource "aws_vpc_security_group_egress_rule" "app_egress" {
  ip_protocol       = "-1"
  cidr_ipv4         = "10.0.0.0/0"
  security_group_id = aws_security_group.app.id
}

# VPC endpoints

resource "aws_security_group" "vpc_endpoints" {
  name        = "${terraform.workspace}-vpc-endpoints-sg"
  description = "Allows ECS tasks to communicate with VPC endpoints"
  vpc_id      = var.vpc_id

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    self      = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_vpc_endpoint" "ecr_api" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.region}.ecr.api"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.private_subnet_ids
  security_group_ids  = [aws_security_group.vpc_endpoints.id]
  private_dns_enabled = true
  tags = {
    Name = "${terraform.workspace}-ecr-api"
  }
}

resource "aws_vpc_endpoint" "ecr_dkr" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.region}.ecr.dkr"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.private_subnet_ids
  security_group_ids  = [aws_security_group.vpc_endpoints.id]
  private_dns_enabled = true
  tags = {
    Name = "${terraform.workspace}-ecr-dkr"
  }
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.region}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = var.route_table_ids
}

# app -> vpc_endpoints egress
resource "aws_vpc_security_group_egress_rule" "app_to_vpc_endpoints" {
  from_port                    = 443
  to_port                      = 443
  ip_protocol                  = "tcp"
  referenced_security_group_id = aws_security_group.vpc_endpoints.id
  security_group_id            = aws_security_group.app.id
}

# vpc_endpoints <- app ingress
resource "aws_vpc_security_group_ingress_rule" "vpc_endpoints_from_app" {
  from_port                    = 443
  to_port                      = 443
  ip_protocol                  = "tcp"
  referenced_security_group_id = aws_security_group.app.id
  security_group_id            = aws_security_group.vpc_endpoints.id
}