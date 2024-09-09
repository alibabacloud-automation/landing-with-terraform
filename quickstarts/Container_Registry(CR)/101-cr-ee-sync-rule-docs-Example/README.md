## Introduction

This example is used to create a `alicloud_cr_ee_sync_rule` resource.

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
| [alicloud_cr_ee_instance.source](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cr_ee_instance) | resource |
| [alicloud_cr_ee_instance.target](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cr_ee_instance) | resource |
| [alicloud_cr_ee_namespace.source](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cr_ee_namespace) | resource |
| [alicloud_cr_ee_namespace.target](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cr_ee_namespace) | resource |
| [alicloud_cr_ee_repo.source](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cr_ee_repo) | resource |
| [alicloud_cr_ee_repo.target](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cr_ee_repo) | resource |
| [alicloud_cr_ee_sync_rule.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cr_ee_sync_rule) | resource |
| [random_integer.default](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |
| [alicloud_regions.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/regions) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"terraform-example"` | no |
<!-- END_TF_DOCS -->
