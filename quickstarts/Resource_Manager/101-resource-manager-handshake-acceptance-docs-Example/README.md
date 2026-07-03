## Introduction

This example is used to create a `alicloud_resource_manager_handshake_acceptance` resource.

<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud.invited"></a> [alicloud.invited](#provider\_alicloud.invited) | n/a |
| <a name="provider_alicloud.management"></a> [alicloud.management](#provider\_alicloud.management) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_resource_manager_handshake.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/resource_manager_handshake) | resource |
| [alicloud_resource_manager_handshake_acceptance.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/resource_manager_handshake_acceptance) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_invited_access_key"></a> [invited\_access\_key](#input\_invited\_access\_key) | n/a | `string` | n/a | yes |
| <a name="input_invited_account_id"></a> [invited\_account\_id](#input\_invited\_account\_id) | n/a | `string` | n/a | yes |
| <a name="input_invited_secret_key"></a> [invited\_secret\_key](#input\_invited\_secret\_key) | n/a | `string` | n/a | yes |
| <a name="input_management_access_key"></a> [management\_access\_key](#input\_management\_access\_key) | n/a | `string` | n/a | yes |
| <a name="input_management_secret_key"></a> [management\_secret\_key](#input\_management\_secret\_key) | n/a | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-hangzhou"` | no |
<!-- END_TF_DOCS -->
