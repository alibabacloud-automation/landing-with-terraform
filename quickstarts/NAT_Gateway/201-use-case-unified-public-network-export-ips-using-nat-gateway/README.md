## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上配置公网NAT网关的SNAT条目,使多个ECS实例可以通过同一弹性公网IP访问互联网。
详情可查看[统一公网出口IP](https://help.aliyun.com/document_detail/122217.html)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to configure SNAT entry of NAT gateway on Alibaba Cloud.
More details in [Unified public network export IPs using NAT gateway](https://help.aliyun.com/document_detail/122217.html).
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
| [alicloud_ecs_command.ecs_a](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_command) | resource |
| [alicloud_ecs_command.ecs_b](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_command) | resource |
| [alicloud_ecs_command.ecs_c](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_command) | resource |
| [alicloud_ecs_invocation.ecs_a](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_invocation) | resource |
| [alicloud_ecs_invocation.ecs_b](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_invocation) | resource |
| [alicloud_ecs_invocation.ecs_c](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_invocation) | resource |
| [alicloud_eip_address.a](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/eip_address) | resource |
| [alicloud_eip_address.aa](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/eip_address) | resource |
| [alicloud_eip_association.b](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/eip_association) | resource |
| [alicloud_eip_association.eip_association](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/eip_association) | resource |
| [alicloud_forward_entry.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/forward_entry) | resource |
| [alicloud_instance.a](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_instance.b](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_instance.c](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_nat_gateway.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/nat_gateway) | resource |
| [alicloud_network_interface.eni_a](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/network_interface) | resource |
| [alicloud_network_interface_attachment.attach_to_ecs_a](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/network_interface_attachment) | resource |
| [alicloud_security_group.a](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_security_group_rule.a](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_slb_backend_server.backend_server](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/slb_backend_server) | resource |
| [alicloud_slb_listener.listener](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/slb_listener) | resource |
| [alicloud_slb_load_balancer.load_balancer](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/slb_load_balancer) | resource |
| [alicloud_snat_entry.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/snat_entry) | resource |
| [alicloud_vpc.a](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.a1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_images.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/images) | data source |
| [alicloud_instance_types.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/instance_types) | data source |
| [alicloud_instances.ecs_instance](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/instances) | data source |
| [alicloud_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_image_id"></a> [image\_id](#input\_image\_id) | n/a | `string` | `"aliyun_3_x64_20G_alibase_20241103.vhd"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | n/a | `string` | `"ecs.e-c1m2.xlarge"` | no |
| <a name="input_load_balancer_spec"></a> [load\_balancer\_spec](#input\_load\_balancer\_spec) | n/a | `string` | `"slb.s2.small"` | no |
| <a name="input_master_zone"></a> [master\_zone](#input\_master\_zone) | n/a | `string` | `"cn-beijing-h"` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"nat-test-ip"` | no |
| <a name="input_password"></a> [password](#input\_password) | n/a | `string` | `"Test123@"` | no |
| <a name="input_region"></a> [region](#input\_region) | 统一公网出口IP | `string` | `"cn-beijing"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Unified public network export IPs using NAT gateway](https://help.aliyun.com/document_detail/122217.html) 

<!-- docs-link --> 