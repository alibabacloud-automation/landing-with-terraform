## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上创建云SSO用户。
详情可查看[创建云SSO用户](https://help.aliyun.com/document_detail/2833154.html)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to create CloudSSO user on Alibaba Cloud.
More details in [Create CloudSSO user](https://help.aliyun.com/document_detail/2833154.html).
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
| [alicloud_cloud_sso_directory.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cloud_sso_directory) | resource |
| [alicloud_cloud_sso_user.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cloud_sso_user) | resource |
| [random_integer.default](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |
| [alicloud_cloud_sso_directories.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/cloud_sso_directories) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-shanghai"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Create CloudSSO user](https://help.aliyun.com/document_detail/2833154.html) 

<!-- docs-link --> 