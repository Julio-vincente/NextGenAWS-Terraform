variable "excution_role_name" {
  type    = string
  default = "ExecRoleECS"
}

variable "task_role_name" {
  type    = string
  default = "TaskRoleECS"
}

variable "policy_s3_dyanmodb" {
  type    = string
  default = "Allow-S3-Dynamodb-ECS"
}