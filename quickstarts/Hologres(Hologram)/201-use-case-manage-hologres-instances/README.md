## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上管理Hologres资源，涉及到Hologres实例的创建。
详情可查看[通过 Terraform 管理 Hologres 实例](https://help.aliyun.com/document_detail/2640310.html)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to manage Hologres resources on Alibaba Cloud, which involves the creation of Hologres instances.
More details in [Manage Hologres instances](https://help.aliyun.com/document_detail/2640310.html).
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
| [alicloud_hologram_instance.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/hologram_instance) | resource |
| [alicloud_vpc.main](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.main](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-shenzhen"` | no |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | n/a | `string` | `"cn-shenzhen-f"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Manage Hologres instances](https://help.aliyun.com/document_detail/2640310.html) 

<!-- docs-link --> 