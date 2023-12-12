<!-- BEGIN_TF_DOCS -->
## Introduction

This example is used to create a `alicloud_vpn_connection` resource.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | n/a |

## Resources

| Name | Type |
|------|------|
| [alicloud_vpn_connection.foo](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpn_connection) | resource |
| [alicloud_vpn_customer_gateway.foo](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpn_customer_gateway) | resource |
| [alicloud_vpn_gateway.foo](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpn_gateway) | resource |
| [alicloud_vpcs.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/vpcs) | data source |
| [alicloud_vswitches.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/vswitches) | data source |
| [alicloud_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"tf-example"` | no |
<!-- END_TF_DOCS -->    