## Introduction

This example is used to create a `alicloud_dcdn_waf_domain` resource.

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
| [alicloud_dcdn_domain.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/dcdn_domain) | resource |
| [alicloud_dcdn_waf_domain.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/dcdn_waf_domain) | resource |
| [random_integer.default](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | n/a | `string` | `"tf-example.com"` | no |
<!-- END_TF_DOCS -->    