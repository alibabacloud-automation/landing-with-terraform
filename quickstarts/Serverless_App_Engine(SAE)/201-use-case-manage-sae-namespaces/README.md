## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上创建、更新和删除SAE命名空间。
详情可查看[使用Terraform管理SAE命名空间](http://help.aliyun.com/document_detail/424334.htm)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to create, update, and delete an SAE namespace on Alibaba Cloud.
More details in [Use Terraform to manage SAE namespaces](http://help.aliyun.com/document_detail/424334.htm).
<!-- DOCS_DESCRIPTION_EN -->

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
| [alicloud_sae_namespace.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/sae_namespace) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_namespace_description"></a> [namespace\_description](#input\_namespace\_description) | Namespace Description | `string` | `"a namespace sample"` | no |
| <a name="input_namespace_id"></a> [namespace\_id](#input\_namespace\_id) | Namespace ID | `string` | `"cn-hangzhou:admin"` | no |
| <a name="input_namespace_name"></a> [namespace\_name](#input\_namespace\_name) | Namespace Name | `string` | `"admin"` | no |
| <a name="input_region_id"></a> [region\_id](#input\_region\_id) | 定义区域变量，默认值为 cn-hangzhou | `string` | `"cn-hangzhou"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Manage SAE Namespaces](http://help.aliyun.com/document_detail/424334.htm) 

<!-- docs-link --> 