## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例使用转发路由器实现跨地域VPC间的IPv6网络通信。
详情可查看[使用企业版转发路由器实现跨地域VPC间的IPv6网络通信](https://help.aliyun.com/zh/cen/use-cases/use-the-enterprise-edition-transit-router-to-enable-ipv6-network-communication-between-vpcs-in-different-regions)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
The example use Enterprise Edition transit routers to establish IPv6 communication among VPCs in different regions.
More details in [Use Enterprise Edition transit routers to establish IPv6 communication among VPCs in different regions](https://www.alibabacloud.com/help/en/cen/use-cases/use-the-enterprise-edition-transit-router-to-enable-ipv6-network-communication-between-vpcs-in-different-regions).
<!-- DOCS_DESCRIPTION_EN -->



<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | n/a |
| <a name="provider_alicloud.hangzhou"></a> [alicloud.hangzhou](#provider\_alicloud.hangzhou) | n/a |
| <a name="provider_alicloud.shanghai"></a> [alicloud.shanghai](#provider\_alicloud.shanghai) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_cen_instance.cen1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_instance) | resource |
| [alicloud_cen_transit_router.tr1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router) | resource |
| [alicloud_cen_transit_router.tr2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router) | resource |
| [alicloud_cen_transit_router_peer_attachment.peer](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_peer_attachment) | resource |
| [alicloud_cen_transit_router_route_table_association.ass1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_table_association) | resource |
| [alicloud_cen_transit_router_route_table_association.ass2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_table_association) | resource |
| [alicloud_cen_transit_router_route_table_association.ass_peer1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_table_association) | resource |
| [alicloud_cen_transit_router_route_table_association.ass_peer2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_table_association) | resource |
| [alicloud_cen_transit_router_route_table_propagation.propa1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_table_propagation) | resource |
| [alicloud_cen_transit_router_route_table_propagation.propa2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_table_propagation) | resource |
| [alicloud_cen_transit_router_route_table_propagation.propa_peer1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_table_propagation) | resource |
| [alicloud_cen_transit_router_route_table_propagation.propa_peer2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_table_propagation) | resource |
| [alicloud_cen_transit_router_vpc_attachment.attach1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_vpc_attachment) | resource |
| [alicloud_cen_transit_router_vpc_attachment.attach2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_vpc_attachment) | resource |
| [alicloud_instance.ecs1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_instance.ecs2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_route_entry.vpc1_to_tr1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/route_entry) | resource |
| [alicloud_route_entry.vpc2_to_tr2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/route_entry) | resource |
| [alicloud_security_group.sg1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_security_group.sg2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_security_group_rule.allow_inbound_icmp1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_security_group_rule.allow_inbound_icmp2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_security_group_rule.allow_inbound_ipv6_icmp1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_security_group_rule.allow_inbound_ipv6_icmp2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_security_group_rule.allow_inbound_ssh1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_security_group_rule.allow_inbound_ssh2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_vpc.vpc1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vpc.vpc2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.vsw1-1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.vsw1-2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.vsw2-1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.vsw2-2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_cen_transit_router_route_tables.tr1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/cen_transit_router_route_tables) | data source |
| [alicloud_cen_transit_router_route_tables.tr2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/cen_transit_router_route_tables) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr_list"></a> [cidr\_list](#input\_cidr\_list) | The list of Private CIDR block | `list(string)` | <pre>[<br/>  "10.0.0.0/8",<br/>  "172.16.0.0/12",<br/>  "192.168.0.0/16"<br/>]</pre> | no |
| <a name="input_default_region_id"></a> [default\_region\_id](#input\_default\_region\_id) | The default region id | `string` | `"cn-hangzhou"` | no |
| <a name="input_hangzhou_az_list"></a> [hangzhou\_az\_list](#input\_hangzhou\_az\_list) | List of availability zones to use | `list(string)` | <pre>[<br/>  "cn-hangzhou-j",<br/>  "cn-hangzhou-k"<br/>]</pre> | no |
| <a name="input_hangzhou_region_id"></a> [hangzhou\_region\_id](#input\_hangzhou\_region\_id) | The hangzhou region id | `string` | `"cn-hangzhou"` | no |
| <a name="input_pname"></a> [pname](#input\_pname) | The prefix name for resources | `string` | `"tf-CenIpv6"` | no |
| <a name="input_shanghai_az_list"></a> [shanghai\_az\_list](#input\_shanghai\_az\_list) | List of availability zones to use | `list(string)` | <pre>[<br/>  "cn-shanghai-m",<br/>  "cn-shanghai-n"<br/>]</pre> | no |
| <a name="input_shanghai_region_id"></a> [shanghai\_region\_id](#input\_shanghai\_region\_id) | The shanghai region id | `string` | `"cn-shanghai"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Use Enterprise Edition transit routers to establish IPv6 communication among VPCs in different regions](https://www.alibabacloud.com/help/en/cen/use-cases/use-the-enterprise-edition-transit-router-to-enable-ipv6-network-communication-between-vpcs-in-different-regions)

<!-- docs-link --> 