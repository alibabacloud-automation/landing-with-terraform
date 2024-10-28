## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上创建、修改、查询和删除RDS PostgreSQL实例账号。
本示例来自[通过 Terraform 管理RDS账号](http://help.aliyun.com/document_detail/456029.htm)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to create, modify, query, and delete an account for an ApsaraDB RDS for PostgreSQL instance on Alibaba Cloud.
This example is from [Manage an RDS account](http://help.aliyun.com/document_detail/456029.htm).
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
| [alicloud_db_account.account](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/db_account) | resource |
| [alicloud_db_instance.instance](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/db_instance) | resource |
| [alicloud_vpc.main](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.main](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_rds_accounts.queryaccounts](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/rds_accounts) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | n/a | `string` | `"pg.n2.2c.2m"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-hangzhou"` | no |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | n/a | `string` | `"cn-hangzhou-b"` | no |
<!-- END_TF_DOCS -->
## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Manage RDS account](http://help.aliyun.com/document_detail/456029.htm) 

<!-- docs-link --> 