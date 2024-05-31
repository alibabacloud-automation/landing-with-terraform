## Introduction

This example is used to create a `alicloud_cloud_firewall_nat_firewall_control_policy` resource.

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
| [alicloud_cloud_firewall_address_book.domain](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cloud_firewall_address_book) | resource |
| [alicloud_cloud_firewall_address_book.ip](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cloud_firewall_address_book) | resource |
| [alicloud_cloud_firewall_address_book.port](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cloud_firewall_address_book) | resource |
| [alicloud_cloud_firewall_address_book.port-update](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cloud_firewall_address_book) | resource |
| [alicloud_cloud_firewall_nat_firewall_control_policy.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cloud_firewall_nat_firewall_control_policy) | resource |
| [alicloud_nat_gateway.defaultMbS2Ts](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/nat_gateway) | resource |
| [alicloud_vpc.defaultDEiWfM](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.defaultFHDM3F](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_direction"></a> [direction](#input\_direction) | n/a | `string` | `"out"` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"terraform-example"` | no |
<!-- END_TF_DOCS -->
