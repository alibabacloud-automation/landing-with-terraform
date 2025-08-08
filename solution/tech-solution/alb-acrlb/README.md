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

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ecs1_instance_type"></a> [ecs1\_instance\_type](#input\_ecs1\_instance\_type) | ECS1 instance type | `string` | `"ecs.t5-lc1m1.small"` | no |
| <a name="input_ecs1_system_disk_category"></a> [ecs1\_system\_disk\_category](#input\_ecs1\_system\_disk\_category) | ECS1 system disk category | `string` | `"cloud_efficiency"` | no |
| <a name="input_ecs2_instance_type"></a> [ecs2\_instance\_type](#input\_ecs2\_instance\_type) | ECS2 instance type | `string` | `"ecs.t5-lc1m1.small"` | no |
| <a name="input_ecs2_system_disk_category"></a> [ecs2\_system\_disk\_category](#input\_ecs2\_system\_disk\_category) | ECS2 system disk category | `string` | `"cloud_efficiency"` | no |
| <a name="input_ecs3_instance_type"></a> [ecs3\_instance\_type](#input\_ecs3\_instance\_type) | ECS3 instance type | `string` | `"ecs.t5-lc1m1.small"` | no |
| <a name="input_ecs3_system_disk_category"></a> [ecs3\_system\_disk\_category](#input\_ecs3\_system\_disk\_category) | ECS3 system disk category | `string` | `"cloud_efficiency"` | no |
| <a name="input_ecs_password"></a> [ecs\_password](#input\_ecs\_password) | ECS instance password | `string` | `"Test12345!"` | no |
| <a name="input_region"></a> [region](#input\_region) | 地域 | `string` | `"cn-hangzhou"` | no |
<!-- END_TF_DOCS -->