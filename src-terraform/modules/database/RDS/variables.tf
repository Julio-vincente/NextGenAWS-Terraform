variable "sg_db_id" {
  type = string
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "rds_username" {
  type = string
}

variable "rds_password" {
  type = string
}

variable "db_name" {
  type    = string
  default = "library"
}

variable "allocated_storage" {
  type        = string
  default     = 10
  description = "Armazenamento em GB."
}

