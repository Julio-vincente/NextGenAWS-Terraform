## AVAILABILITY ZONES
variable "us-east-1a" {
  type    = string
  default = "us-east-1a"
}

variable "us-east-1b" {
  type    = string
  default = "us-east-1b"
}

## VPC ECS AZ1
variable "vpc_ecs_az1_name" {
  type    = string
  default = "VPC_ECS_AZ1"
}

variable "vpc_ecs_az1_cidr" {
  type    = string
  default = "192.168.0.0/16"
}

## SUBNET ECS PUBLIC/PRIVATE
variable "ecs_subnet_public_cidr1" {
  type    = string
  default = "192.168.10.0/24"
}

variable "ecs_subnet_public_cidr2" {
  type    = string
  default = "192.168.20.0/24"
}

variable "ecs_subnet_private_cidr1" {
  type    = string
  default = "192.168.30.0/24"
}

variable "ecs_subnet_private_cidr2" {
  type    = string
  default = "192.168.40.0/24"
}

variable "ecs_subnet_public_name1" {
  type    = string
  default = "ECS_SUBNET_PUBLIC1a"
}

variable "ecs_subnet_public_name2" {
  type    = string
  default = "ECS_SUBNET_PUBLIC1b"
}

variable "ecs_subnet_private_name1" {
  type    = string
  default = "ECS_SUBNET_PRIVATE1a"
}

variable "ecs_subnet_private_name2" {
  type    = string
  default = "ECS_SUBNET_PRIVATE1b"
}

## IGW ECS
variable "ecs_igw_name" {
  type    = string
  default = "IGW_ECS"
}

## NATGW ECS
variable "ecs_natgw_name" {
  type    = string
  default = "NATGW_ECS"
}

## ECS ROUTE TABLE
variable "rt_public_ecs_name" {
  type    = string
  default = "RT_PUBLIC_ECS"
}

variable "rt_private_ecs_name" {
  type    = string
  default = "RT_PRIVATE_ECS"
}

## VPC ECS2 AZ2
variable "vpc_ecs_az2_name" {
  type    = string
  default = "VPC_ECS2_AZ2"
}

variable "vpc_ecs_az2_cidr" {
  type    = string
  default = "172.16.0.0/16"
}

## SUBNET ECS2 PUBLIC/PRIVATE
variable "ecs2_subnet_public_cidr1" {
  type    = string
  default = "172.16.10.0/24"
}

variable "ecs2_subnet_public_cidr2" {
  type    = string
  default = "172.16.20.0/24"
}

variable "ecs2_subnet_private_cidr1" {
  type    = string
  default = "172.16.30.0/24"
}

variable "ecs2_subnet_private_cidr2" {
  type    = string
  default = "172.16.40.0/24"
}

variable "ecs2_subnet_public_name1" {
  type    = string
  default = "ECS2_SUBNET_PUBLIC1a"
}

variable "ecs2_subnet_public_name2" {
  type    = string
  default = "ECS2_SUBNET_PUBLIC1b"
}

variable "ecs2_subnet_private_name1" {
  type    = string
  default = "ECS2_SUBNET_PRIVATE1a"
}

variable "ecs2_subnet_private_name2" {
  type    = string
  default = "ECS2_SUBNET_PRIVATE1b"
}

## IGW ECS2
variable "ecs2_igw_name" {
  type    = string
  default = "IGW_ECS2"
}

## NATGW ECS2
variable "ecs2_natgw_name" {
  type    = string
  default = "NATGW_ECS2"
}

## ECS2 ROUTE TABLE
variable "rt_public_ecs2_name" {
  type    = string
  default = "RT_PUBLIC_ECS2"
}

variable "rt_private_ecs2_name" {
  type    = string
  default = "RT_PRIVATE_ECS2"
}

## SG ECS2
variable "sg_ecs_name" {
  type    = string
  default = "SG_ECS"
}

variable "sg_ecs2_description" {
  type    = string
  default = "Permite HTTP e HTTPs para os cluster do ecs"
}

## SG DB
variable "sg_db_name" {
  type    = string
  default = "SG_DB"
}

variable "sg_db_description" {
  type    = string
  default = "Permite Mysql para o rds"
}

## SG ALB
variable "sg_alb_name" {
  type    = string
  default = "ALB_SG"
}

variable "sg_alb_description" {
  type    = string
  default = "Liberando a porta http e https para o alb"
}

## VPC PEERING 
variable "peering_name" {
  type    = string
  default = "PEERING_ECS-ECS2"
}
