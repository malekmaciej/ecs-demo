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
  source   = "./ecr"
  name = "edmz"
  region   = "eu-central-2"
}