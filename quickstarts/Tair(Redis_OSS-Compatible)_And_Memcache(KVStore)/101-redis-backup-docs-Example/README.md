## Introduction

This example is used to create a `alicloud_redis_backup` resource.

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
| [alicloud_kvstore_instance.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/kvstore_instance) | resource |
| [alicloud_redis_backup.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/redis_backup) | resource |
| [alicloud_vswitch.vswitch](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vpcs.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/vpcs) | data source |
| [alicloud_vswitches.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/vswitches) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"terraform-example"` | no |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | n/a | `string` | `"cn-hangzhou-h"` | no |
<!-- END_TF_DOCS -->
