## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上使用BGP（多线）_精品线路EIP，实现中国内地终端用户到中国香港或其他海外地域服务的低时延访问。
详情可查看[使用BGP（多线）精品线路EIP低时延访问Web服务](https://help.aliyun.com/zh/eip/use-cases/use-bgp-pro-eips-to-access-web-services-with-low-network-latency)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to use BGP (Multi-ISP) Pro elastic IP addresses (EIPs) to optimize data transmission to the Chinese mainland.
More details in [Use BGP (Multi-ISP) Pro EIPs to access web services with low network latency](https://help.aliyun.com/zh/eip/use-cases/use-bgp-pro-eips-to-access-web-services-with-low-network-latency).
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
| [alicloud_eip_address.a](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/eip_address) | resource |
| [alicloud_eip_address.b](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/eip_address) | resource |
| [alicloud_eip_association.ecs_a](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/eip_association) | resource |
| [alicloud_eip_association.ecs_b](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/eip_association) | resource |
| [alicloud_instance.a](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_instance.b](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_security_group.a](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_security_group_rule.a](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_vpc.a](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.a1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [random_integer.default](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_image_id"></a> [image\_id](#input\_image\_id) | n/a | `string` | `"aliyun_3_x64_20G_alibase_20241103.vhd"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | n/a | `string` | `"ecs.e-c1m1.large"` | no |
| <a name="input_master_zone"></a> [master\_zone](#input\_master\_zone) | n/a | `string` | `"cn-hongkong-b"` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"ecs"` | no |
| <a name="input_password"></a> [password](#input\_password) | n/a | `string` | `"Test123@"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-hongkong"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Use BGP (Multi-ISP) Pro EIPs to access web services with low network latency](https://help.aliyun.com/zh/eip/use-cases/use-bgp-pro-eips-to-access-web-services-with-low-network-latency) 

<!-- docs-link --> 