## Introduction

This example is used to create a `alicloud_ddoscoo_web_cc_rule` resource.

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
| [alicloud_ddoscoo_domain_resource.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ddoscoo_domain_resource) | resource |
| [alicloud_ddoscoo_web_cc_rule.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ddoscoo_web_cc_rule) | resource |
| [alicloud_ddoscoo_instances.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/ddoscoo_instances) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | `string` | `"terraform-example.alibaba.com"` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"terraform"` | no |
<!-- END_TF_DOCS -->
