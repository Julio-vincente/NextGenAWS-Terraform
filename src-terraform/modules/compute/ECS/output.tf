output "cluster_name" {
  value = aws_ecs_cluster.cluster_ecs.name
}

output "service_name" {
  value = aws_ecs_service.ecs_service.name
}