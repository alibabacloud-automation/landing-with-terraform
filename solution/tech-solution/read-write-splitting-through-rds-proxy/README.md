## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于实现解决方案[RDS 通过代理组件实现读写分离](https://www.aliyun.com/solution/tech-solution/read-write-splitting-through-rds-proxy), 涉及到专有网络（VPC）、交换机（VSwitch）、云服务器（ECS）、云数据库（RDS MySQL） 等资源的创建。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example demonstrates the implementation of the solution [Read write splitting through RDS proxy](https://www.aliyun.com/solution/tech-solution/read-write-splitting-through-rds-proxy). It involves the creation, and deployment of resources such as Virtual Private Cloud (VPC), VSwitch, Elastic Compute Service (ECS), and ApsaraDB RDS for MySQL.
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
| [alicloud_db_account.db_account](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/db_account) | resource |
| [alicloud_db_account_privilege.account_privilege](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/db_account_privilege) | resource |
| [alicloud_db_database.rds_database](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/db_database) | resource |
| [alicloud_db_instance.database](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/db_instance) | resource |
| [alicloud_db_readonly_instance.readonly_instance](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/db_readonly_instance) | resource |
| [alicloud_ecs_command.install_script](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_command) | resource |
| [alicloud_ecs_invocation.run_install](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_invocation) | resource |
| [alicloud_instance.ecs_instance](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_rds_db_proxy.db_proxy](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/rds_db_proxy) | resource |
| [alicloud_security_group.security_group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_security_group_rule.allow_http](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.vswitch1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.vswitch2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [random_id.suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [alicloud_db_instance_classes.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/db_instance_classes) | data source |
| [alicloud_db_zones.rds_zones](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/db_zones) | data source |
| [alicloud_images.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/images) | data source |
| [alicloud_instance_types.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/instance_types) | data source |
| [alicloud_regions.current](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/regions) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | 请输入数据库名称（由小写字母、数字及特殊字符 -\_ 组成，以字母开头，字母或数字结尾，最多64个字符）。 | `string` | `"db_test"` | no |
| <a name="input_db_password"></a> [db\_password](#input\_db\_password) | 请输入RDS数据库密码。密码长度为8-32位，需包含大写字母、小写字母、数字和特殊字符（如：!@#$%^&*()\_+-=）。 | `string` | n/a | yes |
| <a name="input_db_user_name"></a> [db\_user\_name](#input\_db\_user\_name) | 请输入RDS数据库用户名（长度为2-16个字符，仅允许小写字母、数字和下划线，必须以字母开头，以字母或数字结尾）。 | `string` | `"testuser"` | no |
| <a name="input_ecs_instance_password"></a> [ecs\_instance\_password](#input\_ecs\_instance\_password) | 请输入服务器登录密码。密码长度为8-30位，必须包含大写字母、小写字母、数字和特殊字符（如：!@#$%^&*\_-+=\|{}[]:;'<>,.?/）。 | `string` | n/a | yes |
| <a name="input_region_id"></a> [region\_id](#input\_region\_id) | 请输入地域ID（例如：cn-hangzhou）。 | `string` | `"cn-hangzhou"` | no |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | 请输入VPC的CIDR块（支持的值包括：192.168.0.0/16、172.16.0.0/12、10.0.0.0/8）。这是您的虚拟私有云的地址范围。 | `string` | `"192.168.0.0/16"` | no |
| <a name="input_vswitch1_cidr_block"></a> [vswitch1\_cidr\_block](#input\_vswitch1\_cidr\_block) | 请输入主交换机的CIDR块（例如：192.168.1.0/24）。这是您主虚拟交换机的地址范围。 | `string` | `"192.168.1.0/24"` | no |
| <a name="input_vswitch2_cidr_block"></a> [vswitch2\_cidr\_block](#input\_vswitch2\_cidr\_block) | 请输入备交换机的CIDR块（例如：192.168.2.0/24）。这是您备虚拟交换机的地址范围。 | `string` | `"192.168.2.0/24"` | no |
<!-- END_TF_DOCS -->