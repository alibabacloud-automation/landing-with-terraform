## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上创建一个DMS权限模板。
详情可查看[使用Terraform创建一个DMS权限模板](https://help.aliyun.com/document_detail/2834453.html)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to create a DMS authority template on Alibaba Cloud.
More details in [Create DMS authority template](https://help.aliyun.com/document_detail/2834453.html).
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
| [alicloud_dms_enterprise_authority_template.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/dms_enterprise_authority_template) | resource |
| [alicloud_dms_user_tenants.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/dms_user_tenants) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | n/a | `string` | `"For terraform"` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"terraform-example"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-heyuan"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Create DMS authority template](https://help.aliyun.com/document_detail/2834453.html) 

<!-- docs-link --> 