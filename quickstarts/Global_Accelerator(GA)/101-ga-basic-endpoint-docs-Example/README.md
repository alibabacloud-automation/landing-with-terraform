## Introduction

This example is used to create a `alicloud_ga_basic_endpoint` resource.

<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | n/a |
| <a name="provider_alicloud.hz"></a> [alicloud.hz](#provider\_alicloud.hz) | n/a |
| <a name="provider_alicloud.sz"></a> [alicloud.sz](#provider\_alicloud.sz) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_ecs_network_interface.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_network_interface) | resource |
| [alicloud_ga_basic_accelerator.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ga_basic_accelerator) | resource |
| [alicloud_ga_basic_endpoint.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ga_basic_endpoint) | resource |
| [alicloud_ga_basic_endpoint_group.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ga_basic_endpoint_group) | resource |
| [alicloud_security_group.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_vpc.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_endpoint_region"></a> [endpoint\_region](#input\_endpoint\_region) | n/a | `string` | `"cn-hangzhou"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-shenzhen"` | no |
<!-- END_TF_DOCS -->
