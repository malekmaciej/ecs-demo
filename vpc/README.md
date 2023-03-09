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
| [aws_eip.eip-01](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_eip.eip-02](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_internet_gateway.igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.nat-1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_nat_gateway.nat-2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route.rt-1-igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.rt-2-igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.rt-3-igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.private-01](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.private-02](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.private-03](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.public-1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.public-2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.private-01](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.private-02](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.private-03](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public-1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public-2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_security_group.sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_subnet.private-1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.private-2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.private-3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public-1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public-2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | Common resource tags | `map(string)` | `{}` | no |
| <a name="input_gateway_endpoints_to_create"></a> [gateway\_endpoints\_to\_create](#input\_gateway\_endpoints\_to\_create) | Set of AWS Service names to create VPC Endpoints for | `set(string)` | <pre>[<br>  "s3"<br>]</pre> | no |
| <a name="input_igw_enabled"></a> [igw\_enabled](#input\_igw\_enabled) | Set true to create Internet Gateway | `bool` | n/a | yes |
| <a name="input_interface_endpoints_to_create"></a> [interface\_endpoints\_to\_create](#input\_interface\_endpoints\_to\_create) | Set of AWS Service names to create VPC Endpoints for | `set(string)` | <pre>[<br>  "logs",<br>  "monitoring",<br>  "ecs",<br>  "ecr.dkr",<br>  "ecr.api",<br>  "ssm"<br>]</pre> | no |
| <a name="input_region"></a> [region](#input\_region) | Name of the region where deploying | `string` | n/a | yes |
| <a name="input_subnet_prefix"></a> [subnet\_prefix](#input\_subnet\_prefix) | Map of subnets with defined az and cidr | `map(any)` | <pre>{<br>  "subnet-1": {<br>    "az": "eu-central-2a",<br>    "cidr": "10.0.1.0/24"<br>  },<br>  "subnet-2": {<br>    "az": "eu-central-2b",<br>    "cidr": "10.0.2.0/24"<br>  },<br>  "subnet-3": {<br>    "az": "eu-central-2c",<br>    "cidr": "10.0.0.0/24"<br>  }<br>}</pre> | no |
| <a name="input_subnet_prefix_public"></a> [subnet\_prefix\_public](#input\_subnet\_prefix\_public) | Map of public subnets with defined az and cidr | `map(any)` | <pre>{<br>  "public-subnet-1": {<br>    "az": "eu-central-2a",<br>    "cidr": "10.0.3.0/24"<br>  },<br>  "public-subnet-2": {<br>    "az": "eu-central-2b",<br>    "cidr": "10.0.4.0/24"<br>  }<br>}</pre> | no |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | The primary IPv4 CIDR block for the VPC. | `string` | `"10.0.0.0/16"` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | Name for the VPC | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_security_group_id"></a> [aws\_security\_group\_id](#output\_aws\_security\_group\_id) | ID of Security Group |
| <a name="output_route_table_private_1_id"></a> [route\_table\_private\_1\_id](#output\_route\_table\_private\_1\_id) | ID of Route Table for Private Subnet 1 |
| <a name="output_route_table_private_2_id"></a> [route\_table\_private\_2\_id](#output\_route\_table\_private\_2\_id) | ID of Route Table for Private Subnet 2 |
| <a name="output_subnet_1_id"></a> [subnet\_1\_id](#output\_subnet\_1\_id) | ID of Private Subnet 1 |
| <a name="output_subnet_2_id"></a> [subnet\_2\_id](#output\_subnet\_2\_id) | ID of Private Subnet 2 |
| <a name="output_subnet_3_id"></a> [subnet\_3\_id](#output\_subnet\_3\_id) | ID of Private Subnet 3 |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | ID of VPC |
