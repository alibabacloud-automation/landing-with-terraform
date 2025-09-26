## Introduction

This example is used to create a `alicloud_sls_index` resource.

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
| [alicloud_log_project.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/log_project) | resource |
| [alicloud_log_store.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/log_store) | resource |
| [alicloud_sls_index.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/sls_index) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_logstore_name"></a> [logstore\_name](#input\_logstore\_name) | n/a | `string` | `"logstore-example"` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"terraform-example"` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | n/a | `string` | `"project-for-index-terraform-example"` | no |
<!-- END_TF_DOCS -->
