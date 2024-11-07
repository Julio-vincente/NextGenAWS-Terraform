variable "ecs_cluster_name" {
  type    = string
  default = "microservices-cluster"
}

variable "family_task" {
  type    = string
  default = "nginx-task"
}

variable "ecs_service_name" {
  type    = string
  default = "web-app-service"
}

variable "task_role_arn" {
  description = "ecs task role arn"
  type        = string
}

variable "execution_role_arn" {
  description = "ecs execution role arn"
  type        = string
}

variable "ecs_sg" {
  description = "ecs sg para o service"
  type        = string
}

variable "subnet_public_ecs" {
  description = "subnets publics ecs"
  type        = list(string)
}

variable "target_group_arn" {
  description = "arn do target group"
  type        = string
}
