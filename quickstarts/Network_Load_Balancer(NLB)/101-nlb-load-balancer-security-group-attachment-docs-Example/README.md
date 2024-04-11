## Introduction

This example is used to create a `alicloud_nlb_load_balancer_security_group_attachment` resource.

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
| [alicloud_nlb_load_balancer.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/nlb_load_balancer) | resource |
| [alicloud_nlb_load_balancer_security_group_attachment.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/nlb_load_balancer_security_group_attachment) | resource |
| [alicloud_security_group.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_vpc.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.default1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_nlb_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/nlb_zones) | data source |
| [alicloud_resource_manager_resource_groups.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/resource_manager_resource_groups) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"tf-example"` | no |
<!-- END_TF_DOCS -->    