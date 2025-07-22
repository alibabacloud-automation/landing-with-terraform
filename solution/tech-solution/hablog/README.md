## Introduction
<!-- DOCS_DESCRIPTION_CN -->
本示例用于实现解决方案[云上高可用架构](https://www.aliyun.com/solution/tech-solution/hablog)，涉及专有网络（VPC）、交换机（VSwitch）、RDS数据库（RDS）、云服务器（ECS）、应用型负载均衡器（ALB) 等资源的部署。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to implement solution [Cloud High Availability Architecture](https://www.aliyun.com/solution/tech-solution/hablog), which involves the creation and deployment of resources such as Virtual Private Cloud (Vpc), Virtual Switch (VSwitch), RDS Database (Rds), Elastic Compute Service (Ecs), and Application Load Balancer (Alb).
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
| [alicloud_alb_listener.alb_listener](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/alb_listener) | resource |
| [alicloud_alb_load_balancer.alb](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/alb_load_balancer) | resource |
| [alicloud_alb_server_group.alb_server_group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/alb_server_group) | resource |
| [alicloud_db_database.rds_database](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/db_database) | resource |
| [alicloud_db_instance.rds_instance](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/db_instance) | resource |
| [alicloud_ecs_command.install_app](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_command) | resource |
| [alicloud_ecs_command.prepare_data](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_command) | resource |
| [alicloud_ecs_invocation.invoke_app](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_invocation) | resource |
| [alicloud_ecs_invocation.invoke_script](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_invocation) | resource |
| [alicloud_instance.ecs_instance1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_instance.ecs_instance2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_rds_account.create_db_user](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/rds_account) | resource |
| [alicloud_security_group.security_group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_security_group_rule.security_group_rule1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_security_group_rule.security_group_rule2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.alb_vswitch3](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.alb_vswitch4](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.ecs_vswitch1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.ecs_vswitch2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.rds_vswitch5](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_alb_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/alb_zones) | data source |
| [alicloud_db_instance_classes.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/db_instance_classes) | data source |
| [alicloud_db_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/db_zones) | data source |
| [alicloud_images.instance_image](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/images) | data source |
| [alicloud_instance_types.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/instance_types) | data source |
| [alicloud_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_common_name"></a> [common\_name](#input\_common\_name) | 应用名称 | `string` | `"high-availability"` | no |
| <a name="input_database_name"></a> [database\_name](#input\_database\_name) | 数据名称，由 2 到 32 个小写字母组成，支持小写字母、数字和下划线，以小写字母开头。 | `string` | `"high_availability"` | no |
| <a name="input_db_password"></a> [db\_password](#input\_db\_password) | 数据库账号密码，长度8-30，必须包含三项（大写字母、小写字母、数字、 ()`~!@#$%^&*_-+=|{}[]:;'<>,.?/ 中的特殊符号）` | `string` | n/a | yes |
| <a name="input_db_user_name"></a> [db\_user\_name](#input\_db\_user\_name) | 数据库用户名，由 2 到 32 个小写字母组成，支持小写字母、数字和下划线，以小写字母开头。 | `string` | `"high_availability"` | no |
| <a name="input_ecs_instance_password"></a> [ecs\_instance\_password](#input\_ecs\_instance\_password) | 服务器登录密码,长度8-30，必须包含三项（大写字母、小写字母、数字、 ()`~!@#$%^&*_-+=|{}[]:;'<>,.?/ 中的特殊符号）` | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | 地域 | `string` | `"cn-hangzhou"` | no |
<!-- END_TF_DOCS -->