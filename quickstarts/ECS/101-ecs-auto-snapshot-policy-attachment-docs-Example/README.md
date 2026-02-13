## Introduction

This example is used to create a `alicloud_ecs_auto_snapshot_policy_attachment` resource.

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
| [alicloud_ecs_auto_snapshot_policy.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_auto_snapshot_policy) | resource |
| [alicloud_ecs_auto_snapshot_policy_attachment.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_auto_snapshot_policy_attachment) | resource |
| [alicloud_ecs_disk.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_disk) | resource |
| [alicloud_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"terraform-example"` | no |
<!-- END_TF_DOCS -->    