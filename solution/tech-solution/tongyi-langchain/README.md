## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于实现解决方案[通义千问和 LangChain 搭建对话服务](https://www.aliyun.com/solution/tech-solution/tongyi-langchain), 涉及到PAI-EAS实例（PAI-EAS）、专有网络（VPC）、交换机（VSwitch）、文件存储（NAS）等资源的创建。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to implement solution [Building a conversation service with Qwen and LangChain](https://www.aliyun.com/solution/tech-solution/tongyi-langchain), which involves the creation and deployment of resources such as PAI-EAS,Virtual Private Cloud (VPC), VSwitch, File Storage NAS(NAS).
<!-- DOCS_DESCRIPTION_EN -->
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
| [alicloud_nas_access_group.nas_access_group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/nas_access_group) | resource |
| [alicloud_nas_access_rule.nas_access_rule](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/nas_access_rule) | resource |
| [alicloud_nas_file_system.nas_file_system](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/nas_file_system) | resource |
| [alicloud_nas_mount_target.nas_mount_target](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/nas_mount_target) | resource |
| [alicloud_pai_service.pai_eas](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/pai_service) | resource |
| [alicloud_security_group.security_group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_security_group_rule.allow_http](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_security_group_rule.allow_https](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_security_group_rule.allow_rdp](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.vswitch](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [random_string.random_string](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [alicloud_regions.current](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/regions) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | PAI-EAS实例规格 | `string` | `"ml.gu7i.c8m30.1-gu30"` | no |
| <a name="input_region"></a> [region](#input\_region) | 地域，例如：cn-hangzhou。所有地域及可用区请参见文档：https://help.aliyun.com/document_detail/40654.html#09f1dc16b0uke | `string` | `"cn-hangzhou"` | no |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | 可用区ID | `string` | `"cn-hangzhou-f"` | no |
<!-- END_TF_DOCS -->