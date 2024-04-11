## Introduction

This example is used to create a `alicloud_rds_instance_cross_backup_policy` resource.

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
| [alicloud_db_instance.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/db_instance) | resource |
| [alicloud_rds_instance_cross_backup_policy.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/rds_instance_cross_backup_policy) | resource |
| [alicloud_vpc.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_db_instance_classes.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/db_instance_classes) | data source |
| [alicloud_db_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/db_zones) | data source |
| [alicloud_rds_cross_regions.regions](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/rds_cross_regions) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"tf-example"` | no |
<!-- END_TF_DOCS -->    