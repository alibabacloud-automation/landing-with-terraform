## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云云服务器ECS上基于Alibaba Cloud Linux 3操作系统搭建高可用的微信小程序服务端，并在本地开发一个名为ECS小助手的简单微信小程序。
详情可查看[搭建高可用的微信小程序服务（Alibaba Cloud Linux 3）](https://help.aliyun.com/document_detail/2412552.html)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to build high availability Wechat mini program on Alibaba Cloud ECS based on Alibaba Cloud Linux 3 operating system.
More details in [Build high availability Wechat mini program](https://help.aliyun.com/document_detail/2412552.html).
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
| [alicloud_ecs_command.deploy](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_command) | resource |
| [alicloud_ecs_invocation.invocation](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_invocation) | resource |
| [alicloud_eip_address.eip](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/eip_address) | resource |
| [alicloud_eip_association.clb_ip](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/eip_association) | resource |
| [alicloud_instance.ecs_instance](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_ram_policy.policy](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_policy) | resource |
| [alicloud_ram_role.role](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_role) | resource |
| [alicloud_ram_role_attachment.attach](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_role_attachment) | resource |
| [alicloud_ram_role_policy_attachment.attach](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_role_policy_attachment) | resource |
| [alicloud_security_group.sg](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_security_group_rule.allow_80](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_security_group_rule.allow_ssh](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_slb_attachment.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/slb_attachment) | resource |
| [alicloud_slb_listener.listener](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/slb_listener) | resource |
| [alicloud_slb_load_balancer.instance](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/slb_load_balancer) | resource |
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.vswitch](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_common_name"></a> [common\_name](#input\_common\_name) | Common name for resources | `string` | `"deploy-java-web-by-terraform"` | no |
| <a name="input_ecs_ram_role_name"></a> [ecs\_ram\_role\_name](#input\_ecs\_ram\_role\_name) | English letters, numbers, or ' - ' are allowed. The number of characters should be less than or equal to 64. | `string` | `"EcsRoleForMiniProgramServer"` | no |
| <a name="input_image_id"></a> [image\_id](#input\_image\_id) | Please choose the Alibaba Cloud Linux 3 Image ID for the instance | `string` | `"aliyun_3_x64_20G_alibase_20240528.vhd"` | no |
| <a name="input_instance_count"></a> [instance\_count](#input\_instance\_count) | The number of ECS instances to create. | `string` | `"2"` | no |
| <a name="input_instance_password"></a> [instance\_password](#input\_instance\_password) | Server login password | `string` | `"Test@123456"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Instance type | `string` | `"ecs.e-c1m2.large"` | no |
| <a name="input_region"></a> [region](#input\_region) | Region where resources will be created | `string` | `"cn-beijing"` | no |
| <a name="input_system_disk_category"></a> [system\_disk\_category](#input\_system\_disk\_category) | The category of the system disk. | `string` | `"cloud_essd"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Build high availability Wechat mini program](https://help.aliyun.com/document_detail/2412552.html) 

<!-- docs-link --> 