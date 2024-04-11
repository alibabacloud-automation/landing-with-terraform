## Introduction

This example is used to create a `alicloud_cms_hybrid_monitor_sls_task` resource.

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
| [alicloud_cms_hybrid_monitor_sls_task.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cms_hybrid_monitor_sls_task) | resource |
| [alicloud_cms_namespace.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cms_namespace) | resource |
| [alicloud_cms_sls_group.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cms_sls_group) | resource |
| [alicloud_log_project.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/log_project) | resource |
| [alicloud_log_store.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/log_store) | resource |
| [random_uuid.default](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) | resource |
| [alicloud_account.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/account) | data source |
| [alicloud_regions.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/regions) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"tf_example"` | no |
<!-- END_TF_DOCS -->    