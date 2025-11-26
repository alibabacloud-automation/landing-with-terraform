## Introduction
<!-- DOCS_DESCRIPTION_CN -->
本示例用于实现解决方案[Flink CDC 实现企业级实时数据同步 
](https://www.aliyun.com/solution/tech-solution/flink-cdc-realize-data-synchronization)，涉及专有网络（VPC）、交换机（VSwitch）、实时计算 Flink（Flink）、RDS数据库（RDS）、对象存储服务（OSS）等资源的部署。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to implement solution [Real-time data synchronization with Flink CDC](https://www.aliyun.com/solution/tech-solution/flink-cdc-realize-data-synchronization), which involves the creation and deployment of resources such as Virtual Private Cloud (VPC), Virtual Switch (VSwitch), Realtime Compute for Apache Flink (Flink), RDS Database (RDS), Object Storage Service (OSS).
<!-- DOCS_DESCRIPTION_EN -->

<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_db_database.db_base1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/db_database) | resource |
| [alicloud_db_database.db_base2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/db_database) | resource |
| [alicloud_db_database.db_base3](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/db_database) | resource |
| [alicloud_db_database.db_base4](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/db_database) | resource |
| [alicloud_db_instance.rdsdbinstance](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/db_instance) | resource |
| [alicloud_oss_bucket.bucket](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/oss_bucket) | resource |
| [alicloud_oss_bucket_object.directory_name](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/oss_bucket_object) | resource |
| [alicloud_rds_account.account](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/rds_account) | resource |
| [alicloud_realtime_compute_vvp_instance.flink_instance](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/realtime_compute_vvp_instance) | resource |
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.vswitch](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [random_string.lowercase](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [alicloud_db_zones.zones_ids](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/db_zones) | data source |
| [alicloud_oss_service.open_oss](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/oss_service) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | OSS存储空间名称 | `string` | `"flink-cdc"` | no |
| <a name="input_db_password"></a> [db\_password](#input\_db\_password) | RDS数据库密码 | `string` | n/a | yes |
| <a name="input_db_user_name"></a> [db\_user\_name](#input\_db\_user\_name) | RDS数据库账号 | `string` | `"db_user"` | no |
| <a name="input_dbinstance_class"></a> [dbinstance\_class](#input\_dbinstance\_class) | RDS实例规格 | `string` | `"mysql.n2.medium.1"` | no |
| <a name="input_directory_name"></a> [directory\_name](#input\_directory\_name) | Bucket 文件目录名称 | `string` | `"warehouse"` | no |
| <a name="input_flink_instance_name"></a> [flink\_instance\_name](#input\_flink\_instance\_name) | Flink实例名称 | `string` | `"flink-cdc-test"` | no |
<!-- END_TF_DOCS -->