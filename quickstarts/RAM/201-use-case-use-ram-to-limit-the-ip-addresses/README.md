## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上通过RAM限制用户只能通过指定的IP地址访问企业的云资源。
详情可查看[通过RAM限制用户的访问IP地址](https://help.aliyun.com/document_detail/129718.html)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to use Resource Access Management (RAM) to limit the IP addresses that are allowed to access Alibaba Cloud resources on Alibaba Cloud.
More details in [Use RAM to limit the IP addresses that are allowed to access Alibaba Cloud resources](https://help.aliyun.com/document_detail/129718.html).
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
| [alicloud_ram_policy.policy](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_policy) | resource |
| [alicloud_ram_user.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_user) | resource |
| [alicloud_ram_user_policy_attachment.policy_attachment](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_user_policy_attachment) | resource |
| [random_integer.default](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |

## Inputs

No inputs.
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Use RAM to limit the IP addresses that are allowed to access Alibaba Cloud resources](https://help.aliyun.com/document_detail/129718.html) 

<!-- docs-link --> 