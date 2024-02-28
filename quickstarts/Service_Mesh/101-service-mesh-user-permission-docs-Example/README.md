<!-- BEGIN_TF_DOCS -->
## Introduction

This example is used to create a `alicloud_service_mesh_user_permission` resource.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_ram_user.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_user) | resource |
| [alicloud_service_mesh_service_mesh.default1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/service_mesh_service_mesh) | resource |
| [alicloud_service_mesh_user_permission.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/service_mesh_user_permission) | resource |
| [alicloud_service_mesh_versions.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/service_mesh_versions) | data source |
| [alicloud_vpcs.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/vpcs) | data source |
| [alicloud_vswitches.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/vswitches) | data source |
| [alicloud_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"tfexample"` | no |
<!-- END_TF_DOCS -->    