<!-- DOCS_DESCRIPTION_CN -->
本示例用于实现解决方案[使用ARMS监控自建大模型应用实现可观测](https://www.aliyun.com/solution/tech-solution-deploy/2922005),  涉及到专有网络（VPC）、交换机（VSwitch）、云服务器（ECS）、RAM 用户等资源的创建。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to implement solution [build-an-observability-system-for-ai-applications-at-low-costs](https://www.aliyun.com/solution/tech-solution-deploy/2922005). It involves the creation, and deployment of resources such as Virtual Private Cloud (VPC), VSwitch, Elastic Compute Service (ECS), and RAM users.
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
| [alicloud_security_group_rule.allow_8000](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.vswitch](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/vswitch) | resource |
| [random_string.suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [alicloud_images.default](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/data-sources/images) | data source |
| [alicloud_regions.current_region_ds](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/data-sources/regions) | data source |
| [alicloud_zones.default](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_arms_license_key"></a> [arms\_license\_key](#input\_arms\_license\_key) | 当前环境 ARMS License Key。可以通过OpenAPI获取，前往<https://api.aliyun.com/api/ARMS/2019-08-08/DescribeTraceLicenseKey>，输入参数中填写RegionId（部署地域），单击发起调用，获取结果中LicenseKey对应的值。 | `string` | n/a | yes |
| <a name="input_bai_lian_api_key"></a> [bai\_lian\_api\_key](#input\_bai\_lian\_api\_key) | 百炼 API-KEY，需开通百炼模型服务再获取 API-KEY，详情请参考：https://help.aliyun.com/zh/model-studio/developer-reference/get-api-key | `string` | n/a | yes |
| <a name="input_ecs_instance_password"></a> [ecs\_instance\_password](#input\_ecs\_instance\_password) | 服务器登录密码,长度8-30，必须包含三项（大写字母、小写字母、数字、 ()`~!@#$%^&*_-+=|{}[]:;'<>,.?/ 中的特殊符号）` | `string` | n/a | yes |
| <a name="input_ecs_instance_type"></a> [ecs\_instance\_type](#input\_ecs\_instance\_type) | 实例类型 | `string` | `"ecs.t6-c1m2.large"` | no |
<!-- END_TF_DOCS -->