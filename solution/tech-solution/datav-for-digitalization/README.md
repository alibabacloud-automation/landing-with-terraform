## Introduction
<!-- DOCS_DESCRIPTION_CN -->
本示例用于实现解决方案[快速搭建企业经营大屏](https://www.aliyun.com/solution/tech-solution/datav-for-digitalization)，涉及专有网络（VPC）、交换机（VSwitch）、RDS数据库（RDS）等资源的部署。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to implement solution [Quickly build a large screen of enterprise management](https://www.aliyun.com/solution/tech-solution/datav-for-digitalization), which involves the creation and deployment of resources such as Virtual Private Cloud (VPC), Virtual Switch (VSwitch), RDS Database (RDS).
<!-- DOCS_DESCRIPTION_EN -->

<!-- BEGIN_TF_DOCS -->
## Providers

......
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
| [alicloud_db_account.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/db_account) | resource |
| [alicloud_db_database.database](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/db_database) | resource |
| [alicloud_db_instance.rds_instance](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/db_instance) | resource |
| [alicloud_security_group.security_group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.vswitch](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [random_id.suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [alicloud_db_zones.zones_ids](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/db_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_db_password"></a> [db\_password](#input\_db\_password) | MySQL数据库密码 | `string` | n/a | yes |
| <a name="input_rds_db_user"></a> [rds\_db\_user](#input\_rds\_db\_user) | 数据库账号 | `string` | `"user_test"` | no |
<!-- END_TF_DOCS -->