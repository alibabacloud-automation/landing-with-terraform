## Introduction

This example is used to create a `alicloud_ess_scalinggroup_vserver_groups` resource.

<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_ess_scaling_group.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ess_scaling_group) | resource |
| [alicloud_ess_scalinggroup_vserver_groups.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ess_scalinggroup_vserver_groups) | resource |
| [alicloud_security_group.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_slb_listener.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/slb_listener) | resource |
| [alicloud_slb_load_balancer.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/slb_load_balancer) | resource |
| [alicloud_slb_server_group.default1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/slb_server_group) | resource |
| [alicloud_slb_server_group.default2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/slb_server_group) | resource |
| [alicloud_vpc.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [random_integer.default](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |
| [alicloud_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"terraform-example"` | no |
<!-- END_TF_DOCS -->    