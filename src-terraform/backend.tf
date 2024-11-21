provider "aws" {
  region = var.region_aws1
}

# Modulo VPC 
module "VPC" {
  source = "./modules/VPC"
}

# Modulo WAF
module "IAM" {
  source = "./modules/IAM"
}

# Modulo ECS
module "ECS" {
  source = "./modules/ECS"
  task_role_arn = module.IAM.task_role_arn
  execution_role_arn = module.IAM.execution_role_arn
}