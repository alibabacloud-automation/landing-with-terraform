## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于通过 Terraform Module 快速生成 Terraform Backend 模板，涉及到表格存储服务（Tablestore）和对象存储服务（OSS）资源的创建。
详情可查看[五分钟入门阿里云Terraform OSS Backend](https://help.aliyun.com/document_detail/145541.html)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to generate a Terraform Backend template through Terraform Module, which involves the creation of Table Storage Service and Object Storage Service resources.
More details in [Quick start for Alibaba Cloud OSS Backend for Terraform](https://help.aliyun.com/document_detail/145541.html).
<!-- DOCS_DESCRIPTION_EN -->

<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_remote_state"></a> [remote\_state](#module\_remote\_state) | terraform-alicloud-modules/remote-backend/alicloud | n/a |

## Resources

| Name | Type |
|------|------|
| [random_integer.default](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-hangzhou"` | no |
<!-- END_TF_DOCS -->
## Documentation
<!-- docs-link -->

The template creates a bucket basing on Aliyun document: [Quick start for Alibaba Cloud OSS Backend for Terraform](http://help.aliyun.com/document_detail/145541.html)

<!-- docs-link -->
