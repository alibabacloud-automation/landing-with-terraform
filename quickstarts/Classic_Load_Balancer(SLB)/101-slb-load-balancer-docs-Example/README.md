<!-- BEGIN_TF_DOCS -->
## Introduction

This example is used to create a `alicloud_slb_load_balancer` resource.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | n/a |

## Resources

| Name | Type |
|------|------|
| [alicloud_slb_load_balancer.load_balancer](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/slb_load_balancer) | resource |
| [alicloud_vpc.load_balancer](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.load_balancer](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_zones.load_balancer](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_slb_load_balancer_name"></a> [slb\_load\_balancer\_name](#input\_slb\_load\_balancer\_name) | Create a intranet SLB instance | `string` | `"forSlbLoadBalancer"` | no |
<!-- END_TF_DOCS -->    