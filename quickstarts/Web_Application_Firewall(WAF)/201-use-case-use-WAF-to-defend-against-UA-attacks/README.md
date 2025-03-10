## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上利用Web应用防火墙（Web Application Firewall，简称WAF）3.0的自定义防护功能来防御异常用户代理（UA）对源站的攻击。
详情可查看[通过WAF自定义防护功能抵御异常UA攻击](https://help.aliyun.com/document_detail/2804234.html)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to use the custom rule module of Web Application Firewall (WAF) 3.0 to defend against UA attacks.
More details in [Use the custom rule module of WAF to defend against UA attacks](https://help.aliyun.com/document_detail/2804234.html).
<!-- DOCS_DESCRIPTION_EN -->

<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |
| <a name="provider_time"></a> [time](#provider\_time) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_instance.instance](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_security_group.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_security_group_rule.allow_tcp_22](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_security_group_rule.allow_tcp_443](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_security_group_rule.allow_tcp_80](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_slb_listener.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/slb_listener) | resource |
| [alicloud_slb_load_balancer.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/slb_load_balancer) | resource |
| [alicloud_slb_server_group.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/slb_server_group) | resource |
| [alicloud_slb_server_group_server_attachment.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/slb_server_group_server_attachment) | resource |
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.vswitch](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [random_integer.example](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |
| [time_sleep.example](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [alicloud_zones.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_image_id"></a> [image\_id](#input\_image\_id) | Image of instance. | `string` | `"aliyun_3_x64_20G_alibase_20250117.vhd"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Instance type. | `string` | `"ecs.e-c1m1.large"` | no |
| <a name="input_internet_bandwidth"></a> [internet\_bandwidth](#input\_internet\_bandwidth) | The maximum outbound public bandwidth. Unit: Mbit/s. Valid values: 0 to 100. | `string` | `"10"` | no |
| <a name="input_password"></a> [password](#input\_password) | Server login password, length 8-30, must contain three (Capital letters, lowercase letters, numbers, `~!@#$%^&*_-+=|{}[]:;'<>?,./ Special symbol in)` | `string` | `"Terraform@Example"` | no |
| <a name="input_region"></a> [region](#input\_region) | 资源将要创建的地域 | `string` | `"cn-beijing"` | no |
| <a name="input_source_ip"></a> [source\_ip](#input\_source\_ip) | The IP address you used to access the ECS. | `string` | `"0.0.0.0/0"` | no |
| <a name="input_system_disk_category"></a> [system\_disk\_category](#input\_system\_disk\_category) | The category of the system disk. | `string` | `"cloud_essd"` | no |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | 专有网络VPC网段 | `string` | `"172.16.0.0/16"` | no |
| <a name="input_vswitch_cidr_block"></a> [vswitch\_cidr\_block](#input\_vswitch\_cidr\_block) | 交换机VSwitch网段 | `string` | `"172.16.0.0/24"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Use the custom rule module of WAF to defend against UA attacks](https://help.aliyun.com/document_detail/2804234.html) 

<!-- docs-link --> 