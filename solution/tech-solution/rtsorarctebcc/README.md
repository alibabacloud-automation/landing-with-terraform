## Introduction
<!-- DOCS_DESCRIPTION_CN -->
本示例用于实现解决方案[RDS 到 Redis 实时同步方案](https://www.aliyun.com/solution/tech-solution/rtsorarctebcc), 涉及到涉及到专有网络（VPC）、交换机（VSwitch）、云数据库（RDS）MySQL版、云数据库 Tair（兼容 Redis）等资源的创建。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example demonstrates the implementation of the solution [Real time synchronization solution from RDS to Redis](https://www.aliyun.com/solution/tech-solution/rtsorarctebcc). It involves the creation, configuration, and deployment of resources such as Virtual Private Cloud (VPC), VSwitch, Elastic Compute Service (ECS), ApsaraDB RDS, Tair (Redis OSS-compatible).
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
| [alicloud_db_database.database](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/db_database) | resource |
| [alicloud_db_instance.rds](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/db_instance) | resource |
| [alicloud_dts_synchronization_instance.dts](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/dts_synchronization_instance) | resource |
| [alicloud_dts_synchronization_job.job](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/dts_synchronization_job) | resource |
| [alicloud_kvstore_instance.redis](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/kvstore_instance) | resource |
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.vswitch](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_db_instance_classes.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/db_instance_classes) | data source |
| [alicloud_kvstore_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/kvstore_zones) | data source |
| [alicloud_regions.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/regions) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | RDS数据库名称。由2到16个小写字母组成，下划线。必须以字母开头，以字母数字字符结尾。 | `string` | `"demodb"` | no |
| <a name="input_db_password"></a> [db\_password](#input\_db\_password) | RDS数据库密码，由字母、数字、下划线（\_）组成，长度为8~32个字符，必须包含3种不同类型的字符。 | `string` | n/a | yes |
| <a name="input_dts_job_name"></a> [dts\_job\_name](#input\_dts\_job\_name) | 同步任务名称。建议配置具有业务意义的名称（无唯一性要求），便于后续识别。 | `string` | `"mysql2redis_dts"` | no |
| <a name="input_rds_db_user"></a> [rds\_db\_user](#input\_rds\_db\_user) | RDS数据库账号。由2到16个小写字母组成，下划线。必须以字母开头，以字母数字字符结尾。 | `string` | `"demouser123"` | no |
| <a name="input_redis_instance_class"></a> [redis\_instance\_class](#input\_redis\_instance\_class) | Tair规格。选择机型前请先确认当前可用区下该机型是否有库存，为节省测试成本，推荐使用2GB的规格，例如：tair.rdb.2g | `string` | `"tair.rdb.2g"` | no |
| <a name="input_redis_password"></a> [redis\_password](#input\_redis\_password) | 实例密码。长度8-32个字符,可包含大小字母、数字及特殊符号（包含：!@#$%^&*()\_+-=） | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | 地域 | `string` | `"cn-hangzhou"` | no |
<!-- END_TF_DOCS -->