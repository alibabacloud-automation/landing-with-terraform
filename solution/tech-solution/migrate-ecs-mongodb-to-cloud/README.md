<!-- DOCS_DESCRIPTION_CN -->
本示例用于实现解决方案[自建 MongoDB 迁移到云数据库](https://www.aliyun.com/solution/tech-solution/migrate-self-managed-mongodb-to-cloud), 涉及到专有网络（VPC）、交换机（VSwitch）、云服务器（ECS）、云数据库（MongoDB） 等资源的创建。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example demonstrates the implementation of the solution [Migrate self-managed mongodb to cloud](https://www.aliyun.com/solution/tech-solution/migrate-self-managed-mongodb-to-cloud). It involves the creation, and deployment of resources such as Virtual Private Cloud (VPC), VSwitch, Elastic Compute Service (ECS), and ApsaraDB for MongoDB.
<!-- DOCS_DESCRIPTION_EN -->

<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | 1.253.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.7.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_ecs_command.run_command](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_command) | resource |
| [alicloud_ecs_invocation.install_mongodb](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_invocation) | resource |
| [alicloud_instance.mongodb_server](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_mongodb_instance.mongodb](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/mongodb_instance) | resource |
| [alicloud_security_group.security_group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_security_group_rule.http](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_security_group_rule.mongodb_egress](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_security_group_rule.mongodb_ingress](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_security_group_rule.rdp](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.vswitch](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [random_id.suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [alicloud_images.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/images) | data source |
| [alicloud_instance_types.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/instance_types) | data source |
| [alicloud_mongodb_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/mongodb_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | 请输入自建MongoDB数据库名称（由小写字母、数字及特殊字符 -\_ 组成，以小写字母开头，小写字母或数字结尾，最多64个字符）。 | `string` | `"mongodb_transfer_test"` | no |
| <a name="input_db_password"></a> [db\_password](#input\_db\_password) | 请输入自建MongoDB数据库密码。密码长度为8-32位，需包含大写字母、小写字母、数字和特殊字符（如：!@#$%^&*()\_+-=）。 | `string` | n/a | yes |
| <a name="input_db_user_name"></a> [db\_user\_name](#input\_db\_user\_name) | 请输入自建MongoDB数据库账号（长度为2-16个字符，仅允许小写字母、大写字母、数字和下划线，必须以字母开头，以字母或数字结尾）。 | `string` | n/a | yes |
| <a name="input_ecs_instance_password"></a> [ecs\_instance\_password](#input\_ecs\_instance\_password) | 请输入服务器登录密码。密码长度为8-30位，必须包含大写字母、小写字母、数字和特殊字符（如：!@#$%^&*\_-+=\|{}[]:;'<>,.?/）。 | `string` | n/a | yes |
| <a name="input_mongodb_account_password"></a> [mongodb\_account\_password](#input\_mongodb\_account\_password) | 请输入MongoDB Root密码。密码长度为6-32位，需包含大写字母、小写字母、数字和特殊字符（如：!@#$%^&*()\_+-=）。 | `string` | n/a | yes |
| <a name="input_mongodb_instance_class"></a> [mongodb\_instance\_class](#input\_mongodb\_instance\_class) | 请输入MongoDB实例规格（例如：mdb.shard.2x.xlarge.d）。根据您的数据库负载选择合适的规格。 | `string` | `"mdb.shard.2x.xlarge.d"` | no |
| <a name="input_region_id"></a> [region\_id](#input\_region\_id) | 请输入地域ID（例如：cn-hangzhou）。 | `string` | `"cn-hangzhou"` | no |
<!-- END_TF_DOCS -->