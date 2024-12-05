## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上创建一个配置审计的投递渠道。
详情可查看[使用Terraform创建一个配置审计投递渠道](https://help.aliyun.com/document_detail/2807844.html)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to create Config delivery on Alibaba Cloud.
More details in [Create Config delivery](https://help.aliyun.com/document_detail/2807844.html).
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
| [alicloud_config_delivery.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/config_delivery) | resource |
| [alicloud_log_project.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/log_project) | resource |
| [alicloud_log_store.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/log_store) | resource |
| [random_integer.default](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |
| [alicloud_account.this](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/account) | data source |
| [alicloud_regions.this](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/regions) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | n/a | `string` | `"terraform-example"` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"tf-example-sls"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-heyuan"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Create Config delivery](https://help.aliyun.com/document_detail/2807844.html) 

<!-- docs-link --> 