## Introduction

This example is used to create a `alicloud_cen_inter_region_traffic_qos_queue` resource.

<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | n/a |
| <a name="provider_alicloud.bj"></a> [alicloud.bj](#provider\_alicloud.bj) | n/a |
| <a name="provider_alicloud.hz"></a> [alicloud.hz](#provider\_alicloud.hz) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_cen_bandwidth_package.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_bandwidth_package) | resource |
| [alicloud_cen_bandwidth_package_attachment.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_bandwidth_package_attachment) | resource |
| [alicloud_cen_instance.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_instance) | resource |
| [alicloud_cen_inter_region_traffic_qos_policy.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_inter_region_traffic_qos_policy) | resource |
| [alicloud_cen_inter_region_traffic_qos_queue.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_inter_region_traffic_qos_queue) | resource |
| [alicloud_cen_transit_router.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router) | resource |
| [alicloud_cen_transit_router.peer](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router) | resource |
| [alicloud_cen_transit_router_peer_attachment.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router_peer_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_default_region"></a> [default\_region](#input\_default\_region) | n/a | `string` | `"cn-hangzhou"` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"tf_example"` | no |
| <a name="input_peer_region"></a> [peer\_region](#input\_peer\_region) | n/a | `string` | `"cn-beijing"` | no |
<!-- END_TF_DOCS -->    