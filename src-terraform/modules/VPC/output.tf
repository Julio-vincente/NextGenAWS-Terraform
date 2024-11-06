output "ecs_sg" {
  description = "ecs task role id"
  value       = aws_security_group.sg_ecs2s.id
}

output "subnet_public_ecs" {
  description = "subnets public ids"
  value       = [aws_subnet.ecs_subnet_public1.id, aws_subnet.ecs_subnet_public2.id]
}

output "alb_sg" {
  description = "id do sg para o alb"
  value = aws_security_group.sg_alb.id
}

output "subnet_public_alb" {
  description = "subnets public ids"
  value       = [aws_subnet.ecs_subnet_public1.id, aws_subnet.ecs_subnet_public2.id]
}

output "vpc_id" {
  description = "vpc para o listener"
  value = aws_vpc.vpc_ecs_az1.id
}