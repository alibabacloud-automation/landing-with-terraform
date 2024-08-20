## Introduction

This example is used to create a `alicloud_cloud_firewall_vpc_cen_tr_firewall` resource.

<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | n/a |
| <a name="provider_time"></a> [time](#provider\_time) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_cen_instance.cen](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_instance) | resource |
| [alicloud_cen_transit_router.tr](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router) | resource |
| [alicloud_cen_transit_router_vpc_attachment.tr-vpc1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_vpc_attachment) | resource |
| [alicloud_cloud_firewall_vpc_cen_tr_firewall.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cloud_firewall_vpc_cen_tr_firewall) | resource |
| [alicloud_route_table.foo](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/route_table) | resource |
| [alicloud_vpc.vpc1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.vpc1vsw1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.vpc1vsw2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [time_sleep.wait_10_minutes](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [alicloud_cen_transit_router_available_resources.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/cen_transit_router_available_resources) | data source |
| [alicloud_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | n/a | `string` | `"Created by Terraform"` | no |
| <a name="input_firewall_name"></a> [firewall\_name](#input\_firewall\_name) | n/a | `string` | `"tf-example"` | no |
| <a name="input_firewall_name_update"></a> [firewall\_name\_update](#input\_firewall\_name\_update) | n/a | `string` | `"tf-example-1"` | no |
| <a name="input_firewall_subnet_cidr"></a> [firewall\_subnet\_cidr](#input\_firewall\_subnet\_cidr) | n/a | `string` | `"192.168.3.0/25"` | no |
| <a name="input_firewall_vpc_cidr"></a> [firewall\_vpc\_cidr](#input\_firewall\_vpc\_cidr) | n/a | `string` | `"192.168.3.0/24"` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"terraform-example"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-hangzhou"` | no |
| <a name="input_tr_attachment_master_cidr"></a> [tr\_attachment\_master\_cidr](#input\_tr\_attachment\_master\_cidr) | n/a | `string` | `"192.168.3.192/26"` | no |
| <a name="input_tr_attachment_slave_cidr"></a> [tr\_attachment\_slave\_cidr](#input\_tr\_attachment\_slave\_cidr) | n/a | `string` | `"192.168.3.128/26"` | no |
| <a name="input_zone1"></a> [zone1](#input\_zone1) | n/a | `string` | `"cn-hangzhou-h"` | no |
| <a name="input_zone2"></a> [zone2](#input\_zone2) | n/a | `string` | `"cn-hangzhou-i"` | no |
<!-- END_TF_DOCS -->
