## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上配置CDN加速域名与加速域名的IP白名单。
本示例来自[通过Terraform添加并配置CDN域名](http://help.aliyun.com/document_detail/434131.htm)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to add and configure CDN domian names on Alibaba Cloud.
This example is from [Use Terraform to add and configure a CDN domain name](http://help.aliyun.com/document_detail/434131.htm).
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
| [alicloud_cdn_domain_config.config-ip](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cdn_domain_config) | resource |
| [alicloud_cdn_domain_new.domain](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cdn_domain_new) | resource |
| [random_integer.default](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |

## Inputs

No inputs.
<!-- END_TF_DOCS -->
## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Configure CDN domain name](http://help.aliyun.com/document_detail/434131.htm) 

<!-- docs-link --> 