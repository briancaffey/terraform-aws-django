output "ecs_sg_id" {
  value = aws_security_group.this.id
}

output "cluster_id" {
  value = aws_ecs_cluster.this.id
}

output "cluster_arn" {
  value = aws_ecs_cluster.this.arn
}

output "cluster_name" {
  value = "${var.env}-cluster"
}
