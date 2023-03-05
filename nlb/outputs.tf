output "nlb_id" {
  value       = aws_lb.nlb.id
  description = "The ARN of the load balancer (matches arn)."
}

output "nlb_arn" {
  value       = aws_lb.nlb.arn
  description = "The ARN of the load balancer (matches id)."
}

output "nlb_dns_name" {
  value       = aws_lb.nlb.dns_name
  description = "The DNS name of the load balancer."
}

output "tg_id" {
  value       = aws_lb_target_group.tg.id
  description = "ARN of the Target Group (matches arn)."
}

output "tg_arn" {
  value       = aws_lb_target_group.tg.arn
  description = "ARN of the Target Group (matches id)."
}

output "tg_name" {
  value       = aws_lb_target_group.tg.name
  description = "Name of the Target Group."
}