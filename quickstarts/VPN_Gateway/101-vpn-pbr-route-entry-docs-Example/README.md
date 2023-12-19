<!-- BEGIN_TF_DOCS -->
## Introduction

This example is used to create a `alicloud_vpn_pbr_route_entry` resource.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | n/a |

## Resources

| Name | Type |
|------|------|
| [alicloud_vpn_connection.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpn_connection) | resource |
| [alicloud_vpn_customer_gateway.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpn_customer_gateway) | resource |
| [alicloud_vpn_pbr_route_entry.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpn_pbr_route_entry) | resource |
| [alicloud_vpn_gateways.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/vpn_gateways) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"tfacc"` | no |
<!-- END_TF_DOCS -->    