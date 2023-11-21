<!-- BEGIN_TF_DOCS -->
## Introduction

This example is used to create a `alicloud_nlb_load_balancer` resource.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | n/a |

## Resources

| Name | Type |
|------|------|
| [alicloud_nlb_load_balancer.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/nlb_load_balancer) | resource |
| [alicloud_vpc.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.default_1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.default_2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_nlb_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/nlb_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address_type"></a> [address\_type](#input\_address\_type) | This variable can be used in all resources in this example. | `string` | `"Internet"` | no |
<!-- END_TF_DOCS -->    