## Introduction

This example is used to create a `alicloud_cen_transit_router_route_table_propagation` resource.

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
| [alicloud_cen_instance.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_instance) | resource |
| [alicloud_cen_transit_router.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router) | resource |
| [alicloud_cen_transit_router_route_table.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_table) | resource |
| [alicloud_cen_transit_router_route_table_propagation.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_route_table_propagation) | resource |
| [alicloud_cen_transit_router_vpc_attachment.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_vpc_attachment) | resource |
| [alicloud_vpc.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.example_master](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.example_slave](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_cen_transit_router_available_resources.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/cen_transit_router_available_resources) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"tf_example"` | no |
<!-- END_TF_DOCS -->    