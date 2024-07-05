## Introduction

This example is used to create a `alicloud_express_connect_router_tr_association` resource.

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
| [alicloud_cen_instance.default418DC9](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_instance) | resource |
| [alicloud_cen_transit_router.defaultRYcjsc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cen_transit_router) | resource |
| [alicloud_express_connect_router_express_connect_router.defaultpX0KlC](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/express_connect_router_express_connect_router) | resource |
| [alicloud_express_connect_router_tr_association.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/express_connect_router_tr_association) | resource |
| [alicloud_account.current](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/account) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowprefix2"></a> [allowprefix2](#input\_allowprefix2) | n/a | `string` | `"10.0.1.0/24"` | no |
| <a name="input_allowprefix3"></a> [allowprefix3](#input\_allowprefix3) | n/a | `string` | `"10.0.2.0/24"` | no |
| <a name="input_allowprefix4"></a> [allowprefix4](#input\_allowprefix4) | n/a | `string` | `"10.0.3.0/24"` | no |
| <a name="input_alowprefix1"></a> [alowprefix1](#input\_alowprefix1) | n/a | `string` | `"10.0.0.0/24"` | no |
| <a name="input_asn"></a> [asn](#input\_asn) | n/a | `string` | `"4200001003"` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"terraform-example"` | no |
<!-- END_TF_DOCS -->
