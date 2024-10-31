provider "aws" {
    region = var.region_aws1
}

provider "aws" {
    region = var.region_aws2
}

module "CloudTrail" {
    source = "./modules/CloudTrail"  
}

module "CloudWatch" {
    source = "./modules/CloudWatch"  
}

module "Cognito" {
    source = "./modules/Cognito"  
}

module "EBS" {
    source = "./modules/EBS"  
}

module "ECR" {
    source = "./modules/ECR"  
}

module "EKS" {
    source = "./modules/EKS"  
}

module "Lambda" {
    source = "./modules/Lambda"  
}

module "RDS" {
    source = "./modules/RDS"  
}

module "Route53" {
    source = "./modules/Route53"  
}

module "S3" {
    source = "./modules/S3"  
}

module "SM" {
    source = "./modules/SM"  
}

module "VPC" {
    source = "./modules/VPC"  
}

module "WAF" {
    source = "./modules/WAF"  
}

module "IAM" {
    source = "./modules/IAM"  
}