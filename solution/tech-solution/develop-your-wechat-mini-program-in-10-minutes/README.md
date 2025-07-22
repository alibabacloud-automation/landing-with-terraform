## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于实现解决方案[10 分钟搭建微信、支付宝小程序](https://www.aliyun.com/solution/tech-solution/develop-your-wechat-mini-program-in-10-minutes), 涉及到专有网络（VPC）、交换机（VSwitch）、云服务器（ECS）、云数据库（RDS MySQL） 等资源的创建。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example demonstrates the implementation of the solution [Develop your weChat mini program in 10 minutes](https://www.aliyun.com/solution/tech-solution/develop-your-wechat-mini-program-in-10-minutes). It involves the creation, and deployment of resources such as Virtual Private Cloud (VPC), VSwitch, Elastic Compute Service (ECS), and ApsaraDB RDS for MySQL.
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
| [alicloud_db_account.rds_account](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/db_account) | resource |
| [alicloud_db_account_privilege.rds_account_privilege](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/db_account_privilege) | resource |
| [alicloud_db_database.rds_database](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/db_database) | resource |
| [alicloud_db_instance.rds_db_instance](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/db_instance) | resource |
| [alicloud_ecs_command.run_command](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_command) | resource |
| [alicloud_ecs_invocation.run_command](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_invocation) | resource |
| [alicloud_instance.ecs_instance](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_security_group.security_group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_security_group_rule.http](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_security_group_rule.https](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.vswitch](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [random_id.suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [alicloud_db_instance_classes.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/db_instance_classes) | data source |
| [alicloud_db_zones.rds_zones](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/db_zones) | data source |
| [alicloud_images.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/images) | data source |
| [alicloud_instance_types.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/instance_types) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | 请输入数据库名称（由小写字母、数字及特殊字符 -\_ 组成，以字母开头，字母或数字结尾，最多64个字符）。 | `string` | `"wordpress"` | no |
| <a name="input_db_password"></a> [db\_password](#input\_db\_password) | 请输入RDS数据库密码。密码长度为8-32位，需包含大写字母、小写字母、数字和特殊字符（如：!@#$%^&*()\_+-=）。如果在本教程中重复配置，请确保 MySQL 数据库密码与模板首次执行时设置的密码完全相同，否则配置结果不可用。 | `string` | n/a | yes |
| <a name="input_db_user"></a> [db\_user](#input\_db\_user) | 请输入RDS数据库用户名（长度为2-16个字符，仅允许小写字母、数字和下划线，必须以字母开头，以字母或数字结尾）。 | `string` | `"dbuser"` | no |
| <a name="input_ecs_instance_password"></a> [ecs\_instance\_password](#input\_ecs\_instance\_password) | 请输入服务器登录密码。密码长度为8-30位，必须包含大写字母、小写字母、数字和特殊字符（如：!@#$%^&*\_-+=\|{}[]:;'<>,.?/）。 | `string` | n/a | yes |
| <a name="input_region_id"></a> [region\_id](#input\_region\_id) | 请输入地域ID（例如：cn-hangzhou）。 | `string` | `"cn-hangzhou"` | no |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | 请输入VPC的CIDR块（支持的值包括：192.168.0.0/16、172.16.0.0/12、10.0.0.0/8）。这是您的虚拟私有云的地址范围。 | `string` | `"192.168.0.0/16"` | no |
| <a name="input_vswitch_cidr_block"></a> [vswitch\_cidr\_block](#input\_vswitch\_cidr\_block) | 请输入交换机的CIDR块（例如：192.168.0.0/24）。这是您虚拟交换机的地址范围。 | `string` | `"192.168.0.0/24"` | no |
| <a name="input_word_press_password"></a> [word\_press\_password](#input\_word\_press\_password) | 请输入WordPress管理员密码。密码长度为8-32位，需包含大写字母、小写字母、数字和特殊字符（如：!@#$%^&*()\_+-=）。 | `string` | n/a | yes |
| <a name="input_word_press_user_email"></a> [word\_press\_user\_email](#input\_word\_press\_user\_email) | 请输入WordPress管理员邮箱（用于系统通知和找回密码）。 | `string` | `"admin@example.com"` | no |
| <a name="input_word_press_user_name"></a> [word\_press\_user\_name](#input\_word\_press\_user\_name) | 请输入WordPress管理员用户名（建议使用独特的用户名以增强安全性）。 | `string` | `"admin"` | no |
<!-- END_TF_DOCS -->