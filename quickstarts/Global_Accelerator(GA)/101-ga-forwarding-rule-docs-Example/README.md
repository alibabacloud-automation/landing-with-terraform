## Introduction

This example is used to create a `alicloud_ga_forwarding_rule` resource.

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
| [alicloud_eip_address.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/eip_address) | resource |
| [alicloud_ga_accelerator.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ga_accelerator) | resource |
| [alicloud_ga_bandwidth_package.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ga_bandwidth_package) | resource |
| [alicloud_ga_bandwidth_package_attachment.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ga_bandwidth_package_attachment) | resource |
| [alicloud_ga_endpoint_group.virtual](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ga_endpoint_group) | resource |
| [alicloud_ga_forwarding_rule.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ga_forwarding_rule) | resource |
| [alicloud_ga_listener.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ga_listener) | resource |
| [alicloud_regions.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/regions) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"tf-example"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-hangzhou"` | no |
<!-- END_TF_DOCS -->
