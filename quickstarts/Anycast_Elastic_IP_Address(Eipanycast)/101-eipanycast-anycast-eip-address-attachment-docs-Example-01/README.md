## Introduction

This example is used to create a `alicloud_eipanycast_anycast_eip_address_attachment` resource.

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
| [alicloud_eipanycast_anycast_eip_address.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/eipanycast_anycast_eip_address) | resource |
| [alicloud_eipanycast_anycast_eip_address_attachment.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/eipanycast_anycast_eip_address_attachment) | resource |
| [alicloud_slb_load_balancer.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/slb_load_balancer) | resource |
| [alicloud_vpc.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_regions.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/regions) | data source |
| [alicloud_slb_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/slb_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"terraform-example"` | no |
<!-- END_TF_DOCS -->    