## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于实现解决方案[通过私网安全高效访问 AI 模型服务](https://www.aliyun.com/solution/tech-solution/access-model-services-over-private-networks), 涉及到专有网络VPC、虚拟交换机vSwitch、云服务器ECS、云企业网CEN、阿里云百炼服务、私网连接PrivateLink等资源的部署。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to implement solution [Securely and Efficiently Access AI Model Services via Private Network](https://www.aliyun.com/solution/tech-solution/access-model-services-over-private-networks), which involves the creation and deployment of resources such as Virtual Private Cloud (VPC), vSwitch, Elastic Compute Service (ECS), Cloud Enterprise Network (CEN), Bailian AI Service, and PrivateLink.
<!-- DOCS_DESCRIPTION_EN -->


<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | n/a |
| <a name="provider_alicloud.region_beijing"></a> [alicloud.region\_beijing](#provider\_alicloud.region\_beijing) | n/a |
| <a name="provider_alicloud.region_hangzhou"></a> [alicloud.region\_hangzhou](#provider\_alicloud.region\_hangzhou) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_cen_instance.cen](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_instance) | resource |
| [alicloud_cen_transit_router.bj-tr](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router) | resource |
| [alicloud_cen_transit_router.hz-tr](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router) | resource |
| [alicloud_cen_transit_router_peer_attachment.cen-tr-peer-attachment](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_peer_attachment) | resource |
| [alicloud_cen_transit_router_route_table_association.bj_peer_attachment](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_table_association) | resource |
| [alicloud_cen_transit_router_route_table_association.bj_vpc_attachment](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_table_association) | resource |
| [alicloud_cen_transit_router_route_table_association.hz_peer_attachment](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_table_association) | resource |
| [alicloud_cen_transit_router_route_table_association.hz_vpc_attachment](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_table_association) | resource |
| [alicloud_cen_transit_router_route_table_propagation.bj_peer_propagation](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_table_propagation) | resource |
| [alicloud_cen_transit_router_route_table_propagation.bj_vpc_propagation](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_table_propagation) | resource |
| [alicloud_cen_transit_router_route_table_propagation.hz_peer_propagation](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_table_propagation) | resource |
| [alicloud_cen_transit_router_route_table_propagation.hz_vpc_propagation](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_table_propagation) | resource |
| [alicloud_cen_transit_router_vpc_attachment.bj_vpc_attachment](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_vpc_attachment) | resource |
| [alicloud_cen_transit_router_vpc_attachment.hz_vpc_attachment](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_vpc_attachment) | resource |
| [alicloud_instance.ecs_hz](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_privatelink_vpc_endpoint.dashscope_endpoint](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/privatelink_vpc_endpoint) | resource |
| [alicloud_privatelink_vpc_endpoint_zone.zone1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/privatelink_vpc_endpoint_zone) | resource |
| [alicloud_privatelink_vpc_endpoint_zone.zone2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/privatelink_vpc_endpoint_zone) | resource |
| [alicloud_pvtz_zone.dashscope_pvtz_zone](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/pvtz_zone) | resource |
| [alicloud_pvtz_zone_attachment.hz_vpc_attachment](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/pvtz_zone_attachment) | resource |
| [alicloud_pvtz_zone_record.dashscope_cname_record](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/pvtz_zone_record) | resource |
| [alicloud_security_group.sg_bj](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_security_group.sg_hz](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_security_group_rule.allow_workbench](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_security_group_rule.http_ingress_rule](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_security_group_rule.https_ingress_rule](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_vpc.vpc_bj](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vpc.vpc_hz](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.vsw1_bj](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.vsw1_hz](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.vsw2_bj](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.vsw2_hz](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [random_id.suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [alicloud_cen_transit_router_route_tables.bj-tr-rt](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/cen_transit_router_route_tables) | data source |
| [alicloud_cen_transit_router_route_tables.hz-tr-rt](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/cen_transit_router_route_tables) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bj_zone_id1"></a> [bj\_zone\_id1](#input\_bj\_zone\_id1) | 北京可用区1 | `string` | `"cn-beijing-l"` | no |
| <a name="input_bj_zone_id2"></a> [bj\_zone\_id2](#input\_bj\_zone\_id2) | 北京可用区2 | `string` | `"cn-beijing-k"` | no |
| <a name="input_ecs_instance_password"></a> [ecs\_instance\_password](#input\_ecs\_instance\_password) | 服务器登录密码，长度8-30，必须包含三项（大写字母、小写字母、数字、特殊符号） | `string` | n/a | yes |
| <a name="input_hz_zone_id1"></a> [hz\_zone\_id1](#input\_hz\_zone\_id1) | 杭州可用区1 | `string` | `"cn-hangzhou-j"` | no |
| <a name="input_hz_zone_id2"></a> [hz\_zone\_id2](#input\_hz\_zone\_id2) | 杭州可用区2 | `string` | `"cn-hangzhou-k"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | ECS实例规格 | `string` | `"ecs.e-c1m2.large"` | no |
<!-- END_TF_DOCS -->