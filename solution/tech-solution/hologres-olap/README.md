## Introduction
<!-- DOCS_DESCRIPTION_CN -->
本示例用于实现解决方案[高性能，搭建轻量 OLAP 分析平台
](https://www.aliyun.com/solution/tech-solution/hologres-olap)，涉及专有网络（VPC）、交换机（VSwitch）、实时数仓 Hologres（Hologres）等资源的部署。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to implement solution [Build a high-performance, lightweight OLAP platform](https://www.aliyun.com/solution/tech-solution/hologres-olap), which involves the creation and deployment of resources such as Virtual Private Cloud (VPC), Virtual Switch (VSwitch), Hologres  (Interactive Analytics).
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
| [alicloud_hologram_instance.hologram](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/hologram_instance) | resource |
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.vswitch](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [random_id.suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | 选择可用区 | `string` | `"cn-hangzhou-j"` | no |
<!-- END_TF_DOCS -->