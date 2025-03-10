## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例介绍如何通过转发路由器实现ECS私网访问跨地域的对象存储OSS。
详情可查看[通过企业版转发路由器实现ECS私网访问跨地域的OSS服务](https://help.aliyun.com/document_detail/478724.html)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
The example use transit routers to enable Elastic Compute Service (ECS) instances that are deployed in virtual private clouds (VPCs) to access Object Storage Service (OSS) across regions over VPC connections.
More details in [Use Enterprise Edition transit routers to enable ECS instances to access OSS across regions over VPC connections](https://help.aliyun.com/document_detail/478724.html).
<!-- DOCS_DESCRIPTION_EN -->

<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | n/a |
| <a name="provider_alicloud.hangzhou"></a> [alicloud.hangzhou](#provider\_alicloud.hangzhou) | n/a |
| <a name="provider_alicloud.shanghai"></a> [alicloud.shanghai](#provider\_alicloud.shanghai) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_cen_instance.cen1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_instance) | resource |
| [alicloud_cen_transit_router.tr1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router) | resource |
| [alicloud_cen_transit_router.tr2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router) | resource |
| [alicloud_cen_transit_router_peer_attachment.peer](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_peer_attachment) | resource |
| [alicloud_cen_transit_router_route_entry.tr2_rt1_entry1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_entry) | resource |
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
| [alicloud_instance.main](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_oss_bucket.bucket1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/oss_bucket) | resource |
| [alicloud_oss_bucket_object.obj1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/oss_bucket_object) | resource |
| [alicloud_oss_bucket_policy.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/oss_bucket_policy) | resource |
| [alicloud_route_entry.entry](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/route_entry) | resource |
| [alicloud_route_entry.vpc1_to_tr1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/route_entry) | resource |
| [alicloud_route_entry.vpc2_to_tr2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/route_entry) | resource |
| [alicloud_security_group.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_security_group_rule.allow_inbound_icmp](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_security_group_rule.allow_inbound_ssh](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_vpc.vpc1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vpc.vpc2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.vsw1-1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.vsw1-2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.vsw2-1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.vsw2-2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [random_uuid.default](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) | resource |
| [alicloud_cen_transit_router_route_tables.tr1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/cen_transit_router_route_tables) | data source |
| [alicloud_cen_transit_router_route_tables.tr2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/cen_transit_router_route_tables) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_az_hangzhou"></a> [az\_hangzhou](#input\_az\_hangzhou) | List of availability zones to use | `list(string)` | <pre>[<br/>  "cn-hangzhou-j",<br/>  "cn-hangzhou-k"<br/>]</pre> | no |
| <a name="input_az_shanghai"></a> [az\_shanghai](#input\_az\_shanghai) | List of availability zones to use | `list(string)` | <pre>[<br/>  "cn-shanghai-m",<br/>  "cn-shanghai-n"<br/>]</pre> | no |
| <a name="input_cidr_list"></a> [cidr\_list](#input\_cidr\_list) | List of VPC CIDR block | `list(string)` | <pre>[<br/>  "10.0.0.0/8",<br/>  "172.16.0.0/12",<br/>  "192.168.0.0/16"<br/>]</pre> | no |
| <a name="input_oss_cidr"></a> [oss\_cidr](#input\_oss\_cidr) | The OSS CIDR block | `list(string)` | <pre>[<br/>  "100.118.28.0/24",<br/>  "100.114.102.0/24",<br/>  "100.98.170.0/24",<br/>  "100.118.31.0/24"<br/>]</pre> | no |
| <a name="input_pname"></a> [pname](#input\_pname) | The prefix name for resources | `string` | `"tf-cen-oss"` | no |
| <a name="input_region_id_hangzhou"></a> [region\_id\_hangzhou](#input\_region\_id\_hangzhou) | The region id of hangzhou | `string` | `"cn-hangzhou"` | no |
| <a name="input_region_id_shanghai"></a> [region\_id\_shanghai](#input\_region\_id\_shanghai) | The region id of shanghai | `string` | `"cn-shanghai"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Use Enterprise Edition transit routers to enable ECS instances to access OSS across regions over VPC connections](https://help.aliyun.com/document_detail/478724.html)

<!-- docs-link --> 