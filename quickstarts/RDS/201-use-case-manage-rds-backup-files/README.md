## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上管理 RDS PostgreSQL 备份，涉及到备份的创建，查看，修改与删除。
详情可查看[通过 Terraform 管理 RDS PostgreSQL 备份](http://help.aliyun.com/document_detail/456034.htm)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to manage backup files for an ApsaraDB RDS for PostgreSQL instance on Alibaba Cloud, which involves the creation, query, modification and deletion of backup files.
More details in [Manage RDS backup files](http://help.aliyun.com/document_detail/456034.htm).
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
| [alicloud_rds_backup.instance](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/rds_backup) | resource |
| [alicloud_security_group.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_vpc.main](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.main](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | n/a | `string` | `"pg.n2.2c.2m"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-shenzhen"` | no |
| <a name="input_target_minor_version"></a> [target\_minor\_version](#input\_target\_minor\_version) | n/a | `string` | `"rds_postgres_1300_20240830"` | no |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | n/a | `string` | `"cn-shenzhen-c"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Manage RDS backup files](http://help.aliyun.com/document_detail/456034.htm) 

<!-- docs-link --> 