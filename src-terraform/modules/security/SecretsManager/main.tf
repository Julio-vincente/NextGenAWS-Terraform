resource "aws_secretsmanager_secret" "rds_password_secret" {
  name = "rds_secrets_databases"
}

resource "aws_secretsmanager_secret_version" "secrets_rds" {
    secret_id = aws_secretsmanager_secret.rds_password_secret.id
    secret_string = jsonencode({
        username = "admin"
        password = "Senai-134"
    })
}

# resource "aws_secretsmanager_secret_rotation" "secret_rds_rotation" {
#   secret_id = aws_secretsmanager_secret.rds_password_secret.id
#   rotate_immediately = false

#   rotation_rules {
#     automatically_after_days = 30
#   }
# }