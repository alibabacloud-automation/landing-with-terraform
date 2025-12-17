## Introduction

This example is used to create a `alicloud_wafv3_defense_rule` resource.

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
| [alicloud_wafv3_defense_rule.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/wafv3_defense_rule) | resource |
| [alicloud_wafv3_domain.defaultICMRhk](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/wafv3_domain) | resource |
| [alicloud_wafv3_instances.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/wafv3_instances) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | `string` | `"example.wafqax.top"` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"tfexample"` | no |
| <a name="input_region_id"></a> [region\_id](#input\_region\_id) | n/a | `string` | `"cn-hangzhou"` | no |
<!-- END_TF_DOCS -->
