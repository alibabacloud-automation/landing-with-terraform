## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于实现解决方案[10分钟完成前后端分离架构升级（SAE版）](https://www.aliyun.com/solution/tech-solution-deploy/2866912),  涉及到专有网络（VPC）、交换机（VSwitch）、Serverless应用引擎（SAE）等资源的创建。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to implement solution [The Headless Architecture Solution of Alibaba Cloud(SAE)](https://www.aliyun.com/solution/tech-solution-deploy/2866912). It involves the creation, and deployment of resources such as Virtual Private Cloud (VPC), VSwitch, Serverless App Engine (SAE).
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
| [alicloud_sae_application.sae_backend_app](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/sae_application) | resource |
| [alicloud_sae_application.sae_frontend_app](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/sae_application) | resource |
| [alicloud_sae_config_map.nginx_config_map](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/sae_config_map) | resource |
| [alicloud_sae_load_balancer_internet.sae_slb_frontend](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/sae_load_balancer_internet) | resource |
| [alicloud_sae_load_balancer_intranet.sae_slb_backend](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/sae_load_balancer_intranet) | resource |
| [alicloud_sae_namespace.sae_namespace](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/sae_namespace) | resource |
| [alicloud_security_group.security_group_backend](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_security_group.security_group_frontend](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_slb_load_balancer.slb_backend](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/slb_load_balancer) | resource |
| [alicloud_slb_load_balancer.slb_frontend](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/slb_load_balancer) | resource |
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.vswitch_1](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.vswitch_2](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.vswitch_3](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.vswitch_4](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/vswitch) | resource |
| [random_string.suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [alicloud_zones.default](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-hangzhou"` | no |
<!-- END_TF_DOCS -->