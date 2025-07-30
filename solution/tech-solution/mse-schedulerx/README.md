## Introduction
<!-- DOCS_DESCRIPTION_CN -->
本示例用于实现解决方案[快速集成分布式任务调度](https://www.aliyun.com/solution/tech-solution/mse-schedulerx), 涉及专有网络（VPC）、交换机（VSwitch）、RDS数据库（RDS）、云服务器（ECS）。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to implement solution [Quick Integration Of Distributed Task Scheduling](https://www.aliyun.com/solution/tech-solution/mse-schedulerx), which involves the creation and deployment of resources such as Virtual Private Cloud (Vpc), Virtual Switch (VSwitch), RDS Database (Rds), Elastic Compute Service (Ecs).
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
| [alicloud_db_instance.rds](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/db_instance) | resource |
| [alicloud_ecs_command.deploy](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_command) | resource |
| [alicloud_ecs_invocation.deploy_invocation](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_invocation) | resource |
| [alicloud_instance.ecs](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_rds_account.create_db_user](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/rds_account) | resource |
| [alicloud_security_group.sg](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_security_group_rule.http](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.vsw](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_db_instance_classes.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/db_instance_classes) | data source |
| [alicloud_images.instance_image](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/images) | data source |
| [alicloud_instance_types.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/instance_types) | data source |
| [alicloud_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_common_name"></a> [common\_name](#input\_common\_name) | 应用名称 | `string` | `"scheduler-demo"` | no |
| <a name="input_db_password"></a> [db\_password](#input\_db\_password) | RDS数据库密码，必须包含三种及以上类型：大写字母、小写字母、数字、特殊符号。长度为8～32位。特殊字符包括!@#$%^&*()\_+-= | `string` | n/a | yes |
| <a name="input_db_user_name"></a> [db\_user\_name](#input\_db\_user\_name) | RDS数据库账号，由2到32个小写字母组成，支持小写字母、数字和下划线，以小写字母开头 | `string` | `"user_test"` | no |
| <a name="input_demo_user_name"></a> [demo\_user\_name](#input\_demo\_user\_name) | 在浏览器中登录示例应用程序时的用户名。 | `string` | `"demo-user-example"` | no |
| <a name="input_demo_user_password"></a> [demo\_user\_password](#input\_demo\_user\_password) | 登录示例应用程序时的登录密码，必须包含三种及以上类型：大写字母、小写字母、数字、特殊符号。长度为8～32位。特殊字符包括!@#$%^&*()\_+-= | `string` | `"Demo123.."` | no |
| <a name="input_ecs_instance_password"></a> [ecs\_instance\_password](#input\_ecs\_instance\_password) | 服务器登录密码，长度8-30，必须包含三项（大写字母、小写字母、数字、特殊符号） | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | 地域 | `string` | `"cn-hangzhou"` | no |
| <a name="input_scheduler_x_app_key"></a> [scheduler\_x\_app\_key](#input\_scheduler\_x\_app\_key) | SchedulerX应用密钥，请输入在SchedulerX控制台的接入配置中获取的应用密钥 | `string` | n/a | yes |
| <a name="input_scheduler_x_endpoint"></a> [scheduler\_x\_endpoint](#input\_scheduler\_x\_endpoint) | SchedulerX接入地址，请输入在SchedulerX控制台的接入配置中获取的接入地址 | `string` | `"addr-hz-internal.edas.aliyun.com"` | no |
| <a name="input_scheduler_x_group_id"></a> [scheduler\_x\_group\_id](#input\_scheduler\_x\_group\_id) | SchedulerX应用ID，请输入在SchedulerX控制台的接入配置中获取的应用ID | `string` | `"test"` | no |
| <a name="input_scheduler_x_namespace"></a> [scheduler\_x\_namespace](#input\_scheduler\_x\_namespace) | SchedulerX命名空间，请输入在SchedulerX控制台的接入配置中获取的命名空间 | `string` | `"00000000-00000000-00000000-00000000"` | no |
<!-- END_TF_DOCS -->