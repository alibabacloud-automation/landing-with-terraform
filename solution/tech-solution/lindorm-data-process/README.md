## Introduction
<!-- DOCS_DESCRIPTION_CN -->
本示例用于实现解决方案[泛时序数据一站式分析与洞察](https://www.aliyun.com/solution/tech-solution/lindorm-data-process)，涉及专有网络（VPC）、交换机（VSwitch）、云服务器（ECS）、云原生多模数据库 Lindorm（Lindorm）等资源的部署。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to implement solution [Unified Time-Series Data Analysis and Insights
](https://www.aliyun.com/solution/tech-solution/lindorm-data-process), which involves the creation and deployment of resources such as Virtual Private Cloud (VPC), Virtual Switch (VSwitch), Elastic Compute Service (ECS), Lindorm Database（Lindorm）.
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
| [alicloud_ecs_command.deploy_application_on_ecs_alicloud_ecs_command](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_command) | resource |
| [alicloud_ecs_invocation.deploy_application_on_ecs_alicloud_ecs_invocation](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_invocation) | resource |
| [alicloud_instance.ecs_instance](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_lindorm_instance.lindorm_instance](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/lindorm_instance) | resource |
| [alicloud_security_group.security_group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.vswitch](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [random_string.lowercase](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [alicloud_images.alinux3](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/images) | data source |
| [alicloud_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_instance_password"></a> [instance\_password](#input\_instance\_password) | ECS实例密码 | `string` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | ECS实例类型 | `string` | `"ecs.e-c1m4.2xlarge"` | no |
<!-- END_TF_DOCS -->