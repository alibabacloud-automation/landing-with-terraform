## Introduction

This example is used to create a `alicloud_mongodb_private_srv_network_address` resource.

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
| [alicloud_mongodb_instance.defaultHrZmxC](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/mongodb_instance) | resource |
| [alicloud_mongodb_private_srv_network_address.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/mongodb_private_srv_network_address) | resource |
| [alicloud_vpc.defaultie35CW](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.defaultg0DCAR](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"terraform-example"` | no |
| <a name="input_region_id"></a> [region\_id](#input\_region\_id) | n/a | `string` | `"cn-shanghai"` | no |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | n/a | `string` | `"cn-shanghai-b"` | no |
<!-- END_TF_DOCS -->
