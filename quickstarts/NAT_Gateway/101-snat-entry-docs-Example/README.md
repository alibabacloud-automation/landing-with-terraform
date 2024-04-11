## Introduction

This example is used to create a `alicloud_snat_entry` resource.

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
| [alicloud_eip_address.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/eip_address) | resource |
| [alicloud_eip_association.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/eip_association) | resource |
| [alicloud_nat_gateway.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/nat_gateway) | resource |
| [alicloud_snat_entry.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/snat_entry) | resource |
| [alicloud_vpc.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"tf_example"` | no |
<!-- END_TF_DOCS -->    