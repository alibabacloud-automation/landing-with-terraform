<!-- BEGIN_TF_DOCS -->
## Introduction

This example is used to create a `alicloud_vpc_ipv6_egress_rule` resource.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | n/a |

## Resources

| Name | Type |
|------|------|
| [alicloud_instance.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_security_group.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_vpc.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vpc_ipv6_egress_rule.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc_ipv6_egress_rule) | resource |
| [alicloud_vpc_ipv6_gateway.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc_ipv6_gateway) | resource |
| [alicloud_vpc_ipv6_internet_bandwidth.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc_ipv6_internet_bandwidth) | resource |
| [alicloud_vswitch.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_images.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/images) | data source |
| [alicloud_instance_types.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/instance_types) | data source |
| [alicloud_vpc_ipv6_addresses.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/vpc_ipv6_addresses) | data source |
| [alicloud_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"terraform-example"` | no |
<!-- END_TF_DOCS -->    