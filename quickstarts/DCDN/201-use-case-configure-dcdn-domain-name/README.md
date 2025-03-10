## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上配置DCDN加速域名与加速域名的IP白名单。
详情可查看[通过Terraform添加并配置DCDN域名](https://help.aliyun.com/document_detail/434131.html)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to add and configure DCDN domian names on Alibaba Cloud.
More details in [Use Terraform to add and configure a DCDN domain name](https://help.aliyun.com/document_detail/434131.html).
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
| [alicloud_dcdn_domain.domain](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/dcdn_domain) | resource |
| [alicloud_dcdn_domain_config.config-ip](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/dcdn_domain_config) | resource |
| [random_integer.default](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |

## Inputs

No inputs.
<!-- END_TF_DOCS -->
## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Configure DCDN domain name](https://help.aliyun.com/document_detail/434131.html) 

<!-- docs-link --> 