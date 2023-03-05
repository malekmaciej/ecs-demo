variable "name" {
  type        = string
  description = "Name for the Elastic Container Registry"
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
