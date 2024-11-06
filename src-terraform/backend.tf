provider "aws" {
  region = var.region_aws1
}

module "WAF" {
  source     = "./modules/WAF"
  depends_on = [module.VPC]
}

module "VPC" {
  source = "./modules/VPC"
}

module "IAM" {
  source = "./modules/IAM"
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

module "ECR" {
  source = "./modules/ECR"
}

module "CloudWatch" {
  source = "./modules/CloudWatch"
}

module "ALB" {
  source            = "./modules/ALB"
  alb_sg            = module.VPC.alb_sg
  subnet_public_alb = module.VPC.subnet_public_alb
  vpc_id            = module.VPC.vpc_id
  depends_on        = [module.VPC, module.CertificateManager, module.Route53]
}

module "CertificateManager" {
  source     = "./modules/CertificateManager"
  depends_on = [module.Route53]
}

module "Route53" {
  source = "./modules/Route53"
}
