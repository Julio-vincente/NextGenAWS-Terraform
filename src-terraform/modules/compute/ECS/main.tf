# ECS Cluster
resource "aws_ecs_cluster" "cluster_ecs" {
  name = var.cluster_name

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

# ECS Task Definition
resource "aws_ecs_task_definition" "service_prod" {
  family                   = var.task_family
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  task_role_arn            = var.task_role_arn
  execution_role_arn       = var.execution_role_arn

  container_definitions = jsonencode([{
    name      = "task_app"
    image     = "aaaaaaaa"
    cpu       = 256
    memory    = 512
    essential = true
    portMappings = [
      {
        containerPort = 80
        hostPort      = 80
        protocol      = "tcp"
      }
    ]
    environment = [
      {
        name  = "DB_HOST"
        value = var.rds_endpoint
      },

      {
        name  = "DB_USER"
        value = var.rds_username

      },

      {
        name  = "DB_PASSWORD"
        value = var.rds_password
      },

      {
        name  = "DB_NAME"
        value = "library"
      }
    ]

    logConfiguration = {
      logDriver = "awslogs"
      options = {
        "awslogs-group"         = var.ecs_log_group
        "awslogs-region"        = "us-east-1"
        "awslogs-stream-prefix" = "ecs"
      }
    }
  }])

  depends_on = [aws_ecs_cluster.cluster_ecs]
}


# ECS Service
resource "aws_ecs_service" "ecs_service" {
  name            = var.service_name
  cluster         = aws_ecs_cluster.cluster_ecs.id
  task_definition = aws_ecs_task_definition.service_prod.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets          = var.subnet_public_ids
    security_groups  = [var.sg_ecs_id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "task_app"
    container_port   = 80
  }

  depends_on = [aws_ecs_task_definition.service_prod]
}
