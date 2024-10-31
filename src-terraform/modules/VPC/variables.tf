## VPC PRODUCTION
variable "vpc_prod_name" {
  type = string
  default = "Production"
}

variable "vpc_prod_cidr" {
  type = string
  default = "192.168.0.0/16"
}

## ZONES
variable "Zone1a" {
    type = string
    default = "us-east-1a"
}

variable "Zone1b" {
    type = string
    default = "us-east-1b"
}

## SUBNET PUBLIC 1A
variable "name_prod_pub1a" {
    type = string
    default = "Production_Public_1a"  
}

variable "cidr_prod_pub1a" {
    type = string
    default = "192.168.10.0/24"  
}

## SUBNET PUBLIC 1B
variable "name_prod_pub1b" {
    type = string
    default = "Production_Public_1b"  
}

variable "cidr_prod_pub1b" {
    type = string
    default = "192.168.20.0/24"  
}

## SUBNET PRIVATE 1A
variable "name_prod_priv1a" {
    type = string
    default = "Production_Private_1a"  
}

variable "cidr_prod_priv1a" {
    type = string
    default = "192.168.30.0/24"  
}

## SUBNET PRIVATE 1B
variable "name_prod_priv1b" {
    type = string
    default = "Production_Private_1b"  
}

variable "cidr_prod_priv1b" {
    type = string
    default = "192.168.40.0/24"  
}

## IGW PROD
variable "name_igw_prod" {
    type = string
    default = "igw-prod"
}

## NATGW PROD
variable "name_natgw_prod" {
    type = string
    default = "natgw-prod"
}

## ROUTE TABLE PUBLIC PROD
variable "name_route_table_public_prod" {
    type = string
    default = "rt-public-prod"
}