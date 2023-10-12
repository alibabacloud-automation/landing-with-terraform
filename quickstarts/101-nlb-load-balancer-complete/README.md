<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | n/a |

## Resources

| Name | Type |
|------|------|
| [alicloud_common_bandwidth_package.default](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/common_bandwidth_package) | resource |
| [alicloud_nlb_load_balancer.default](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/nlb_load_balancer) | resource |
| [alicloud_nlb_zones.default](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/data-sources/nlb_zones) | data source |
| [alicloud_resource_manager_resource_groups.default](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/data-sources/resource_manager_resource_groups) | data source |
| [alicloud_vpcs.default](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/data-sources/vpcs) | data source |
| [alicloud_vswitches.default_1](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/data-sources/vswitches) | data source |
| [alicloud_vswitches.default_2](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/data-sources/vswitches) | data source |
| [alicloud_vswitches.default_3](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/data-sources/vswitches) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address_type_var"></a> [address\_type\_var](#input\_address\_type\_var) | n/a | `string` | `"Internet"` | no |
| <a name="input_cross_zone_enabled_var"></a> [cross\_zone\_enabled\_var](#input\_cross\_zone\_enabled\_var) | n/a | `string` | `"false"` | no |
| <a name="input_deletion_protection_enabled_var"></a> [deletion\_protection\_enabled\_var](#input\_deletion\_protection\_enabled\_var) | n/a | `string` | `"false"` | no |
| <a name="input_deletion_protection_reason_var"></a> [deletion\_protection\_reason\_var](#input\_deletion\_protection\_reason\_var) | n/a | `string` | `"tf-open"` | no |
| <a name="input_modification_protection_reason_var"></a> [modification\_protection\_reason\_var](#input\_modification\_protection\_reason\_var) | n/a | `string` | `"tf-open"` | no |
| <a name="input_modification_protection_status_var"></a> [modification\_protection\_status\_var](#input\_modification\_protection\_status\_var) | n/a | `string` | `"NonProtection"` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"tf-examplecn-hangzhounlbloadbalancer28660"` | no |
<!-- END_TF_DOCS -->    