## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上使用Anycast EIP提升用户的公网访问体验，涉及到Anycast EIP实例的创建。
详情可查看[任播弹性公网IP快速入门](https://help.aliyun.com/document_detail/171864.html)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to use Anycast EIPs to accelerate access to Alibaba Cloud, which involves the creation of Anycast EIP instance.
More details in [Anycast elastic IP addresses Qickstart](https://help.aliyun.com/document_detail/171864.html).
<!-- DOCS_DESCRIPTION_EN -->

<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | n/a |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |
| <a name="provider_time"></a> [time](#provider\_time) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_ecs_command.ecs_command](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_command) | resource |
| [alicloud_ecs_invocation.invocation](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_invocation) | resource |
| [alicloud_eipanycast_anycast_eip_address.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/eipanycast_anycast_eip_address) | resource |
| [alicloud_eipanycast_anycast_eip_address_attachment.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/eipanycast_anycast_eip_address_attachment) | resource |
| [alicloud_instance.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_security_group.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_security_group_rule.egress](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_security_group_rule.ingress](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_slb_listener.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/slb_listener) | resource |
| [alicloud_slb_load_balancer.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/slb_load_balancer) | resource |
| [alicloud_slb_server_group.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/slb_server_group) | resource |
| [alicloud_slb_server_group_server_attachment.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/slb_server_group_server_attachment) | resource |
| [alicloud_vpc.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.vswitch](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [null_resource.check](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [random_integer.example](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |
| [time_sleep.example](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [alicloud_slb_load_balancers.exist_slb](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/slb_load_balancers) | data source |
| [alicloud_zones.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alicloud_slb_load_balancer_id"></a> [alicloud\_slb\_load\_balancer\_id](#input\_alicloud\_slb\_load\_balancer\_id) | SLB instance ID | `string` | `""` | no |
| <a name="input_create_slb"></a> [create\_slb](#input\_create\_slb) | Do you want to create slb load balancer | `bool` | `"true"` | no |
| <a name="input_region"></a> [region](#input\_region) | The region where the load balancing instance is located | `string` | `"us-west-1"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Anycast elastic IP addresses Qickstart](https://help.aliyun.com/document_detail/171864.html) 

<!-- docs-link --> 