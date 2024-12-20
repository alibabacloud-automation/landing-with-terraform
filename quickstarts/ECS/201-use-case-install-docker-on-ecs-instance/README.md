## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例基于OOS模板在阿里云ECS实例上快速安装Docker。支持在新建的ECS实例上进行安装和在一个已有的ECS实例安装两种场景。
详情可查看[安装Docker](https://help.aliyun.com/zh/ecs/use-cases/install-and-use-docker-on-a-linux-ecs-instance)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example quickly installs Docker on an Alibaba Cloud ECS instance based on the OOS template. 
It supports two scenarios: installing on a newly created ECS instance and installing on an existing ECS instance.
More details in [Install Docker](https://www.alibabacloud.com/help/zh/ecs/use-cases/install-and-use-docker-on-a-linux-ecs-instance).
<!-- DOCS_DESCRIPTION_EN -->

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_instance.instance](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_oos_execution.install](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/oos_execution) | resource |
| [alicloud_security_group.sg](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_security_group_rule.allow_icmp_-1](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_security_group_rule.allow_tcp_22](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_security_group_rule.allow_tcp_3389](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_security_group_rule.allow_tcp_80](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.vsw](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_zones.default](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_instance"></a> [create\_instance](#input\_create\_instance) | If you want to install docker on an existing instance, set create\_instance to false and set instance\_id to the instance id. | `bool` | `true` | no |
| <a name="input_image_id"></a> [image\_id](#input\_image\_id) | n/a | `string` | `"ubuntu_18_04_64_20G_alibase_20190624.vhd"` | no |
| <a name="input_instance_id"></a> [instance\_id](#input\_instance\_id) | n/a | `string` | `""` | no |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | n/a | `string` | `"deploying-docker"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | n/a | `string` | `"ecs.n1.tiny"` | no |
| <a name="input_internet_bandwidth"></a> [internet\_bandwidth](#input\_internet\_bandwidth) | n/a | `number` | `10` | no |
| <a name="input_password"></a> [password](#input\_password) | n/a | `string` | `"Test@12345"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-shanghai"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ecs_login_address"></a> [ecs\_login\_address](#output\_ecs\_login\_address) | n/a |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link -->

The template is based on Aliyun document: [Install Docker on Ecs with Terraform](https://help.aliyun.com/zh/ecs/use-cases/install-and-use-docker-on-a-linux-ecs-instance)

<!-- docs-link -->