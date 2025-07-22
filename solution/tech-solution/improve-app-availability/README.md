## Introduction
<!-- DOCS_DESCRIPTION_CN -->
本示例用于实现解决方案[自动弹性，稳定交付](https://www.aliyun.com/solution/tech-solution/improve-app-availability), 涉及到专有网络（VPC）、交换机（VSwitch）、云服务器（ECS）、应用型负载均衡器（ALB) 、弹性伸缩（ESS）等资源的部署。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to implement solution [Auto Scaling and Stable Delivery](https://www.aliyun.com/solution/tech-solution/improve-app-availability), which involves the creation and deployment of resources such as Virtual Private Cloud (VPC), VSwitch, Elastic Compute Service (ECS), Application Load Balancer (ALB), and Elastic Scaling Service (ESS).
<!-- DOCS_DESCRIPTION_EN -->

<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |
| <a name="provider_time"></a> [time](#provider\_time) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_alb_listener.alb_listener](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/alb_listener) | resource |
| [alicloud_alb_load_balancer.alb](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/alb_load_balancer) | resource |
| [alicloud_alb_server_group.alb_server_group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/alb_server_group) | resource |
| [alicloud_ess_scaling_configuration.ess_scaling_configuration](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ess_scaling_configuration) | resource |
| [alicloud_ess_scaling_group.ess_scaling_group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ess_scaling_group) | resource |
| [alicloud_ess_scaling_rule.ess_scale_down_rule](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ess_scaling_rule) | resource |
| [alicloud_ess_scaling_rule.ess_scale_up_rule](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ess_scaling_rule) | resource |
| [alicloud_ess_scheduled_task.scheduled_scale_down_task](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ess_scheduled_task) | resource |
| [alicloud_ess_scheduled_task.scheduled_scale_up_task](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ess_scheduled_task) | resource |
| [alicloud_ess_server_group_attachment.ess_server_group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ess_server_group_attachment) | resource |
| [alicloud_security_group.security_group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_security_group_rule.security_group_http](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_security_group_rule.security_group_https](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.alb_vswitch_3](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.alb_vswitch_4](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.ecs_vswitch_1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.ecs_vswitch_2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [random_integer.default](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |
| [time_static.example](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/static) | resource |
| [alicloud_alb_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/alb_zones) | data source |
| [alicloud_images.instance_image](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/images) | data source |
| [alicloud_instance_types.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/instance_types) | data source |
| [alicloud_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_common_name"></a> [common\_name](#input\_common\_name) | 弹性应用名称 | `string` | `"elastic-app"` | no |
| <a name="input_ecs_instance_password"></a> [ecs\_instance\_password](#input\_ecs\_instance\_password) | 服务器登录密码,长度8-30，必须包含三项（大写字母、小写字母、数字、 ()`~!@#$%^&*_-+=|{}[]:;'<>,.?/中的特殊符号）` | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | 地域 | `string` | `"cn-hangzhou"` | no |
| <a name="input_scale_down_time"></a> [scale\_down\_time](#input\_scale\_down\_time) | 自动缩容执行时间 | `string` | `null` | no |
| <a name="input_scale_up_time"></a> [scale\_up\_time](#input\_scale\_up\_time) | 自动扩容执行时间 | `string` | `null` | no |
<!-- END_TF_DOCS -->