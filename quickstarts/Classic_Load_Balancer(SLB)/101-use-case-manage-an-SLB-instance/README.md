## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上创建一个负载均衡实例，并为其添加TCP、UDP和HTTP三种协议的监听。涉及到负载均衡实例和监听资源的创建和部署。
详情可查看[通过Terraform管理负载均衡服务](https://help.aliyun.com/document_detail/111634.html)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to create an SLB instance on Alibaba Cloud, and adding TCP, UDP, and HTTP listeners to the load balancer instance. It involves the creation and deployment of resources such as Server Load Balancer instances and listeners.
More details in [Manage an SLB instance](https://help.aliyun.com/document_detail/111634.html).
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
| [alicloud_slb_listener.http](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/slb_listener) | resource |
| [alicloud_slb_listener.tcp](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/slb_listener) | resource |
| [alicloud_slb_listener.udp](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/slb_listener) | resource |
| [alicloud_slb_load_balancer.instance](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/slb_load_balancer) | resource |

## Inputs

No inputs.
<!-- END_TF_DOCS -->
## Documentation
<!-- docs-link -->

The template is based on Aliyun document: [Manage an SLB instance](http://help.aliyun.com/document_detail/111634.html)

<!-- docs-link -->
