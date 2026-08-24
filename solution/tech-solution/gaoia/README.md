## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于实现解决方案[互联网应用全球加速](https://www.aliyun.com/solution/tech-solution/gaoia), 涉及到GA、NLB、VPC、vSwitch、ECS等资源的部署。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to implement solution [Global acceleration of Internet applications](https://www.aliyun.com/solution/tech-solution/gaoia), which involves the creation and deployment of resources such as ga, nlb, vpc, vSwitch, and ecs.
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
| [alicloud_ecs_command.run_command_ecs01](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_command) | resource |
| [alicloud_ecs_command.run_command_ecs02](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_command) | resource |
| [alicloud_ecs_invocation.invoke_script_ecs01](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_invocation) | resource |
| [alicloud_ecs_invocation.invoke_script_ecs02](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_invocation) | resource |
| [alicloud_ga_accelerator.accelerator](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ga_accelerator) | resource |
| [alicloud_ga_ip_set.accelerate_region](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ga_ip_set) | resource |
| [alicloud_ga_listener.ga_listener](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ga_listener) | resource |
| [alicloud_instance.ecs_instance_01](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_instance.ecs_instance_02](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_nlb_listener.nlb_listener](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/nlb_listener) | resource |
| [alicloud_nlb_load_balancer.nlb_load_balancer](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/nlb_load_balancer) | resource |
| [alicloud_nlb_server_group.nlb_server_group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/nlb_server_group) | resource |
| [alicloud_nlb_server_group_server_attachment.server_attachment1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/nlb_server_group_server_attachment) | resource |
| [alicloud_nlb_server_group_server_attachment.server_attachment2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/nlb_server_group_server_attachment) | resource |
| [alicloud_security_group.security_group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_security_group_rule.allow_tcp_80](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.vswitch1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.vswitch2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_accelerate_region_id"></a> [accelerate\_region\_id](#input\_accelerate\_region\_id) | 加速地域ID | `string` | `"cn-hongkong"` | no |
| <a name="input_ecs_instance_password"></a> [ecs\_instance\_password](#input\_ecs\_instance\_password) | 服务器登录密码,长度8-30，必须包含三项（大写字母、小写字母、数字、 ()`~!@#$%^&*_-+=|{}[]:;'<>,.?/ 中的特殊符号）` | `string` | n/a | yes |
| <a name="input_ecs_instance_type"></a> [ecs\_instance\_type](#input\_ecs\_instance\_type) | ECS实例规格 | `string` | `"ecs.e-c1m1.large"` | no |
| <a name="input_region"></a> [region](#input\_region) | 资源部署地域 | `string` | `"us-east-1"` | no |
| <a name="input_zone1"></a> [zone1](#input\_zone1) | 交换机可用区1 | `string` | `"us-east-1a"` | no |
| <a name="input_zone2"></a> [zone2](#input\_zone2) | 交换机可用区2，请确保交换机可用区2与交换机可用区1不相同 | `string` | `"us-east-1b"` | no |
<!-- END_TF_DOCS -->