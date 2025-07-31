<!-- DOCS_DESCRIPTION_CN -->
本示例用于实现解决方案[低成本搭建 DeepSeek 专属 AI 网站](https://www.aliyun.com/solution/tech-solution/ecs-and-deepseek-build-personal-website), 涉及到专有网络（VPC）、交换机（VSwitch）、云服务器（ECS）、RAM 用户等资源的创建。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to implement solution [ECS and Deepseek Build Personal Website](https://www.aliyun.com/solution/tech-solution/ecs-and-deepseek-build-personal-website), which involves the creation and deployment of resources such as Virtual Private Cloud (VPC), VSwitch, Elastic Compute Service (ECS), and RAM users.
<!-- DOCS_DESCRIPTION_EN --

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
| [alicloud_ecs_command.install_app](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_command) | resource |
| [alicloud_ecs_invocation.invoke_script](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_invocation) | resource |
| [alicloud_instance.ecs_instance](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_ram_user.user](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_user) | resource |
| [alicloud_security_group.security_group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_security_group_rule.allow_tcp_8080](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.vswitch](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [random_id.suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [alicloud_regions.current](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/regions) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_CommonName"></a> [CommonName](#input\_CommonName) | n/a | `string` | `"deepseek-private-ai"` | no |
| <a name="input_InstanceType"></a> [InstanceType](#input\_InstanceType) | {<br/>    "AssociationProperty": "ALIYUN::ECS::Instance::InstanceType",<br/>    "AssociationPropertyMetadata": {<br/>      "ZoneId": "${ZoneId}",<br/>      "InstanceChargeType": "PostPaid",<br/>      "SystemDiskCategory": "cloud\_essd",<br/>      "Constraints": {<br/>        "Architecture": ["X86"],<br/>        "vCPU": [2],<br/>        "Memory": [2]<br/>      }<br/>    },<br/>    "Label": {<br/>      "zh-cn": "实例类型",<br/>      "en": "Instance Type"<br/>    }<br/>  } | `string` | `"ecs.e-c1m1.large"` | no |
| <a name="input_ZoneId"></a> [ZoneId](#input\_ZoneId) | {<br/>    "AssociationProperty": "ALIYUN::ECS::Instance::ZoneId",<br/>    "Description": {<br/>      "zh-cn": "可用区",<br/>      "en": "Availability Zone"<br/>    },<br/>    "Label": {<br/>      "zh-cn": "可用区",<br/>      "en": "Availability Zone"<br/>    }<br/>  } | `string` | `"cn-hangzhou-f"` | no |
| <a name="input_bai_lian_api_key"></a> [bai\_lian\_api\_key](#input\_bai\_lian\_api\_key) | 百炼 API-KEY，需开通百炼模型服务再获取 API-KEY，详情请参考：https://help.aliyun.com/zh/model-studio/developer-reference/get-api-key | `string` | n/a | yes |
| <a name="input_ecs_instance_password"></a> [ecs\_instance\_password](#input\_ecs\_instance\_password) | 服务器登录密码,长度8-30，必须包含三项（大写字母、小写字母、数字、 ()`~!@#$%^&*_-+=|{}[]:;'<>,.?/ 中的特殊符号）` | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | 地域，例如：cn-hangzhou。所有地域及可用区请参见文档：https://help.aliyun.com/document_detail/40654.html#09f1dc16b0uke | `string` | `"cn-hangzhou"` | no |
<!-- END_TF_DOCS -->