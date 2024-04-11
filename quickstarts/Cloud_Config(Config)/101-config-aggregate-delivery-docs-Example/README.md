## Introduction

This example is used to create a `alicloud_config_aggregate_delivery` resource.

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
| [alicloud_config_aggregate_delivery.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/config_aggregate_delivery) | resource |
| [alicloud_config_aggregator.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/config_aggregator) | resource |
| [alicloud_log_project.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/log_project) | resource |
| [alicloud_log_store.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/log_store) | resource |
| [random_uuid.default](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) | resource |
| [alicloud_account.this](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/account) | data source |
| [alicloud_regions.this](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/regions) | data source |
| [alicloud_resource_manager_accounts.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/resource_manager_accounts) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"tf_example"` | no |
<!-- END_TF_DOCS -->    