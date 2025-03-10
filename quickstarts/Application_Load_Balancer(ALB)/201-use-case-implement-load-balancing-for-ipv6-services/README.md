## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上为双栈ALB实例开启IPv6挂载，即ALB实例同时支持挂载IPv4和IPv6的云服务器ECS。
详情可查看[ALB快速实现IPv6服务的负载均衡](https://help.aliyun.com/document_detail/444034.html)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to configure a dual-stack server group that contains IPv4 and IPv6 Elastic Compute Service (ECS) instances for a dual-stack ALB instance on Alibaba Cloud.
More details in [Use ALB to balance loads for IPv6 services](https://help.aliyun.com/document_detail/444034.html).
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
| [alicloud_alb_listener.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/alb_listener) | resource |
| [alicloud_alb_load_balancer.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/alb_load_balancer) | resource |
| [alicloud_alb_server_group.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/alb_server_group) | resource |
| [alicloud_dns_record.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/dns_record) | resource |
| [alicloud_ecs_command.backup_ecs_command](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_command) | resource |
| [alicloud_ecs_command.master_ecs_command](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_command) | resource |
| [alicloud_ecs_invocation.backup_invocation](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_invocation) | resource |
| [alicloud_ecs_invocation.master_invocation](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_invocation) | resource |
| [alicloud_instance.backup_example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_instance.master_example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_security_group.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_security_group_rule.egress](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_security_group_rule.ingress](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_vpc.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
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

The template is based on Aliyun document: [Use ALB to balance loads for IPv6 services](https://help.aliyun.com/document_detail/444034.html) 

<!-- docs-link --> 