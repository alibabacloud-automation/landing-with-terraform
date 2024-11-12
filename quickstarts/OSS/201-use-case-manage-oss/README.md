## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上通过Terraform创建Bucket，涉及到OSS存储空间的创建与存储空间访问权限的配置。
详情可查看[通过Terraform创建Bucket](http://help.aliyun.com/document_detail/98855.htm)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to manage Object Storage Service on Alibaba Cloud, which involves the creation of OSS bucket and configuration of OSS bucket ACL.
More details in [Use Terraform to manage OSS](http://help.aliyun.com/document_detail/98855.htm).
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
| [alicloud_oss_bucket.bucket](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/oss_bucket) | resource |
| [alicloud_oss_bucket_acl.bucket-ac](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/oss_bucket_acl) | resource |
| [random_uuid.default](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-beijing"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Manage OSS](http://help.aliyun.com/document_detail/98855.htm) 

<!-- docs-link --> 