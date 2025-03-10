## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上创建ENS实例。
详情可查看[在Cloud Shell中使用Terraform创建ENS实例](https://help.aliyun.com/document_detail/2771531.html)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to create ENS instance on Alibaba Cloud.
More details in [Use Terraform in Cloud Shell to create an ENS instance](https://help.aliyun.com/document_detail/2771531.html).
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
| [alicloud_ens_instance.instance](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ens_instance) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_image_id"></a> [image\_id](#input\_image\_id) | n/a | `string` | `"win2022_21H2_x64_dtc_zh-cn_40G_alibase_20211116"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | n/a | `string` | `"ens.sn1.small"` | no |
| <a name="input_internet_charge_type"></a> [internet\_charge\_type](#input\_internet\_charge\_type) | n/a | `string` | `"BandwidthByDay"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-hangzhou"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Create ENS instance in Cloud Shell](https://help.aliyun.com/document_detail/2771531.html) 

<!-- docs-link --> 