## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上RDS PostgreSQL实例绑定标签以及解绑标签，涉及到RDS PostgreSQL实例与标签等资源的创建与配置。
详情可查看[通过 Terraform 管理 RDS PostgreSQL 实例标签](https://help.aliyun.com/document_detail/456037.html)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to add tags and remove tags from an ApsaraDB RDS for PostgreSQL instance on Alibaba Cloud, which involves the creation and configuration of resources such as ApsaraDB RDS for PostgreSQL instance and tags.
More details in [Manage RDS tags](https://help.aliyun.com/document_detail/456037.html).
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
| [alicloud_db_instance.instance](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/db_instance) | resource |
| [alicloud_vpc.main](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.main](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | n/a | `string` | `"pg.n2.2c.2m"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-heyuan"` | no |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | n/a | `string` | `"cn-heyuan-a"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Manage RDS tags](https://help.aliyun.com/document_detail/456037.html) 

<!-- docs-link --> 