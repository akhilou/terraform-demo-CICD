output "alb_dns_name" {
  value = aws_lb.alb.dns_name
}

output "target_group_arn" {
  value = aws_lb_target_group.tg.arn
}

output "alb_hosted_zone_id" {
  value = aws_lb.alb.canonical_hosted_zone_id
}
