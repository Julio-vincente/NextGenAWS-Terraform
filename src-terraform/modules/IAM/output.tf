output "eks_role_arn" {
  description = "eks role arn"
  value       = aws_iam_role.eks_role.arn
}
output "nodes_role_arn" {
  description = "node role arn"
  value       = aws_iam_role.node_role.arn
}