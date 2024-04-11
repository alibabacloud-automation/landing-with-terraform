## Introduction

This example is used to create a `alicloud_adb_account` resource.

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
| [alicloud_adb_account.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/adb_account) | resource |
| [alicloud_adb_db_cluster.cluster](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/adb_db_cluster) | resource |
| [alicloud_adb_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/adb_zones) | data source |
| [alicloud_vpcs.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/vpcs) | data source |
| [alicloud_vswitches.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/vswitches) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_creation"></a> [creation](#input\_creation) | n/a | `string` | `"ADB"` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"tfexample"` | no |
<!-- END_TF_DOCS -->    