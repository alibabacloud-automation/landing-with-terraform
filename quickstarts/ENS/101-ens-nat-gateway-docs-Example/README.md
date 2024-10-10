## Introduction

This example is used to create a `alicloud_ens_nat_gateway` resource.

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
| [alicloud_ens_nat_gateway.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ens_nat_gateway) | resource |
| [alicloud_ens_network.defaultObbrL7](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ens_network) | resource |
| [alicloud_ens_vswitch.defaulteFw783](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ens_vswitch) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ens_region_id"></a> [ens\_region\_id](#input\_ens\_region\_id) | n/a | `string` | `"cn-chenzhou-telecom_unicom_cmcc"` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"terraform-example"` | no |
<!-- END_TF_DOCS -->