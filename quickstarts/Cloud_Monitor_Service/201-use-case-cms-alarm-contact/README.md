## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上创建一个云监控的报警联系人。
详情可查看[使用Terraform创建报警联系人](https://help.aliyun.com/document_detail/2807110.html)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to create a CMS alarm contact on Alibaba Cloud.
More details in [Create CMS alarm contact](https://help.aliyun.com/document_detail/2807110.html).
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
| [alicloud_cms_alarm_contact.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cms_alarm_contact) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_describe"></a> [describe](#input\_describe) | n/a | `string` | `"For example"` | no |
| <a name="input_mail"></a> [mail](#input\_mail) | n/a | `string` | `"username@example.com"` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"tf_example"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-heyuan"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Create CMS alarm contact](https://help.aliyun.com/document_detail/2807110.html) 

<!-- docs-link --> 