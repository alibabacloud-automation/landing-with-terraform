## Introduction

This example is used to create a `alicloud_ebs_disk_replica_pair` resource.

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
| [alicloud_ebs_disk_replica_pair.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ebs_disk_replica_pair) | resource |
| [alicloud_ecs_disk.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_disk) | resource |
| [alicloud_ecs_disk.destination](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_disk) | resource |
| [alicloud_ebs_regions.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/ebs_regions) | data source |
| [alicloud_regions.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/regions) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"tf-example"` | no |
<!-- END_TF_DOCS -->    