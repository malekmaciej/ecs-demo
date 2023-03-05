module "edmz_vpc" {
  source      = "./vpc"
  vpc_name    = "edmz_vpc"
  region      = "eu-central-2"
  igw_enabled = true
}

module "idmz_vpc" {
  source      = "./vpc"
  vpc_name    = "idmz_vpc"
  region      = "eu-central-2"
  igw_enabled = false
}

module "edmz-ecr" {
  source = "./ecr"
  name   = "edmz"
  region = "eu-central-2"
}

module "edmz-ecs" {
  source = "./ecs"
  name   = "edmz"
  region = "eu-central-2"
  subnet_ids = [module.edmz_vpc.subnet_1-id, module.edmz_vpc.subnet_2-id]
  security_group_ids = [module.edmz_vpc.aws_security_group_id]
  vpc_id = module.edmz_vpc.vpc_id
  ecr_repository_url = module.edmz-ecr.ecr_repository_url
}

