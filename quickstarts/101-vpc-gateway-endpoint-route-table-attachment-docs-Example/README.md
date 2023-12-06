<!-- BEGIN_TF_DOCS -->
## Introduction

This example is used to create a `alicloud_vpc_gateway_endpoint_route_table_attachment` resource.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | n/a |

## Resources

| Name | Type |
|------|------|
| [alicloud_route_table.defaultRT](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/route_table) | resource |
| [alicloud_vpc.defaulteVpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vpc_gateway_endpoint.defaultGE](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc_gateway_endpoint) | resource |
| [alicloud_vpc_gateway_endpoint_route_table_attachment.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc_gateway_endpoint_route_table_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"terraform-example"` | no |
<!-- END_TF_DOCS -->    