## Introduction

This example is used to create a `alicloud_nlb_load_balancer` resource.

## Requirements

Before using this example, you first need to create the following dependency resources.
- `alicloud_resource_manager_resource_groups`

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
| [alicloud_common_bandwidth_package.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/common_bandwidth_package) | resource |
| [alicloud_nlb_load_balancer.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/nlb_load_balancer) | resource |
| [alicloud_vpc.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.default_1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.default_2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_nlb_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/nlb_zones) | data source |
| [alicloud_resource_manager_resource_groups.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/resource_manager_resource_groups) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address_type"></a> [address\_type](#input\_address\_type) | This variable can be used in all resources in this example. | `string` | `"Internet"` | no |
| <a name="input_cross_zone_enabled"></a> [cross\_zone\_enabled](#input\_cross\_zone\_enabled) | This variable can be used in all resources in this example. | `bool` | `false` | no |
| <a name="input_deletion_protection_enabled"></a> [deletion\_protection\_enabled](#input\_deletion\_protection\_enabled) | This variable can be used in all resources in this example. | `bool` | `false` | no |
| <a name="input_deletion_protection_reason"></a> [deletion\_protection\_reason](#input\_deletion\_protection\_reason) | This variable can be used in all resources in this example. | `string` | `"tf-open"` | no |
| <a name="input_modification_protection_reason"></a> [modification\_protection\_reason](#input\_modification\_protection\_reason) | This variable can be used in all resources in this example. | `string` | `"tf-open"` | no |
| <a name="input_modification_protection_status"></a> [modification\_protection\_status](#input\_modification\_protection\_status) | This variable can be used in all resources in this example. | `string` | `"NonProtection"` | no |
| <a name="input_name"></a> [name](#input\_name) | This variable can be used in all resources in this example. | `string` | `"tf-example"` | no |
<!-- END_TF_DOCS -->    