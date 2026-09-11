## Introduction

This example is used to create a `alicloud_vpc_route_target_group` resource.

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
| [alicloud_gwlb_load_balancer.active](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/gwlb_load_balancer) | resource |
| [alicloud_gwlb_load_balancer.standby](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/gwlb_load_balancer) | resource |
| [alicloud_privatelink_vpc_endpoint.active](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/privatelink_vpc_endpoint) | resource |
| [alicloud_privatelink_vpc_endpoint.standby](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/privatelink_vpc_endpoint) | resource |
| [alicloud_privatelink_vpc_endpoint_service.active](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/privatelink_vpc_endpoint_service) | resource |
| [alicloud_privatelink_vpc_endpoint_service.standby](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/privatelink_vpc_endpoint_service) | resource |
| [alicloud_privatelink_vpc_endpoint_service_resource.active](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/privatelink_vpc_endpoint_service_resource) | resource |
| [alicloud_privatelink_vpc_endpoint_service_resource.standby](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/privatelink_vpc_endpoint_service_resource) | resource |
| [alicloud_privatelink_vpc_endpoint_zone.active](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/privatelink_vpc_endpoint_zone) | resource |
| [alicloud_privatelink_vpc_endpoint_zone.standby](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/privatelink_vpc_endpoint_zone) | resource |
| [alicloud_vpc.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vpc_route_target_group.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc_route_target_group) | resource |
| [alicloud_vswitch.zone_a](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.zone_b](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"terraform-example"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-wulanchabu"` | no |
| <a name="input_zone_id_1"></a> [zone\_id\_1](#input\_zone\_id\_1) | n/a | `string` | `"cn-wulanchabu-b"` | no |
| <a name="input_zone_id_2"></a> [zone\_id\_2](#input\_zone\_id\_2) | n/a | `string` | `"cn-wulanchabu-c"` | no |
<!-- END_TF_DOCS -->
