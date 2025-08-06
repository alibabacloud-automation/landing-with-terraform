## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于实现解决方案[高效搭建 AI 智能体与工作流应用](https://www.aliyun.com/solution/tech-solution/build-ai-applications-based-on-alibaba-cloud-model-studio), 涉及到 专有网络（VPC）、交换机（VSwitch）、云服务器（ECS） 等资源的创建。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to implement solution [Efficiently build AI agents and workflow applications](https://www.aliyun.com/solution/tech-solution/build-ai-applications-based-on-alibaba-cloud-model-studio), which involves the creation and deployment of resources such as Virtual Private Cloud (VPC), VSwitch, Elastic Compute Service (ECS).
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
| [alicloud_ecs_command.run_script](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_command) | resource |
| [alicloud_ecs_invocation.run_command](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_invocation) | resource |
| [alicloud_instance.ecs_instance](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_security_group.security_group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_security_group_rule.allow_http](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.vswitch](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_regions.current](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/regions) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bai_lian_api_key"></a> [bai\_lian\_api\_key](#input\_bai\_lian\_api\_key) | 百炼 API-KEY，需开通百炼模型服务再获取 API-KEY，详情请参考：https://help.aliyun.com/zh/model-studio/developer-reference/get-api-key | `string` | n/a | yes |
| <a name="input_common_name"></a> [common\_name](#input\_common\_name) | Common name prefix for resources | `string` | `"BaiLian"` | no |
| <a name="input_ecs_instance_password"></a> [ecs\_instance\_password](#input\_ecs\_instance\_password) | 服务器登录密码,长度8-30，必须包含三项（大写字母、小写字母、数字、 ()`~!@#$%^&*_-+=|{}[]:;'<>,.?/ 中的特殊符号）` | `string` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | {<br/>    "Label": {<br/>      "en": "Instance Type",<br/>      "zh-cn": "实例规格"<br/>    },<br/>    "AssociationProperty": "ALIYUN::ECS::Instance::InstanceType",<br/>    "AssociationPropertyMetadata": {<br/>      "InstanceChargeType": "PostPaid",<br/>      "SystemDiskCategory": "cloud\_essd"<br/>    }<br/>  } | `string` | `"ecs.e-c1m2.large"` | no |
| <a name="input_region"></a> [region](#input\_region) | 地域，例如：cn-hangzhou。所有地域及可用区请参见文档：https://help.aliyun.com/document_detail/40654.html#09f1dc16b0uke | `string` | `"cn-hangzhou"` | no |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | {<br/>    "Label": {<br/>      "en": "Availability Zone",<br/>      "zh-cn": "可用区"<br/>    },<br/>    "AssociationProperty": "ALIYUN::ECS::Instance::ZoneId"<br/>  } | `string` | `"cn-hangzhou-h"` | no |
<!-- END_TF_DOCS --> 