## Introduction

This example is used to create a `alicloud_slb_backend_server` resource.

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
| [alicloud_instance.backend_server](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_security_group.backend_server](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_slb_backend_server.backend_server](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/slb_backend_server) | resource |
| [alicloud_slb_load_balancer.backend_server](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/slb_load_balancer) | resource |
| [alicloud_vpc.backend_server](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.backend_server](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_images.backend_server](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/images) | data source |
| [alicloud_instance_types.backend_server](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/instance_types) | data source |
| [alicloud_zones.backend_server](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_slb_backend_server_name"></a> [slb\_backend\_server\_name](#input\_slb\_backend\_server\_name) | alicloud\_slb\_backend\_server | `string` | `"slbbackendservertest"` | no |
<!-- END_TF_DOCS -->    