## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例会在阿里云上创建3个VPC：VPC1、VPC2、VPC3，其中VPC2和VPC3之间的互访流量通过转发路由器引导至VPC1进行过滤。
详情可查看[使用企业版转发路由器实现流量安全互访](https://help.aliyun.com/zh/cen/use-cases/use-an-enterprise-edition-transit-router-to-enable-and-secure-network-communication)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
The example will create 3 VPCs on Alibaba Cloud: VPC1, VPC2, and VPC3, where the traffic between VPC2 and VPC3 is routed through transit router to VPC1 for filtering.
More details in [Use an Enterprise Edition transit router to establish and secure network communication
](https://www.alibabacloud.com/help/en/cen/use-cases/use-an-enterprise-edition-transit-router-to-enable-and-secure-network-communication).
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
| [alicloud_cen_instance.cen1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_instance) | resource |
| [alicloud_cen_transit_router.tr1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router) | resource |
| [alicloud_cen_transit_router_route_entry.tr_rt1_entry1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_entry) | resource |
| [alicloud_cen_transit_router_route_entry.tr_rt2_entry1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_entry) | resource |
| [alicloud_cen_transit_router_route_entry.tr_rt2_entry2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_entry) | resource |
| [alicloud_cen_transit_router_route_table.tr_rt1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_table) | resource |
| [alicloud_cen_transit_router_route_table.tr_rt2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_table) | resource |
| [alicloud_cen_transit_router_route_table_association.ass1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_table_association) | resource |
| [alicloud_cen_transit_router_route_table_association.ass2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_table_association) | resource |
| [alicloud_cen_transit_router_route_table_association.ass3](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_table_association) | resource |
| [alicloud_cen_transit_router_vpc_attachment.attach1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_vpc_attachment) | resource |
| [alicloud_cen_transit_router_vpc_attachment.attach2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_vpc_attachment) | resource |
| [alicloud_cen_transit_router_vpc_attachment.attach3](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_vpc_attachment) | resource |
| [alicloud_instance.main](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_route_entry.rt-entry1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/route_entry) | resource |
| [alicloud_route_entry.rt-entry2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/route_entry) | resource |
| [alicloud_route_entry.rt-entry3](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/route_entry) | resource |
| [alicloud_route_entry.rt-entry4](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/route_entry) | resource |
| [alicloud_route_entry.rt-entry5](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/route_entry) | resource |
| [alicloud_route_table.rt](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/route_table) | resource |
| [alicloud_route_table_attachment.rt_attach](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/route_table_attachment) | resource |
| [alicloud_security_group.main](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_security_group_rule.allow_all_outbound](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_security_group_rule.allow_inbound_icmp](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_security_group_rule.allow_inbound_ssh](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_vpc.main](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.main](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_az"></a> [az](#input\_az) | List of availability zones to use | `list(string)` | <pre>[<br/>  "cn-hangzhou-i",<br/>  "cn-hangzhou-j",<br/>  "cn-hangzhou-k"<br/>]</pre> | no |
| <a name="input_default_region"></a> [default\_region](#input\_default\_region) | Default region | `string` | `"cn-hangzhou"` | no |
| <a name="input_pname"></a> [pname](#input\_pname) | The prefix name for the resources | `string` | `"tf-CenSec"` | no |
| <a name="input_vpc_count"></a> [vpc\_count](#input\_vpc\_count) | Number of VPCs to create | `number` | `3` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Use an Enterprise Edition transit router to establish and secure network communication
](https://www.alibabacloud.com/help/en/cen/use-cases/use-an-enterprise-edition-transit-router-to-enable-and-secure-network-communication) 

<!-- docs-link --> 