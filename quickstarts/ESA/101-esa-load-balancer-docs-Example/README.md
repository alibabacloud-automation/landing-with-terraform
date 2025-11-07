## Introduction

This example is used to create a `alicloud_esa_load_balancer` resource.

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
| [alicloud_esa_load_balancer.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/esa_load_balancer) | resource |
| [alicloud_esa_origin_pool.resource_OriginPool_LoadBalancer_1_1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/esa_origin_pool) | resource |
| [alicloud_esa_site.resource_Site_OriginPool](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/esa_site) | resource |
| [random_integer.default](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |
| [alicloud_esa_sites.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/esa_sites) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"terraform-example"` | no |
<!-- END_TF_DOCS -->
