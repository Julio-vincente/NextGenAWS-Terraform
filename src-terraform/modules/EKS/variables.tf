variable "eks_prod_name" {
  type    = string
  default = "EKS_PROD"
}

variable "node_group_name" {
  type    = string
  default = "NODE_PROD"
}

variable "public_subnet_ids" {
  description = "A list of public subnets IDs"
  type        = list(string)
}

variable "eks_role_arn" {
  description = "EKS Role arn"
  type        = string
}

variable "nodes_role_arn" {
  description = "Node eks role arn"
  type        = string
}