## Introduction

This example is used to create a `alicloud_ga_basic_endpoint_group` resource.

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
| [alicloud_ga_basic_accelerator.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ga_basic_accelerator) | resource |
| [alicloud_ga_basic_endpoint_group.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ga_basic_endpoint_group) | resource |
| [alicloud_slb_load_balancer.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/slb_load_balancer) | resource |
| [alicloud_vpc.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_endpoint_group_region"></a> [endpoint\_group\_region](#input\_endpoint\_group\_region) | n/a | `string` | `"cn-beijing"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-hangzhou"` | no |
<!-- END_TF_DOCS -->
