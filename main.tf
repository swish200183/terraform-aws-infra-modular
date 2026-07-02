module "network" {
  source = "./modules/network"

  project_name       = var.project_name
  environment        = var.environment
  vpc_cidr           = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
}

module "compute" {
  source = "./modules/compute"

  project_name      = var.project_name
  instance_type     = var.instance_type
  subnet_id         = module.network.public_subnet_id
  security_group_id = module.network.security_group_id
}

module "storage" {
  source = "./modules/storage"

  project_name = var.project_name
}