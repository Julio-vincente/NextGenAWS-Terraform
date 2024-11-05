output "public_subnet_ids" {
  description = "public eks subnets ids"
  value       = [aws_subnet.eks_subnet_public1.id, aws_subnet.eks_subnet_public2.id]
}

output "private_subnet_id" {
  description = "private eks subnet id"
  value       = [aws_subnet.eks_subnet_private1.id, aws_subnet.eks_subnet_private2.id]
}

output "sg_rds_id" {
  description = "sg rds id"
  value       = aws_security_group.sg_db.id
}

output "sg_nodes_id" {
  description = "sg nodes id"
  value       = aws_security_group.sg_nodes.id
}