terraform {
  required_version = ">= 1.3.9"
}

provider "aws" {
  profile = "default"
  region  = "eu-central-2"
}