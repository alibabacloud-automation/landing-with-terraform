## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于实现解决方案[端到端全链路追踪诊断](https://www.aliyun.com/solution/tech-solution/end-to-end-tracing-and-diagnostics),  涉及到专有网络（VPC）、交换机（VSwitch）、云服务器（ECS）、RAM 用户等资源的创建。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to implement solution [end-to-end-tracing-and-diagnostics](https://www.aliyun.com/solution/tech-solution/end-to-end-tracing-and-diagnostics). It involves the creation, and deployment of resources such as Virtual Private Cloud (VPC), VSwitch, Elastic Compute Service (ECS), and RAM users.
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
| [alicloud_db_account_privilege.account_privilege](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/db_account_privilege) | resource |
| [alicloud_db_database.rds_database](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/db_database) | resource |
| [alicloud_db_instance.rds_instance](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/db_instance) | resource |
| [alicloud_ecs_command.run_command](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ecs_command) | resource |
| [alicloud_ecs_invocation.invoke_script](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ecs_invocation) | resource |
| [alicloud_instance.ecs_instance](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_kvstore_instance.redis_instance](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/kvstore_instance) | resource |
| [alicloud_mse_cluster.mse_micro_registry_instance](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/mse_cluster) | resource |
| [alicloud_ram_access_key.ramak](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ram_access_key) | resource |
| [alicloud_ram_user.ram_user](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ram_user) | resource |
| [alicloud_ram_user_policy_attachment.attach_policy_to_user](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ram_user_policy_attachment) | resource |
| [alicloud_rds_account.rds_account](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/rds_account) | resource |
| [alicloud_rocketmq_account.default](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/rocketmq_account) | resource |
| [alicloud_rocketmq_acl.consumer_group](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/rocketmq_acl) | resource |
| [alicloud_rocketmq_acl.topic1](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/rocketmq_acl) | resource |
| [alicloud_rocketmq_acl.topic2](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/rocketmq_acl) | resource |
| [alicloud_rocketmq_acl.topic3](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/rocketmq_acl) | resource |
| [alicloud_rocketmq_consumer_group.consumer_group](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/rocketmq_consumer_group) | resource |
| [alicloud_rocketmq_instance.rocketmq](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/rocketmq_instance) | resource |
| [alicloud_rocketmq_topic.topic1](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/rocketmq_topic) | resource |
| [alicloud_rocketmq_topic.topic2](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/rocketmq_topic) | resource |
| [alicloud_rocketmq_topic.topic3](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/rocketmq_topic) | resource |
| [alicloud_security_group.security_group](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_security_group_rule.allow_web](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.ecs_vswitch](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.rds_vswitch](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.redis_vswitch](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/vswitch) | resource |
| [random_string.suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [alicloud_db_zones.rds_zones](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/data-sources/db_zones) | data source |
| [alicloud_images.default](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/data-sources/images) | data source |
| [alicloud_kvstore_zones.redis_zones](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/data-sources/kvstore_zones) | data source |
| [alicloud_mse_clusters.mse_micro_registry_instance](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/data-sources/mse_clusters) | data source |
| [alicloud_regions.current_region_ds](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/data-sources/regions) | data source |
| [alicloud_zones.ecs_zones](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_arms_license_key"></a> [arms\_license\_key](#input\_arms\_license\_key) | 当前环境 ARMS License Key。登录ARMS 管理控制台：https://arms.console.aliyun.com，点击接入中心 > 服务端应用 > Java 应用监控。在开始接入页签中选择所属环境类型设置为手动安装，在下载Agent步骤中指定部署地域，然后在安装Agent步骤中获取变量-Darms.licenseKey对应的值。 | `string` | n/a | yes |
| <a name="input_db_account_name"></a> [db\_account\_name](#input\_db\_account\_name) | RDS数据库账号 | `string` | `"db_normal_account"` | no |
| <a name="input_db_instance_type"></a> [db\_instance\_type](#input\_db\_instance\_type) | RDS实例规格 | `string` | `"mysql.n2.medium.1"` | no |
| <a name="input_db_password"></a> [db\_password](#input\_db\_password) | 请输入RDS数据库密码。密码长度为8-32位，需包含大写字母、小写字母、数字和特殊字符（如：!@#$%^&*()\_+-=）。如果在本教程中重复配置，请确保 MySQL 数据库密码与模板首次执行时设置的密码完全相同，否则配置结果不可用。 | `string` | n/a | yes |
| <a name="input_ecs_instance_password"></a> [ecs\_instance\_password](#input\_ecs\_instance\_password) | 服务器登录密码,长度8-30，必须包含三项（大写字母、小写字母、数字、 ()`~!@#$%^&*_-+=|{}[]:;'<>,.?/ 中的特殊符号）` | `string` | n/a | yes |
| <a name="input_ecs_instance_type"></a> [ecs\_instance\_type](#input\_ecs\_instance\_type) | ECS实例规格 | `string` | `"ecs.t6-c1m2.large"` | no |
| <a name="input_mse_license_key"></a> [mse\_license\_key](#input\_mse\_license\_key) | 当前环境 MSE License Key。登录MSE控制台：https://mse.console.aliyun.com，点击治理中心 > 应用治理，在顶部选择地域, 在右上角点击查看License Key，获取MSE License Key。 | `string` | n/a | yes |
| <a name="input_redis_instance_type"></a> [redis\_instance\_type](#input\_redis\_instance\_type) | Redis实例规格 | `string` | `"redis.shard.small.2.ce"` | no |
| <a name="input_redis_password"></a> [redis\_password](#input\_redis\_password) | 请输入Redis密码。密码长度为8-32位，需包含大写字母、小写字母、数字和特殊字符（如：!@#$%^&*()\_+-=）。 | `string` | n/a | yes |
| <a name="input_rocketmq_password"></a> [rocketmq\_password](#input\_rocketmq\_password) | 请输入RocketMQ密码。密码长度为8-32位，需包含大写字母、小写字母、数字和特殊字符（如：!@#$%^&*()\_+-=）。 | `string` | n/a | yes |
| <a name="input_rocketmq_username"></a> [rocketmq\_username](#input\_rocketmq\_username) | 请输入RocketMQ用户名。用户名长度为4-16位，只能包含字母、数字和下划线。 | `string` | `"rmquser"` | no |
<!-- END_TF_DOCS -->