## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上创建一台ECS实例并部署DeepSite应用，涉及到专有网络VPC、虚拟交换机vSwitch、安全组等资源的创建和部署。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to create an ECS instance on Alibaba Cloud and deploy DeepSite applications, involving the creation and deployment of proprietary network VPC, virtual switch vSwitch, security group and other resources.
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
| [alicloud_ecs_command.install_app](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_command) | resource |
| [alicloud_ecs_invocation.run_install](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_invocation) | resource |
| [alicloud_instance.ecs_instance](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_security_group.security_group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_security_group_rule.allow_tcp_443](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_security_group_rule.allow_tcp_80](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_security_group_rule.allow_tcp_8080](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.vswitch](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [random_id.suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [alicloud_regions.current](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/regions) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ecs_instance_password"></a> [ecs\_instance\_password](#input\_ecs\_instance\_password) | {<br/>    "Label": {<br/>      "en": "Instance Password",<br/>      "zh-cn": "实例密码"<br/>    },<br/>    "Description": {<br/>      "en": "Server login password, Length 8-30, must contain three(Capital letters, lowercase letters, numbers, ()\`~!@#$%^&*_-+=|{}[]:;'<>,.?/ Special symbol in)",<br/>      "zh-cn": "服务器登录密码，长度8-30，必须包含三项（大写字母、小写字母、数字、 ()\`~!@#$%^&*\_-+=\|{}[]:;'<>,.?/ 中的特殊符号）"<br/>    },<br/>    "ConstraintDescription": {<br/>      "en": "Length 8-30, must contain three(Capital letters, lowercase letters, numbers, ()\`~!@#$%^&*_-+=|{}[]:;'<>,.?/ Special symbol in)",<br/>      "zh-cn": "长度8-30，必须包含三项（大写字母、小写字母、数字、 ()\`~!@#$%^&*\_-+=\|{}[]:;'<>,.?/ 中的特殊符号）"<br/>    },<br/>    "AssociationProperty": "ALIYUN::ECS::Instance::Password"<br/>  } | `string` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | {<br/>    "Label": {<br/>      "en": "Instance Type",<br/>      "zh-cn": "实例类型"<br/>    },<br/>    "AssociationProperty": "ALIYUN::ECS::Instance::InstanceType",<br/>    "AssociationPropertyMetadata": {<br/>      "ZoneId": "${zone\_id}",<br/>      "InstanceChargeType": "PostPaid",<br/>      "SystemDiskCategory": "cloud\_essd\_entry",<br/>      "Constraints": {<br/>        "Architecture": ["X86"],<br/>        "vCPU": [2],<br/>        "Memory": [4]<br/>      }<br/>    },<br/>    "Description": {<br/>      "zh-cn": "推荐规格：ecs.e-c1m2.large（2 vCPU 4 GiB）",<br/>      "en": "Recommended: ecs.e-c1m2.large (2 vCPU 4 GiB)"<br/>    }<br/>  } | `string` | `"ecs.e-c1m2.large"` | no |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | {<br/>    "Label": {<br/>      "en": "Availability Zone",<br/>      "zh-cn": "可用区"<br/>    },<br/>    "AssociationProperty": "ALIYUN::ECS::Instance::ZoneId",<br/>    "AssociationPropertyMetadata": {<br/>      "RegionId": "cn-shanghai",<br/>      "AutoSelectFirst": true<br/>    }<br/>  } | `string` | `"cn-shanghai-b"` | no |
<!-- END_TF_DOCS -->