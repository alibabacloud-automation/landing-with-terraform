## Introduction

This example is used to create a `alicloud_resource_manager_shared_target` resource.

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
| [alicloud_resource_manager_resource_share.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/resource_manager_resource_share) | resource |
| [alicloud_resource_manager_shared_target.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/resource_manager_shared_target) | resource |
| [random_integer.default](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |
| [alicloud_resource_manager_accounts.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/resource_manager_accounts) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"terraform-example"` | no |
<!-- END_TF_DOCS -->    