## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上创建ECS抢占式实例。
[创建ECS抢占式实例](https://help.aliyun.com/document_detail/58613.html)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to create ECS preemptible instance on Alibaba Cloud.
More details in [Create ECS preemptible instance](https://help.aliyun.com/document_detail/58613.html).
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
| [alicloud_instance.instance](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_security_group.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_security_group_rule.allow_all_tcp](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.vsw](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | 可用区 | `string` | `"cn-beijing-b"` | no |
| <a name="input_cidr_ip"></a> [cidr\_ip](#input\_cidr\_ip) | 入站规则CIDR | `string` | `"0.0.0.0/0"` | no |
| <a name="input_image_id"></a> [image\_id](#input\_image\_id) | 操作系统镜像 | `string` | `"ubuntu_140405_64_40G_cloudinit_20161115.vhd"` | no |
| <a name="input_instance_charge_type"></a> [instance\_charge\_type](#input\_instance\_charge\_type) | 付费类型 | `string` | `"PostPaid"` | no |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | 实例名称 | `string` | `"test_fofo"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | 实例规格 | `string` | `"ecs.n2.small"` | no |
| <a name="input_internet_max_bandwidth_out"></a> [internet\_max\_bandwidth\_out](#input\_internet\_max\_bandwidth\_out) | 公网带宽 | `number` | `10` | no |
| <a name="input_port_range"></a> [port\_range](#input\_port\_range) | 入站规则端口范围 | `string` | `"1/65535"` | no |
| <a name="input_priority"></a> [priority](#input\_priority) | 入站规则优先级 | `number` | `1` | no |
| <a name="input_region"></a> [region](#input\_region) | 区域 | `string` | `"cn-beijing"` | no |
| <a name="input_security_group_name"></a> [security\_group\_name](#input\_security\_group\_name) | 安全组名称 | `string` | `"default"` | no |
| <a name="input_spot_duration"></a> [spot\_duration](#input\_spot\_duration) | 抢占式实例的保留时长 | `number` | `0` | no |
| <a name="input_spot_strategy"></a> [spot\_strategy](#input\_spot\_strategy) | 抢占式实例出价策略 | `string` | `"SpotAsPriceGo"` | no |
| <a name="input_system_disk_category"></a> [system\_disk\_category](#input\_system\_disk\_category) | 系统盘类型 | `string` | `"cloud_efficiency"` | no |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | VPC CIDR 块 | `string` | `"172.16.0.0/12"` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | VPC 名称 | `string` | `"tf_test_fofo"` | no |
| <a name="input_vswitch_cidr_block"></a> [vswitch\_cidr\_block](#input\_vswitch\_cidr\_block) | VSwitch CIDR 块 | `string` | `"172.16.0.0/21"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Create ECS preemptible instance](https://help.aliyun.com/document_detail/58613.html) 

<!-- docs-link --> 