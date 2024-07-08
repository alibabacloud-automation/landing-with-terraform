## Introduction

This example is used to create a `alicloud_adb_resource_group` resource.

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
| [alicloud_adb_db_cluster.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/adb_db_cluster) | resource |
| [alicloud_adb_resource_group.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/adb_resource_group) | resource |
| [alicloud_vpc.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_adb_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/adb_zones) | data source |
| [alicloud_resource_manager_resource_groups.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/resource_manager_resource_groups) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"tf_example"` | no |
<!-- END_TF_DOCS -->
