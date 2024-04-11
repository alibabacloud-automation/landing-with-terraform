## Introduction

This example is used to create a `alicloud_ons_group` resource.

<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_ons_group.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ons_group) | resource |
| [alicloud_ons_instance.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ons_instance) | resource |
| [random_integer.default](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_group_name"></a> [group\_name](#input\_group\_name) | n/a | `string` | `"GID-tf-example"` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"GID-tf-example"` | no |
<!-- END_TF_DOCS -->    