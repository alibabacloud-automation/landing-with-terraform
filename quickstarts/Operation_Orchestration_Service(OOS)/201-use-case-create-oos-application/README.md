## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上的系统运维管理中创建一个应用。
详情可查看[使用Terraform编排系统运维管理](https://help.aliyun.com/zh/oos/developer-reference/terraform-integration-example)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to create an application in Operation Orchestration Service on Alibaba Cloud.
More details in [Use Terraform to arrange Operation Orchestration Service](https://help.aliyun.com/zh/oos/developer-reference/terraform-integration-example).
<!-- DOCS_DESCRIPTION_EN -->

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
| [alicloud_oos_application.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/oos_application) | resource |
| [random_integer.default](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |
| [alicloud_resource_manager_resource_groups.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/resource_manager_resource_groups) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"terraform-example"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-hangzhou"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Manage OOS applicaiton](https://help.aliyun.com/zh/oos/developer-reference/terraform-integration-example) 

<!-- docs-link --> 