provider "aws" {
  region = var.region_aws1
}

module "VPC" {
  source = "./modules/VPC"
}

module "WAF" {
  source     = "./modules/WAF"
  depends_on = [module.VPC]
}

module "IAM" {
  source = "./modules/IAM"
}

module "ECS" {
  source = "./modules/ECS"
}

module "Route53" {
  source = "./modules/Route53"
}

module "CertificateManager" {
  source = "./modules/CertificateManager"
}