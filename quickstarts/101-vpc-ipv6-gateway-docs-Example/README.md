<!-- BEGIN_TF_DOCS -->
## Introduction

This example is used to create a `alicloud_vpc_ipv6_gateway` resource.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | n/a |

## Resources

| Name | Type |
|------|------|
| [alicloud_resource_manager_resource_group.changeRg](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/resource_manager_resource_group) | resource |
| [alicloud_resource_manager_resource_group.defaultRg](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/resource_manager_resource_group) | resource |
| [alicloud_vpc.defaultVpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vpc_ipv6_gateway.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc_ipv6_gateway) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"tf-testacc-example"` | no |
<!-- END_TF_DOCS -->    