## Introduction

This example is used to create a `alicloud_slb_server_group_server_attachment` resource.

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
| [alicloud_instance.server_attachment](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_security_group.server_attachment](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_slb_load_balancer.server_attachment](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/slb_load_balancer) | resource |
| [alicloud_slb_server_group.server_attachment](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/slb_server_group) | resource |
| [alicloud_slb_server_group_server_attachment.server_attachment](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/slb_server_group_server_attachment) | resource |
| [alicloud_vpc.server_attachment](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.server_attachment](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_images.server_attachment](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/images) | data source |
| [alicloud_instance_types.server_attachment](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/instance_types) | data source |
| [alicloud_zones.server_attachment](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_slb_server_group_server_attachment"></a> [slb\_server\_group\_server\_attachment](#input\_slb\_server\_group\_server\_attachment) | n/a | `string` | `"terraform-example"` | no |
| <a name="input_slb_server_group_server_attachment_count"></a> [slb\_server\_group\_server\_attachment\_count](#input\_slb\_server\_group\_server\_attachment\_count) | n/a | `number` | `5` | no |
<!-- END_TF_DOCS -->    