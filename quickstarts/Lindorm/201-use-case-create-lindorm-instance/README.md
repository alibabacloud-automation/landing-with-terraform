## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上创建Lindorm实例。
详情可查看[通过Terraform创建Lindorm实例](https://help.aliyun.com/document_detail/2841383.html)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to create Lindorm instance on Alibaba Cloud.
More details in [Create Lindorm instance](https://help.aliyun.com/document_detail/2841383.html).
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
| [alicloud_lindorm_instance.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/lindorm_instance) | resource |
| [alicloud_vpc.vpc1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"lindormtest"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-qingdao"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Create Lindorm instance](https://help.aliyun.com/document_detail/2841383.html) 

<!-- docs-link --> 