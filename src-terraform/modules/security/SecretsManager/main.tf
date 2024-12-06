data "aws_secretsmanager_secret" "rds_secret" {
  name = "prod/library/mysql"
}

data "aws_secretsmanager_secret_version" "rds_secret_version" {
  secret_id = data.aws_secretsmanager_secret.rds_secret.id
}

locals {
  rds_credentials = jsondecode(data.aws_secretsmanager_secret_version.rds_secret_version.secret_string)
}
