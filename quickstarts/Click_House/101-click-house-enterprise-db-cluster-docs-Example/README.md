## Introduction

This example is used to create a `alicloud_click_house_enterprise_db_cluster` resource.

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
| [alicloud_click_house_enterprise_db_cluster.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/click_house_enterprise_db_cluster) | resource |
| [alicloud_vpc.defaultktKLuM](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.defaultRNbPh8](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.defaultTQWN3k](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.defaultylyLu8](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"terraform-example"` | no |
| <a name="input_region_id"></a> [region\_id](#input\_region\_id) | n/a | `string` | `"cn-beijing"` | no |
| <a name="input_vpc_ip_range"></a> [vpc\_ip\_range](#input\_vpc\_ip\_range) | n/a | `string` | `"172.16.0.0/12"` | no |
| <a name="input_vsw_ip_range_i"></a> [vsw\_ip\_range\_i](#input\_vsw\_ip\_range\_i) | n/a | `string` | `"172.16.1.0/24"` | no |
| <a name="input_vsw_ip_range_k"></a> [vsw\_ip\_range\_k](#input\_vsw\_ip\_range\_k) | n/a | `string` | `"172.16.3.0/24"` | no |
| <a name="input_vsw_ip_range_l"></a> [vsw\_ip\_range\_l](#input\_vsw\_ip\_range\_l) | n/a | `string` | `"172.16.2.0/24"` | no |
| <a name="input_zone_id_i"></a> [zone\_id\_i](#input\_zone\_id\_i) | n/a | `string` | `"cn-beijing-i"` | no |
| <a name="input_zone_id_k"></a> [zone\_id\_k](#input\_zone\_id\_k) | n/a | `string` | `"cn-beijing-k"` | no |
| <a name="input_zone_id_l"></a> [zone\_id\_l](#input\_zone\_id\_l) | n/a | `string` | `"cn-beijing-l"` | no |
<!-- END_TF_DOCS -->
