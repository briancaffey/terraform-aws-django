resource "aws_security_group" "alb" {
  name        = "${terraform.workspace}-alb-sg"
  description = "Controls access to the ALB"
  vpc_id      = var.vpc_id
  tags = {
    Name = "${terraform.workspace}-alb-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "http" {
  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "tcp"
  from_port = 80
  security_group_id = aws_security_group.alb.id
  to_port   = 80
  tags = {
    Name = "${terraform.workspace}-alb-ingress-http-sgr"
  }
}

resource "aws_vpc_security_group_ingress_rule" "https" {
  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "tcp"
  from_port = 443
  security_group_id = aws_security_group.alb.id
  to_port   = 443
  tags = {
    Name = "${terraform.workspace}-alb-ingress-https-sgr"
  }
}

resource "aws_security_group" "app" {
  name        = "${terraform.workspace}-app-sg"
  description = "Allows inbound access from the ALB only"
  vpc_id      = var.vpc_id
  tags = {
    Name = "${terraform.workspace}-ecs-sg"
  }
}

resource "aws_vpc_security_group_egress_rule" "alb" {
  security_group_id = aws_security_group.alb.id
  referenced_security_group_id = aws_security_group.app.id
  ip_protocol                  = "tcp"
  from_port = 0
  to_port   = 65535
  tags = {
    Name = "${terraform.workspace}-alb-to-app-sgr"
  }
}

# Allow all traffic from ALB security group
resource "aws_vpc_security_group_ingress_rule" "alb_ingress" {
  from_port = 0
  to_port   = 65535
  ip_protocol                  = "tcp"
  referenced_security_group_id = aws_security_group.alb.id
  security_group_id            = aws_security_group.app.id
  tags = {
    Name = "${terraform.workspace}-alb-ingress-sg"
  }
}

# Allow all outbound traffic
resource "aws_vpc_security_group_egress_rule" "app_egress" {
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
  security_group_id = aws_security_group.app.id
  tags = {
    Name = "${terraform.workspace}-app-egress-sg"
  }
}

# VPC endpoints
resource "aws_security_group" "vpc_endpoints" {
  name        = "${terraform.workspace}-vpc-endpoints-sg"
  description = "Allows ECS tasks to communicate with VPC endpoints"
  vpc_id      = var.vpc_id
  tags = {
    Name = "${terraform.workspace}-vpc-endpoints-sg"
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
  tags = {
    Name = "${terraform.workspace}-s3"
  }
}

resource "aws_vpc_endpoint" "secretsmanager" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.region}.secretsmanager"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.private_subnet_ids
  security_group_ids  = [aws_security_group.vpc_endpoints.id]
  private_dns_enabled = true
}

# app -> vpc_endpoints egress
resource "aws_vpc_security_group_egress_rule" "app_to_vpc_endpoints" {
  from_port                    = 443
  to_port                      = 443
  ip_protocol                  = "tcp"
  referenced_security_group_id = aws_security_group.vpc_endpoints.id
  security_group_id            = aws_security_group.app.id
  tags = {
    Name = "${terraform.workspace}-app-to-vpce-egress-sg"
  }
}

# vpc_endpoints <- app ingress
resource "aws_vpc_security_group_ingress_rule" "vpc_endpoints_from_app" {
  from_port                    = 443
  to_port                      = 443
  ip_protocol                  = "tcp"
  referenced_security_group_id = aws_security_group.app.id
  security_group_id            = aws_security_group.vpc_endpoints.id
  tags = {
    Name = "${terraform.workspace}-vpce-from-app-sg"
  }
}