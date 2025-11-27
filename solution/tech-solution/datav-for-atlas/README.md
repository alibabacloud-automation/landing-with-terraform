## Introduction
<!-- DOCS_DESCRIPTION_CN -->
本示例用于实现解决方案[一站式时空决策，释放空间数据价值](https://www.aliyun.com/solution/tech-solution/datav-for-atlas)，涉及专有网络（VPC）、交换机（VSwitch）、RDS数据库（RDS）等资源的部署。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to implement solution [Unified spatio-temporal decision-making to unlock the value of spatial data](https://www.aliyun.com/solution/tech-solution/datav-for-atlas), which involves the creation and deployment of resources such as Virtual Private Cloud (VPC), Virtual Switch (VSwitch),RDS Database (RDS).
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
| [alicloud_db_account_privilege.privilege](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/db_account_privilege) | resource |
| [alicloud_db_connection.public](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/db_connection) | resource |
| [alicloud_db_database.db_database](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/db_database) | resource |
| [alicloud_db_instance.db_instance](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/db_instance) | resource |
| [alicloud_rds_account.account](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/rds_account) | resource |
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.vswitch](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [random_id.suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [alicloud_db_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/db_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_db_instance_class"></a> [db\_instance\_class](#input\_db\_instance\_class) | 实例规格 | `string` | `"pg.n4.2c.1m"` | no |
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | RDS数据库名称 | `string` | `"food_test"` | no |
| <a name="input_db_password"></a> [db\_password](#input\_db\_password) | RDS数据库密码 | `string` | n/a | yes |
| <a name="input_rds_db_user"></a> [rds\_db\_user](#input\_rds\_db\_user) | RDS数据库账号 | `string` | `"test_user"` | no |
<!-- END_TF_DOCS -->