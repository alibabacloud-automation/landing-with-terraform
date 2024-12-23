## Introduction

This example is used to create a `alicloud_nas_access_point` resource.

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
| [alicloud_nas_access_group.defaultBbc7ev](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/nas_access_group) | resource |
| [alicloud_nas_access_point.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/nas_access_point) | resource |
| [alicloud_nas_file_system.defaultVtUpDh](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/nas_file_system) | resource |
| [alicloud_vpc.defaultkyVC70](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.defaultoZAPmO](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azone"></a> [azone](#input\_azone) | n/a | `string` | `"cn-hangzhou-g"` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"terraform-example"` | no |
| <a name="input_region_id"></a> [region\_id](#input\_region\_id) | n/a | `string` | `"cn-hangzhou"` | no |
<!-- END_TF_DOCS -->
