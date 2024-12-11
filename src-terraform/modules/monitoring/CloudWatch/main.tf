resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "ecs-high-cpu"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = 75
  alarm_actions       = [var.scale_up_arn]
  dimensions = {
    ServiceName = var.service_name
    ClusterName = var.cluster_name
  }
}

resource "aws_cloudwatch_log_group" "ecs_log_group" {
  name              = "/ecs/task-logs"
  retention_in_days = 7
}
