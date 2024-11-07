variable "alb_name" {
  type    = string
  default = "ALB_APP"
}

variable "alb_sg" {
  description = "id do sg para alb"
  type        = string
}

variable "subnet_public_alb" {
  description = "public subnets para o alb"
  type        = list(string)
}

variable "target_name" {
  type    = string
  default = "https_target_group"
}

variable "vpc_id" {
  description = "vpc id para o listener"
  type        = string
}

variable "certificate_arn" {
  description = "certificate domain arn"
  type        = string
}
