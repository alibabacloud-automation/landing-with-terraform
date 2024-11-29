## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上创建容器镜像企业版实例。
详情可查看[使用Terraform创建容器镜像企业版实例](https://help.aliyun.com/zh/acr/developer-reference/terraform-integration-example)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to create a Container Registry Enterprise Edition image on Alibaba Cloud.
More details in [Create ACR enterprise edition instance](https://help.aliyun.com/zh/acr/developer-reference/terraform-integration-example).
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
| [alicloud_cr_ee_instance.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cr_ee_instance) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"tf-example"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-heyuan"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Create ACR enterprise edition instance](https://help.aliyun.com/zh/acr/developer-reference/terraform-integration-example) 

<!-- docs-link --> 