## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上创建VPC边界防火墙（防护通过高速通道连接的两个VPC之间的流量）。
详情可查看[通过 Terraform 创建VPC边界防火墙来防护通过高速通道连接的两个VPC之间的流量](https://help.aliyun.com/document_detail/2245589.html)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to create a virtual private cloud (VPC) firewall to protect traffic between two VPCs that are connected by using an Express Connect circuit.
More details in [Create a VPC firewall to protect traffic between two VPCs that are connected by using an Express Connect circuit](https://help.aliyun.com/document_detail/2245589.html).
<!-- DOCS_DESCRIPTION_EN -->

<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | n/a |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |
| <a name="provider_time"></a> [time](#provider\_time) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_cloud_firewall_vpc_firewall.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cloud_firewall_vpc_firewall) | resource |
| [alicloud_route_entry.foo](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/route_entry) | resource |
| [alicloud_route_entry.foo1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/route_entry) | resource |
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vpc.vpc1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vpc_peer_connection.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc_peer_connection) | resource |
| [alicloud_vpc_peer_connection_accepter.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc_peer_connection_accepter) | resource |
| [alicloud_vswitch.vsw](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.vsw1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.vsw2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.vsw3](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [null_resource.wait_for_firewall](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [time_sleep.wait_before_firewall](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [alicloud_account.current](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/account) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-heyuan"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [protect traffic between two VPCs](https://help.aliyun.com/document_detail/2245589.html) 

<!-- docs-link --> 