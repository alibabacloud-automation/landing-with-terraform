## Introduction

<!-- DOCS_DESCRIPTION_CN -->
云命令行（Cloud Shell）中预装了Terraform。Terraform是一种开源工具，用于安全高效地预配和管理云基础结构。您可以通过Terraform管理阿里云资源。本示例用于在阿里云上创建ECS。
详情可查看[云命令行中使用Terraform管理ECS实例](http://help.aliyun.com/document_detail/102418.htm)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
Terraform is preinstalled in Cloud Shell. Terraform is an open source tool that allows you to preconfigure and manage your cloud infrastructure in a secure and efficient manner. In Cloud Shell, you can use Terraform to manage your Alibaba Cloud resources. This example is used to create ECS instance on Alibaba Cloud. 
More details in [Use Terraform to manage Alibaba Cloud resources in Cloud Shell](http://help.aliyun.com/document_detail/102418.htm).
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
| [alicloud_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_available_disk_category"></a> [available\_disk\_category](#input\_available\_disk\_category) | n/a | `string` | `"cloud_efficiency"` | no |
| <a name="input_available_resource_creation"></a> [available\_resource\_creation](#input\_available\_resource\_creation) | n/a | `string` | `"VSwitch"` | no |
| <a name="input_cidr_ip"></a> [cidr\_ip](#input\_cidr\_ip) | n/a | `string` | `"0.0.0.0/0"` | no |
| <a name="input_image_id"></a> [image\_id](#input\_image\_id) | n/a | `string` | `"ubuntu_18_04_64_20G_alibase_20190624.vhd"` | no |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | n/a | `string` | `"test_fofo"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | n/a | `string` | `"ecs.n4.large"` | no |
| <a name="input_internet_max_bandwidth_out"></a> [internet\_max\_bandwidth\_out](#input\_internet\_max\_bandwidth\_out) | n/a | `number` | `10` | no |
| <a name="input_port_range"></a> [port\_range](#input\_port\_range) | n/a | `string` | `"1/65535"` | no |
| <a name="input_priority"></a> [priority](#input\_priority) | n/a | `number` | `1` | no |
| <a name="input_region_id"></a> [region\_id](#input\_region\_id) | n/a | `string` | `"cn-shanghai"` | no |
| <a name="input_security_group_name"></a> [security\_group\_name](#input\_security\_group\_name) | n/a | `string` | `"default"` | no |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | n/a | `string` | `"172.16.0.0/12"` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | n/a | `string` | `"tf_test_fofo"` | no |
| <a name="input_vswitch_cidr_block"></a> [vswitch\_cidr\_block](#input\_vswitch\_cidr\_block) | n/a | `string` | `"172.16.0.0/21"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Use Terraform to manage Alibaba Cloud resources in Cloud Shell](http://help.aliyun.com/document_detail/102418.htm) 

<!-- docs-link --> 