## Introduction

This example is used to create a `alicloud_cen_vbr_health_check` resource.

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
| [alicloud_cen_instance.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_instance) | resource |
| [alicloud_cen_instance_attachment.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_instance_attachment) | resource |
| [alicloud_cen_vbr_health_check.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_vbr_health_check) | resource |
| [alicloud_express_connect_virtual_border_router.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/express_connect_virtual_border_router) | resource |
| [random_integer.vlan_id](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |
| [alicloud_express_connect_physical_connections.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/express_connect_physical_connections) | data source |
| [alicloud_regions.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/regions) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"terraform-example"` | no |
<!-- END_TF_DOCS -->    