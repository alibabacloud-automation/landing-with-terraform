## Introduction

This example is used to create a `alicloud_governance_account` resource.

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
| [alicloud_governance_account.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/governance_account) | resource |
| [random_integer.default](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |
| [alicloud_account.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/account) | data source |
| [alicloud_governance_baselines.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/governance_baselines) | data source |
| [alicloud_resource_manager_folders.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/resource_manager_folders) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"terraform-example"` | no |
<!-- END_TF_DOCS -->
