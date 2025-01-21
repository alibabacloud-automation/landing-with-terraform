## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上Linux系统的ECS实例上使用Nginx搭建多个Web站点。
详情可查看[Nginx服务配置多站点](https://help.aliyun.com/zh/ecs/use-cases/build-multiple-websites-on-a-linux-instance)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to use NGINX to build multiple websites on a Linux ECS instance on Alibaba Cloud.
More details in [Use NGINX to configure multiple websites](https://help.aliyun.com/zh/ecs/use-cases/build-multiple-websites-on-a-linux-instance).
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
| [alicloud_security_group_rule.allow_ssh](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.vswitch](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [random_integer.default](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |
| [alicloud_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_disk_category"></a> [disk\_category](#input\_disk\_category) | 定义变量 disk\_category，指定磁盘类型，默认值为 cloud\_essd | `string` | `"cloud_essd"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | 定义变量 instance\_type，类型为字符串，指定实例类型，默认值为 ecs.c6.large | `string` | `"ecs.c6.large"` | no |
| <a name="input_password"></a> [password](#input\_password) | 定义变量 password，指定实例的密码，默认值为 Terraform@Example123! | `string` | `"Terraform@Example123!"` | no |
| <a name="input_region"></a> [region](#input\_region) | 定义变量 region，用于指定阿里云的区域，默认值为 cn-guangzhou | `string` | `"cn-guangzhou"` | no |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | 定义变量 vpc\_cidr\_block，指定 VPC 的 CIDR 块，默认值为 172.16.0.0/16 | `string` | `"172.16.0.0/16"` | no |
| <a name="input_vsw_cidr_block"></a> [vsw\_cidr\_block](#input\_vsw\_cidr\_block) | 定义变量 vsw\_cidr\_block，指定 VSwitch 的 CIDR 块，默认值为 172.16.0.0/24 | `string` | `"172.16.0.0/24"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Use NGINX to configure multiple websites](https://help.aliyun.com/zh/ecs/use-cases/build-multiple-websites-on-a-linux-instance) 

<!-- docs-link --> 