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

module "EKS" {
  source            = "./modules/EKS"
  public_subnet_ids = module.VPC.public_subnet_ids
  eks_role_arn      = module.IAM.eks_role_arn
  nodes_role_arn    = module.IAM.nodes_role_arn
  depends_on        = [module.VPC, module.IAM]
}

module "Route53" {
  source = "./modules/Route53"
}

module "CertificateManager" {
  source = "./modules/CertificateManager"
}