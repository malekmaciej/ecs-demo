variable "name" {
  type        = string
  description = "Name for the ECS Cluster"
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

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs for ECS Service network"
}

variable "security_group_ids" {
  type        = list(string)
  description = "List of security group IDs for ECS Service network"
}

variable "ecr_repository_url" {
  type        = string
  description = "The URL of the repository (in the form aws_account_id.dkr.ecr.region.amazonaws.com/repositoryName)."
}

variable "target_group_arn" {
  type        = string
  description = "ARN of the Load Balancer target group to associate with the service."
}
