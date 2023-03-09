data "aws_caller_identity" "current" {}

data "aws_network_interface" "privatelink_endpoint_eni" {
    for_each = aws_vpc_endpoint.idmz_to_edmz_endpoint.network_interface_ids
    id = each.value
}