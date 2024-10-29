## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上的专有网络中创建负载均衡实例，涉及到专有网络VPC、虚拟交换机vSwitch、负载均衡实例等资源的创建，并为负载均衡实例添加监听。
详情可查看[通过Terraform在专有网络中创建负载均衡实例](https://help.aliyun.com/document_detail/111830.html)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to create a Server Load Balancer instance on Alibaba Cloud, which involves the creation of resources such as Virtual Private Cloud, virtual Switches, and SLB instances, and adding a TCP listener to the load balancer instance. 
More details in [Create an SLB instance in a VPC](https://help.aliyun.com/document_detail/111830.html).
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
| [alicloud_slb_listener.listener](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/slb_listener) | resource |
| [alicloud_slb_load_balancer.instance](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/slb_load_balancer) | resource |
| [alicloud_vpc.main](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.main](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-hangzhou"` | no |
<!-- END_TF_DOCS -->
## Documentation
<!-- docs-link -->

The template is based on Aliyun document: [Create an SLB instance in a VPC](http://help.aliyun.com/document_detail/111830.htm)

<!-- docs-link -->
