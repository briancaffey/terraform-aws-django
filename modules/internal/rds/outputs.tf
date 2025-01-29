output "address" {
  value = aws_db_instance.this.address
}

output "rds_password_secret_name" {
  value = aws_secretsmanager_secret.this.name
}