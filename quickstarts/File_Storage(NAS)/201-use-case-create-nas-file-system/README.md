## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上通过Terraform创建一个NAS文件系统。
详情可查看[通过Terraform创建文件系统](https://help.aliyun.com/document_detail/2797185.html)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used create a NAS file system on Alibaba Cloud.
More details in [Create NAS file system](https://help.aliyun.com/document_detail/2797185.html).
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
| [alicloud_nas_file_system.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/nas_file_system) | resource |
| [random_integer.default](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |
| [alicloud_nas_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/nas_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-hangzhou"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Create NAS file system](https://help.aliyun.com/document_detail/2797185.html) 

<!-- docs-link --> 