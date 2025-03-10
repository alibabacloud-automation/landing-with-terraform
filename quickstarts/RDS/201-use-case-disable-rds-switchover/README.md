## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上临时关闭高可用RDS PostgreSQL实例的主备自动切换，涉及到RDS PostgreSQL实例资源的创建和主备自动切换功能的配置。
详情可查看[通过 Terraform 临时关闭RDS主备自动切换](https://help.aliyun.com/document_detail/456031.html)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to disable the automatic primary/secondary switchover feature for an ApsaraDB RDS for PostgreSQL instance that runs RDS High-availability Edition for a short period of time on Alibaba Cloud, which involves the creation of ApsaraDB RDS for PostgreSQL instance and configuration of the switchover feature.
More details in [Disable the RDS automatic primary/secondary switchover feature for a short period of time](https://help.aliyun.com/document_detail/456031.html).
<!-- DOCS_DESCRIPTION_EN -->

<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | n/a |
| <a name="provider_time"></a> [time](#provider\_time) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_db_instance.instance](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/db_instance) | resource |
| [alicloud_vpc.main](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.main](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [time_static.example](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/static) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | n/a | `string` | `"pg.n2.2c.2m"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-heyuan"` | no |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | n/a | `string` | `"cn-heyuan-b"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Disable the automatic primary/secondary switchover feature for a short period of time](https://help.aliyun.com/document_detail/456031.html) 

<!-- docs-link --> 