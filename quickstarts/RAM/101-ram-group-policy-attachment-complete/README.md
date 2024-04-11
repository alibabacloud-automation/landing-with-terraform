## Introduction

This example is used to create a `alicloud_ram_group_policy_attachment` resource.

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
| [alicloud_ram_group.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_group) | resource |
| [alicloud_ram_group_policy_attachment.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_group_policy_attachment) | resource |
| [alicloud_ram_policy.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | This variable can be used in all resources in this example. | `string` | `"tf-example"` | no |
<!-- END_TF_DOCS -->    