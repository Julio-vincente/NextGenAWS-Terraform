# REGIOES AWS
variable "us-east-1a" {
  type    = string
  default = "us-east-1a"
}

variable "us-east-1b" {
  type    = string
  default = "us-east-1b"
}

# VPC MAIN
variable "vpc_name" {
  type    = string
  default = "vpc_main"
}

variable "vpc_cidr" {
  type    = string
  default = "192.168.0.0/16"
}

# SUBNETS PUBLICAS
variable "subnet_pub1a_name" {
  type    = string
  default = "sub_pub_1a"
}

variable "subnet_pub1a_cidr" {
  type    = string
  default = "192.168.10.0/24"
}

variable "subnet_pub1b_name" {
  type    = string
  default = "sub_pub_1b"
}

variable "subnet_pub1b_cidr" {
  type    = string
  default = "192.168.20.0/24"
}

#SUBNETS PRIVADAS
variable "subnet_priv1a_name" {
  type    = string
  default = "sub_priv_1a"
}

variable "subnet_priv1a_cidr" {
  type    = string
  default = "192.168.30.0/24"
}

variable "subnet_priv1b_name" {
  type    = string
  default = "sub_priv_1b"
}

variable "subnet_priv1b_cidr" {
  type    = string
  default = "192.168.40.0/24"
}

# IGW
variable "igw_prod" {
  type    = string
  default = "igw_prod"
}

# NAT GATEWAY
variable "natgw_name" {
  type    = string
  default = "natgw_prod"
}

# ROUTE TABLE PUB
variable "rt_pub_name" {
  type    = string
  default = "rt_pub_prod"
}

# ROUTE TABLE PRIV
variable "rt_priv_name" {
  type    = string
  default = "rt_priv_prod"
}

# SG ECS
variable "sg_ecs_name" {
  type    = string
  default = "ECS-SG"
}

variable "sg_ecs_description" {
  type    = string
  default = "Sg para o ecs permitindo que o sg do load balancer se comunique com o ecs permitindo HTTP e HTTPs"
}

# SG ALB
variable "sg_alb_name" {
  type    = string
  default = "ALB-SG"
}

variable "sg_alb_description" {
  type    = string
  default = "Sg para o alb permitindo HTTPs de forma segura e HTTP para redirecionar para HTTPs"
}

# SG RDS
variable "sg_rds_name" {
  type    = string
  default = "RDS-SG"
}

variable "sg_rds_description" {
  type    = string
  default = "Sg para o banco de dados RDS liberando a porta 3306/MYSQL"
}
