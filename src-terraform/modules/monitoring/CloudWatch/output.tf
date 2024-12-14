output "ecs_log_group" {
  value = aws_cloudwatch_log_group.ecs_log_group.name
}

output "guardyduty_log_group" {
  value = aws_cloudwatch_log_group.guardduty_log_group.arn
}