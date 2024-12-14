## ECS TASKS E EXECUTION ROLES
resource "aws_iam_role" "execution_role_ecs" {
  name = "ExecRoleECS"
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

resource "aws_iam_role_policy_attachments_exclusive" "ECSTaskRole" {
  role_name   = aws_iam_role.execution_role_ecs.name
  policy_arns = ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"]
}

resource "aws_iam_role" "task_role_ecs" {
  name = "TaskRoleECS"
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
  name = "ecs_policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "secretsmanager:GetSecretValue"
        ],
        Resource = var.secret_arn
      },
      {
        Effect   = "Allow"
        Action   = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListObject"
        ]
        Resource = [
          "${var.bucket_arn}/*",
          var.bucket_arn
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_policy_attach" {
  policy_arn = aws_iam_policy.ecs_task_role.arn
  role       = aws_iam_role.task_role_ecs.name
}

resource "aws_iam_role" "autoscaling_role" {
  name = "ecs-autoscaling-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action    = "sts:AssumeRole",
        Effect    = "Allow",
        Principal = {
          Service = "application-autoscaling.amazonaws.com"
        }
      }
    ]
  })
}

# CloudWatch role
resource "aws_iam_role" "cloudwatch_event_role" {
  name = "cloudwatch-event-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "events.amazonaws.com"
        }
      }
    ]
  })
}

# CloudWatch policy
resource "aws_iam_role_policy" "cloudwatch_event_policy" {
  name   = "cloudwatch-event-policy"
  role   = aws_iam_role.cloudwatch_event_role.name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = "logs:PutLogEvents"
        Effect   = "Allow"
        Resource = "${var.guardyduty_log_group}:*"
      }
    ]
  })
}