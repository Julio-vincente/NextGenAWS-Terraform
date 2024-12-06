output "rds_username" {
  value = local.rds_credentials["username"]
}

output "rds_password" {
  value = local.rds_credentials["password"]
}

output "secret_arn" {
  value = data.aws_secretsmanager_secret.rds_secret.arn
}
