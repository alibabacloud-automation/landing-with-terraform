## Introduction

This example is used to create a `alicloud_nlb_load_balancer` resource.

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
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vpc_ipv6_gateway.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc_ipv6_gateway) | resource |
| [alicloud_vswitch.vsw](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"tf-example"` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | n/a | `list` | <pre>[<br/>  "cn-beijing-i",<br/>  "cn-beijing-k",<br/>  "cn-beijing-l"<br/>]</pre> | no |
<!-- END_TF_DOCS -->
