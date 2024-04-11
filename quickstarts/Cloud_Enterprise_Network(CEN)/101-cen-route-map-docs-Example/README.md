## Introduction

This example is used to create a `alicloud_cen_route_map` resource.

<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | n/a |
| <a name="provider_alicloud.hz"></a> [alicloud.hz](#provider\_alicloud.hz) | n/a |
| <a name="provider_alicloud.sh"></a> [alicloud.sh](#provider\_alicloud.sh) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_cen_instance.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_instance) | resource |
| [alicloud_cen_instance_attachment.example_hz](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_instance_attachment) | resource |
| [alicloud_cen_instance_attachment.example_sh](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_instance_attachment) | resource |
| [alicloud_cen_route_map.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_route_map) | resource |
| [alicloud_vpc.example_hz](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vpc.example_sh](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_destination_region"></a> [destination\_region](#input\_destination\_region) | n/a | `string` | `"cn-shanghai"` | no |
| <a name="input_source_region"></a> [source\_region](#input\_source\_region) | n/a | `string` | `"cn-hangzhou"` | no |
<!-- END_TF_DOCS -->    