variable "common_tags" {
  type        = map(any)
  description = "Default tags attached to all resources"
  default = {
    terraform = "true"
    repo_name = "https://github.com/malekmaciej/ecs-demo.git"
  }
}