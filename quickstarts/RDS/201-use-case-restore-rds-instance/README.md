## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上恢复RDS PostgreSQL实例，涉及到备份的创建以及按时间点和备份集恢复RDS PostgreSQL实例。
详情可查看[通过 Terraform 恢复 RDS PostgreSQL 实例](http://help.aliyun.com/document_detail/456035.htm)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to restore RDS PostgreSQL instance on Alibaba Cloud, which involves the creation of backup and restoration by backup and time.
More details in [Restore RDS instance data](http://help.aliyun.com/document_detail/456035.htm).
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
| [alicloud_rds_clone_db_instance.clone_id](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/rds_clone_db_instance) | resource |
| [alicloud_rds_clone_db_instance.clone_time](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/rds_clone_db_instance) | resource |
| [alicloud_vpc.main](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.main](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_rds_backups.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/rds_backups) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | n/a | `string` | `"pg.n2.2c.2m"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-heyuan"` | no |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | n/a | `string` | `"cn-heyuan-b"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Restore RDS instance](http://help.aliyun.com/document_detail/456035.htm) 

<!-- docs-link --> 