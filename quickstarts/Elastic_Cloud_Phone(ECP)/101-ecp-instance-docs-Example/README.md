## Introduction

This example is used to create a `alicloud_ecp_instance` resource.

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
| [alicloud_ecp_instance.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecp_instance) | resource |
| [alicloud_ecp_key_pair.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecp_key_pair) | resource |
| [alicloud_security_group.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_vpc.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [random_integer.default](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |
| [alicloud_ecp_instance_types.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/ecp_instance_types) | data source |
| [alicloud_ecp_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/ecp_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"terraform-example"` | no |
<!-- END_TF_DOCS -->    