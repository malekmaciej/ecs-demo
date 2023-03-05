output "ecr_registry_id" {
  value       = aws_ecr_repository.aws-ecr.id
  description = "The registry ID where the repository was created"
}

output "ecr_repository_url" {
  value       = aws_ecr_repository.aws-ecr.repository_url
  description = "The URL of the repository (in the form aws_account_id.dkr.ecr.region.amazonaws.com/repositoryName)."
}

output "ecr_repository_arn" {
  value       = aws_ecr_repository.aws-ecr.arn
  description = "Full ARN of the repository"
}
