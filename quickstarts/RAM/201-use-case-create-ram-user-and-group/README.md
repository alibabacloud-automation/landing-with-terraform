## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上创建RAM用户与RAM用户组，并将RAM用户添加到RAM用户组，涉及到RAM用户，RAM用户AccessKey和RAM用户组的创建。
详情可查看[通过Terraform创建RAM用户与RAM用户组](https://help.aliyun.com/document_detail/2841105.html)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to create a Resource Access Management (RAM) user on Alibaba Cloud, which involves the creation of resources such as RAM user, RAM AccessKey and RAM group.
More details in [Create RAM user and group](https://help.aliyun.com/document_detail/2841105.html).
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
| [alicloud_ram_access_key.ak](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_access_key) | resource |
| [alicloud_ram_group.group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_group) | resource |
| [alicloud_ram_group_membership.membership](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_group_membership) | resource |
| [alicloud_ram_login_profile.profile](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_login_profile) | resource |
| [alicloud_ram_user.user](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_user) | resource |
| [random_integer.default](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_accesskey_txt_name"></a> [accesskey\_txt\_name](#input\_accesskey\_txt\_name) | 保存AccessKey的文件名 | `string` | `"accesskey.txt"` | no |
| <a name="input_password"></a> [password](#input\_password) | RAM用户登录密码， | `string` | `"Test@123456!"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Create RAM user and group](https://help.aliyun.com/document_detail/2841105.html) 

<!-- docs-link --> 