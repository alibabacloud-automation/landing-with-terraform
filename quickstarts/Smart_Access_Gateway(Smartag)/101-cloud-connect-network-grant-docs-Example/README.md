## Introduction

This example is used to create a `alicloud_cloud_connect_network_grant` resource.

<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud.cen_account"></a> [alicloud.cen\_account](#provider\_alicloud.cen\_account) | n/a |
| <a name="provider_alicloud.default"></a> [alicloud.default](#provider\_alicloud.default) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_cen_instance.cen](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_instance) | resource |
| [alicloud_cloud_connect_network.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cloud_connect_network) | resource |
| [alicloud_cloud_connect_network_grant.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cloud_connect_network_grant) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_another_uid"></a> [another\_uid](#input\_another\_uid) | n/a | `number` | `123456789` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"tf-example"` | no |
<!-- END_TF_DOCS -->    