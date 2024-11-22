output "target_group_arn" {
  description = "target_arn"
  value       = aws_lb_target_group.flask_target_group.arn
}

output "alb_arn" {
    description = "alb arn"
    value = aws_lb.flask_alb.arn
}
