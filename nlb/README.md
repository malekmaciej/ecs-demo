## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.9 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_lb.nlb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.listener](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.tg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_security_group.sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | Common resource tags | `map(string)` | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | Name for the Network Load Balancer | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Name of the region where deploying | `string` | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | List of subnets for Network Load Balancer Listeners | `list(any)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_nlb_arn"></a> [nlb\_arn](#output\_nlb\_arn) | The ARN of the load balancer (matches id). |
| <a name="output_nlb_dns_name"></a> [nlb\_dns\_name](#output\_nlb\_dns\_name) | The DNS name of the load balancer. |
| <a name="output_nlb_id"></a> [nlb\_id](#output\_nlb\_id) | The ARN of the load balancer (matches arn). |
| <a name="output_tg_arn"></a> [tg\_arn](#output\_tg\_arn) | ARN of the Target Group (matches id). |
| <a name="output_tg_id"></a> [tg\_id](#output\_tg\_id) | ARN of the Target Group (matches arn). |
| <a name="output_tg_name"></a> [tg\_name](#output\_tg\_name) | Name of the Target Group. |
