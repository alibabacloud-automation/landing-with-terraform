## Introduction

This example is used to create a `alicloud_alb_listener_additional_certificate_attachment` resource.

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
| [alicloud_alb_listener.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/alb_listener) | resource |
| [alicloud_alb_listener_additional_certificate_attachment.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/alb_listener_additional_certificate_attachment) | resource |
| [alicloud_alb_load_balancer.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/alb_load_balancer) | resource |
| [alicloud_alb_server_group.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/alb_server_group) | resource |
| [alicloud_ssl_certificates_service_certificate.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ssl_certificates_service_certificate) | resource |
| [alicloud_vpc.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [random_integer.default](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |
| [alicloud_alb_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/alb_zones) | data source |
| [alicloud_resource_manager_resource_groups.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/resource_manager_resource_groups) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"tf_example"` | no |
<!-- END_TF_DOCS -->    