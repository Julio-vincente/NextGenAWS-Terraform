## VPC PRODUCTION
resource "aws_vpc" "vpc_prod" {
    cidr_block = var.vpc_prod_cidr
    enable_dns_hostnames = true
    enable_dns_support = true

    tags = {
      Name = var.vpc_prod_name
    }
}

## SUBNET PUB 1A
resource "aws_subnet" "prod_pub1a" {
  vpc_id = aws_vpc.vpc_prod.id
  cidr_block = var.cidr_prod_pub1a
  availability_zone = var.Zone1a

  tags = {
    Name = var.name_prod_pub1a
  }
}

## SUBNET PUB 1B
resource "aws_subnet" "prod_pub1b" {
  vpc_id = aws_vpc.vpc_prod.id
  cidr_block = var.cidr_prod_pub1b
  availability_zone = var.Zone1b

  tags = {
    Name = var.name_prod_pub1b
  }
}

## SUBNET PRIV 1A
resource "aws_subnet" "prod_pub1a" {
  vpc_id = aws_vpc.vpc_prod.id
  cidr_block = var.cidr_prod_priv1a
  availability_zone = var.Zone1a

  tags = {
    Name = var.name_prod_priv1a
  }
}

## SUBNET PRIV 1B
resource "aws_subnet" "prod_pub1b" {
  vpc_id = aws_vpc.vpc_prod.id
  cidr_block = var.cidr_prod_priv1b
  availability_zone = var.Zone1b

  tags = {
    Name = var.name_prod_priv1b
  }
}

## IGW PROD
resource "aws_internet_gateway" "igw_prod" {
  vpc_id = aws_vpc.vpc_prod.id
  tags = {
    Name = var.name_igw_prod
  }
}

## EIP NAT PROD
resource "aws_eip" "eip_nat1" {}

## NAT GATEWAY PROD
resource "aws_nat_gateway" "nat_gw" {
  subnet_id = aws_subnet.prod_pub1a.id
  allocation_id = aws_eip.eip_nat1.id
  tags = {
    Name = var.name_natgw_prod
  }
}

## ROUTE TABLE PUBLIC PROD
resource "aws_route_table" "rt_public_prod" {
  vpc_id = aws_vpc.vpc_prod.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_prod.id
  }

  route {
    cidr_block = "0.0.0.0/0"
    transit_gateway_id = aws
  }
  
  tags = {
    Name = var.name_route_table_public_prod
  }
}