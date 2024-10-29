## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上创建一台ECS实例，涉及到专有网络VPC、虚拟交换机vSwitch、安全组、弹性计算实例等资源的创建和部署。
详情可查看[创建一台ECS实例](https://help.aliyun.com/document_detail/95829.html)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to create an ECS instance on Alibaba Cloud, which involves the creation and deployment of resources such as Virtual Private Cloud, virtual Switches, security groups, and Elastic Compute Service instances.
More details in [Create an ECS instance](https://help.aliyun.com/document_detail/95829.html).
<!-- DOCS_DESCRIPTION_EN -->

## Introduction

Here is the brief introduction for example usage scenes.

## Requirements

Here is a list of dependencies that need to be created before executing the example

<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cr"></a> [cr](#module\_cr) | roura356a/cr/alicloud | 1.3.1 |

## Resources

| Name | Type |
|------|------|
| [random_integer.default](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-beijing"` | no |
<!-- END_TF_DOCS -->
## Documentation
<!-- docs-link -->

The template is based on Aliyun document: [Create container image repositories and an authorized RAM user](http://help.aliyun.com/document_detail/148892.html)

<!-- docs-link -->
