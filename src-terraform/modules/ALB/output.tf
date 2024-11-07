output "target_group_arn" {
  description = "Target group arn para o ecs"
  value       = aws_lb_target_group.target_group_alb.arn
}

output "alb_dns_name" {
  description = "dns_name_alb"
  value       = aws_lb.alb_application.dns_name
}

output "alb_zone_id" {
  description = "dns_zone_id"
  value       = aws_lb.alb_application.zone_id
}

output "alb_arn" {
  description = "alb arn para o waf"
  value = aws_lb.alb_application.arn
}
