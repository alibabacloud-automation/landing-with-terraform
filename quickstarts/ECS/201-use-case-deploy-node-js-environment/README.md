## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云ECS实例上手动部署Node.js环境。
详情可查看[手动部署Node.js环境](https://help.aliyun.com/document_detail/50775.html)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to manually deploy a Node.js environment on an Elastic Compute Service (ECS) instance on Alibaba Cloud.
More details in [Manually deploy a Node.js environment](https://help.aliyun.com/document_detail/50775.html).
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
| [alicloud_ecs_command.command](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_command) | resource |
| [alicloud_ecs_invocation.invocation](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_invocation) | resource |
| [alicloud_instance.instance](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_security_group.group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_security_group_rule.allow_all_tcp](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_security_group_rule.allow_icmp_all](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_security_group_rule.allow_tcp_443](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_security_group_rule.allow_tcp_80](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.vswitch](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_instances.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/instances) | data source |
| [alicloud_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_instance"></a> [create\_instance](#input\_create\_instance) | 如果要在现有实例上安装node.js，请将create\_instance设置为false，并将instance\_id设置为实例id。 | `bool` | `true` | no |
| <a name="input_image_id"></a> [image\_id](#input\_image\_id) | 镜像ID | `string` | `"aliyun_3_x64_20G_alibase_20240528.vhd"` | no |
| <a name="input_instance_id"></a> [instance\_id](#input\_instance\_id) | 实例ID | `string` | `""` | no |
| <a name="input_instance_password"></a> [instance\_password](#input\_instance\_password) | 实例登录密码 | `string` | `"Test@12345"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | 实例规格 | `string` | `"ecs.e-c1m2.large"` | no |
| <a name="input_name"></a> [name](#input\_name) | 实例名称 | `string` | `"terraform-example"` | no |
| <a name="input_region"></a> [region](#input\_region) | 地域 | `string` | `"cn-heyuan"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Manually deploy a Node.js environment](https://help.aliyun.com/document_detail/50775.html) 

<!-- docs-link --> 