## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上创建VPC边界防火墙（防护云企业网基础版的网络实例和指定VPC之间的互访流量）。
详情可查看[通过Terraform创建VPC边界防火墙（防护云企业网基础版的网络实例和指定VPC之间的互访流量）](https://help.aliyun.com/document_detail/2245588.html)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to create a virtual private cloud (VPC) firewall by using Terraform. The firewall protects access traffic between a VPC and a network instance that is attached to a Basic Edition transit router of a Cloud Enterprise Network (CEN) instance.
More details in [Create a VPC firewall to protect access traffic between a VPC and a network instance that is attached to a Basic Edition transit router of a CEN instance](https://help.aliyun.com/document_detail/2245588.html).
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
| [alicloud_cen_instance.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_instance) | resource |
| [alicloud_cen_instance_attachment.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_instance_attachment) | resource |
| [alicloud_cen_instance_attachment.example1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_instance_attachment) | resource |
| [alicloud_cloud_firewall_vpc_firewall_cen.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cloud_firewall_vpc_firewall_cen) | resource |
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vpc.vpc1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
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
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-qingdao"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [The firewall protects access traffic between a VPC and a network instance that is attached to a Basic Edition transit router of a Cloud Enterprise Network (CEN) instance](https://help.aliyun.com/document_detail/2245588.html) 

<!-- docs-link --> 