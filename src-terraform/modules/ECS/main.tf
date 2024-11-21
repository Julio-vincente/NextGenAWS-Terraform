resource "aws_ecs_cluster" "cluster_ecs" {
    name = var.cluster_name

    setting {
      name = "containerInsights"
      value = "enabled"
    }
}

resource "aws_ecs_task_definition" "service_prod" {
  family = var.task_family
  requires_compatibilities = ["FARGATE"]
  task_role_arn = var.task_role_arn
  execution_role_arn = var.execution_role_arn
  container_definitions = jsonencode([
    {
      name = 
      
    }
  ])
  
}