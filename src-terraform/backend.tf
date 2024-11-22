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

# Modulo ALB
module "ALB" {
  source            = "./modules/ALB"
  public_subnet_ids = module.VPC.public_subnet_ids
  sg_alb_id         = module.VPC.sg_alb_id
  vpc_id            = module.VPC.vpc_id
  depends_on = [ module.VPC ]
}

# Modulo ECS
module "ECS" {
  source             = "./modules/ECS"
  task_role_arn      = module.IAM.task_role_arn
  execution_role_arn = module.IAM.execution_role_arn
  subnet_public_ids  = module.VPC.public_subnet_ids
  sg_ecs_id          = module.VPC.sg_ecs_id
  target_group_arn   = module.ALB.target_group_arn

  depends_on = [ module.ALB, module.VPC,module.IAM ]
}

module "WAF" {
  source = "./modules/WAF"
  alb_arn = module.ALB.alb_arn
  depends_on = [ module.ALB ]
}