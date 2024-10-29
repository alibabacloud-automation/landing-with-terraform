## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上创建一个存储空间，并将其设置为公共读权限。
详情可查看[通过Terraform管理Bucket](https://help.aliyun.com/document_detail/111911.html)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to create an Object Storage Service(OSS) bucket on Alibaba Cloud and set it to public-read access.
More details in [Manage a Bucket](https://help.aliyun.com/document_detail/111911.html).
<!-- DOCS_DESCRIPTION_EN -->

<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud.bj-prod"></a> [alicloud.bj-prod](#provider\_alicloud.bj-prod) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_oss_bucket.bucket-new](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/oss_bucket) | resource |
| [alicloud_oss_bucket_acl.bucket-new](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/oss_bucket_acl) | resource |
| [random_integer.default](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |

## Inputs

No inputs.
<!-- END_TF_DOCS -->
## Documentation
<!-- docs-link -->

The template creates a bucket basing on Aliyun document: [Manage a Bucket](http://help.aliyun.com/document_detail/111911.html)

<!-- docs-link -->
