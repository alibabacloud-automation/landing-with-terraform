## Introduction

This example is used to create a `alicloud_slb_rule` resource.

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
| [alicloud_instance.rule](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_security_group.rule](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_slb_listener.rule](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/slb_listener) | resource |
| [alicloud_slb_load_balancer.rule](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/slb_load_balancer) | resource |
| [alicloud_slb_rule.rule](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/slb_rule) | resource |
| [alicloud_slb_server_group.rule](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/slb_server_group) | resource |
| [alicloud_vpc.rule](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.rule](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_images.rule](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/images) | data source |
| [alicloud_instance_types.rule](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/instance_types) | data source |
| [alicloud_zones.rule](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_slb_rule_name"></a> [slb\_rule\_name](#input\_slb\_rule\_name) | n/a | `string` | `"terraform-example"` | no |
<!-- END_TF_DOCS -->    