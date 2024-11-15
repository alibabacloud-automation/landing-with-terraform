## Introduction

This example is used to create a `alicloud_gwlb_load_balancer` resource.

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
| [alicloud_gwlb_load_balancer.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/gwlb_load_balancer) | resource |
| [alicloud_vpc.defaulti9Axhl](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.default9NaKmL](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.defaultH4pKT4](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_resource_manager_resource_groups.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/resource_manager_resource_groups) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"terraform-example"` | no |
| <a name="input_region_id"></a> [region\_id](#input\_region\_id) | n/a | `string` | `"cn-wulanchabu"` | no |
| <a name="input_zone_id1"></a> [zone\_id1](#input\_zone\_id1) | n/a | `string` | `"cn-wulanchabu-b"` | no |
| <a name="input_zone_id2"></a> [zone\_id2](#input\_zone\_id2) | n/a | `string` | `"cn-wulanchabu-c"` | no |
<!-- END_TF_DOCS -->
