## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上创建创建伸缩组、伸缩配置、伸缩规则等弹性伸缩资源。
详情可查看[通过Terraform创建弹性伸缩资源](https://help.aliyun.com/document_detail/452290.html)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to create Auto Scaling resources, such as scaling groups, scaling configurations, and scaling rules on Alibaba Cloud.
More details in [Use Terraform to create Auto Scaling resources](https://help.aliyun.com/document_detail/452290.html).
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
| [alicloud_ess_scaling_configuration.configuration](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ess_scaling_configuration) | resource |
| [alicloud_ess_scaling_group.group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ess_scaling_group) | resource |
| [alicloud_ess_scaling_rule.rule](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ess_scaling_rule) | resource |
| [alicloud_security_group.security](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_security_group_rule.allow_all_tcp](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.vsw](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_image_id"></a> [image\_id](#input\_image\_id) | n/a | `string` | `"aliyun_2_1903_x64_20G_alibase_20210120.vhd"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | n/a | `string` | `"ecs.hfc7.xlarge"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-heyuan"` | no |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | n/a | `string` | `"cn-heyuan-b"` | no |
<!-- END_TF_DOCS -->
## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Create auto scaling resources](https://help.aliyun.com/document_detail/452290.html) 

<!-- docs-link --> 