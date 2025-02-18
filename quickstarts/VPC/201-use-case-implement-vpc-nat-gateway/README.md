## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上通过Terraform实现VPC NAT网关，以解决VPC地址冲突时的私网访问问题。
详情可查看[通过Terraform实现VPC NAT网关，以解决VPC地址冲突时的私网访问问题](https://help.aliyun.com/zh/nat-gateway/getting-started/access-when-vpc-addresses-conflict-through-vpc-nat-gateway?spm=a2c4g.11186623.help-menu-44413.d_1_1.7eacdf64ZDZMdt)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to implement the VPC NAT gateway to solve the problem of private network access when VPC addresses conflict on Alibaba Cloud.
More details in [Implement VPC NAT Gateway](https://help.aliyun.com/zh/nat-gateway/getting-started/access-when-vpc-addresses-conflict-through-vpc-nat-gateway?spm=a2c4g.11186623.help-menu-44413.d_1_1.7eacdf64ZDZMdt).
<!-- DOCS_DESCRIPTION_EN -->

<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_cen_instance.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_instance) | resource |
| [alicloud_cen_transit_router.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router) | resource |
| [alicloud_cen_transit_router_route_table_association.a](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_table_association) | resource |
| [alicloud_cen_transit_router_route_table_association.b](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_table_association) | resource |
| [alicloud_cen_transit_router_route_table_propagation.a](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_table_propagation) | resource |
| [alicloud_cen_transit_router_route_table_propagation.b](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_table_propagation) | resource |
| [alicloud_cen_transit_router_vpc_attachment.a](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_vpc_attachment) | resource |
| [alicloud_cen_transit_router_vpc_attachment.b](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_vpc_attachment) | resource |
| [alicloud_forward_entry.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/forward_entry) | resource |
| [alicloud_instance.a](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_instance.b](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_nat_gateway.a](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/nat_gateway) | resource |
| [alicloud_nat_gateway.b](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/nat_gateway) | resource |
| [alicloud_route_entry.a](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/route_entry) | resource |
| [alicloud_route_entry.aa](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/route_entry) | resource |
| [alicloud_route_entry.b](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/route_entry) | resource |
| [alicloud_route_entry.bb](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/route_entry) | resource |
| [alicloud_route_table.a](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/route_table) | resource |
| [alicloud_route_table.b](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/route_table) | resource |
| [alicloud_route_table_attachment.a](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/route_table_attachment) | resource |
| [alicloud_route_table_attachment.b](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/route_table_attachment) | resource |
| [alicloud_security_group.a](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_security_group.b](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_security_group_rule.a](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_security_group_rule.b](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_snat_entry.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/snat_entry) | resource |
| [alicloud_vpc.a](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vpc.b](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vpc_ipv4_cidr_block.a](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc_ipv4_cidr_block) | resource |
| [alicloud_vpc_ipv4_cidr_block.b](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc_ipv4_cidr_block) | resource |
| [alicloud_vswitch.a1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.a2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.b1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.b2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_cen_transit_router_route_tables.cen_route_table_id](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/cen_transit_router_route_tables) | data source |
| [alicloud_images.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/images) | data source |
| [alicloud_instance_types.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/instance_types) | data source |
| [alicloud_vpc_nat_ips.nat_ips_a](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/vpc_nat_ips) | data source |
| [alicloud_vpc_nat_ips.nat_ips_b](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/vpc_nat_ips) | data source |
| [alicloud_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_master_zone"></a> [master\_zone](#input\_master\_zone) | n/a | `string` | `"cn-beijing-h"` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"nat-test"` | no |
| <a name="input_password"></a> [password](#input\_password) | n/a | `string` | `"Test123@"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-beijing"` | no |
| <a name="input_slave_zone"></a> [slave\_zone](#input\_slave\_zone) | n/a | `string` | `"cn-beijing-k"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Implement VPC NAT Gateway](https://help.aliyun.com/zh/nat-gateway/getting-started/access-when-vpc-addresses-conflict-through-vpc-nat-gateway?spm=a2c4g.11186623.help-menu-44413.d_1_1.7eacdf64ZDZMdt) 

<!-- docs-link --> 