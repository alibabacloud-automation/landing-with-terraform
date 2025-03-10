## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云的ECS实例上手动部署LNMP环境。
详情可查看[手动部署LNMP环境](https://help.aliyun.com/document_detail/97251.html)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to deploy an LNMP stack (Linux, NGINX, MySQL, and PHP) on an Elastic Compute Service (ECS) instance on Alibaba Cloud.
More details in [Deploy an LNMP stack](https://help.aliyun.com/document_detail/97251.html).
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
| <a name="input_disk_category"></a> [disk\_category](#input\_disk\_category) | n/a | `string` | `"cloud_essd"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | n/a | `string` | `"ecs.c6.large"` | no |
| <a name="input_password"></a> [password](#input\_password) | n/a | `string` | `"Terraform@Example123!"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-guangzhou"` | no |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | n/a | `string` | `"172.16.0.0/16"` | no |
| <a name="input_vsw_cidr_block"></a> [vsw\_cidr\_block](#input\_vsw\_cidr\_block) | n/a | `string` | `"172.16.0.0/24"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Deploy an LNMP stack](https://help.aliyun.com/document_detail/97251.html) 

<!-- docs-link --> 