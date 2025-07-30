## Introduction
<!-- DOCS_DESCRIPTION_CN -->
本示例用于实现解决方案[低代码高效构建企业门户网站](https://www.aliyun.com/solution/tech-solution/build-a-website), 涉及到专有网络（VPC）、交换机（VSwitch）、云数据库RDS、多端低代码开发平台魔笔、资源编排（ROS）。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example demonstrates the implementation of the solution [Low-code Efficient Construction Of Enterprise Portal Websites](https://www.aliyun.com/solution/tech-solution/build-a-website). It involves the creation, configuration, and deployment of resources such as Virtual Private Cloud (Vpc), Virtual Switch (VSwitch), Elastic Compute Service (Ecs), Multi-terminal low-code development platform Mobi, Resource Orchestration Service (ROS).
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
| [alicloud_db_connection.rds_connection](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/db_connection) | resource |
| [alicloud_db_database.rds_database](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/db_database) | resource |
| [alicloud_db_instance.rds_instance](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/db_instance) | resource |
| [alicloud_rds_account.create_db_user](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/rds_account) | resource |
| [alicloud_ros_stack.mobi_stack](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ros_stack) | resource |
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.vswitch_1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [random_integer.app_name_random](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |
| [alicloud_db_instance_classes.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/db_instance_classes) | data source |
| [alicloud_db_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/db_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | APP名称 | `string` | `"mobi_app"` | no |
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | 数据库名 | `string` | `"db_name"` | no |
| <a name="input_db_password"></a> [db\_password](#input\_db\_password) | 数据库密码 | `string` | n/a | yes |
| <a name="input_db_user_name"></a> [db\_user\_name](#input\_db\_user\_name) | 数据库用户名 | `string` | `"db_user"` | no |
| <a name="input_region"></a> [region](#input\_region) | 地域 | `string` | `"cn-hangzhou"` | no |
<!-- END_TF_DOCS -->