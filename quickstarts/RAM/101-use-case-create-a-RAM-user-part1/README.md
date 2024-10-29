## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于创建一个阿里云RAM用户，为其设置登录密码和访问密钥，并将其添加到一个阿里云RAM用户组中。
详情可查看[使用Terraform创建一个RAM用户](https://help.aliyun.com/document_detail/146286.html)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to create a RAM user on Alibaba Cloud, set a login password and access key for it, and add it to a RAM user group.
More details in [Create a RAM user](https://help.aliyun.com/document_detail/146286.html).
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
| [alicloud_ram_access_key.ak](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_access_key) | resource |
| [alicloud_ram_group.group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_group) | resource |
| [alicloud_ram_group_membership.membership](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_group_membership) | resource |
| [alicloud_ram_login_profile.profile](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_login_profile) | resource |
| [alicloud_ram_user.user](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_user) | resource |

## Inputs

No inputs.
<!-- END_TF_DOCS -->
## Documentation
<!-- docs-link -->

The template is based on Aliyun document: [Create a RAM user](https://help.aliyun.com/document_detail/146286.html)

<!-- docs-link -->
