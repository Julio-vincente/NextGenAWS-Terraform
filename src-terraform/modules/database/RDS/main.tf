resource "aws_db_instance" "library_database" {
  allocated_storage      = var.allocated_storage
  db_name                = var.db_name
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  username               = var.rds_username
  password               = var.rds_password
  skip_final_snapshot    = true
  publicly_accessible    = true
  parameter_group_name   = aws_db_parameter_group.parameter_group.name
  db_subnet_group_name   = aws_db_subnet_group.subnet_group.name
  vpc_security_group_ids = [var.sg_db_id]
}

resource "aws_db_parameter_group" "parameter_group" {
  name   = "rds-pg"
  family = "mysql8.0"
}

resource "aws_db_subnet_group" "subnet_group" {
  name       = "subnet_group_app"
  subnet_ids = var.public_subnet_ids

  tags = {
    Name = "RDS Subnet Group"
  }
}
