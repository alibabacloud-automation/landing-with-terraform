## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上使用阿里云RAM和资源组对ECS实例进行分组并授权，限制RAM用户只能查看和管理被授权ECS实例。
详情可查看[使用资源组限制RAM用户管理指定的ECS实例](https://help.aliyun.com/document_detail/306216.html)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to add an Elastic Compute Service (ECS) instance to a resource group and grant a Resource Access Management (RAM) user the permissions to view and manage the ECS instance in the resource group on Alibaba Cloud.
More details in [Use a resource group to grant a RAM user the permissions to manage a specific ECS instance](https://help.aliyun.com/document_detail/306216.html).
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
| [alicloud_instance.instance](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_ram_user.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_user) | resource |
| [alicloud_resource_manager_policy_attachment.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/resource_manager_policy_attachment) | resource |
| [alicloud_resource_manager_resource_group.ecs_admin](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/resource_manager_resource_group) | resource |
| [alicloud_security_group.group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_security_group_rule.allow_http](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_security_group_rule.allow_ssh](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.vswitch](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [random_integer.default](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |
| [alicloud_account.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/account) | data source |
| [alicloud_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_image_id"></a> [image\_id](#input\_image\_id) | 定义镜像ID变量，默认为一个示例镜像ID | `string` | `"centos_7_9_x64_20G_alibase_20240628.vhd"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | 定义实例类型变量，默认为 "ecs.e-c1m1.large" | `string` | `"ecs.e-c1m1.large"` | no |
| <a name="input_password"></a> [password](#input\_password) | 定义实例默认登陆密码 | `string` | `"Terraform@Example"` | no |
| <a name="input_region"></a> [region](#input\_region) | 定义区域变量，默认为 "cn-guangzhou" | `string` | `"cn-guangzhou"` | no |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | 定义VPC的CIDR块，默认为 "172.16.0.0/16" | `string` | `"172.16.0.0/16"` | no |
| <a name="input_vsw_cidr_block"></a> [vsw\_cidr\_block](#input\_vsw\_cidr\_block) | 定义VSwitch的CIDR块，默认为 "172.16.0.0/24" | `string` | `"172.16.0.0/24"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Use a resource group to grant a RAM user the permissions to manage a specific ECS instance](https://help.aliyun.com/document_detail/306216.html) 

<!-- docs-link --> 