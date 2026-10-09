## Introduction
<!-- DOCS_DESCRIPTION_CN -->
本示例用于实现解决方案[Serverless 事件驱动架构实践](https://www.aliyun.com/solution/tech-solution/fc-drive-file), 涉及到专有网络（VPC）、交换机（VSwitch）、云服务器（ECS）、云数据库（RDS）MySQL版、对象存储（OSS）等资源的部署。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to implement solution [Practice of Serverless Event Driven Architecture](https://www.aliyun.com/solution/tech-solution/fc-drive-file), which involves the creation and deployment of resources such as Virtual Private Cloud (VPC), VSwitch, Elastic Compute Service (ECS), ApsaraDB RDS, Object Storage Service (OSS).
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
| [alicloud_db_database.rds_database](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/db_database) | resource |
| [alicloud_db_instance.rds_instance](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/db_instance) | resource |
| [alicloud_ecs_command.deploy_application_command](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_command) | resource |
| [alicloud_ecs_invocation.deploy_application_invocation](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_invocation) | resource |
| [alicloud_fc_function.fc_function](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/fc_function) | resource |
| [alicloud_fc_service.fc_service](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/fc_service) | resource |
| [alicloud_fc_trigger.fc_trigger](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/fc_trigger) | resource |
| [alicloud_instance.ecs_instance](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_message_service_queue.queue](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/message_service_queue) | resource |
| [alicloud_oss_bucket.oss_bucket](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/oss_bucket) | resource |
| [alicloud_ram_policy.fc_demo_policy](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_policy) | resource |
| [alicloud_ram_role.fc_demo_role](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_role) | resource |
| [alicloud_ram_role.oss_event_notification_role](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_role) | resource |
| [alicloud_ram_role_policy_attachment.fc_demo_policy_attachment](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_role_policy_attachment) | resource |
| [alicloud_ram_role_policy_attachment.oss_event_notification_policy](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_role_policy_attachment) | resource |
| [alicloud_ram_role_policy_attachment.sts_assume_role_attachment](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_role_policy_attachment) | resource |
| [alicloud_rds_account.rds_account](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/rds_account) | resource |
| [alicloud_security_group.security_group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_security_group_rule.security_group_rule_80](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.vswitch1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.vswitch2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [random_id.suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [alicloud_caller_identity.current](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/caller_identity) | data source |
| [alicloud_db_instance_classes.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/db_instance_classes) | data source |
| [alicloud_db_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/db_zones) | data source |
| [alicloud_images.instance_image](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/images) | data source |
| [alicloud_instance_types.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/instance_types) | data source |
| [alicloud_ram_roles.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/ram_roles) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | bucket\_name，存储空间名称。长度为3~63个字符，必须以小写字母或数字开头和结尾，可以包含小写字母、数字和连字符(-)；需要全网唯一性，已经存在的不能在创建。 | `string` | `"file-processing-example"` | no |
| <a name="input_db_password"></a> [db\_password](#input\_db\_password) | db\_password，数据库账号密码，必须包含三种及以上类型：大写字母、小写字母、数字、特殊符号。长度为8～32位。特殊字符包括! @ # $ % ^ & * () \_ + - = | `string` | n/a | yes |
| <a name="input_db_user_name"></a> [db\_user\_name](#input\_db\_user\_name) | db\_user\_name，RDS数据库账号。由 2 到 32 个小写字母组成，支持小写字母、数字和下划线，以小写字母开头。 | `string` | `"applets"` | no |
| <a name="input_demo_user_name"></a> [demo\_user\_name](#input\_demo\_user\_name) | demo\_user\_name，在浏览器中登录示例应用程序时的用户名。3 到 63 个字母组成。 | `string` | `"demo-user-example"` | no |
| <a name="input_demo_user_password"></a> [demo\_user\_password](#input\_demo\_user\_password) | demo\_user\_password，在浏览器中登录示例应用程序时的密码，长度8-30，必须包含三项（大写字母、小写字母、数字、 ()`~!@#$%^&*_-+=|{}[]:;'<>,.?/ 中的特殊符号）` | `string` | n/a | yes |
| <a name="input_ecs_instance_password"></a> [ecs\_instance\_password](#input\_ecs\_instance\_password) | ecs\_instance\_password，服务器登录密码,长度8-30，必须包含三项（大写字母、小写字母、数字、 ()`~!@#$%^&*_-+=|{}[]:;'<>,.?/ 中的特殊符号）` | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | 地域 | `string` | `"cn-hangzhou"` | no |
<!-- END_TF_DOCS -->