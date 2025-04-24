## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上创建一个PostgreSQL类型的云数据库实例。
本示例来自[创建一个云数据库实例](https://help.aliyun.com/document_detail/111635.html)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to create a PostgreSQL database for RDS instance on Alibaba Cloud.
This example is from [Create an ApsaraDB for RDS instance](https://help.aliyun.com/document_detail/111635.html).
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
| [alicloud_db_account_privilege.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/db_account_privilege) | resource |
| [alicloud_db_connection.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/db_connection) | resource |
| [alicloud_db_database.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/db_database) | resource |
| [alicloud_db_instance.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/db_instance) | resource |
| [alicloud_rds_account.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/rds_account) | resource |
| [alicloud_vpc.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_db_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/db_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_name"></a> [account\_name](#input\_account\_name) | 设置RDS账号名称 | `string` | `"tf_example"` | no |
| <a name="input_account_password"></a> [account\_password](#input\_account\_password) | 设置RDS账号的密码 | `string` | `"!Qaz1234"` | no |
| <a name="input_connection_prefix"></a> [connection\_prefix](#input\_connection\_prefix) | 设置外网连接地址的前缀 | `string` | `"test1234"` | no |
| <a name="input_db_category"></a> [db\_category](#input\_db\_category) | 设置产品系列，按量付费类型实例只支持Basic、HighAvailability、cluster。 | `string` | `"Basic"` | no |
| <a name="input_db_instance_storage_type"></a> [db\_instance\_storage\_type](#input\_db\_instance\_storage\_type) | 设置实例存储类型 | `string` | `"cloud_essd"` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | 设置数据库版本 | `string` | `"14.0"` | no |
| <a name="input_instance_storage"></a> [instance\_storage](#input\_instance\_storage) | 设置存储空间 | `string` | `"20"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | 设置实例规格 | `string` | `"pg.n2.2c.1m"` | no |
| <a name="input_name"></a> [name](#input\_name) | 设置资源名称 | `string` | `"tf_test"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Create an ApsaraDB for RDS instance](https://help.aliyun.com/document_detail/111635.html) 

<!-- docs-link --> 