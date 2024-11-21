output "task_role_arn" {
  description = "ecs task role arn"
  value       = aws_iam_role.task_role_ecs.arn
}

output "execution_role_arn" {
  description = "ecs execution role arn"
  value       = aws_iam_role.execution_role_ecs.arn
}