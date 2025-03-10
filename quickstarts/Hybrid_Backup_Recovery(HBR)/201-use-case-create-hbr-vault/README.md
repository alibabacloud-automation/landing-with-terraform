## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上创建一个云备份的备份库。
详情可查看[使用Terraform管理云备份资源](https://help.aliyun.com/document_detail/2786629.html)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to create a HBR vault on Alibaba Cloud.
More details in [Create HBR Vault](https://help.aliyun.com/document_detail/2786629.html).
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
| [alicloud_hbr_vault.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/hbr_vault) | resource |
| [random_integer.default](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-hangzhou"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Create HBR Vault](https://help.aliyun.com/document_detail/2786629.html) 

<!-- docs-link --> 