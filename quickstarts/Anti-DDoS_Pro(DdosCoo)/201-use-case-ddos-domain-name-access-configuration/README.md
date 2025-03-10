## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上配置DDoS高防域名接入规则。
详情可查看[通过Terraform配置DDoS高防域名接入规则](https://help.aliyun.com/document_detail/2527826.html)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to add a domain name to Anti-DDoS Pro or Anti-DDoS Premium on Alibaba Cloud.
More details in [Add a domain name to Anti-DDoS Pro or Anti-DDoS Premium](https://help.aliyun.com/document_detail/2527826.html).
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
| [alicloud_ddoscoo_domain_resource.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ddoscoo_domain_resource) | resource |
| [alicloud_ddoscoo_instance.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ddoscoo_instance) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | `string` | `"tf-example.alibaba.com"` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"tf-example"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [DDoS domain name access configuration](https://help.aliyun.com/document_detail/2527826.html) 

<!-- docs-link --> 