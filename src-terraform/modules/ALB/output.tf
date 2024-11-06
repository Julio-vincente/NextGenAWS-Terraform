output "target_group_arn" {
    description = "Target group arn para o ecs"
    value = aws_lb_target_group.target_group_alb.arn
}