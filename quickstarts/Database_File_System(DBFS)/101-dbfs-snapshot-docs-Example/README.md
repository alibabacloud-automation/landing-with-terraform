## Introduction

This example is used to create a `alicloud_dbfs_snapshot` resource.

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
| [alicloud_dbfs_instance.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/dbfs_instance) | resource |
| [alicloud_dbfs_instance_attachment.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/dbfs_instance_attachment) | resource |
| [alicloud_dbfs_snapshot.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/dbfs_snapshot) | resource |
| [alicloud_instance.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_security_group.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_images.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/images) | data source |
| [alicloud_instance_types.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/instance_types) | data source |
| [alicloud_vpcs.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/vpcs) | data source |
| [alicloud_vswitches.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/vswitches) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"tf-example"` | no |
<!-- END_TF_DOCS -->    