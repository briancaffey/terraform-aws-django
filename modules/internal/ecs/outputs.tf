output "cluster_id" {
  value = aws_ecs_cluster.this.id
}

output "cluster_arn" {
  value = aws_ecs_cluster.this.arn
}

output "cluster_name" {
  value = "${terraform.workspace}-cluster"
}
