## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上创建角色并绑定权限策略。
详情可查看[创建角色并绑定自定义权限策略](https://help.aliyun.com/document_detail/145530.html)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to create a RAM role on Alibaba Cloud and grant custom permissions to the role.
More details in [Create a role and bind a custom permission policy to the role](https://help.aliyun.com/document_detail/145530.html).
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
| [alicloud_ram_policy.policy](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_policy) | resource |
| [alicloud_ram_role.role](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_role) | resource |
| [alicloud_ram_role_policy_attachment.attach](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_role_policy_attachment) | resource |

## Inputs

No inputs.
<!-- END_TF_DOCS -->
## Documentation
<!-- docs-link -->

The template is based on Aliyun document: [Create a role and bind a custom permission policy to the role](https://help.aliyun.com/document_detail/145530.html)

<!-- docs-link -->
