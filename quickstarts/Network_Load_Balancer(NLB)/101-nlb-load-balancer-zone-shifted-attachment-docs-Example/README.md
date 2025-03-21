## Introduction

This example is used to create a `alicloud_nlb_load_balancer_zone_shifted_attachment` resource.

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
| [alicloud_nlb_load_balancer.nlb](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/nlb_load_balancer) | resource |
| [alicloud_nlb_load_balancer_zone_shifted_attachment.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/nlb_load_balancer_zone_shifted_attachment) | resource |
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.vsw1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.vsw2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"terraform-example"` | no |
<!-- END_TF_DOCS -->
