## Introduction

This example is used to create a `alicloud_mongodb_node` resource.

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
| [alicloud_mongodb_node.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/mongodb_node) | resource |
| [alicloud_mongodb_sharding_instance.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/mongodb_sharding_instance) | resource |
| [alicloud_vpc.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ipv4_cidr"></a> [ipv4\_cidr](#input\_ipv4\_cidr) | n/a | `string` | `"10.0.0.0/24"` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"terraform-example"` | no |
| <a name="input_region_id"></a> [region\_id](#input\_region\_id) | n/a | `string` | `"cn-shanghai"` | no |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | n/a | `string` | `"cn-shanghai-b"` | no |
<!-- END_TF_DOCS -->
