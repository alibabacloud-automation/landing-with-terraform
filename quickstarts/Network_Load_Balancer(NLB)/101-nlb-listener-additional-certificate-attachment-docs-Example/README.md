## Introduction

This example is used to create a `alicloud_nlb_listener_additional_certificate_attachment` resource.

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
| [alicloud_nlb_listener.create_listener](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/nlb_listener) | resource |
| [alicloud_nlb_listener_additional_certificate_attachment.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/nlb_listener_additional_certificate_attachment) | resource |
| [alicloud_nlb_load_balancer.lb](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/nlb_load_balancer) | resource |
| [alicloud_nlb_server_group.create_sg](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/nlb_server_group) | resource |
| [alicloud_ssl_certificates_service_certificate.ssl](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ssl_certificates_service_certificate) | resource |
| [alicloud_ssl_certificates_service_certificate.ssl0](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ssl_certificates_service_certificate) | resource |
| [alicloud_vpc.create_vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.create_vsw_j](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.create_vsw_k](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [random_integer.default](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |
| [alicloud_nlb_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/nlb_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"tf-example"` | no |
<!-- END_TF_DOCS -->    