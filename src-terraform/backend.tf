provider "aws" {
  region = var.region_aws1
}

# Modulo VPC 
module "VPC" {
  source = "./modules/networking/VPC"
}

# Modulo IAM
module "IAM" {
  source = "./modules/security/IAM"
  secret_arn = module.SecretsManager.secret_arn
  bucket_arn = module.S3.bucket_arn
}

# Modulo ACM
module "CertificateManager" {
  source = "./modules/networking_frontend/CertificateManager"
}

# Modulo ALB
module "ALB" {
  source            = "./modules/networking_frontend/ALB"
  public_subnet_ids = module.VPC.public_subnet_ids
  sg_alb_id         = module.VPC.sg_alb_id
  vpc_id            = module.VPC.vpc_id
  certificate_arn = module.CertificateManager.certificate_arn
  depends_on = [ module.VPC ]
}

# Modulo Route53
module "Route53" {
  source = "./modules/networking_frontend/Route53"
  alb_zone_id = module.ALB.alb_zone_id
  alb_dns_name = module.ALB.alb_dns_name
}

# Modulo ECR
module "ECR" {
  source = "./modules/compute/ECR"
}

# Modulo ECS
module "ECS" {
  source             = "./modules/compute/ECS"
  task_role_arn      = module.IAM.task_role_arn
  execution_role_arn = module.IAM.execution_role_arn
  subnet_public_ids  = module.VPC.public_subnet_ids
  sg_ecs_id          = module.VPC.sg_ecs_id
  target_group_arn   = module.ALB.target_group_arn
  rds_endpoint = module.RDS.rds_endpoint
  rds_username = module.SecretsManager.rds_username
  rds_password = module.SecretsManager.rds_password

  depends_on = [ module.ALB, module.VPC, module.IAM ]
}

# Modulo AutoScaling
module "AutoScaling" {
  source = "./modules/compute/AutoScaling"
  cluster_name = module.ECS.cluster_name
  service_name = module.ECS.service_name
}

# Modulo WAF
module "WAF" {
  source = "./modules/security/WAF"
  alb_arn = module.ALB.alb_arn
  depends_on = [ module.ALB ]
}

# Modulo Secrets Manager
module "SecretsManager" {
  source = "./modules/security/SecretsManager"
}

# Modulo RDS
module "RDS" {
  source = "./modules/database/RDS"
  sg_db_id = module.VPC.sg_db_id
  public_subnet_ids = module.VPC.public_subnet_ids
  rds_username = module.SecretsManager.rds_username
  rds_password = module.SecretsManager.rds_password

  depends_on = [ module.SecretsManager, module.VPC ]
}

# Modulo CloudWatch
module "CloudWatch" {
  source = "./modules/monitoring/CloudWatch"
  cluster_name = module.ECS.cluster_name
  service_name = module.ECS.service_name
  scale_up_arn = module.AutoScaling.scale_up_arn
}

# Modulo S3
module "S3" {
  source = "./modules/storage/S3"
}