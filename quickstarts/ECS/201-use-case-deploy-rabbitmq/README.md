## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上的云服务器ECS中部署开源的RabbitMQ。。
详情可查看[部署开源的RabbitMQ](https://help.aliyun.com/zh/ecs/use-cases/deploy-rabbitmq)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to deploy open source RabbitMQ on an Elastic Compute Service (ECS) instance on Alibaba Cloud.
More details in [Deploy open source RabbitMQ](https://help.aliyun.com/zh/ecs/use-cases/deploy-rabbitmq).
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
| [alicloud_ecs_command.deploy_rabbitmq](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_command) | resource |
| [alicloud_ecs_invocation.invocation](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_invocation) | resource |
| [alicloud_instance.rabbitmq_ecs](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_security_group.rabbitmq_sg](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_security_group_rule.allow_icmp_all](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_security_group_rule.allow_tcp_15672](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_security_group_rule.allow_tcp_22](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_security_group_rule.allow_tcp_80](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_vpc.rabbitmq_vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.rabbitmq_vsw](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_ip"></a> [access\_ip](#input\_access\_ip) | The IP address you used to access the ECS. | `string` | `"0.0.0.0/0"` | no |
| <a name="input_common_name"></a> [common\_name](#input\_common\_name) | Common name for resources. | `string` | `"deploy_rabbitmq_by_tf"` | no |
| <a name="input_image_id"></a> [image\_id](#input\_image\_id) | Image of instance. Supported only on Ubuntu. | `string` | `"ubuntu_22_04_x64_20G_alibase_20241224.vhd"` | no |
| <a name="input_instance_password"></a> [instance\_password](#input\_instance\_password) | Server login password, length 8-30, must contain three (Capital letters, lowercase letters, numbers, `~!@#$%^&*_-+=|{}[]:;'<>?,./ Special symbol in)` | `string` | `"Test@123456"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Instance type. | `string` | `"ecs.e-c1m2.large"` | no |
| <a name="input_rabbitmq_user_name"></a> [rabbitmq\_user\_name](#input\_rabbitmq\_user\_name) | Create a new user for RabbitMQ. | `string` | `"rabbitmq@new_user"` | no |
| <a name="input_rabbitmq_user_password"></a> [rabbitmq\_user\_password](#input\_rabbitmq\_user\_password) | Password for a new RabbitMQ user. | `string` | `"rabbitmq@pw12345"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-beijing"` | no |
| <a name="input_system_disk_category"></a> [system\_disk\_category](#input\_system\_disk\_category) | The category of the system disk. | `string` | `"cloud_essd"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Deploy open source RabbitMQ](https://help.aliyun.com/zh/ecs/use-cases/deploy-rabbitmq) 

<!-- docs-link --> 