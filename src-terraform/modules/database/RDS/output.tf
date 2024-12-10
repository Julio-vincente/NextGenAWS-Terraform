output "rds_endpoint" {
    value = aws_db_instance.library_database.endpoint
}

output "rds_name" {
  value = aws_db_instance.library_database.db_name
}