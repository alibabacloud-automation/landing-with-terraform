<!-- BEGIN_TF_DOCS -->
## Introduction

This example is used to create a `alicloud_vpc_gateway_endpoint` resource.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | n/a |

## Resources

| Name | Type |
|------|------|
| [alicloud_resource_manager_resource_group.defaultRg](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/resource_manager_resource_group) | resource |
| [alicloud_vpc.defaultVpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vpc_gateway_endpoint.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc_gateway_endpoint) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | `string` | `"com.aliyun.cn-hangzhou.oss"` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"terraform-example"` | no |
<!-- END_TF_DOCS -->    