output "rds_username" {
    value = jsondecode(aws_secretsmanager_secret_version.secrets_rds.secret_string)["username"]
}

output "rds_password" {
    value = jsondecode(aws_secretsmanager_secret_version.secrets_rds.secret_string)["password"]
}