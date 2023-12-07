<!-- BEGIN_TF_DOCS -->
## Introduction

This example is used to create a `alicloud_ram_security_preference` resource.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | n/a |

## Resources

| Name | Type |
|------|------|
| [alicloud_ram_security_preference.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_security_preference) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_user_to_change_password"></a> [allow\_user\_to\_change\_password](#input\_allow\_user\_to\_change\_password) | This variable can be used in all resources in this example. | `bool` | `true` | no |
| <a name="input_allow_user_to_manage_access_keys"></a> [allow\_user\_to\_manage\_access\_keys](#input\_allow\_user\_to\_manage\_access\_keys) | This variable can be used in all resources in this example. | `bool` | `true` | no |
| <a name="input_allow_user_to_manage_mfa_devices"></a> [allow\_user\_to\_manage\_mfa\_devices](#input\_allow\_user\_to\_manage\_mfa\_devices) | This variable can be used in all resources in this example. | `bool` | `true` | no |
| <a name="input_enable_save_mfa_ticket"></a> [enable\_save\_mfa\_ticket](#input\_enable\_save\_mfa\_ticket) | This variable can be used in all resources in this example. | `bool` | `true` | no |
| <a name="input_enforce_mfa_for_login"></a> [enforce\_mfa\_for\_login](#input\_enforce\_mfa\_for\_login) | This variable can be used in all resources in this example. | `bool` | `false` | no |
| <a name="input_login_network_masks"></a> [login\_network\_masks](#input\_login\_network\_masks) | This variable can be used in all resources in this example. | `string` | `""` | no |
| <a name="input_login_session_duration"></a> [login\_session\_duration](#input\_login\_session\_duration) | This variable can be used in all resources in this example. | `number` | `7` | no |
<!-- END_TF_DOCS -->    