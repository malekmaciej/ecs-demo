module "edmz_vpc" {
  source      = "./vpc"
  vpc_name    = "edmz_vpc"
  region      = "eu-central-2"
  igw_enabled = true
  common_tags = var.common_tags
}

module "idmz_vpc" {
  source      = "./vpc"
  vpc_name    = "idmz_vpc"
  region      = "eu-central-2"
  igw_enabled = false
  common_tags = var.common_tags
}

module "edmz-ecr" {
  source = "./ecr"
  name   = "edmz"
  region = "eu-central-2"
  common_tags = var.common_tags
}

module "edmz-ecs" {
  source             = "./ecs"
  name               = "edmz"
  region             = "eu-central-2"
  subnet_ids         = [module.edmz_vpc.subnet_1-id, module.edmz_vpc.subnet_2-id]
  security_group_ids = [module.edmz_vpc.aws_security_group_id]
  ecr_repository_url = module.edmz-ecr.ecr_repository_url
  target_group_arn   = module.edmz-nlb.tg_arn
  common_tags = var.common_tags
}

module "edmz-nlb" {
  source     = "./nlb"
  name       = "edmz"
  region     = "eu-central-2"
  vpc_id     = module.edmz_vpc.vpc_id
  subnet_ids = [module.edmz_vpc.subnet_1-id, module.edmz_vpc.subnet_2-id]
  common_tags = var.common_tags
}

resource "aws_vpc_endpoint_service" "edmz-service-endpoint" {
  acceptance_required        = false
  network_load_balancer_arns = [module.edmz-nlb.nlb_arn]
  tags = merge(
    var.common_tags,
    {
      Name = "edmz-squid-proxy-endpoint-service"
  })
}