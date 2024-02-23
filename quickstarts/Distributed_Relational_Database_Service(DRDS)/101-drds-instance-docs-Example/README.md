<!-- BEGIN_TF_DOCS -->
## Introduction

This example is used to create a `alicloud_drds_instance` resource.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | 1.217.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_drds_instance.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/drds_instance) | resource |
| [alicloud_vpcs.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/vpcs) | data source |
| [alicloud_vswitches.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/vswitches) | data source |
| [alicloud_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_instance_series"></a> [instance\_series](#input\_instance\_series) | n/a | `string` | `"drds.sn1.4c8g"` | no |
<!-- END_TF_DOCS -->    