provider "aws" {
  region = var.region_aws1
}

module "VPC" {
  source = "./modules/VPC"
}

module "IAM" {
  source = "./modules/IAM"
}

module "ECR" {
  source = "./modules/ECR"
}

module "CloudWatch" {
  source = "./modules/CloudWatch"
}

module "ECS" {
  source             = "./modules/ECS"
  task_role_arn      = module.IAM.task_role_arn
  execution_role_arn = module.IAM.execution_role_arn
  subnet_public_ecs  = module.VPC.subnet_public_ecs
  ecs_sg             = module.VPC.ecs_sg
  target_group_arn   = module.ALB.target_group_arn
  depends_on         = [module.IAM, module.CloudWatch, module.VPC]
}

module "CertificateManager" {
  source = "./modules/CertificateManager"
  domain_validation = module.Route53.validation_record_fqdns
  record_fqdn       = module.Route53.validation_record_fqdns
}

module "Route53" {
  source                    = "./modules/Route53"
  alb_zone_id               = module.ALB.alb_zone_id
  alb_dns_name              = module.ALB.alb_dns_name
  domain_validation_options = module.CertificateManager.certificate_domain
  certificate_arn           = module.CertificateManager.certificate_arn
  depends_on = [ module.CertificateManager ]

}

module "ALB" {
  source            = "./modules/ALB"
  alb_sg            = module.VPC.alb_sg
  subnet_public_alb = module.VPC.subnet_public_alb
  vpc_id            = module.VPC.vpc_id
  certificate_arn   = module.CertificateManager.certificate_arn
  depends_on        = [module.CertificateManager]
}


module "WAF" {
  source     = "./modules/WAF"
  alb_arn = module.ALB.alb_arn
  depends_on = [module.VPC]
}
