## Introduction

This example is used to create a `alicloud_threat_detection_monitor_account` resource.

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
| [alicloud_threat_detection_monitor_account.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/threat_detection_monitor_account) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_member_account_ids"></a> [member\_account\_ids](#input\_member\_account\_ids) | The IDs of the member accounts in the resource directory. Multiple IDs must be separated by commas (,). | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"terraform-example"` | no |
<!-- END_TF_DOCS -->
