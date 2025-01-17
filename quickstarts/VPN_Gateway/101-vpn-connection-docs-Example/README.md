## Introduction

This example is used to create a `alicloud_vpn_connection` resource.

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
| [alicloud_vpc.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vpn_connection.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpn_connection) | resource |
| [alicloud_vpn_customer_gateway.changeCustomerGateway](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpn_customer_gateway) | resource |
| [alicloud_vpn_customer_gateway.defaultCustomerGateway](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpn_customer_gateway) | resource |
| [alicloud_vpn_gateway.HA-VPN](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpn_gateway) | resource |
| [alicloud_vswitch.default0](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.default1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vpn_gateway_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/vpn_gateway_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"terraform-example"` | no |
| <a name="input_spec"></a> [spec](#input\_spec) | n/a | `string` | `"5"` | no |
<!-- END_TF_DOCS -->
