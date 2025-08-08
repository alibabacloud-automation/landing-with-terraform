## Introduction
<!-- DOCS_DESCRIPTION_CN -->
本示例用于实现解决方案[ALB 实现跨地域负载均衡](https://www.aliyun.com/solution/tech-solution/alb-acrlb), 涉及到涉及到专有网络（VPC）、交换机（VSwitch）、云服务器（ECS）、云企业网(CEN)、应用型负载均衡（ALB）等资源的创建。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example demonstrates the implementation of the solution [Implementing Cross-Region Load Balancing with ALB](https://www.aliyun.com/solution/tech-solution/alb-acrlb). It involves the creation, configuration, and deployment of resources such as Virtual Private Cloud (VPC), VSwitch, Elastic Compute Service (ECS), Cloud Enterprise Network (CEN), Application Load Balancer (ALB).
<!-- DOCS_DESCRIPTION_EN -->

<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | n/a |
| <a name="provider_alicloud.region1"></a> [alicloud.region1](#provider\_alicloud.region1) | n/a |
| <a name="provider_alicloud.region2"></a> [alicloud.region2](#provider\_alicloud.region2) | n/a |
| <a name="provider_alicloud.region3"></a> [alicloud.region3](#provider\_alicloud.region3) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_alb"></a> [alb](#module\_alb) | ./alb | n/a |
| <a name="module_ecs1"></a> [ecs1](#module\_ecs1) | ./ecs | n/a |
| <a name="module_ecs2"></a> [ecs2](#module\_ecs2) | ./ecs | n/a |
| <a name="module_ecs3"></a> [ecs3](#module\_ecs3) | ./ecs | n/a |
| <a name="module_vpc1"></a> [vpc1](#module\_vpc1) | ./vpc | n/a |
| <a name="module_vpc2"></a> [vpc2](#module\_vpc2) | ./vpc | n/a |
| <a name="module_vpc3"></a> [vpc3](#module\_vpc3) | ./vpc | n/a |

## Resources

| Name | Type |
|------|------|
| [alicloud_cen_instance.cen](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_instance) | resource |
| [alicloud_cen_transit_router.tr1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router) | resource |
| [alicloud_cen_transit_router.tr2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router) | resource |
| [alicloud_cen_transit_router.tr3](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router) | resource |
| [alicloud_cen_transit_router_peer_attachment.peer12_attachment](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_peer_attachment) | resource |
| [alicloud_cen_transit_router_peer_attachment.peer13_attachment](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_peer_attachment) | resource |
| [alicloud_cen_transit_router_route_entry.tr1_route_entry](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_entry) | resource |
| [alicloud_cen_transit_router_route_table.tr1_route_table](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_table) | resource |
| [alicloud_cen_transit_router_route_table.tr2_route_table](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_table) | resource |
| [alicloud_cen_transit_router_route_table.tr3_route_table](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_table) | resource |
| [alicloud_cen_transit_router_route_table_association.tr1_association12](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_table_association) | resource |
| [alicloud_cen_transit_router_route_table_association.tr1_association13](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_table_association) | resource |
| [alicloud_cen_transit_router_route_table_association.tr1_association21](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_table_association) | resource |
| [alicloud_cen_transit_router_route_table_association.tr1_association31](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_table_association) | resource |
| [alicloud_cen_transit_router_route_table_association.tr1_table_association](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_table_association) | resource |
| [alicloud_cen_transit_router_route_table_association.tr2_table_association](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_table_association) | resource |
| [alicloud_cen_transit_router_route_table_association.tr3_table_association](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_table_association) | resource |
| [alicloud_cen_transit_router_route_table_propagation.tr1_propagation12](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_table_propagation) | resource |
| [alicloud_cen_transit_router_route_table_propagation.tr1_propagation13](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_table_propagation) | resource |
| [alicloud_cen_transit_router_route_table_propagation.tr1_propagation21](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_table_propagation) | resource |
| [alicloud_cen_transit_router_route_table_propagation.tr1_propagation31](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_table_propagation) | resource |
| [alicloud_cen_transit_router_route_table_propagation.tr1_table_propagation](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_table_propagation) | resource |
| [alicloud_cen_transit_router_route_table_propagation.tr2_table_propagation](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_table_propagation) | resource |
| [alicloud_cen_transit_router_route_table_propagation.tr3_table_propagation](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_table_propagation) | resource |
| [alicloud_cen_transit_router_vpc_attachment.vpc_att1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_vpc_attachment) | resource |
| [alicloud_cen_transit_router_vpc_attachment.vpc_att2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_vpc_attachment) | resource |
| [alicloud_cen_transit_router_vpc_attachment.vpc_att3](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_vpc_attachment) | resource |
| [alicloud_route_entry.vpc1_route_entry](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/route_entry) | resource |
| [alicloud_route_entry.vpc2_route_entry](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/route_entry) | resource |
| [alicloud_route_entry.vpc3_route_entry](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/route_entry) | resource |
| [alicloud_cen_transit_router_service.open](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/cen_transit_router_service) | data source |
| [alicloud_instance_types.types1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/instance_types) | data source |
| [alicloud_instance_types.types2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/instance_types) | data source |
| [alicloud_instance_types.types3](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/instance_types) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ecs_password"></a> [ecs\_password](#input\_ecs\_password) | ECS instance password | `string` | n/a | yes |
| <a name="input_region1"></a> [region1](#input\_region1) | Region ID | `string` | `"cn-chengdu"` | no |
| <a name="input_region2"></a> [region2](#input\_region2) | Region ID | `string` | `"cn-shanghai"` | no |
| <a name="input_region3"></a> [region3](#input\_region3) | Region ID | `string` | `"cn-qingdao"` | no |
| <a name="input_system_disk_category"></a> [system\_disk\_category](#input\_system\_disk\_category) | System disk category | `string` | `"cloud_essd_entry"` | no |
| <a name="input_zone11_id"></a> [zone11\_id](#input\_zone11\_id) | zone11 ID | `string` | `"cn-chengdu-a"` | no |
| <a name="input_zone12_id"></a> [zone12\_id](#input\_zone12\_id) | zone12 ID | `string` | `"cn-chengdu-b"` | no |
| <a name="input_zone21_id"></a> [zone21\_id](#input\_zone21\_id) | zone21 ID | `string` | `"cn-shanghai-e"` | no |
| <a name="input_zone22_id"></a> [zone22\_id](#input\_zone22\_id) | zone22 ID | `string` | `"cn-shanghai-f"` | no |
| <a name="input_zone31_id"></a> [zone31\_id](#input\_zone31\_id) | zone31 ID | `string` | `"cn-qingdao-c"` | no |
| <a name="input_zone32_id"></a> [zone32\_id](#input\_zone32\_id) | zone32 ID | `string` | `"cn-qingdao-b"` | no |
<!-- END_TF_DOCS -->