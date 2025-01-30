# RDS Security Group (traffic ECS -> RDS)
resource "aws_security_group" "this" {
  name        = "${terraform.workspace}-rds-security-group"
  description = "Allows inbound access from ECS only"
  vpc_id      = var.vpc_id

  ingress {
    protocol        = "tcp"
    from_port       = var.port
    to_port         = var.port
    security_groups = [var.app_sg_id]
  }

  # ingress {
  #   protocol    = "tcp"
  #   from_port   = var.port
  #   to_port     = var.port
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_subnet_group" "this" {
  name       = "${terraform.workspace}-rds-subnet-group"
  subnet_ids = var.private_subnet_ids
}

# RDS password
resource "random_password" "this"{
  length           = 16
  special          = true
  override_special = "_!%^"
}

resource "random_string" "suffix" {
  length  = 8
  special = false
  upper   = false
}

resource "aws_secretsmanager_secret" "this" {
  name = "${terraform.workspace}/rds-password/${random_string.suffix.result}"
}

resource "aws_secretsmanager_secret_version" "this" {
  secret_id = aws_secretsmanager_secret.this.id
  secret_string = random_password.this.result
}

# RDS instance
resource "aws_db_instance" "this" {
  identifier                 = "${terraform.workspace}-rds"
  db_name                    = var.rds_db_name
  username                   = var.rds_username
  password                   = aws_secretsmanager_secret_version.this.secret_string
  port                       = var.port
  engine                     = var.engine
  engine_version             = var.engine_version
  instance_class             = var.rds_instance_class
  allocated_storage          = "20"
  storage_encrypted          = true
  vpc_security_group_ids     = [aws_security_group.this.id]
  db_subnet_group_name       = aws_db_subnet_group.this.name
  multi_az                   = false
  storage_type               = "gp2"
  publicly_accessible        = false
  backup_retention_period    = 7
  skip_final_snapshot        = true
  auto_minor_version_upgrade = false
  # TODO: use these settings when there is better support in Terraform
  # manage_master_user_password = true
  # master_user_secret {
  #   secret_arn = aws_secretsmanager_secret.rds_credentials.arn
  # }
}
