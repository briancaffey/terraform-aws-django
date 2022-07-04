output "listener_arn" {
  value = aws_alb_listener.https.arn
}

output "alb_default_tg_arn" {
  value = aws_alb_target_group.this.arn
}

output "alb_dns_name" {
  value = aws_lb.this.dns_name
}