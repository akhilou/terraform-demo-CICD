data "aws_route53_zone" "main" {
  name = var.domain_name
}

resource "aws_route53_record" "app_record" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = var.subdomain_name
  type    = "A"
  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_hosted_zone_id
    evaluate_target_health = true
  }
}


