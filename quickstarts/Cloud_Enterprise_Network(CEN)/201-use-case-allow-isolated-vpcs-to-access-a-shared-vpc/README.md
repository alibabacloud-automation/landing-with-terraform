## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例会在阿里云上创建3个VPC：VPC1、VPC2、VPC3，其中VPC3为共享VPC。通过转发路由器，实现VPC1和VPC2均能访问VPC3使用共享服务，而VPC1和VPC2之间不互通。
详情可查看[隔离VPC使用共享服务](https://help.aliyun.com/zh/cen/use-cases/allow-isolated-vpcs-to-access-a-shared-vpc)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
The example will create 3 VPCs on Alibaba Cloud: VPC1, VPC2, and VPC3, with VPC3 being a shared VPC. By using a transit router, both VPC1 and VPC2 can access shared services in VPC3, while VPC1 and VPC2 remain isolated from each other in terms of network connectivity.
More details in [Allow isolated VPCs to access a shared VPC](https://www.alibabacloud.com/help/en/cen/use-cases/allow-isolated-vpcs-to-access-a-shared-vpc).
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
| [alicloud_cen_instance.cen](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_instance) | resource |
| [alicloud_cen_transit_router.tr](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router) | resource |
| [alicloud_cen_transit_router_route_entry.tr_entry](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_entry) | resource |
| [alicloud_cen_transit_router_route_table.custom_table](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_table) | resource |
| [alicloud_cen_transit_router_route_table_association.ass1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_table_association) | resource |
| [alicloud_cen_transit_router_route_table_association.ass2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_table_association) | resource |
| [alicloud_cen_transit_router_route_table_association.ass3](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_table_association) | resource |
| [alicloud_cen_transit_router_route_table_propagation.propa](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_table_propagation) | resource |
| [alicloud_cen_transit_router_vpc_attachment.attach](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_vpc_attachment) | resource |
| [alicloud_instance.ecs](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_route_entry.vpc_entry](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/route_entry) | resource |
| [alicloud_security_group.sg](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_security_group_rule.allow_inbound_icmp](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_security_group_rule.allow_inbound_ssh](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.vsw](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_cen_transit_router_route_tables.tr](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/cen_transit_router_route_tables) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_az_list"></a> [az\_list](#input\_az\_list) | List of availability zones to use | `list(string)` | <pre>[<br/>  "cn-hangzhou-j",<br/>  "cn-hangzhou-k"<br/>]</pre> | no |
| <a name="input_default_region"></a> [default\_region](#input\_default\_region) | Default region | `string` | `"cn-hangzhou"` | no |
| <a name="input_ecs_ip_list"></a> [ecs\_ip\_list](#input\_ecs\_ip\_list) | List of ECS ip | `list(string)` | <pre>[<br/>  "192.168.0.124",<br/>  "172.16.0.222",<br/>  "10.0.0.112"<br/>]</pre> | no |
| <a name="input_pname"></a> [pname](#input\_pname) | The prefix name for the resources | `string` | `"tf-CenSharedVpc"` | no |
| <a name="input_vpc_cidr_list"></a> [vpc\_cidr\_list](#input\_vpc\_cidr\_list) | List of VPC CIDR block | `list(string)` | <pre>[<br/>  "192.168.0.0/16",<br/>  "172.16.0.0/12",<br/>  "10.0.0.0/16"<br/>]</pre> | no |
| <a name="input_vsw_cidr_list"></a> [vsw\_cidr\_list](#input\_vsw\_cidr\_list) | List of VSW CIDR block | `list(string)` | <pre>[<br/>  "192.168.0.0/24",<br/>  "192.168.1.0/24",<br/>  "172.16.0.0/24",<br/>  "172.16.1.0/24",<br/>  "10.0.0.0/24",<br/>  "10.0.1.0/24"<br/>]</pre> | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Allow isolated VPCs to access a shared VPC](https://www.alibabacloud.com/help/en/cen/use-cases/allow-isolated-vpcs-to-access-a-shared-vpc) 

<!-- docs-link --> 