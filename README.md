## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.9 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.57.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_edmz-ecr"></a> [edmz-ecr](#module\_edmz-ecr) | ./ecr | n/a |
| <a name="module_edmz-ecs"></a> [edmz-ecs](#module\_edmz-ecs) | ./ecs | n/a |
| <a name="module_edmz-nlb"></a> [edmz-nlb](#module\_edmz-nlb) | ./nlb | n/a |
| <a name="module_edmz_vpc"></a> [edmz\_vpc](#module\_edmz\_vpc) | ./vpc | n/a |
| <a name="module_idmz-nlb"></a> [idmz-nlb](#module\_idmz-nlb) | ./nlb | n/a |
| <a name="module_idmz_vpc"></a> [idmz\_vpc](#module\_idmz\_vpc) | ./vpc | n/a |
| <a name="module_internal-ecr"></a> [internal-ecr](#module\_internal-ecr) | ./ecr | n/a |
| <a name="module_internal_vpc"></a> [internal\_vpc](#module\_internal\_vpc) | ./vpc | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_vpc_endpoint.idmz_to_edmz_endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint_service.edmz_service_endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint_service) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_network_interface.privatelink_endpoint_eni](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/network_interface) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | Default tags attached to all resources | `map(any)` | <pre>{<br>  "repo_name": "https://github.com/malekmaciej/ecs-demo.git",<br>  "terraform": "true"<br>}</pre> | no |

## Outputs

No outputs.
