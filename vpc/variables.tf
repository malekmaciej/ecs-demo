variable "vpc_name" {
  type        = string
  description = "Name for the VPC"
}

variable "vpc_cidr_block" {
  type        = string
  description = "The primary IPv4 CIDR block for the VPC."
  default     = "10.0.0.0/16"
}

variable "subnet_prefix" {
  description = "Map of subnets with defined az and cidr"
  type        = map(any)
  default = {
    subnet-1 = {
      az   = "eu-central-2a"
      cidr = "10.0.1.0/24"
    }
    subnet-2 = {
      az   = "eu-central-2b"
      cidr = "10.0.2.0/24"
    }
    subnet-3 = {
      az   = "eu-central-2c"
      cidr = "10.0.0.0/24"
    }
  }
}

variable "subnet_prefix_public" {
  description = "Map of public subnets with defined az and cidr"
  type        = map(any)
  default = {
    public-subnet-1 = {
      az   = "eu-central-2a"
      cidr = "10.0.3.0/24"
    }
    public-subnet-2 = {
      az   = "eu-central-2b"
      cidr = "10.0.4.0/24"
    }
  }
}

variable "interface_endpoints_to_create" {
  type        = set(string)
  description = "Set of AWS Service names to create VPC Endpoints for"
  default     = ["logs", "monitoring", "ecs", "ecr.dkr", "ecr.api", "ssm"]
}

variable "gateway_endpoints_to_create" {
  type        = set(string)
  description = "Set of AWS Service names to create VPC Endpoints for"
  default     = ["s3"]
}

variable "region" {
  type        = string
  description = "Name of the region where deploying"
}


variable "common_tags" {
  type        = map(string)
  description = "Common resource tags"
  default     = {}
}

variable "igw_enabled" {
  type        = bool
  description = "Set true to create Internet Gateway"
}