resource "aws_ecr_repository" "aws-ecr" {
  name = lower("${var.name}-ecr")
  tags = merge(
    var.common_tags,
    {
      Name = var.name
  })
}

resource "aws_ecr_lifecycle_policy" "aws-ecr-policy" {
  repository = aws_ecr_repository.aws-ecr.name
  policy     = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Only keep 10 latest images",
            "selection": {
                "tagStatus": "untagged",
                "countType": "imageCountMoreThan",
                "countNumber": 10
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}

resource "aws_ecr_repository_policy" "aws-ecr-repository-policy" {
  repository = aws_ecr_repository.aws-ecr.name
  policy     = data.aws_iam_policy_document.aws-ecr-repository-policy.json
}