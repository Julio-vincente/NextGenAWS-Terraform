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

resource "aws_cloudwatch_metric_alarm" "high_memory" {
  alarm_name          = "ecs-high-memory"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = 80
  alarm_actions       = [var.scale_up_arn]
  dimensions = {
    ServiceName = var.service_name
    ClusterName = var.cluster_name
  }
}

resource "aws_cloudwatch_metric_alarm" "high_network_in" {
  alarm_name          = "ecs-high-network-in"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "NetworkBytesIn"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Sum"
  threshold           = 1000000000
  alarm_actions       = [var.scale_up_arn]
  dimensions = {
    ServiceName = var.service_name
    ClusterName = var.cluster_name
  }
}

resource "aws_cloudwatch_metric_alarm" "high_network_out" {
  alarm_name          = "ecs-high-network-out"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "NetworkBytesOut"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Sum"
  threshold           = 1000000000
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

resource "aws_cloudwatch_dashboard" "ecs_dashboard" {
  dashboard_name = "ecs-dashboard"
  dashboard_body = jsonencode({
    "widgets": [
      {
        "type": "metric",
        "x": 0,
        "y": 0,
        "width": 24,
        "height": 12,
        "properties": {
          "metrics": [
            ["AWS/ECS", "CPUUtilization", "ServiceName", var.service_name, "ClusterName", var.cluster_name]
          ],
          "period": 60,
          "stat": "Average",
          "region": var.region,
          "title": "ECS CPU Utilization"
        }
      },
      {
        "type": "metric",
        "x": 0,
        "y": 12,
        "width": 24,
        "height": 12,
        "properties": {
          "metrics": [
            ["AWS/ECS", "MemoryUtilization", "ServiceName", var.service_name, "ClusterName", var.cluster_name]
          ],
          "period": 60,
          "stat": "Average",
          "region": var.region,
          "title": "ECS Memory Utilization"
        }
      },
      {
        "type": "metric",
        "x": 0,
        "y": 24,
        "width": 24,
        "height": 12,
        "properties": {
          "metrics": [
            ["AWS/ECS", "NetworkBytesIn", "ServiceName", var.service_name, "ClusterName", var.cluster_name]
          ],
          "period": 60,
          "stat": "Sum",
          "region": var.region,
          "title": "ECS Network In"
        }
      },
      {
        "type": "metric",
        "x": 0,
        "y": 36,
        "width": 24,
        "height": 12,
        "properties": {
          "metrics": [
            ["AWS/ECS", "NetworkBytesOut", "ServiceName", var.service_name, "ClusterName", var.cluster_name]
          ],
          "period": 60,
          "stat": "Sum",
          "region": var.region,
          "title": "ECS Network Out"
        }
      }
    ]
  })
}

resource "aws_cloudwatch_event_rule" "guardduty_findings_rule" {
  name        = "guardduty-findings-rule"
  description = "Regra para capturar achados do GuardDuty"
  event_pattern = jsonencode({
    "source": ["aws.guardduty"],
    "detail-type": ["GuardDuty Finding"]
  })
}

resource "aws_cloudwatch_log_group" "guardduty_log_group" {
  name = "/aws/guardduty/findings"
}

resource "aws_cloudwatch_event_target" "guardduty_target" {
  rule = aws_cloudwatch_event_rule.guardduty_findings_rule.name
  arn  = aws_cloudwatch_log_group.guardduty_log_group.arn
}