output "rds_endpoint_clean" {
  value = element(split(":", aws_db_instance.library_database.endpoint), 0)
}

output "rds_name" {
  value = aws_db_instance.library_database.db_name
}
