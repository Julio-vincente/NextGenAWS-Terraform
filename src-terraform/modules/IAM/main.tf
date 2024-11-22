## ECS TASKS E EXECUTION ROLES
resource "aws_iam_role" "execution_role_ecs" {
  name = var.excution_role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachments_exclusive" "example" {
  role_name   = aws_iam_role.execution_role_ecs.name
  policy_arns = ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"]
}

resource "aws_iam_role" "task_role_ecs" {
  name = var.task_role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

## POLICY PARA TASK ROLE
resource "aws_iam_policy" "ecs_task_role" {
  name = var.policy_s3_dyanmodb
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "s3:*"
        Resource = "*"
      },
      {
        Effect   = "Allow"
        Action   = "rds:*"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_policy_attach" {
  policy_arn = aws_iam_policy.ecs_task_role.arn
  role       = aws_iam_role.task_role_ecs.name
}
