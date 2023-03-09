# VPCs 
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

module "internal_vpc" {
  source      = "./vpc"
  vpc_name    = "internal_vpc"
  region      = "eu-central-2"
  igw_enabled = false
  common_tags = var.common_tags
}

# ECRs
module "edmz-ecr" {
  source      = "./ecr"
  name        = "edmz"
  region      = "eu-central-2"
  common_tags = var.common_tags
}

module "internal-ecr" {
  source      = "./ecr"
  name        = "internal-ecr"
  region      = "eu-central-2"
  common_tags = var.common_tags
}

# Elastic Container Service Clusters
module "edmz-ecs" {
  source             = "./ecs"
  name               = "edmz"
  region             = "eu-central-2"
  subnet_ids         = [module.edmz_vpc.subnet_1_id, module.edmz_vpc.subnet_2_id, module.edmz_vpc.subnet_3_id]
  security_group_ids = [module.edmz_vpc.aws_security_group_id]
  ecr_repository_url = module.edmz-ecr.ecr_repository_url
  target_group_arn   = module.edmz-nlb.tg_arn
  common_tags        = var.common_tags
}

module "edmz-nlb" {
  source      = "./nlb"
  name        = "edmz"
  region      = "eu-central-2"
  vpc_id      = module.edmz_vpc.vpc_id
  subnet_ids  = [module.edmz_vpc.subnet_1_id, module.edmz_vpc.subnet_2_id, module.edmz_vpc.subnet_3_id]
  common_tags = var.common_tags
}

# VPC Private Link iDMZ -> eDMZ
resource "aws_vpc_endpoint_service" "edmz_service_endpoint" {
  acceptance_required        = false
  network_load_balancer_arns = [module.edmz-nlb.nlb_arn]
  allowed_principals = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
  tags = merge(
    var.common_tags,
    {
      Name = "edmz-squid-proxy-endpoint-service"
  })
}

resource "aws_vpc_endpoint" "idmz_to_edmz_endpoint" {
  vpc_id = module.idmz_vpc.vpc_id
  service_name = aws_vpc_endpoint_service.edmz_service_endpoint.service_name
  vpc_endpoint_type = "Interface"
  subnet_ids = [module.idmz_vpc.subnet_1_id, module.idmz_vpc.subnet_2_id, module.idmz_vpc.subnet_3_id]
  security_group_ids = [module.idmz_vpc.aws_security_group_id]
  private_dns_enabled = false
  tags = merge(
    var.common_tags,
    {
      Name = "idmz-edmz-squid-proxy-private-link"
  })
}

# VPC Private Link Internal -> iDMZ
module "idmz-nlb" {
  source      = "./nlb"
  name        = "idmz"
  region      = "eu-central-2"
  vpc_id      = module.idmz_vpc.vpc_id
  subnet_ids  = [module.idmz_vpc.subnet_1_id, module.idmz_vpc.subnet_2_id, module.idmz_vpc.subnet_3_id]
  common_tags = var.common_tags
}