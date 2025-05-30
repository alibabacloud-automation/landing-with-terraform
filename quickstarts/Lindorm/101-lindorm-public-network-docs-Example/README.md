## Introduction

This example is used to create a `alicloud_lindorm_public_network` resource.

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
| [alicloud_lindorm_instance.defaultQpsLKr](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/lindorm_instance) | resource |
| [alicloud_lindorm_public_network.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/lindorm_public_network) | resource |
| [alicloud_vpc.defaultX7MgJO](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.default45mCzM](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"terraform-example"` | no |
| <a name="input_region_id"></a> [region\_id](#input\_region\_id) | n/a | `string` | `"cn-shanghai"` | no |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | n/a | `string` | `"cn-shanghai-f"` | no |
<!-- END_TF_DOCS -->
