## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上将接入全球加速网络的加速IP配置为IPv6协议类型，实现IPv6转换服务。
详情可查看[全球加速加速IPv6客户端访问IPv4服务](https://help.aliyun.com/document_detail/176428.html)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to set the protocol type of the accelerated IP addresses of your Global Accelerator (GA) instance to IPv6 on Alibaba Cloud.
More details in [GA accelerate access from IPv6 clients to IPv4 services](https://help.aliyun.com/document_detail/176428.html).
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
| [alicloud_alidns_record.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/alidns_record) | resource |
| [alicloud_ecs_command.ecs_command](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_command) | resource |
| [alicloud_ecs_invocation.nvocation](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_invocation) | resource |
| [alicloud_ga_accelerator.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ga_accelerator) | resource |
| [alicloud_ga_endpoint_group.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ga_endpoint_group) | resource |
| [alicloud_ga_ip_set.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ga_ip_set) | resource |
| [alicloud_ga_listener.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ga_listener) | resource |
| [alicloud_instance.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_security_group.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_security_group_rule.egress](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_vpc.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [random_integer.example](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |
| [alicloud_ga_accelerators.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/ga_accelerators) | data source |
| [alicloud_zones.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_ecs_service"></a> [create\_ecs\_service](#input\_create\_ecs\_service) | Do you want to create a service on ecs | `bool` | `true` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | Change to your domain name | `string` | `"tf-example.com"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-hangzhou"` | no |
| <a name="input_service_endpoint"></a> [service\_endpoint](#input\_service\_endpoint) | your service endpoint | `string` | `null` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Accelerate access from IPv6 clients to IPv4 services](https://help.aliyun.com/document_detail/176428.html) 

<!-- docs-link --> 