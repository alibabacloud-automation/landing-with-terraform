## Introduction

This example is used to create a `alicloud_fcv3_trigger` resource.

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
| [alicloud_fcv3_function.function](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/fcv3_function) | resource |
| [alicloud_fcv3_trigger.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/fcv3_trigger) | resource |
| [alicloud_account.current](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/account) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_function_name"></a> [function\_name](#input\_function\_name) | n/a | `string` | `"TerraformTriggerResourceAPI"` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"terraform-example"` | no |
| <a name="input_trigger_name"></a> [trigger\_name](#input\_trigger\_name) | n/a | `string` | `"TerraformTrigger_CDN"` | no |
<!-- END_TF_DOCS -->
