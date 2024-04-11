## Introduction

This example is used to create a `alicloud_slb_server_group` resource.

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
| [alicloud_slb_load_balancer.server_group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/slb_load_balancer) | resource |
| [alicloud_slb_server_group.server_group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/slb_server_group) | resource |
| [alicloud_vpc.server_group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.server_group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_zones.server_group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_slb_server_group_name"></a> [slb\_server\_group\_name](#input\_slb\_server\_group\_name) | n/a | `string` | `"forSlbServerGroup"` | no |
<!-- END_TF_DOCS -->    