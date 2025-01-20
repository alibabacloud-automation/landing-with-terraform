## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上基于ECS部署和使用SVN。
详情可查看[部署和使用SVN](https://help.aliyun.com/zh/ecs/use-cases/deploying-and-using-svn)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to deploy and use SVN on Elastic Compute Service (ECS) on Alibaba Cloud.
More details in [Deploy and use SVN](https://help.aliyun.com/zh/ecs/use-cases/deploying-and-using-svn).
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
| [alicloud_security_group.group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_security_group_rule.allow_http](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_security_group_rule.allow_https](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_security_group_rule.allow_ssh](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.vswitch](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [random_integer.default](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |
| [alicloud_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | 定义实例类型变量，默认为 "ecs.c6.large"（适用于Ubuntu的实例类型） | `string` | `"ecs.c6.large"` | no |
| <a name="input_password"></a> [password](#input\_password) | 定义实例默认登录密码 | `string` | `"Terraform@Example"` | no |
| <a name="input_region"></a> [region](#input\_region) | 定义区域变量，默认为 "cn-guangzhou" | `string` | `"cn-guangzhou"` | no |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | 定义VPC的CIDR块，默认为 "172.16.0.0/16" | `string` | `"172.16.0.0/16"` | no |
| <a name="input_vsw_cidr_block"></a> [vsw\_cidr\_block](#input\_vsw\_cidr\_block) | 定义VSwitch的CIDR块，默认为 "172.16.0.0/24" | `string` | `"172.16.0.0/24"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Deploy and use SVN](https://help.aliyun.com/zh/ecs/use-cases/deploying-and-using-svn) 

<!-- docs-link --> 