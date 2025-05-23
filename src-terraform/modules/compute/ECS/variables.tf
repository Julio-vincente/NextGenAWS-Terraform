variable "task_role_arn" {
  type = string
}

variable "execution_role_arn" {
  type = string
}

variable "subnet_public_ids" {
  type = list(string)
}

variable "sg_ecs_id" {
  type = string
}

variable "target_group_arn" {
  type = string
}

variable "rds_endpoint" {
  type = string
}

variable "rds_username" {
  type = string
}

variable "rds_password" {
  type = string
}

variable "ecs_log_group" {
  type = string
}
