## Introduction

This example is used to create a `alicloud_config_compliance_pack` resource.

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
| [alicloud_config_compliance_pack.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/config_compliance_pack) | resource |
| [alicloud_config_rule.rule1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/config_rule) | resource |
| [alicloud_config_rule.rule2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/config_rule) | resource |
| [alicloud_regions.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/regions) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"tf-example-config-name"` | no |
<!-- END_TF_DOCS -->    