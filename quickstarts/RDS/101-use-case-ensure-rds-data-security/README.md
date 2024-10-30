## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上针对RDS PostgreSQL实例修改安全组、修改IP白名单、修改SSL配置以及切换高安全模式，涉及到RDS PostgreSQL资源的创建与白名单，安全组，SSL等资源的配置。
详情可查看[通过 Terraform 增加 RDS 示例的数据安全性](http://help.aliyun.com/document_detail/456032.htm)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to change security groups, IP address whitelists, and secure sockets layer (SSL) encryption settings of an ApsaraDB RDS for PostgreSQL instance on Alibaba Cloud, which involves the creation  of ApsaraDB RDS for PostgreSQL instance and configuration of resources such as security groups, IP address whitelists and SSL.
More details in [Ensure RDS data security](http://help.aliyun.com/document_detail/456032.htm).
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
| [alicloud_security_group.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_vpc.main](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.main](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | n/a | `string` | `"pg.n2.2c.2m"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-shenzhen"` | no |
| <a name="input_security_ips"></a> [security\_ips](#input\_security\_ips) | n/a | `string` | `"0.0.0.0/0"` | no |
| <a name="input_target_minor_version"></a> [target\_minor\_version](#input\_target\_minor\_version) | n/a | `string` | `"rds_postgres_1300_20240830"` | no |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | n/a | `string` | `"cn-shenzhen-c"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Ensure RDS data security](http://help.aliyun.com/document_detail/456032.htm) 

<!-- docs-link --> 