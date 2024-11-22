variable "cluster_name" {
  type    = string
  default = "ProdCluster"
}

variable "task_family" {
  type    = string
  default = "service"
}

variable "service_name" {
  type    = string
  default = "service_app"
}

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