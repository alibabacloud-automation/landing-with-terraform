## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上创建一台ECS实例，涉及到专有网络VPC、虚拟交换机vSwitch、安全组、弹性计算实例等资源的创建和部署。
详情可查看[创建一台ECS实例](https://help.aliyun.com/zh/ecs/developer-reference/terraform/)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to create an ECS instance on Alibaba Cloud, which involves the creation and deployment of resources such as Virtual Private Cloud, virtual Switches, security groups, and Elastic Compute Service instances.
More details in [Create an ECS instance](https://help.aliyun.com/zh/ecs/developer-reference/terraform/).
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
| [alicloud_security_group_rule.allow_all_tcp](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.vswitch](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [random_integer.default](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |
| [alicloud_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | 定义一个字符串类型的变量instance\_type，默认值为"ecs.e-c1m1.large"，用于指定ECS实例类型 | `string` | `"ecs.e-c1m1.large"` | no |
| <a name="input_region"></a> [region](#input\_region) | 定义一个变量region，默认值为"cn-beijing"，用于指定阿里云区域 | `string` | `"cn-beijing"` | no |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | 定义一个变量vpc\_cidr\_block，默认值为"172.16.0.0/16"，用于指定VPC的CIDR块 | `string` | `"172.16.0.0/16"` | no |
| <a name="input_vsw_cidr_block"></a> [vsw\_cidr\_block](#input\_vsw\_cidr\_block) | 定义一个变量vsw\_cidr\_block，默认值为"172.16.0.0/24"，用于指定VSwitch的CIDR块 | `string` | `"172.16.0.0/24"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Create an ECS instance](https://help.aliyun.com/zh/ecs/developer-reference/terraform/) 

<!-- docs-link --> 