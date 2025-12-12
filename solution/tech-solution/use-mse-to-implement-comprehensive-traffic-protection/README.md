## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于实现解决方案[MSE 助力实现全方位流量防护](https://www.aliyun.com/solution/tech-solution/use-mse-to-implement-comprehensive-traffic-protection),  涉及到专有网络（VPC）、交换机（VSwitch）、云服务器（ECS）等资源的创建。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to implement solution [use-mse-to-implement-comprehensive-traffic-protection](https://www.aliyun.com/solution/tech-solution/use-mse-to-implement-comprehensive-traffic-protection). It involves the creation, and deployment of resources such as Virtual Private Cloud (VPC), VSwitch, Elastic Compute Service (ECS).
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
| [alicloud_ecs_command.run_command](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ecs_command) | resource |
| [alicloud_ecs_invocation.invoke_script](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ecs_invocation) | resource |
| [alicloud_instance.ecs_instance](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_ram_access_key.ramak](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ram_access_key) | resource |
| [alicloud_ram_user.ram_user](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ram_user) | resource |
| [alicloud_ram_user_policy_attachment.attach_policy_to_user](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ram_user_policy_attachment) | resource |
| [alicloud_security_group.security_group](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_security_group_rule.allow_80](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.vswitch](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/vswitch) | resource |
| [random_string.suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [alicloud_images.default](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/data-sources/images) | data source |
| [alicloud_regions.current_region_ds](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/data-sources/regions) | data source |
| [alicloud_zones.default](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ecs_instance_password"></a> [ecs\_instance\_password](#input\_ecs\_instance\_password) | 服务器登录密码,长度8-30，必须包含三项（大写字母、小写字母、数字、 ()`~!@#$%^&*_-+=|{}[]:;'<>,.?/ 中的特殊符号）` | `string` | n/a | yes |
| <a name="input_ecs_instance_type"></a> [ecs\_instance\_type](#input\_ecs\_instance\_type) | 实例类型 | `string` | `"ecs.t6-c1m2.large"` | no |
| <a name="input_mse_license_key"></a> [mse\_license\_key](#input\_mse\_license\_key) | 当前环境 MSE License Key。登录MSE控制台：https://mse.console.aliyun.com，点击治理中心 > 应用治理，在顶部选择地域, 在右上角点击查看License Key，获取MSE License Key。 | `string` | n/a | yes |
<!-- END_TF_DOCS -->