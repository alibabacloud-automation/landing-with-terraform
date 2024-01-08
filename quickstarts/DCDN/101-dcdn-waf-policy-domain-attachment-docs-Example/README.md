<!-- BEGIN_TF_DOCS -->
## Introduction

This example is used to create a `alicloud_dcdn_waf_policy_domain_attachment` resource.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | n/a |

## Resources

| Name | Type |
|------|------|
| [alicloud_dcdn_domain.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/dcdn_domain) | resource |
| [alicloud_dcdn_waf_domain.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/dcdn_waf_domain) | resource |
| [alicloud_dcdn_waf_policy.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/dcdn_waf_policy) | resource |
| [alicloud_dcdn_waf_policy_domain_attachment.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/dcdn_waf_policy_domain_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | n/a | `string` | `"example.com"` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"tf_example"` | no |
<!-- END_TF_DOCS -->    