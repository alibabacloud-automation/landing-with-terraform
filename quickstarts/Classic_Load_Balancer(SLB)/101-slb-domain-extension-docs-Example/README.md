## Introduction

This example is used to create a `alicloud_slb_domain_extension` resource.

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
| [alicloud_slb_domain_extension.example1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/slb_domain_extension) | resource |
| [alicloud_slb_listener.https](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/slb_listener) | resource |
| [alicloud_slb_load_balancer.instance](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/slb_load_balancer) | resource |
| [alicloud_slb_server_certificate.domain_extension](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/slb_server_certificate) | resource |
| [alicloud_vpc.domain_extension](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.domain_extension](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_zones.domain_extension](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_slb_domain_extension_name"></a> [slb\_domain\_extension\_name](#input\_slb\_domain\_extension\_name) | Create a new load balancer and domain extension | `string` | `"forDomainExtension"` | no |
<!-- END_TF_DOCS -->    