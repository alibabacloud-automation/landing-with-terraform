## Introduction

This example is used to create a `alicloud_vpc_traffic_mirror_session` resource.

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
| [alicloud_ecs_network_interface.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_network_interface) | resource |
| [alicloud_ecs_network_interface_attachment.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_network_interface_attachment) | resource |
| [alicloud_instance.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_security_group.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_vpc.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vpc_traffic_mirror_filter.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc_traffic_mirror_filter) | resource |
| [alicloud_vpc_traffic_mirror_session.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc_traffic_mirror_session) | resource |
| [alicloud_vswitch.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_images.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/images) | data source |
| [alicloud_instance_types.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/instance_types) | data source |
| [alicloud_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"tf-example"` | no |
<!-- END_TF_DOCS -->    