## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上创建和执行OOS模板。
详情可查看[使用Terraform操作OOS](https://help.aliyun.com/document_detail/179444.html)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to create and execute OOS template on Alibaba Cloud.
More details in [Use Terraform to manage OOS](https://help.aliyun.com/document_detail/179444.html).
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
| [alicloud_oos_execution.exampleExecution](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/oos_execution) | resource |
| [alicloud_oos_template.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/oos_template) | resource |
| [random_integer.default](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-beijing"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Manage OOS](https://help.aliyun.com/document_detail/179444.html) 

<!-- docs-link --> 