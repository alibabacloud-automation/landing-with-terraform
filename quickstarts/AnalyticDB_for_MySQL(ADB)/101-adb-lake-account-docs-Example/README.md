## Introduction

This example is used to create a `alicloud_adb_lake_account` resource.

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
| [alicloud_adb_db_cluster_lake_version.CreateInstance](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/adb_db_cluster_lake_version) | resource |
| [alicloud_adb_lake_account.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/adb_lake_account) | resource |
| [alicloud_vpc.VPCID](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.VSWITCHID](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"terraform-example"` | no |
<!-- END_TF_DOCS -->    