variable "name" {
  type        = string
  description = "Name for the Network Load Balancer"
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
  type        = list(any)
  description = "List of subnets for Network Load Balancer Listeners"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}