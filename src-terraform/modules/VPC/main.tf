## VPC ECS
resource "aws_vpc" "vpc_ecs_az1" {
  cidr_block           = var.vpc_ecs_az1_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = var.vpc_ecs_az1_name
  }
}

## SUBNET ECS PUBLIC/PRIVATE
resource "aws_subnet" "ecs_subnet_public1" {
  vpc_id                  = aws_vpc.vpc_ecs_az1.id
  cidr_block              = var.ecs_subnet_public_cidr1
  availability_zone       = var.us-east-1a
  map_public_ip_on_launch = true
  tags = {
    Name = var.ecs_subnet_public_name1
  }
}

resource "aws_subnet" "ecs_subnet_public2" {
  vpc_id                  = aws_vpc.vpc_ecs_az1.id
  cidr_block              = var.ecs_subnet_public_cidr2
  availability_zone       = var.us-east-1b
  map_public_ip_on_launch = true
  tags = {
    Name = var.ecs_subnet_public_name2
  }
}

resource "aws_subnet" "ecs_subnet_private1" {
  vpc_id                  = aws_vpc.vpc_ecs_az1.id
  cidr_block              = var.ecs_subnet_private_cidr1
  availability_zone       = var.us-east-1b
  map_public_ip_on_launch = true
  tags = {
    Name = var.ecs_subnet_private_name1
  }
}

resource "aws_subnet" "ecs_subnet_private2" {
  vpc_id                  = aws_vpc.vpc_ecs_az1.id
  cidr_block              = var.ecs_subnet_private_cidr2
  availability_zone       = var.us-east-1b
  map_public_ip_on_launch = true
  tags = {
    Name = var.ecs_subnet_private_name2
  }
}

## IGW ECS
resource "aws_internet_gateway" "igw_ecs" {
  vpc_id = aws_vpc.vpc_ecs_az1.id

  tags = {
    Name = var.ecs_igw_name
  }
}

## NAT GATEWAY ECS
resource "aws_eip" "eip_ecs" {}

resource "aws_nat_gateway" "nat_gateway_ecs" {
  allocation_id = aws_eip.eip_ecs.id
  subnet_id     = aws_subnet.ecs_subnet_public1.id

  tags = {
    Name = var.ecs_natgw_name
  }
}

## VPC ECS ROUTE TABLES
resource "aws_route_table" "public_rt_ecs" {
  vpc_id = aws_vpc.vpc_ecs_az1.id

  route {
    cidr_block                = aws_vpc.vpc_ecs2s_az1.cidr_block
    vpc_peering_connection_id = aws_vpc_peering_connection.ecs_vpc_peering.id
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_ecs.id
  }
  tags = {
    Name = var.rt_public_ecs_name
  }
}

resource "aws_route_table" "private_rt_ecs" {
  vpc_id = aws_vpc.vpc_ecs_az1.id

  route {
    cidr_block                = aws_vpc.vpc_ecs2s_az1.cidr_block
    vpc_peering_connection_id = aws_vpc_peering_connection.ecs_vpc_peering.id
  }

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway_ecs.id
  }

  tags = {
    Name = var.rt_private_ecs_name
  }
}

## VPC ecs2S
resource "aws_vpc" "vpc_ecs2s_az1" {
  cidr_block           = var.vpc_ecs_az2_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = var.vpc_ecs_az2_name
  }
}

## SUBNET ecs2S PUBLIC/PRIVATE
resource "aws_subnet" "ecs2s_subnet_public1" {
  vpc_id                  = aws_vpc.vpc_ecs2s_az1.id
  cidr_block              = var.ecs2_subnet_public_cidr1
  availability_zone       = var.us-east-1a
  map_public_ip_on_launch = true
  tags = {
    Name = var.ecs2_subnet_private_name1
  }
}

resource "aws_subnet" "ecs2s_subnet_public2" {
  vpc_id                  = aws_vpc.vpc_ecs2s_az1.id
  cidr_block              = var.ecs2_subnet_public_cidr2
  availability_zone       = var.us-east-1a
  map_public_ip_on_launch = true
  tags = {
    Name = var.ecs2_subnet_public_name2
  }
}

resource "aws_subnet" "ecs2s_subnet_private1" {
  vpc_id                  = aws_vpc.vpc_ecs2s_az1.id
  cidr_block              = var.ecs2_subnet_private_cidr1
  availability_zone       = var.us-east-1b
  map_public_ip_on_launch = true
  tags = {
    Name = var.ecs2_subnet_private_name1
  }
}

resource "aws_subnet" "ecs2s_subnet_private2" {
  vpc_id                  = aws_vpc.vpc_ecs2s_az1.id
  cidr_block              = var.ecs2_subnet_private_cidr2
  availability_zone       = var.us-east-1b
  map_public_ip_on_launch = true
  tags = {
    Name = var.ecs2_subnet_private_name2
  }
}

## IGW ecs2S
resource "aws_internet_gateway" "igw_ecs2s" {
  vpc_id = aws_vpc.vpc_ecs2s_az1.id

  tags = {
    Name = var.ecs2_igw_name
  }
}

## NAT GATEWAY ecs2S
resource "aws_eip" "eip_ecs2s" {}

resource "aws_nat_gateway" "nat_gateway_ecs2s" {
  allocation_id = aws_eip.eip_ecs2s.id
  subnet_id     = aws_subnet.ecs2s_subnet_public1.id

  tags = {
    Name = var.ecs2_natgw_name
  }
}

## VPC ecs2S ROUTE TABLES
resource "aws_route_table" "public_rt_ecs2s" {
  vpc_id = aws_vpc.vpc_ecs2s_az1.id

  route {
    cidr_block                = aws_vpc.vpc_ecs_az1.cidr_block
    vpc_peering_connection_id = aws_vpc_peering_connection.ecs_vpc_peering.id
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_ecs2s.id
  }
  tags = {
    Name = var.rt_public_ecs2_name
  }
}

resource "aws_route_table" "private_rt_ecs2s" {
  vpc_id = aws_vpc.vpc_ecs2s_az1.id

  route {
    cidr_block                = aws_vpc.vpc_ecs_az1.cidr_block
    vpc_peering_connection_id = aws_vpc_peering_connection.ecs_vpc_peering.id
  }

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway_ecs2s.id
  }

  tags = {
    Name = var.rt_private_ecs2_name
  }
}

## SECURITY GROUP ecs2S 
resource "aws_security_group" "sg_ecs2s" {
  name        = var.sg_ecs_name
  description = var.sg_ecs2_description
  vpc_id      = aws_vpc.vpc_ecs2s_az1.id
}

resource "aws_vpc_security_group_ingress_rule" "ecs2s_sg_ingress_http_rule" {
  security_group_id = aws_security_group.sg_ecs2s.id
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "ecs2s_sg_ingress_https_rule" {
  security_group_id = aws_security_group.sg_ecs2s.id
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_egress_rule" "ecs2s_sg_egress_all_rule" {
  security_group_id = aws_security_group.sg_ecs2s.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}

## SECURITY GROUP DB 
resource "aws_security_group" "sg_db" {
  name        = var.sg_db_name
  description = var.sg_db_description
  vpc_id      = aws_vpc.vpc_ecs2s_az1.id
}

resource "aws_vpc_security_group_ingress_rule" "db_sg_ingress_mysql_rule" {
  security_group_id = aws_security_group.sg_db.id
  from_port         = 3306
  to_port           = 3306
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_egress_rule" "db_sg_egress_all_rule" {
  security_group_id = aws_security_group.sg_db.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}

## SECURITY GROUP DB 
resource "aws_security_group" "sg_alb" {
  name        = var.sg_alb_name
  description = var.sg_alb_description
  vpc_id      = aws_eip.eip_ecs.id
}

resource "aws_vpc_security_group_ingress_rule" "alb_sg_ingress_https_rule" {
  security_group_id = aws_security_group.sg_alb.id
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "alb_sg_ingress_http_rule" {
  security_group_id = aws_security_group.sg_alb.id
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_egress_rule" "alb_sg_egress_all_rule" {
  security_group_id = aws_security_group.sg_alb.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}

## VPC PEERING WITH THE VPCs
resource "aws_vpc_peering_connection" "ecs_vpc_peering" {
  vpc_id      = aws_vpc.vpc_ecs_az1.id
  peer_vpc_id = aws_vpc.vpc_ecs2s_az1.id
  auto_accept = true

  tags = {
    Name = var.peering_name
  }
}
