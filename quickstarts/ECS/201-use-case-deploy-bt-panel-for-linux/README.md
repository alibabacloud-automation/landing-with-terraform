## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云的ECS实例上手动部署宝塔面板。
详情可查看[手动部署宝塔面板](https://help.aliyun.com/document_detail/2846544.html)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to deploy BT panel for Linux instance on Alibaba Cloud.
More details in [Deploy BT panel for Linux instance](https://help.aliyun.com/document_detail/2846544.html).
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
| [alicloud_ecs_command.install_content](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_command) | resource |
| [alicloud_ecs_invocation.invocation_install](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_invocation) | resource |
| [alicloud_instance.instance](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_security_group.group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_security_group_rule.allow_all_tcp](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_security_group_rule.allow_tcp_443](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_security_group_rule.allow_tcp_80](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.vswitch](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_instances.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/instances) | data source |
| [alicloud_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_instance"></a> [create\_instance](#input\_create\_instance) | n/a | `bool` | `true` | no |
| <a name="input_image_id"></a> [image\_id](#input\_image\_id) | 镜像ID | `string` | `"debian_12_8_x64_20G_alibase_20241216.vhd"` | no |
| <a name="input_instance_id"></a> [instance\_id](#input\_instance\_id) | 实例ID | `string` | `""` | no |
| <a name="input_instance_password"></a> [instance\_password](#input\_instance\_password) | 实例登录密码 | `string` | `"Test@12345"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | 实例规格 | `string` | `"ecs.e-c1m2.xlarge"` | no |
| <a name="input_name"></a> [name](#input\_name) | 实例名称 | `string` | `"terraform-example"` | no |
| <a name="input_region"></a> [region](#input\_region) | 地域 | `string` | `"cn-beijing"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Deploy BT panel for Linux instance](https://help.aliyun.com/document_detail/2846544.html) 

<!-- docs-link --> 