<!-- BEGIN_TF_DOCS -->
## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例基于阿里云洛神网络全球基础设施及云原生 SDN 技术，帮助企业客户在云上快速构建[两地三中心跨域多活网络](https://www.aliyun.com/solution/tech-solution/tltcamanidl)，保障企业核心业务在全球多地域的高品质互联。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is based on Alibaba Cloud's Luoshen Network global infrastructure and cloud-native SDN technology, helping enterprise customers quickly build a two-site, three-center cross-region active-active network on the cloud, ensuring high-quality interconnection for enterprise core businesses across multiple global regions.
<!-- DOCS_DESCRIPTION_EN -->


<!-- BEGIN_TF_DOCS -->

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | n/a |
| <a name="provider_alicloud.user1_region1"></a> [alicloud.user1\_region1](#provider\_alicloud.user1\_region1) | n/a |
| <a name="provider_alicloud.user1_region2"></a> [alicloud.user1\_region2](#provider\_alicloud.user1\_region2) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_alb_listener.listener1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/alb_listener) | resource |
| [alicloud_alb_listener.listener2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/alb_listener) | resource |
| [alicloud_alb_load_balancer.alb1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/alb_load_balancer) | resource |
| [alicloud_alb_load_balancer.alb2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/alb_load_balancer) | resource |
| [alicloud_alb_server_group.server_group1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/alb_server_group) | resource |
| [alicloud_alb_server_group.server_group2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/alb_server_group) | resource |
| [alicloud_cen_instance.cen](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_instance) | resource |
| [alicloud_cen_transit_router.tr1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router) | resource |
| [alicloud_cen_transit_router.tr2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router) | resource |
| [alicloud_cen_transit_router_peer_attachment.user2_peer_attachment](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_peer_attachment) | resource |
| [alicloud_cen_transit_router_route_entry.route_entry1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_entry) | resource |
| [alicloud_cen_transit_router_route_entry.route_entry2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_entry) | resource |
| [alicloud_cen_transit_router_route_table.route_table1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_table) | resource |
| [alicloud_cen_transit_router_route_table.route_table2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_table) | resource |
| [alicloud_cen_transit_router_route_table_association.association1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_table_association) | resource |
| [alicloud_cen_transit_router_route_table_association.association2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_table_association) | resource |
| [alicloud_cen_transit_router_route_table_association.association3](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_table_association) | resource |
| [alicloud_cen_transit_router_route_table_association.association4](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_table_association) | resource |
| [alicloud_cen_transit_router_route_table_propagation.propagation3](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_table_propagation) | resource |
| [alicloud_cen_transit_router_route_table_propagation.propagation4](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_table_propagation) | resource |
| [alicloud_cen_transit_router_vpc_attachment.vpc_att1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_vpc_attachment) | resource |
| [alicloud_cen_transit_router_vpc_attachment.vpc_att2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_vpc_attachment) | resource |
| [alicloud_dts_instance.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/dts_instance) | resource |
| [alicloud_ecs_command.cmd1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_command) | resource |
| [alicloud_ecs_command.cmd2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_command) | resource |
| [alicloud_ecs_invocation.default1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_invocation) | resource |
| [alicloud_ecs_invocation.default2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_invocation) | resource |
| [alicloud_ecs_invocation.default3](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_invocation) | resource |
| [alicloud_ecs_invocation.default4](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_invocation) | resource |
| [alicloud_instance.ecs1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_instance.ecs2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_instance.ecs3](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_instance.ecs4](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_polardb_account.polardb_account1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/polardb_account) | resource |
| [alicloud_polardb_account.polardb_account2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/polardb_account) | resource |
| [alicloud_polardb_account_privilege.privilege](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/polardb_account_privilege) | resource |
| [alicloud_polardb_account_privilege.privilege2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/polardb_account_privilege) | resource |
| [alicloud_polardb_cluster.polardb1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/polardb_cluster) | resource |
| [alicloud_polardb_cluster.polardb2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/polardb_cluster) | resource |
| [alicloud_polardb_database.polardb_database1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/polardb_database) | resource |
| [alicloud_polardb_database.polardb_database2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/polardb_database) | resource |
| [alicloud_route_entry.route_entry2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/route_entry) | resource |
| [alicloud_route_entry.user1_region1_route_entry](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/route_entry) | resource |
| [alicloud_security_group.group1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_security_group.group2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_security_group_rule.rule1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_security_group_rule.rule2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_vpc.vpc1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vpc.vpc2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.vsw1-1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.vsw1-2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.vsw2-1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.vsw2-2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_cen_transit_router_service.open](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/cen_transit_router_service) | data source |
| [alicloud_polardb_node_classes.data_polardb1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/polardb_node_classes) | data source |
| [alicloud_polardb_node_classes.data_polardb2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/polardb_node_classes) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_db_password"></a> [db\_password](#input\_db\_password) | Please enter the PolarDB database password. The password must be 8-32 characters long and include uppercase letters, lowercase letters, numbers, and special characters (e.g., !@#$%^&*()\_+-=). If repeating the configuration in this tutorial, please ensure that the MySQL database password is identical to the one set during the first execution of the template. Otherwise, the configuration result will be invalid. | `string` | n/a | yes |
| <a name="input_ecs_instance_password"></a> [ecs\_instance\_password](#input\_ecs\_instance\_password) | Please enter the ECS login password, with a length of 8-30 characters, and it must include three of the following: uppercase letters, lowercase letters, numbers, and special characters from ()`~!@#$%^&*_-+=|{}[]:;'<>,.?/.` | `string` | n/a | yes |
| <a name="input_polardb_account_name"></a> [polardb\_account\_name](#input\_polardb\_account\_name) | n/a | `string` | `"terraform"` | no |
| <a name="input_polardb_class"></a> [polardb\_class](#input\_polardb\_class) | n/a | `string` | `"polar.mysql.x4.large"` | no |
| <a name="input_region1"></a> [region1](#input\_region1) | n/a | `string` | `"cn-shanghai"` | no |
| <a name="input_region1_instance_type1"></a> [region1\_instance\_type1](#input\_region1\_instance\_type1) | n/a | `string` | `"ecs.g8i.large"` | no |
| <a name="input_region1_instance_type2"></a> [region1\_instance\_type2](#input\_region1\_instance\_type2) | n/a | `string` | `"ecs.g8i.large"` | no |
| <a name="input_region1_zone_id1"></a> [region1\_zone\_id1](#input\_region1\_zone\_id1) | n/a | `string` | `"cn-shanghai-e"` | no |
| <a name="input_region1_zone_id2"></a> [region1\_zone\_id2](#input\_region1\_zone\_id2) | n/a | `string` | `"cn-shanghai-f"` | no |
| <a name="input_region2"></a> [region2](#input\_region2) | n/a | `string` | `"cn-beijing"` | no |
| <a name="input_region2_instance_type1"></a> [region2\_instance\_type1](#input\_region2\_instance\_type1) | n/a | `string` | `"ecs.g7.large"` | no |
| <a name="input_region2_instance_type2"></a> [region2\_instance\_type2](#input\_region2\_instance\_type2) | n/a | `string` | `"ecs.g7.large"` | no |
| <a name="input_region2_zone_id1"></a> [region2\_zone\_id1](#input\_region2\_zone\_id1) | n/a | `string` | `"cn-beijing-k"` | no |
| <a name="input_region2_zone_id2"></a> [region2\_zone\_id2](#input\_region2\_zone\_id2) | n/a | `string` | `"cn-beijing-l"` | no |
<!-- END_TF_DOCS -->