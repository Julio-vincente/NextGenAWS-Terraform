# VPC MAIN
resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = var.vpc_name
  }
}

# SUBNETS PUBLICAS
resource "aws_subnet" "pub1a" {
  vpc_id            = aws_vpc.main_vpc.id
  availability_zone = var.us-east-1a
  cidr_block        = var.subnet_pub1a_cidr
  map_public_ip_on_launch = true

  tags = {
    Name = var.subnet_pub1a_name
  }
}

resource "aws_subnet" "pub1b" {
  vpc_id            = aws_vpc.main_vpc.id
  availability_zone = var.us-east-1b
  cidr_block        = var.subnet_pub1b_cidr
  map_public_ip_on_launch = true

  tags = {
    Name = var.subnet_pub1b_name
  }
}

# SUBNETS PRIVADAS
resource "aws_subnet" "priv1a" {
  vpc_id            = aws_vpc.main_vpc.id
  availability_zone = var.us-east-1a
  cidr_block        = var.subnet_priv1a_cidr
  map_public_ip_on_launch = true

  tags = {
    Name = var.subnet_priv1a_name
  }
}

resource "aws_subnet" "priv1b" {
  vpc_id            = aws_vpc.main_vpc.id
  availability_zone = var.us-east-1b
  cidr_block        = var.subnet_priv1b_cidr
  map_public_ip_on_launch = true

  tags = {
    Name = var.subnet_priv1b_name
  }
}

# INTERNET GATEWAY
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = var.igw_prod
  }
}

# NAT GATEWAY
resource "aws_eip" "elastic_ip" {}

resource "aws_nat_gateway" "nat_gw" {
  subnet_id     = aws_subnet.pub1a.id
  allocation_id = aws_eip.elastic_ip.id

  tags = {
    Name = var.natgw_name
  }
}

# ROUTE TABLE PUBLICAS
resource "aws_route_table" "rt_public" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = var.rt_pub_name
  }
}

resource "aws_route_table_association" "rt_ass_pub1" {
  route_table_id = aws_route_table.rt_public.id
  subnet_id      = aws_subnet.pub1a.id
}

resource "aws_route_table_association" "rt_ass_pub2" {
  route_table_id = aws_route_table.rt_public.id
  subnet_id      = aws_subnet.pub1b.id
}

# ROUTE TABLE PRIVADAS
resource "aws_route_table" "rt_private" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = var.rt_priv_name
  }
}

resource "aws_route_table_association" "rt_ass_priv1" {
  route_table_id = aws_route_table.rt_private.id
  subnet_id      = aws_subnet.priv1a.id
}

resource "aws_route_table_association" "rt_ass_priv2" {
  route_table_id = aws_route_table.rt_private.id
  subnet_id      = aws_subnet.priv1b.id
}

## Security Groups Alb, Rds e ECS
# ALB SG
resource "aws_security_group" "alb_sg" {
  name        = var.sg_alb_name
  description = var.sg_alb_description
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# ECS SG
resource "aws_security_group" "ecs_sg" {
  name        = var.sg_ecs_name
  description = var.sg_ecs_description
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    from_port       = 5000
    to_port         = 5000
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# RDS SG
resource "aws_security_group" "rds_sg" {
  name        = var.sg_rds_name
  description = var.sg_rds_description
  vpc_id      = aws_vpc.main_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "mysql_ecs_sg" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.rds_sg.id
  security_group_id        = aws_security_group.ecs_sg.id
  depends_on               = [aws_security_group.alb_sg, aws_security_group.ecs_sg, aws_security_group.rds_sg]
}

resource "aws_security_group_rule" "mysql_rds_sg" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.ecs_sg.id
  security_group_id        = aws_security_group.rds_sg.id
  depends_on               = [aws_security_group.alb_sg, aws_security_group.ecs_sg, aws_security_group.rds_sg]
}
