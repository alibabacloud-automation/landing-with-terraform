## Introduction

This example is used to create a `alicloud_vpc_ipv6_address` resource.

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
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vpc_ipv6_address.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc_ipv6_address) | resource |
| [alicloud_vswitch.vswich](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_resource_manager_resource_groups.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/resource_manager_resource_groups) | data source |
| [alicloud_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"terraform-example"` | no |
<!-- END_TF_DOCS -->    