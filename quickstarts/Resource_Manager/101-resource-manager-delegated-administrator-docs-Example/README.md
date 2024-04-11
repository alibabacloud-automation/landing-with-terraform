## Introduction

This example is used to create a `alicloud_resource_manager_delegated_administrator` resource.

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
| [alicloud_resource_manager_account.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/resource_manager_account) | resource |
| [alicloud_resource_manager_delegated_administrator.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/resource_manager_delegated_administrator) | resource |
| [random_integer.default](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |
| [alicloud_resource_manager_folders.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/resource_manager_folders) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | n/a | `string` | `"EAccount"` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"tf-example"` | no |
<!-- END_TF_DOCS -->    