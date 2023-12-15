<!-- BEGIN_TF_DOCS -->
## Introduction

This example is used to create a `alicloud_cloud_storage_gateway_gateway_logging` resource.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Resources

| Name | Type |
|------|------|
| [alicloud_cloud_storage_gateway_gateway.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cloud_storage_gateway_gateway) | resource |
| [alicloud_cloud_storage_gateway_gateway_logging.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cloud_storage_gateway_gateway_logging) | resource |
| [alicloud_cloud_storage_gateway_storage_bundle.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cloud_storage_gateway_storage_bundle) | resource |
| [alicloud_log_project.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/log_project) | resource |
| [alicloud_log_store.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/log_store) | resource |
| [alicloud_vpc.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [random_uuid.default](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) | resource |
| [alicloud_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"tf-example"` | no |
<!-- END_TF_DOCS -->    