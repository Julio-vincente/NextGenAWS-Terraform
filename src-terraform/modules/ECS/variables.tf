variable "cluster_name" {
    type = string
    default = "ProdCluster"
}

variable "task_family" {
    type = string
    default = "service"
}

variable "task_role_arn" {
    type = string
}

variable "execution_role_arn" {
    type = string
}
