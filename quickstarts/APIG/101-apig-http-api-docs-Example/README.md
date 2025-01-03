## Introduction

This example is used to create a `alicloud_apig_http_api` resource.

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
| [alicloud_apig_http_api.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/apig_http_api) | resource |
| [alicloud_resource_manager_resource_groups.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/resource_manager_resource_groups) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"terraform-example"` | no |
| <a name="input_protocol"></a> [protocol](#input\_protocol) | n/a | `string` | `"HTTP"` | no |
| <a name="input_protocol_https"></a> [protocol\_https](#input\_protocol\_https) | n/a | `string` | `"HTTPS"` | no |
<!-- END_TF_DOCS -->
