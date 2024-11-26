## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上创建表格存储实例。
详情可查看[通过Terraform创建表格存储实例](https://help.aliyun.com/zh/tablestore/developer-reference/terraform-integration-example-of-tablestore)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to create TableStore instance on Alibaba Cloud.
More details in [Create TableStore instance](https://help.aliyun.com/zh/tablestore/developer-reference/terraform-integration-example-of-tablestore).
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
| [alicloud_ots_instance.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ots_instance) | resource |
| [random_integer.default](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"tf-example"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-hangzhou"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Create TableStore instance](https://help.aliyun.com/zh/tablestore/developer-reference/terraform-integration-example-of-tablestore) 

<!-- docs-link --> 