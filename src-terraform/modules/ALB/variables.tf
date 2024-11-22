variable "alb_name" {
  type = string
  default = "AlbApp"
}

variable "target_name" {
  type = string
  default = "TargetAppFlask"
}

variable "sg_alb_id" {
  type = string
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}