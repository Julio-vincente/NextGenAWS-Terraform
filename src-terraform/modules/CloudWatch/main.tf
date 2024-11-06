resource "aws_cloudwatch_log_group" "ecs_log_group" {
  name              = var.name_cloudwatch_logs_ecs
  retention_in_days = 7
}