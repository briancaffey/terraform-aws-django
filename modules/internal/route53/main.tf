data "aws_route53_zone" "this" {
  name         = "${var.domain_name}."
  private_zone = false
}

resource "aws_route53_record" "this" {
  zone_id = data.aws_route53_zone.this.id
  name    = "${terraform.workspace}.${var.domain_name}"
  type    = "CNAME"
  ttl     = "60"
  records = [var.alb_dns_name]
}
