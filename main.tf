locals {
  region       = var.region
  project_name = var.project_name
  environment  = var.environment
}

#create vpc module 
module "vpc" {
  source                       = "git@github.com:elafkaihi/terraform-modules.git//vpc"
  region                       = local.region
  environment                  = local.environment
  project_name                 = local.project_name
  vpc_cidr                     = var.vpc_cidr
  public_subnet_az1_cidr       = var.public_subnet_az1_cidr
  public_subnet_az2_cidr       = var.public_subnet_az2_cidr
  private_app_subnet_az1_cidr  = var.private_app_subnet_az1_cidr
  private_app_subnet_az2_cidr  = var.private_app_subnet_az2_cidr
  private_data_subnet_az1_cidr = var.private_data_subnet_az1_cidr
  private_data_subnet_az2_cidr = var.private_data_subnet_az2_cidr
}

#create nat gateway
module "nat_gateway" {
    source                       = "git@github.com:elafkaihi/terraform-modules.git//nat-gateway"
    project_name = local.project_name
    environment = local.environment
    public_subnet_az1_id = module.vpc.public_subnet_az1_id
    public_subnet_az2_id = module.vpc.public_subnet_az2_id
    internet_gateway = module.vpc.internet_gateway
    vpc_id = module.vpc.vpc_id
    private_app_subnet_az1_id = module.vpc.private_app_subnet_az1_id
    private_app_subnet_az2_id = module.vpc.private_app_subnet_az2_id
    private_data_subnet_az1_id = module.vpc.private_data_subnet_az1_id
    private_data_subnet_az2_id = module.vpc.private_data_subnet_az2_id
}
