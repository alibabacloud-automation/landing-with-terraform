## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上为双栈NLB实例开启IPv6挂载，即NLB实例同时支持挂载IPv4和IPv6的云服务器ECS（Elastic Compute Service）。
详情可查看[NLB快速实现IPv6服务的负载均衡](https://help.aliyun.com/document_detail/2569277.html)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to add IPv4 and IPv6 Elastic Compute Service (ECS) instances to a dual-stack NLB instance on Alibaba Cloud.
More details in [Use NLB to balance loads for IPv6 services](https://help.aliyun.com/document_detail/2569277.html).
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
| [alicloud_dns_record.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/dns_record) | resource |
| [alicloud_ecs_command.backup_ecs_command](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_command) | resource |
| [alicloud_ecs_command.master_ecs_command](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_command) | resource |
| [alicloud_ecs_invocation.backup_invocation](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_invocation) | resource |
| [alicloud_ecs_invocation.master_invocation](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_invocation) | resource |
| [alicloud_instance.backup_example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_instance.master_example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_nlb_listener.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/nlb_listener) | resource |
| [alicloud_nlb_load_balancer.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/nlb_load_balancer) | resource |
| [alicloud_nlb_server_group.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/nlb_server_group) | resource |
| [alicloud_nlb_server_group_server_attachment.attachment_backup_ecs](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/nlb_server_group_server_attachment) | resource |
| [alicloud_nlb_server_group_server_attachment.attachment_master_ecs](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/nlb_server_group_server_attachment) | resource |
| [alicloud_security_group.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_security_group_rule.egress](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_security_group_rule.ingress](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_vpc.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vpc_ipv6_gateway.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc_ipv6_gateway) | resource |
| [alicloud_vswitch.backup_vswitch](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.master_vswitch](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [random_integer.example](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |
| [alicloud_zones.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_host_name"></a> [host\_name](#input\_host\_name) | your domain name | `string` | `"tf-example.com"` | no |
| <a name="input_password"></a> [password](#input\_password) | ECS登录密码 | `string` | `"Terraform@Example"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-beijing"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Use NLB to balance loads for IPv6 services](https://help.aliyun.com/document_detail/2569277.html) 

<!-- docs-link --> 