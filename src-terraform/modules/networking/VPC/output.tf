output "public_subnet_ids" {
  description = "public ecs subnets ids"
  value       = [aws_subnet.pub1a.id, aws_subnet.pub1b.id]
}

output "sg_ecs_id" {
  description = "sg ecs id"
  value       = aws_security_group.ecs_sg.id
}

output "sg_alb_id" {
  description = "sg alb id"
  value       = aws_security_group.alb_sg.id
}

output "sg_db_id" {
  description = "sg rds id"
  value = aws_security_group.rds_sg.id
}

output "vpc_id" {
  description = "vpc_prod_id"
  value = aws_vpc.main_vpc.id
}