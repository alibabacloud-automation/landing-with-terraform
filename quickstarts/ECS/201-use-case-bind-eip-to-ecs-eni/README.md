## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上为ECS弹性网卡绑定EIP。
详情可查看[为弹性网卡绑定EIP](https://help.aliyun.com/document_detail/156980.html)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to bind EIPs to ECS elastic network interface on Alibaba Cloud.
More details in [How to bind EIPs to ECS elastic network interface](https://help.aliyun.com/document_detail/156980.html).
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
| [alicloud_eip.eip](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/eip) | resource |
| [alicloud_eip_association.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/eip_association) | resource |
| [alicloud_network_interface.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/network_interface) | resource |
| [alicloud_security_group.group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_security_group_rule.allow_80_tcp](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.vswitch](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_private_ip"></a> [private\_ip](#input\_private\_ip) | The primary private IP address of the ENI. The specified IP address must be available within the CIDR block of the VSwitch. If this parameter is not specified, an available IP address is assigned from the VSwitch CIDR block at random. | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | The region where the resources will be created. | `string` | `"cn-beijing"` | no |
| <a name="input_source_ip"></a> [source\_ip](#input\_source\_ip) | The IP address you used to access the ENI. | `string` | `"0.0.0.0/0"` | no |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | Specify the CIDR block of the VPC. If the vpc\_id is provided, this value can be left blank. | `string` | `"192.168.0.0/16"` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | When binding an ENI to an existing ECS instance, this value is required and must be the VPC associated with the ECS instance. | `string` | `""` | no |
| <a name="input_vswitch_cidr_block"></a> [vswitch\_cidr\_block](#input\_vswitch\_cidr\_block) | Specify the CIDR block of the VSwitch. The CIDR block must be within the range of the VPC CIDR block. | `string` | `"192.168.0.0/24"` | no |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | When binding an ENI to an existing ECS instance, this value is required and must be the zone where the ECS instance is located. | `string` | `""` | no |
<!-- END_TF_DOCS -->

<!-- docs-link --> 

The template is based on Aliyun document: [How to bind EIPs to ECS elastic network interface](https://help.aliyun.com/document_detail/156980.html) 

<!-- docs-link --> 