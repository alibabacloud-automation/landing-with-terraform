## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于实现解决方案[企业云上网络架构规划](https://www.aliyun.com/solution/tech-solution/ecnap), 涉及到CEN、TR、VPC、vSwitch、ECS等资源的部署。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to implement solution [Enterprise Cloud Network Architecture Planning](https://www.aliyun.com/solution/tech-solution/ecnap), which involves the creation and deployment of resources such as cen, tr, vpc, vSwitch, and ecs.
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
| [alicloud_cen_instance.cen_instance](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_instance) | resource |
| [alicloud_cen_transit_router.transit_router](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router) | resource |
| [alicloud_cen_transit_router_route_entry.transit_router_route_entry](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_entry) | resource |
| [alicloud_cen_transit_router_route_table.transit_router_custom_route_table_1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_table) | resource |
| [alicloud_cen_transit_router_route_table.transit_router_custom_route_table_2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_table) | resource |
| [alicloud_cen_transit_router_route_table_association.transit_router_custom_route_table_1_association_prd1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_table_association) | resource |
| [alicloud_cen_transit_router_route_table_association.transit_router_custom_route_table_1_association_prd2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_table_association) | resource |
| [alicloud_cen_transit_router_route_table_association.transit_router_custom_route_table_1_association_prd3](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_table_association) | resource |
| [alicloud_cen_transit_router_route_table_association.transit_router_custom_route_table_2_association_sec](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_table_association) | resource |
| [alicloud_cen_transit_router_route_table_propagation.transit_router_custom_route_table_propagation_for_vpc_prd1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_table_propagation) | resource |
| [alicloud_cen_transit_router_route_table_propagation.transit_router_custom_route_table_propagation_for_vpc_prd2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_table_propagation) | resource |
| [alicloud_cen_transit_router_route_table_propagation.transit_router_custom_route_table_propagation_for_vpc_sec](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_table_propagation) | resource |
| [alicloud_cen_transit_router_vpc_attachment.transit_router_vpc_prd1_attachment](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_vpc_attachment) | resource |
| [alicloud_cen_transit_router_vpc_attachment.transit_router_vpc_prd2_attachment](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_vpc_attachment) | resource |
| [alicloud_cen_transit_router_vpc_attachment.transit_router_vpc_prd3_attachment](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_vpc_attachment) | resource |
| [alicloud_cen_transit_router_vpc_attachment.transit_router_vpc_sec_attachment](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_vpc_attachment) | resource |
| [alicloud_ecs_command.run_command](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_command) | resource |
| [alicloud_ecs_invocation.invoke_script](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_invocation) | resource |
| [alicloud_instance.ecs_instance_in_vpc_prd1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_instance.ecs_instance_in_vpc_prd2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_instance.ecs_instance_in_vpc_prd3](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_instance.ecs_instance_in_vpc_sec](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_route_entry.route_forward_to_cen](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/route_entry) | resource |
| [alicloud_route_entry.route_forward_to_ecs](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/route_entry) | resource |
| [alicloud_route_table.vpc_sec_custom_route_table_1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/route_table) | resource |
| [alicloud_route_table.vpc_sec_custom_route_table_2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/route_table) | resource |
| [alicloud_route_table_attachment.route_table_attachment_vswitch_sec_001](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/route_table_attachment) | resource |
| [alicloud_route_table_attachment.route_table_attachment_vswitch_sec_002](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/route_table_attachment) | resource |
| [alicloud_route_table_attachment.route_table_attachment_vswitch_sec_003](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/route_table_attachment) | resource |
| [alicloud_security_group.sg_for_vpc_prd1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_security_group.sg_for_vpc_prd2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_security_group.sg_for_vpc_prd3](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_security_group.sg_for_vpc_sec](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_security_group_rule.sg_rule_for_vpc_prd1_ingress_prd1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_security_group_rule.sg_rule_for_vpc_prd1_ingress_prd2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_security_group_rule.sg_rule_for_vpc_prd1_ingress_sec](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_security_group_rule.sg_rule_for_vpc_prd2_ingress_prd1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_security_group_rule.sg_rule_for_vpc_prd2_ingress_prd2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_security_group_rule.sg_rule_for_vpc_prd2_ingress_sec](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_security_group_rule.sg_rule_for_vpc_prd3_ingress_prd3](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_security_group_rule.sg_rule_for_vpc_sec_ingress_prd1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_security_group_rule.sg_rule_for_vpc_sec_ingress_prd2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_security_group_rule.sg_rule_for_vpc_sec_ingress_sec](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_vpc.vpc_prd1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vpc.vpc_prd2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vpc.vpc_prd3](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vpc.vpc_sec](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.vswitch_prd1_001](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.vswitch_prd1_002](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.vswitch_prd1_003](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.vswitch_prd2_001](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.vswitch_prd2_002](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.vswitch_prd2_003](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.vswitch_prd3_001](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.vswitch_prd3_002](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.vswitch_prd3_003](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.vswitch_sec_001](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.vswitch_sec_002](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.vswitch_sec_003](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_cen_transit_router_service.open](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/cen_transit_router_service) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ecs_instance_password"></a> [ecs\_instance\_password](#input\_ecs\_instance\_password) | 服务器登录密码,长度8-30，必须包含三项（大写字母、小写字母、数字、 ()`~!@#$%^&*_-+=|{}[]:;'<>,.?/ 中的特殊符号）` | `string` | n/a | yes |
| <a name="input_ecs_instance_type"></a> [ecs\_instance\_type](#input\_ecs\_instance\_type) | ECS实例规格 | `string` | `"ecs.t6-c4m1.large"` | no |
| <a name="input_region"></a> [region](#input\_region) | 资源部署地域 | `string` | `"cn-hangzhou"` | no |
| <a name="input_zone1"></a> [zone1](#input\_zone1) | 交换机可用区1 | `string` | `"cn-hangzhou-j"` | no |
| <a name="input_zone2"></a> [zone2](#input\_zone2) | 交换机可用区2，请确保交换机可用区2与交换机可用区1不相同 | `string` | `"cn-hangzhou-k"` | no |
<!-- END_TF_DOCS -->